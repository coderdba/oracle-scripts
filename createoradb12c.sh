#!/bin/ksh
#--------------------------------------------------------------------------------
#
# createdb12c.sh
# Sep 2014
#
# to create oracle 12c rac database
#
#--------------------------------------------------------------------------------

echo INFO - starting `date`
echo

#--------------------------------------------------------
# source in subroutines
echo INFO - sourcing subroutines
. subroutines12c.sh

#--------------------------------------------------------
# call environment subroutine
echo INFO - calling set_env to set environment
set_env

echo INFO - environment variables listing:
env

echo

#exit 101

#--------------------------------------------------------
# run dbca
echo INFO - Starting dbca
dbcacommand="dbca -createPluggableDatabase -sourceDB $DB_UNIQUE_NAME -pdbName P2 -pdbAdminPassword lhf$DB_NAME

echo
echo $dbcacommand

echo
echo INFO - Running dbca command
$dbcacommand

echo INFO - Ending dbca
