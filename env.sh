#!/bin/ksh

# Basic environment and standard log/tmp file setup

export oratab=/etc/oratab

# TBD - Modify the following lines to pick these from oratab based on the DB Name sent in

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/11.2.0.4.RAC
export ORACLE_SID=RAC29DB21 
#
export PATH=/bin:/sbin:/etc:/usr/bin:/usr/sbin:/usr/local/bin:/usr/lib:$ORACLE_HOME/bin:.
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export LIBPATH=$ORACLE_HOME/lib
export TNS_ADMIN=/usr/local/tns

scriptpath=$0
script=`basename $scriptpath`
scriptdir=`dirname $scriptpath`
cd $scriptdir
scriptdir=`pwd`
installdir=`dirname $scriptdir`

logdir=${scriptdir}
logfile=${logdir}/${script}.log
tmpfile1=${logdir}/${script}.tmp1
tmpfile2=${logdir}/${script}.tmp2
