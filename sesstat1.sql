-- query1

select a.username, a.status, a.sql_id, b.value, c.name
from v$session a, v$sesstat b, v$statname c
where a.sql_id is not null and a.sid=b.sid and b.STATISTIC# = c.STATISTIC#
order by a.username, a.sql_id, c.name;

