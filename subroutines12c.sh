#---------------------------------------------------------------------
#
#  subroutines.sh
#
#  subroutines for createdb.sh
#  gowrish m
#  sep 2014
#
#---------------------------------------------------------------------

#---------------------------------------
# subroutines begin
#---------------------------------------

set_env()
{
# oracle directories
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/u01/app/oracle/product/12.1.0.2.DB
export GRID_HOME=/u01/app/GRID/12.1.0.2
export ORATAB=/etc/oratab

# oracle version, characterset etc
export VERSION=12.2.0.2
export CHAR_SET=AL32UTF8

# db names
export DB_NAME=ORADB1
export DB_UNIQUE_NAME=ORADB1_SITE1
export ORACLE_SID=ORADB11

# host and nodes
export HOSTNAME=node1
export NODE_LIST="node1,node2"
export NODE_NUMBER=1

# log files, config files
export LOGFILE=createdb11g.sh.log.$DB_UNIQUE_NAME
export DB_CONFIG_FILE=ORADB1_SITE1.conf

# paths
export LIBPATH=/lib
export PATH=/bin:/usr/ccs/bin:/usr/bin:/usr/sbin:/usr/ucb:/bin:/jdk/bin:/etc:/usr/openwin/bin:/opt/cobol/bin:/opt/reel/bin:/usr/local/bin:/opt/oracle/bin:/opt/oracle/product/jre:/opt/oracle/product/jre/1.1.8:/usr/platform/sun4u/sbin:/jdk/bin:$ORACLE_HOME/bin:$GRID_HOME/bin:.
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib:/lib:/usr/dt/lib:/usr/openwin/bin:/usr/ucblib

# which dbca
export DBCA=$ORACLE_HOME/bin/dbca
}

#---------------------------------------
# subroutines end
#---------------------------------------
