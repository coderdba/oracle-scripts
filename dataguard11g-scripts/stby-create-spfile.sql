whenever sqlerror exit

create pfile='/tmp/pfile' from spfile;
create spfile='+DATA_DG01/RL4DB3_TTC/spfile_RL4DB3.ora' from  pfile='/tmp/pfile';

set echo off
