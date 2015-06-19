#!/bin/ksh
#
#  Deduce CPU weightage of users across all databases in a server/cluster
#
#

script=$0
script_basename=`basename $script`
script_dirname=`dirname $script`
host_name=`hostname`
templog=/tmp/${script_basename}.log.${host_name}
outfile=${script}.out.${host_name}
sqlfile=${outfile}.sql
analysisfile1=${outfile}-analysis1.lst
analysisfile2=${outfile}-analysis2.lst

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

-- Note - whether SYS is to be included or not - mostly not as in the sql below
select d.name || ',' || to_char(sysdate, 'DD-MON-YYYY HH24:MI') || ',' || nvl(a.username, 'BACKGROUND PROC') || ',' || b.name || ',' || sum(c.value)
from gv\$session a, v\$statname b, gv\$sesstat c, v\$database d
where a.sid=c.sid and b.statistic# = c.statistic# and b.name = 'CPU used by this session'
and   a.username is not null
and   a.username not in ('SYS')
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

# Generate insert statements (this can be done in the select statement above itself)
cat $outfile | while read line
do

dbname=`echo $line |cut -d, -f1`
timestamp=`echo $line |cut -d, -f2`
username=`echo $line |cut -d, -f3`
statistic=`echo $line |cut -d, -f4`
statisticvalue=`echo $line |cut -d, -f5`

echo "insert into dbuserstathist values ('$dbname','$timestamp','$username','$statistic',$statisticvalue);" >> $sqlfile

done

# Insert data and do analysis
export ORACLE_SID=ODRDB11

sqlplus -s / as sysdba <<EOF

-- Drop and re-create table 
drop table dbuserstathist;
create table test.dbuserstathist 
(dbname varchar2(10), 
time_stamp varchar2(20), 
user_name varchar2(20), 
statistic_name varchar2(100), 
statistic_value number(20)
);

-- Insert data
@$sqlfile
commit;

-- Do analysis
set lines 120
set pages 1000

column dbname format a10
column time_stamp format a20
column user_name format a20
column statistic_name format a30
column pct_weight_at_cluster format 990

spool $analysisfile1

prompt
prompt Percent Weight Ordered by Timestamp, DB, User
prompt

select a.time_stamp, a.dbname, a.user_name, a.statistic_name, round(100*a.statistic_value/b.statistic_sum, 0) pct_weight_at_cluster
from test.dbuserstathist a,
(select time_stamp, statistic_name, sum(statistic_value) statistic_sum
 from test.dbuserstathist
 group by  time_stamp, statistic_name) b
where a.time_stamp=b.time_stamp and a.statistic_name=b.statistic_name
order by 1,2,3,4;

spool off

spool $analysisfile2

prompt
prompt Percent Weight Ordered by DB, User, Timestamp
prompt

select a.time_stamp, a.dbname, a.user_name, a.statistic_name, round(100*a.statistic_value/b.statistic_sum, 0) pct_weight_at_cluster
from test.dbuserstathist a,
(select time_stamp, statistic_name, sum(statistic_value) statistic_sum
 from test.dbuserstathist
 group by  time_stamp, statistic_name) b
where a.time_stamp=b.time_stamp and a.statistic_name=b.statistic_name
order by 2,3,1,4;

spool off


EOF

