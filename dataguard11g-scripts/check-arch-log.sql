select THREAD#,SEQUENCE#,ARCHIVED,APPLIED,STATUS
from v$archived_log
order by 1,2;
