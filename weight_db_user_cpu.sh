#!/bin/ksh
#
#

script=$0
script_basename=`basename $script`
script_dirname=`dirname $script`
host_name=`hostname`
templog=/tmp/${script_basename}.log.${host_name}
outfile=${script}.out.${host_name}

for dbname in `ps -ef|grep pmon |grep -v grep |grep -v ASM | awk '{print $8}' | cut -d_ -f3`
do

export ORACLE_SID=$dbname
export ORACLE_HOME=`cat /etc/oratab | grep ^${dbname}: | cut -d: -f2`
export PATH=/bin:/usr/ccs/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/ucb:$ORACLE_HOME/bin:.
export LD_LIBRARY_PATH=$ORACLE_HOME/lib

#  Fetch  DBNAME, DATE-TIME, USERNAE, STATISTIC, SUM OF STATISTIC VALUE
sqlplus -s / as sysdba <<EOF > $templog 2>>$templog
set echo off
set feed off
set head off

select d.name || ',' || to_char(sysdate, 'DD-MON-YYYY HH24:MI') || ',' || nvl(a.username, 'BACKGROUND PROC') || ',' || b.name || ',' || sum(c.value)
from gv\$session a, v\$statname b, gv\$sesstat c, v\$database d
where a.sid=c.sid and b.statistic# = c.statistic# and b.name = 'CPU used by this session'
group by d.name, a.username, b.name;
EOF

grep ORA- $templog
if [ $? -ne 0 ]
then
cat $templog | grep -v ^$ >> $outfile
else
echo "${dbname},ERR,ERR,ERR,ERR,ERR" >> $outfile
fi

done
