set echo on

select THREAD#,SEQUENCE#,PROCESS,STATUS
from v$managed_standby
order by 1,2;

select * from v$archive_gap;

echo off

