SELECT s.sid, s.serial#, s.username, s.osuser, p.spid unix_process, s.machine, p.terminal, s.program, s.terminal
FROM v$session s, v$process p
WHERE s.paddr = p.addr
and s.machine like 'host1%'
and s.terminal = 'pts/2';
