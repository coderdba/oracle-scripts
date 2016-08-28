select a.username,
a.sql_id,
b.sql_text
from v$session a, v$sql b
where a.username in (select distinct username from v$session where username like 'SV%') and a.sql_id=b.sql_id
order by 1,2;
