-- http://www.softwaretestinghelp.com/testing-oracle-database-for-memory-space-and-cpu/
--  % of parse vs total cpu
select (a.value / b.value)*100 "% CPU for
parsing" from V$SYSSTAT a, V$SYSSTAT b
where a.name = 'parse time cpu' and
b.name = 'CPU used by this session';

-- CPU usage for all sessions
SELECT n.username, s.sid, s.value 
FROM v$sesstat s,v$statname t, v$session n 
WHERE s.statistic# = t.statistic# AND n.sid = s.sid
AND t.name='CPU used by this session' ORDER BY s.value desc;
