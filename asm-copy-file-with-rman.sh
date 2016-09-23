#!/bin/ksh

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

# need to get the new file name from the string
#   output file name=+NEW_DG/<db_unique_name>/datafile/my_ts.1097.923044943 tag=TAG20160920T092223 RECID=5 STAMP=923044953

cat $file_list_file | while read datafile
do

# First do rman copy datafile
rman target sys/password <<EOF > $rmantmpfile1
BACKUP AS COPY DATAFILE "${datafile}" FORMAT "+${to_diskgroup}";
EOF


rman target sys/password <<EOF
SQL "ALTER DATABASE DATAFILE ''${datafile}'' OFFLINE";
SWITCH DATAFILE "${datafile}" TO COPY;
RECOVER DATAFILE "${datafilecopy}";
SQL "ALTER DATABASE DATAFILE ''${datafilecopy}'' ONLINE";
DELETE DATAFILECOPY "${datafile}";
EOF

done
