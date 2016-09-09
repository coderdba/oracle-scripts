set echo on

spool prim-check-redo

select thread#,groups from v$thread;

select distinct BYTES from v$log;

select group#, thread# from v$log order by 1,2;

select group#, thread# from v$standby_log order by 1,2;

set echo off

spool off
