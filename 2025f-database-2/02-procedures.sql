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
spool "02_procedures_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on

-- 1. Add new personnel
create or replace procedure add_personnel(
    p_first_name in varchar2,
    p_last_name in varchar2,
    p_personnel_type in varchar2,
    p_service_rank in varchar2,
    p_branch_id in number,
    p_command_id in number,
    p_op_base_id in number,
    p_salary in number
) as
    v_new_id number;
begin
    select nvl(max(id), 0) + 1 into v_new_id from personnel;
    
    insert into personnel (id, first_name, last_name, personnel_type, service_rank, 
                          branch_id, command_id, op_base_id, is_active, service_years, deployed, salary)
    values (v_new_id, p_first_name, p_last_name, p_personnel_type, p_service_rank,
            p_branch_id, p_command_id, p_op_base_id, 1, 0, 0, p_salary);
    
    dbms_output.put_line('Personnel added with ID: ' || v_new_id);
end;
/

-- 2. Add new vehicle
create or replace procedure add_vehicle(
    p_sku in varchar2,
    p_branch_id in number,
    p_command_id in number,
    p_op_base_id in number,
    p_responsible_personnel_id in number,
    p_purpose in varchar2,
    p_purchase_cost in number
) as
    v_new_id number;
begin
    select nvl(max(id), 0) + 1 into v_new_id from vehicles;
    
    insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active,
                         responsible_personnel_id, service_years, deployed, purpose, purchase_cost)
    values (v_new_id, p_sku, p_branch_id, p_command_id, p_op_base_id, 1,
            p_responsible_personnel_id, 0, 0, p_purpose, p_purchase_cost);
    
    dbms_output.put_line('Vehicle added with ID: ' || v_new_id);
end;
/

-- 3. Create deployment
create or replace procedure create_deployment(
    p_branch_id in number,
    p_command_id in number,
    p_vehicle_id in number,
    p_personnel_id in number,
    p_op_base_id in number
) as
    v_new_id number;
begin
    select nvl(max(id), 0) + 1 into v_new_id from deployments;
    
    insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id)
    values (v_new_id, p_branch_id, p_command_id, p_vehicle_id, p_personnel_id, p_op_base_id);
    
    update personnel set deployed = deployed + 1 where id = p_personnel_id;
    update vehicles set deployed = deployed + 1 where id = p_vehicle_id;
    
    dbms_output.put_line('Deployment created with ID: ' || v_new_id);
end;
/

-- 4. Get personnel by branch
create or replace procedure get_personnel_by_branch(
    p_branch_id in number
) as
    cursor c_personnel is
        select p.id, p.first_name, p.last_name, p.service_rank, b.branch_name
        from personnel p
        join branches b on p.branch_id = b.id
        where p.branch_id = p_branch_id and p.is_active = 1;
begin
    dbms_output.put_line('Personnel in branch ID ' || p_branch_id || ':');
    for rec in c_personnel loop
        dbms_output.put_line(rec.id || ' - ' || rec.first_name || ' ' || rec.last_name || 
                           ' (' || rec.service_rank || ')');
    end loop;
end;
/

-- 5. Calculate total vehicle costs by branch
create or replace procedure calc_vehicle_costs_by_branch(
    p_branch_id in number
) as
    v_total_purchase number := 0;
    v_total_maintenance number := 0;
    v_total_deployment number := 0;
begin
    select nvl(sum(purchase_cost), 0), nvl(sum(maintenance_cost), 0), nvl(sum(deployment_cost), 0)
    into v_total_purchase, v_total_maintenance, v_total_deployment
    from vehicles
    where branch_id = p_branch_id and is_active = 1;
    
    dbms_output.put_line('Vehicle costs for branch ID ' || p_branch_id || ':');
    dbms_output.put_line('Total Purchase Cost: $' || to_char(v_total_purchase, '999,999,999.99'));
    dbms_output.put_line('Total Maintenance Cost: $' || to_char(v_total_maintenance, '999,999,999.99'));
    dbms_output.put_line('Total Deployment Cost: $' || to_char(v_total_deployment, '999,999,999.99'));
end;
/

-- 6. Update personnel salary
create or replace procedure update_personnel_salary(
    p_personnel_id in number,
    p_new_salary in number
) as
    v_count number;
begin
    select count(*) into v_count from personnel where id = p_personnel_id;
    
    if v_count = 0 then
        dbms_output.put_line('Personnel ID ' || p_personnel_id || ' not found');
        return;
    end if;
    
    update personnel set salary = p_new_salary where id = p_personnel_id;
    dbms_output.put_line('Salary updated for personnel ID ' || p_personnel_id);
end;
/

-- 7. Deactivate personnel
create or replace procedure deactivate_personnel(
    p_personnel_id in number
) as
    v_count number;
begin
    select count(*) into v_count from personnel where id = p_personnel_id;
    
    if v_count = 0 then
        dbms_output.put_line('Personnel ID ' || p_personnel_id || ' not found');
        return;
    end if;
    
    update personnel set is_active = 0 where id = p_personnel_id;
    dbms_output.put_line('Personnel ID ' || p_personnel_id || ' deactivated');
end;
/

-- 8. Get deployment summary
create or replace procedure get_deployment_summary as
    cursor c_summary is
        select b.branch_name, count(d.id) as deployment_count
        from branches b
        left join deployments d on b.id = d.branch_id
        group by b.branch_name
        order by deployment_count desc;
begin
    dbms_output.put_line('Deployment Summary by Branch:');
    for rec in c_summary loop
        dbms_output.put_line(rec.branch_name || ': ' || rec.deployment_count || ' deployments');
    end loop;
end;
/

-- 9. Get ALL personnel with correlated commanding officer, rank, base, command, branch
create or replace procedure get_all_personnel_correlated as
begin
    for rec in (
        select p.id, p.first_name, p.last_name, p.service_rank,
               b.branch_name, c.command_name, ob.op_base_name,
               co.first_name || ' ' || co.last_name as commanding_officer
        from personnel p
        join branches b on p.branch_id = b.id
        join commands c on p.command_id = c.id
        join op_bases ob on p.op_base_id = ob.id
        left join personnel co on p.commanding_officer_id = co.id
        where p.is_active = 1
        order by p.id
    ) loop
        dbms_output.put_line(rec.id || ' - ' || rec.first_name || ' ' || rec.last_name ||
                           ' (' || rec.service_rank || ') - ' || rec.branch_name ||
                           ' - ' || rec.command_name || ' - ' || rec.op_base_name ||
                           ' - CO: ' || nvl(rec.commanding_officer, 'None'));
    end loop;
end;
/

-- 10. Get ALL personnel WITHOUT a CO assigned
create or replace procedure get_all_personnel_no_co as
begin
    dbms_output.put_line('--- ALL PERSONNEL W/O COMMANDING OFFICER ---');
    for rec in (
        select p.id, p.first_name, p.last_name, p.service_rank,
                b.branch_name, c.command_name, ob.op_base_name
        from personnel p
        join branches b on p.branch_id = b.id
        join commands c on p.command_id = c.id
        join op_bases ob on p.op_base_id = ob.id
        where p.commanding_officer_id is null
    ) loop
        dbms_output.put_line(rec.id || ' - ' || rec.first_name || ' ' || rec.last_name ||
                           ' (' || rec.service_rank || ') - ' || rec.branch_name ||
                           ' - ' || rec.command_name || ' - ' || rec.op_base_name);
    end loop;
end;
/

spool off