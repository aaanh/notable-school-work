/*
 * Copyright (c) 2025 Anh Hoang Nguyen <anhnguyen@aaanh.com>
 * 
 * All rights reserved. All materials and contents in this source
 * file are made available only for school work grading purposes
 * 
 * Author: Anh Hoang Nguyen - https://anh.to/gh - anhnguyen@aaanh.com
 */

-- START SPOOL CONFIG
COLUMN tstamp NEW_VALUE ts
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD_HH24MISS') tstamp FROM dual;

SET LINESIZE 200
spool "00_schema_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on

-- Military assets database, scoped to US
-- due to information availability and because joint international forces would be too much
-- modeled assets are scoped to vehicles and personnel, no armaments

-- e.g. army, airforce, navy, marine
create table branches (
  id number(8,0) primary key,
  branch_name nvarchar2(50)
);

-- command e.g. CENTCOM, JSOC, NATO, NORAD
create table commands (
  id number(8,0) primary key,
  command_name nvarchar2(50)
);

create table op_bases (
  id number(8,0) primary key,
  op_base_name nvarchar2(50),
  op_location nvarchar2(50) 
);

create table personnel (
  -- IDENT
  id number(8,0) primary key,
  first_name nvarchar2(50) not null,
  last_name nvarchar2(50) not null,
  personnel_type nvarchar2(20) not null,
  service_rank nvarchar2(50),

  -- logistics and operations
  branch_id number(8,0) references branches(id),
  command_id number(8,0) references commands(id),
  op_base_id number(8,0) references op_bases(id),
  is_active number(1,0) check (is_active in (0,1)),
  commanding_officer_id number(8,0) references personnel(id),
  service_years number(3,0),
  deployed number(6,0),

  -- financial
  salary number(12,2)
);

create table vehicles (
  -- identification
  id number(8,0) primary key,
  sku nvarchar2(50),

  -- logistics and operations
  branch_id number(8,0) references branches(id),
  command_id number(8,0) references commands(id),
  op_base_id number(8,0) references op_bases(id),
  is_active number(1,0) check (is_active in (0,1)),
  responsible_personnel_id number(8,0) references personnel(id),
  service_years number(3,0),
  deployed number(6,0),
  ---- combat, transport, industrial
  purpose nvarchar2(50),

  -- financials
  purchase_cost number(18, 2),
  maintenance_cost number(18, 2),
  yearly_depreciation number(18,2),
  deployment_cost number(18,2)
);

create table deployments (
  id number(8,0) primary key,
  branch_id number(8,0) references branches(id),
  command_id number(8,0) references commands(id),
  vehicle_id number(8,0) references vehicles(id),
  personnel_id number(8,0) references personnel(id),
  op_base_id number(8,0) references op_bases(id)
);

create table personnel_audit (
    audit_id number primary key,
    personnel_id number,
    old_salary number,
    new_salary number,
    change_date date,
    change_type varchar2(10)
);

-- store constants to calculate certain scores
-- i.e. combat readiness or deployment eligibility limits
-- instead of hardcoding in the body of procedures/functions/triggers
create table evaluation_criteria (
  criteria nvarchar2(50) primary key,
  criteria_value number
);

spool off