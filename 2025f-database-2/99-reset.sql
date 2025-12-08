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
spool "99_reset_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on

-- nuke tables
drop table branches cascade constraints purge;
drop table commands cascade constraints purge;
drop table op_bases cascade constraints purge;
drop table personnel cascade constraints purge;
drop table vehicles cascade constraints purge;
drop table deployments cascade constraints purge;
drop table evaluation_criteria cascade constraints purge;
drop table personnel_audit cascade constraints purge;

-- nuke procedures, functions, triggers, packages, sequences
-- adapted from oracle forum
begin
  for i in (select object_name from user_objects where object_type = 'PROCEDURE')
  loop
    execute immediate 'drop procedure ' || i.object_name;
  end loop;
end;
/

begin
  for i in (select object_name from user_objects where object_type = 'FUNCTION')
  loop
    execute immediate 'drop function ' || i.object_name;
  end loop;
end;
/

begin
  for i in (select object_name from user_objects where object_type = 'PACKAGE')
  loop
    execute immediate 'drop package ' || i.object_name;
  end loop;
end;
/

begin
  for i in (select object_name from user_objects where object_type = 'TRIGGER')
  loop
    execute immediate 'drop trigger ' || i.object_name;
  end loop;
end;
/

begin
  for i in (select object_name from user_objects where object_type = 'SEQUENCE')
  loop
    execute immediate 'drop sequence ' || i.object_name;
  end loop;
end;
/

commit;

spool off
