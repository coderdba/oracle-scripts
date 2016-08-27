-- For parallel queries - PROGRAM will show up as P0NN the parallel processors
select username, command, program, to_Char(logon_time, 'DD-MON-YYYY HH24:MI'), sql_id from v$session order by 1,2
