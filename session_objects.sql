SELECT a.object,
       a.type,
       a.sid,
       b.username,
       b.osuser,
       b.program
FROM   v$access a,
       v$session b
WHERE  a.sid   = b.sid
AND    a.owner = UPPER('&ENTER_SCHEMA_NAME')
AND    a.sid = &enter_session_id
ORDER BY a.object
/
