SELECT a.object,
       a.type,
       e.name,
       d.value,
       a.sid
       --b.username,
       --b.osuser,
       --b.program
FROM   v$access a,
       v$session b,
       dba_objects c,
       v$sesstat d,
       v$statname e
WHERE  a.sid   = b.sid
AND    d.sid   = a.sid
AND    a.owner = c.owner
AND    a.object = c.object_name
AND    a.type = c.object_type
AND    a.type in ('TABLE', 'INDEX', 'MATERIALIZED VIEW', 'TABLE PARTITION', 'INDEX PARTITION')
AND    a.sid = d.sid
and    d.statistic# = e.statistic#
and    e.name like '%mem%'
ORDER BY a.owner, a.object;
