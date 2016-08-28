-- query1

select a.username, a.status, a.sql_id, b.value, c.name
from v$session a, v$sesstat b, v$statname c
where a.sql_id is not null and a.sid=b.sid and b.STATISTIC# = c.STATISTIC#
order by a.username, a.sql_id, c.name;

-- some userful performance lag statistics
physical read total bytes
physical reads direct
physical reads
execute count
physical read bytes
logical read bytes from cache
file io wait time
file io service time
dirty buffers inspected
db block changes
consistent changes
db block gets
consistent gets
concurrency wait time
cell physical IO interconnect bytes

