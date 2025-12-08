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
spool "04_packages_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on

-- Military Operations Package Specification
create or replace package pkg_military_ops as
    procedure generate_deployment_report(p_branch_id in number);
    function calculate_readiness_score(p_command_id in number) return number;
    procedure optimize_resource_allocation;
end pkg_military_ops;
/

-- Military Operations Package Body
create or replace package body pkg_military_ops as

    -- Generate comprehensive deployment report with nested cursors
    procedure generate_deployment_report(p_branch_id in number) as
        cursor c_commands is
            select distinct c.id, c.command_name
            from commands c
            join deployments d on c.id = d.command_id
            where d.branch_id = p_branch_id;
            
        cursor c_deployments(p_command_id number) is
            select d.id, d.op_base_id, ob.op_base_name
            from deployments d
            join op_bases ob on d.op_base_id = ob.id
            where d.branch_id = p_branch_id and d.command_id = p_command_id;
            
        cursor c_deployment_details(p_deployment_id number) is
            select p.first_name, p.last_name, v.sku, v.purpose
            from deployments d
            join personnel p on d.personnel_id = p.id
            join vehicles v on d.vehicle_id = v.id
            where d.id = p_deployment_id;
    begin
        dbms_output.put_line('=== DEPLOYMENT REPORT FOR BRANCH ID: ' || p_branch_id || ' ===');
        
        for cmd_rec in c_commands loop
            dbms_output.put_line('Command: ' || cmd_rec.command_name);
            
            for dep_rec in c_deployments(cmd_rec.id) loop
                dbms_output.put_line('  Base: ' || dep_rec.op_base_name);
                
                -- nested cursor for deployment details
                for det_rec in c_deployment_details(dep_rec.id) loop
                    dbms_output.put_line('    Personnel: ' || det_rec.first_name || ' ' || det_rec.last_name);
                    dbms_output.put_line('    Vehicle: ' || det_rec.sku || ' (' || det_rec.purpose || ')');
                end loop;
            end loop;
        end loop;
    end;

    -- Calculate readiness score using multiple cursors
    function calculate_readiness_score(p_command_id in number) return number as
        v_score number := 0;
        v_personnel_ready number := 0;
        v_vehicle_ready number := 0;
        v_total_personnel number := 0;
        v_total_vehicles number := 0;
        v_max_personnel_deployments number;
        v_max_vehicle_deployments number;
        
        cursor c_personnel_readiness is
            select count(*) as ready_count
            from personnel
            where command_id = p_command_id and is_active = 1 and deployed < v_max_personnel_deployments;
            
        cursor c_vehicle_readiness is
            select count(*) as ready_count
            from vehicles
            where command_id = p_command_id and is_active = 1 and deployed < v_max_vehicle_deployments;
            
        cursor c_total_assets is
            select 
                (select count(*) from personnel where command_id = p_command_id) as total_personnel,
                (select count(*) from vehicles where command_id = p_command_id) as total_vehicles
            from dual;
    begin
        select criteria_value into v_max_personnel_deployments from evaluation_criteria where criteria = 'MAX_PERSONNEL_DEPLOYMENTS_READY';
        select criteria_value into v_max_vehicle_deployments from evaluation_criteria where criteria = 'MAX_VEHICLE_DEPLOYMENTS_READY';
        
        for p_rec in c_personnel_readiness loop
            v_personnel_ready := p_rec.ready_count;
        end loop;
        
        for v_rec in c_vehicle_readiness loop
            v_vehicle_ready := v_rec.ready_count;
        end loop;
        
        for t_rec in c_total_assets loop
            v_total_personnel := t_rec.total_personnel;
            v_total_vehicles := t_rec.total_vehicles;
        end loop;
        
        if v_total_personnel > 0 and v_total_vehicles > 0 then
            v_score := ((v_personnel_ready / v_total_personnel) + (v_vehicle_ready / v_total_vehicles)) * 50;
        end if;
        
        return round(v_score, 2);
    end;

    -- Optimize resource allocation with complex cursor logic
    procedure optimize_resource_allocation as
        v_overutilized_threshold number;
        cursor c_branches is
            select id, branch_name from branches;
            
        cursor c_underutilized_personnel(p_branch_id number) is
            select id, first_name, last_name, deployed
            from personnel
            where branch_id = p_branch_id and is_active = 1 and deployed = 0;
            
        cursor c_overutilized_vehicles(p_branch_id number) is
            select id, sku, deployed
            from vehicles
            where branch_id = p_branch_id and is_active = 1 and deployed > v_overutilized_threshold;
    begin
        select criteria_value into v_overutilized_threshold from evaluation_criteria where criteria = 'MAX_PERSONNEL_DEPLOYMENTS_READY';
        
        dbms_output.put_line('=== RESOURCE OPTIMIZATION REPORT ===');
        
        for branch_rec in c_branches loop
            dbms_output.put_line('Branch: ' || branch_rec.branch_name);
            
            -- check underutilized personnel
            for pers_rec in c_underutilized_personnel(branch_rec.id) loop
                dbms_output.put_line('  Underutilized: ' || pers_rec.first_name || ' ' || pers_rec.last_name);
            end loop;
            
            -- check overutilized vehicles
            for veh_rec in c_overutilized_vehicles(branch_rec.id) loop
                dbms_output.put_line('  Overutilized Vehicle: ' || veh_rec.sku || ' (deployed ' || veh_rec.deployed || ' times)');
            end loop;
        end loop;
    end;

end pkg_military_ops;
/

spool off