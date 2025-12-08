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
spool "06_demo_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on

-- DEMO: Testing Procedures
begin
    dbms_output.put_line('=== TESTING PROCEDURES ===');
    
    -- Test get_all_personnel_correlated
    get_all_personnel_correlated;

    -- Test get_all_personnel_no_co
    get_all_personnel_no_co;

    -- Test add_personnel
    add_personnel('Jane', 'Doe', 'Officer', 'Lieutenant', 1, 1, 1, 65000);
    
    -- Test get_personnel_by_branch
    get_personnel_by_branch(1);
    get_personnel_by_branch(3);
    
    -- Test calc_vehicle_costs_by_branch
    calc_vehicle_costs_by_branch(1);
    calc_vehicle_costs_by_branch(3);
    
    -- Test update_personnel_salary (triggers audit)
    update_personnel_salary(1, 90000);
end;
/

-- DEMO: Testing Functions
begin
    dbms_output.put_line('=== TESTING FUNCTIONS ===');
    
    -- Test get_branch_total_cost
    dbms_output.put_line('Branch 1 Total Cost: $' || get_branch_total_cost(1));
    
    -- Test get_rank_level
    dbms_output.put_line('Colonel Rank Level: ' || get_rank_level('Colonel'));
    
    -- Test check_deployment_eligibility
    dbms_output.put_line('Personnel 1 Eligibility: ' || check_deployment_eligibility(1));
end;
/

-- DEMO: Testing Package Procedures and Functions
begin
    dbms_output.put_line('=== TESTING PACKAGES ===');
    
    -- Test deployment report
    pkg_military_ops.generate_deployment_report(1);
    
    -- Test readiness score
    dbms_output.put_line('Command 1 Readiness Score: ' || pkg_military_ops.calculate_readiness_score(1));
    
    -- Test resource optimization
    pkg_military_ops.optimize_resource_allocation;
end;
/

-- DEMO: Testing Triggers (executed automatically)
begin
    dbms_output.put_line('=== TESTING TRIGGERS ===');
    dbms_output.put_line('Triggers execute automatically on DML operations:');
    
    -- Trigger 1: Personnel audit (fires on salary update)
    dbms_output.put_line('1. Personnel audit trigger fires on salary updates');
    update personnel set salary = salary + 1000 where id = 2;
    
    -- Trigger 2: Vehicle maintenance validation (fires on vehicle update)
    dbms_output.put_line('2. Vehicle maintenance trigger fires on maintenance cost updates');
    update vehicles set maintenance_cost = maintenance_cost * 1.1 where id = 1;
    
    -- Trigger 3: Deployment validation (fires on new deployment)
    dbms_output.put_line('3. Deployment validation trigger fires on new deployments');
    create_deployment(1, 1, 2, 7, 1);
    
    dbms_output.put_line('Check personnel_audit table for audit records:');
    for rec in (select * from personnel_audit where rownum <= 3) loop
        dbms_output.put_line('Audit ID: ' || rec.audit_id || ', Personnel: ' || rec.personnel_id || 
                           ', Old Salary: ' || rec.old_salary || ', New Salary: ' || rec.new_salary);
    end loop;
end;
/

spool off