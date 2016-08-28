-- query1
select username, status, sql_id, WAIT_CLASS, SECONDS_IN_WAIT, SERVICE_NAME from v$session
where sql_id is not null
order by 1;

