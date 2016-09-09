select THREAD#,SEQUENCE#,PROCESS,STATUS
from v$managed_standby
order by 1,2;
