#!/bin/ksh 

#source the password file
. ./path_to/secret_data.txt
sqlplus -s username/$sys_pass@wherever as sysdba << END
...
END
