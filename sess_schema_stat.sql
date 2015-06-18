column owner format a10
column type format a20
column name format a20
column value format 999999999990
SELECT a.owner,
       a.type,
       substr(e.name,1, 20) stat_name,
       sum(d.value)
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
--AND    a.type in ('TABLE', 'INDEX', 'MATERIALIZED VIEW', 'TABLE PARTITION', 'INDEX PARTITION')
AND    a.sid = d.sid
and    d.statistic# = e.statistic#
and    e.name like '%mem%'
group BY a.owner, a.type, e.name
--ORDER BY a.owner, a.type, e.name
;
