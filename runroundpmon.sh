#!/bin/ksh


ps -ef|grep pmon |grep -v grep |grep -v ASM | grep -v ksh | while read line
do

sid=`echo $line | awk '{print $8}' | cut -d_ -f3`


export ORACLE_SID=$sid
export ORACLE_HOME=`grep $sid /etc/oratab | cut -d: -f2`
export PATH=/bin:/sbin:/usr/bin:/usr/local/bin:/usr/sbin:$ORACLE_HOME/bin
export LD_LIBRARAY_PATH=$ORACLE_HOME/lib

#echo line=$line
#echo sid=$ORACLE_SID
#echo path=$PATH

sqlplus -s / as sysdba <<EOF

set head off

/*
select name, log_mode, database_role, open_mode from v\$database;

select a.total_gb + b.total_gb total_size_gb
from (select (round ( sum(bytes)/(1024*1024*1024))) total_gb from v\$datafile) a,
     (select (round ( sum(bytes)/(1024*1024*1024))) total_gb from v\$tempfile) b ;
*/

select c.name, c.log_mode, c.database_role, c.open_mode, a.total_gb + b.total_gb total_size_gb
from (select (round ( sum(bytes)/(1024*1024*1024))) total_gb from v\$datafile) a,
     (select (round ( sum(bytes)/(1024*1024*1024))) total_gb from v\$tempfile) b,
     (select name, log_mode, database_role, open_mode from v\$database) c;

EOF

done
