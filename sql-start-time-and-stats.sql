select username, sql_id, to_char(sql_exec_start, 'DD-MON-YYYY HH24:MI'), CONCURRENCY_WAIT_TIME  from v$sql_monitor order by 1,2
