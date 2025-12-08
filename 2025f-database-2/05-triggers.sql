/*
 * Copyright (c) 2025 Anh Hoang Nguyen <anhnguyen@aaanh.com>
 * 
 * All rights reserved. All materials and contents in this source
 * file are made available only for school work grading purposes
 * 
 * Author: Anh Hoang Nguyen - https://anh.to/gh - anhnguyen@aaanh.com
 */

-- START SPOOL CONFIG
column tstamp new_value ts
select to_char(sysdate, 'YYYYMMDD_HH24MISS') tstamp from dual;

set linesize 200
spool "05_triggers_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on

-- 1. Audit trigger for personnel changes
drop sequence audit_seq;
create sequence audit_seq start with 1;

-- executes when there are ANY updates to the personnel table
create or replace trigger trg_personnel_audit
    after update on personnel
    for each row
begin
    if :old.salary != :new.salary then
        insert into personnel_audit (audit_id, personnel_id, old_salary, new_salary, change_date, change_type)
        values (audit_seq.nextval, :new.id, :old.salary, :new.salary, sysdate, 'SALARY');
    end if;
end;
/

-- 2. Vehicle maintenance trigger with cursor
-- same as personnel but vehicles
create or replace trigger trg_vehicle_maintenance
    before update on vehicles
    for each row
declare
    v_high_cost_count number := 0;
    v_cost_threshold number;
    v_increase_threshold number;
    v_max_high_maintenance number;
    cursor c_expensive_vehicles is
        select id, maintenance_cost
        from vehicles
        where branch_id = :new.branch_id and maintenance_cost > v_cost_threshold;
begin
    select criteria_value into v_cost_threshold from evaluation_criteria where criteria = 'HIGH_MAINTENANCE_COST_THRESHOLD';
    select criteria_value into v_increase_threshold from evaluation_criteria where criteria = 'MAINTENANCE_COST_INCREASE_THRESHOLD';
    select criteria_value into v_max_high_maintenance from evaluation_criteria where criteria = 'MAX_HIGH_MAINTENANCE_VEHICLES';
    
    -- check if maintenance cost is too high
    if :new.maintenance_cost > :old.maintenance_cost * v_increase_threshold then
        for v_rec in c_expensive_vehicles loop
            v_high_cost_count := v_high_cost_count + 1;
        end loop;
        
        if v_high_cost_count > v_max_high_maintenance then
            raise_application_error(-20001, 'Too many high-maintenance vehicles in branch');
        end if;
    end if;
end;
/

-- 3. Deployment validation trigger with nested cursors
-- when INSERTING into deployments, REJECT OR ACCEPT
create or replace trigger trg_deployment_validation
    before insert on deployments
    for each row
declare
    v_personnel_available number := 0;
    v_vehicle_available number := 0;
    v_max_personnel_deployments number;
    v_max_base_capacity number;
    
    cursor c_personnel_check is
        select id, is_active, deployed
        from personnel
        where id = :new.personnel_id;
        
    cursor c_vehicle_check(p_personnel_id number) is
        select v.id, v.is_active, v.responsible_personnel_id
        from vehicles v
        where v.id = :new.vehicle_id;
        
    cursor c_base_capacity is
        select count(*) as current_deployments
        from deployments
        where op_base_id = :new.op_base_id;
begin
    select criteria_value into v_max_personnel_deployments from evaluation_criteria where criteria = 'MAX_PERSONNEL_DEPLOYMENTS_LIMIT';
    select criteria_value into v_max_base_capacity from evaluation_criteria where criteria = 'MAX_BASE_CAPACITY';
    
    -- check personnel availability
    for p_rec in c_personnel_check loop
        if p_rec.is_active = 0 then
            raise_application_error(-20002, 'Personnel not active');
        end if;
        
        if p_rec.deployed > v_max_personnel_deployments then
            raise_application_error(-20003, 'Personnel over-deployed');
        end if;
        
        -- nested cursor for vehicle check
        for v_rec in c_vehicle_check(p_rec.id) loop
            if v_rec.is_active = 0 then
                raise_application_error(-20004, 'Vehicle not active');
            end if;
        end loop;
    end loop;
    
    -- check base capacity
    for b_rec in c_base_capacity loop
        if b_rec.current_deployments > v_max_base_capacity then
            raise_application_error(-20005, 'Base at capacity');
        end if;
    end loop;
end;
/

spool off