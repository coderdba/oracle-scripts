# Shell script with embedded sql
#
# Very basic example
#

scriptname=$0
logfile=$scriptname.log
exec > $logfile 2>> $logfile

sqlplus -s username/password << EOF

select * from v\$instance;

EOF

grep ORA- $logfile
if [ $? -eq 0 ]
then
  echo ERR - There were errors in sql execution
  retcode=1
else
  echo INFO - Successful execution of sql script
  retcode=0
fi

cat $logfile
exit $retcode
