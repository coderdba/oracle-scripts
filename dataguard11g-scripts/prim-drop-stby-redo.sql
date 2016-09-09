select GROUP# from  gv$standby_log order by 1;

alter database drop standby logfile group 101;
alter database drop standby logfile group 102;
alter database drop standby logfile group 103;

alter database drop standby logfile group 201;
alter database drop standby logfile group 202;
alter database drop standby logfile group 203;

select GROUP# from  gv$standby_log order by 1;
