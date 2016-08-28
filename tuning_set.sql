-- Increase time limit for the advisor task to use (to avoid timeout error)
--    the current operation was interrupted because it timed out
-- http://www.dba-oracle.com/t_ora_13639_current_operation_was_interrupted_timeout.htm
BEGIN   DBMS_SQLTUNE.SET_AUTO_TUNING_TASK_PARAMETER(parameter => 'TIME_LIMIT', value => '7200'); END;

-- Create the task
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

-- Run the task
exec dbms_sqltune.execute_tuning_task(task_name => 'sqltune_4d52dww11d728');

-- Verify completion
select task_name, status
from dba_advisor_log
where owner = 'SYS';

-- Generate advisor output
set long 10000;
set pagesize 1000
set linesize 220
set pagesize 24
--select dbms_sqltune.report_tuning_task('4d52dww11d728_tune_report') as output

select dbms_sqltune.report_tuning_task('sqltune_4d52dww11d728') as output
from dual;
