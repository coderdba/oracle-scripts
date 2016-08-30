-- For individual tables

set heading off;
set echo off;
Set pages 999;
set long 90000;

spool ddl_list.sql
select dbms_metadata.get_ddl('TABLE','DEPT','SCOTT') from dual; 
select dbms_metadata.get_ddl('INDEX','DEPT_IDX','SCOTT') from dual;
spool off;

-- For schema

set pagesize 0
set long 90000
set feedback off
set echo off 
set heading 999
set lines 100

select 
   dbms_metadata.GET_DDL(u.object_type,u.object_name,'PUBS')
from 
   dba_objects u
where 
   owner = 'PUBS';
   
-- Grants

select dbms_metadata.get_granted_ddl('system_grant','') from dual;

select dbms_metadata.get_granted_ddl('role_grant','') from dual;
 
select dbms_metadata.get_granted_ddl('object_grant','') from dual;
