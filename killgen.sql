select 
--a.status || ' '||  
'alter system kill session ' ||  '''' || a.sid || ',' || a.serial# || '''' || ';'
from v$session a
where username like 'XX%' and username != 'XXYY'
--order by status
;
