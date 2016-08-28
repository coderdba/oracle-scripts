DECLARE
  v_tune_taskid  VARCHAR2(100);
BEGIN
  v_tune_taskid := dbms_sqltune.create_tuning_task (
                          sql_id      => '4d52dww11d728',
                          scope       => dbms_sqltune.scope_comprehensive,
                          time_limit  => 30,
                          task_name   => 'sqltune_4d52dww11d728',
                          description => 'Tuning task sql_id 4d52dww11d728');
  dbms_output.put_line('taskid = ' || v_tune_taskid);
END;
/

exec dbms_sqltune.execute_tuning_task(task_name => 'sqltune_4d52dww11d728');

select task_name, status
from dba_advisor_log
where owner = 'SYS';

set long 10000;
set pagesize 1000
set linesize 220
set pagesize 24
--select dbms_sqltune.report_tuning_task('4d52dww11d728_tune_report') as output

select dbms_sqltune.report_tuning_task('sqltune_4d52dww11d728') as output
from dual;
