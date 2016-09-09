select thread#, group#, sequence#, ARCHIVED, STATUS
from v$log
order by 1,2;
