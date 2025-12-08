-- alter session set container="cbdroot";
drop user c##washington cascade;
create user c##washington identified by dod;
grant connect, create session, resource, create view to c##washington;
alter user c##washington quota 100M on users;
connect c##washington/dod;