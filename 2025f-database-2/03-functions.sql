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
spool "03_functions_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on

-- 1. Calculate total branch cost
create or replace function get_branch_total_cost(p_branch_id in number) 
return number as
    v_personnel_cost number := 0;
    v_vehicle_cost number := 0;
    v_total number := 0;
begin
    select nvl(sum(salary), 0) into v_personnel_cost 
    from personnel where branch_id = p_branch_id and is_active = 1;
    
    select nvl(sum(purchase_cost + maintenance_cost), 0) into v_vehicle_cost
    from vehicles where branch_id = p_branch_id and is_active = 1;
    
    v_total := v_personnel_cost + v_vehicle_cost;
    return v_total;
end;
/

-- 2. Get personnel rank level
create or replace function get_rank_level(p_rank in varchar2) 
return number as
begin
    case upper(p_rank)
        when 'PRIVATE' then return 1;
        when 'PRIVATE FIRST CLASS' then return 2;
        when 'SPECIALIST' then return 3;
        when 'CORPORAL' then return 4;
        when 'SERGEANT' then return 5;
        when 'STAFF SERGEANT' then return 6;
        when 'SERGEANT FIRST CLASS' then return 7;
        when 'FIRST SERGEANT' then return 8;
        when 'SERGEANT MAJOR' then return 9;
        when 'SECOND LIEUTENANT' then return 10;
        when 'FIRST LIEUTENANT' then return 11;
        when 'LIEUTENANT' then return 12;
        when 'CAPTAIN' then return 13;
        when 'MAJOR' then return 14;
        when 'LIEUTENANT COLONEL' then return 15;
        when 'COLONEL' then return 16;
        when 'BRIGADIER GENERAL' then return 17;
        when 'MAJOR GENERAL' then return 18;
        when 'LIEUTENANT GENERAL' then return 19;
        when 'GENERAL' then return 20;
        else return 0;
    end case;
end;
/

-- 3. Check deployment eligibility with nested cursor
create or replace function check_deployment_eligibility(p_personnel_id in number)
return varchar2 as
    v_result varchar2(20) := 'ELIGIBLE';
    v_branch_id number;
    v_command_id number;
    v_max_deployments number;
    v_min_service_years number;
    
    cursor c_personnel is
        select branch_id, command_id, deployed, service_years
        from personnel where id = p_personnel_id;
        
    cursor c_branch_vehicles(p_branch number, p_command number) is
        select id, purpose, is_active
        from vehicles 
        where branch_id = p_branch and command_id = p_command and is_active = 1;
begin
    select criteria_value into v_max_deployments from evaluation_criteria where criteria = 'MAX_DEPLOYMENTS_OVERDEPLOYED';
    select criteria_value into v_min_service_years from evaluation_criteria where criteria = 'MIN_SERVICE_YEARS_DEPLOYMENT';
    
    for p_rec in c_personnel loop
        if p_rec.deployed > v_max_deployments then
            v_result := 'OVER_DEPLOYED';
        elsif p_rec.service_years < v_min_service_years then
            v_result := 'INSUFFICIENT_EXP';
        else
            -- nested cursor to check available vehicles
            for v_rec in c_branch_vehicles(p_rec.branch_id, p_rec.command_id) loop
                if v_rec.purpose = 'combat' then
                    v_result := 'COMBAT_READY';
                    exit;
                end if;
            end loop;
        end if;
    end loop;
    
    return v_result;
end;
/

spool off