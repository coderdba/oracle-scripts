#!/bin/ksh
#
#  asm-move-datafile-with-rman.sh
#
#  Copy datafiles to another diskgroup
#
#

if [ $# -lt 2 ]
then
    echo "ERR - Provide arguments 1. file-list file  2. diskgroup to move the files"
    exit 1
fi

script=`basename $0`
file_list_file=$1
to_diskgroup=$2

logfileformat=${script}.${file_list_file}.${to_diskgroup}
rmantmpfile1=${logfileformat}.rman.tmp1
rmantmpfile2=${logfileformat}.rman.tmp2
rmantmpfile3=${logfileformat}.rman.tmp3
logfile=${logfileformat}.log

# need to get the new file name from the string
#   output file name=+NEW_DG/<db_unique_name>/datafile/my_ts.1097.923044943 tag=TAG20160920T092223 RECID=5 STAMP=923044953

exec > $logfile 2>> $logfile

echo "INFO - Starting script $script for file-list $file_list_file to move to diskgroup $to_diskgroup" `date`

# Loop through the file list
cat $file_list_file | while read datafile
do

echo ""
echo "INFO  - Starting file $datafile" `date`
echo "INFO - Backup as copy of $datafile"
rman target sys/password <<EOF > $rmantmpfile1
BACKUP AS COPY DATAFILE "${datafile}" FORMAT "+${to_diskgroup}";
EOF

cat $rmantmpfile1
echo

if (grep RMAN- $rmantmpfile1)
then
    echo "ERR - Error in backup-as-copy step for ${datafile}"
    echo "      Look in $rmantmpfile1 (contents below)"
    #cat $rmantmpfile1
    exit 1
fi

datafilecopy=`grep "output file name" $rmantmpfile1 | awk '{print $3}' | cut -d= -f2`

echo "INFO - Switch and recover file $datafilecopy - copy of $datafile"
rman target sys/password <<EOF > $rmantmpfile2
SQL "ALTER DATABASE DATAFILE ''${datafile}'' OFFLINE";
SWITCH DATAFILE "${datafile}" TO COPY;
RECOVER DATAFILE "${datafilecopy}";
SQL "ALTER DATABASE DATAFILE ''${datafilecopy}'' ONLINE";
EOF

cat $rmantmpfile2
echo

if (grep RMAN- $rmantmpfile2)
then
    echo "ERR - Error in backup-as-copy step for ${datafile}"
    echo "      Look in $rmantmpfile2 (contents below)"
    #cat $rmantmpfile2
    exit 1
fi

echo "INFO - Delete file $datafile"
rman target sys/password <<EOF > $rmantmpfile3
DELETE noprompt DATAFILECOPY "${datafile}";
EOF

cat $rmantmpfile3
echo

if (grep RMAN- $rmantmpfile3)
then
    echo "ERR - Error in delete-file step for ${datafile}"
    echo "      Look in $rmantmpfile3 (contents below)"
    #cat $rmantmpfile3
    exit 1
fi

echo "INFO  - Ending file $datafile" `date`
echo "-----------------------------------------------"
echo

done

echo "INFO - Ending script $script for file-list $file_list_file to move to diskgroup $to_diskgroup" `date`
