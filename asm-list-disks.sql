spool list-disks

set lines 100
set pages 50

column path format a30

select header_status, count(*) from v$asm_disk group by header_status;

select header_status, name, path from v$asm_disk order by 1,2,3;

select header_status, name, path, mount_status, mode_status, state, redundancy, total_mb, free_mb
from v$asm_disk order by 1,2,3;

select a.name dg_name, b.header_status, b.name, b.path, b.mount_status, b.mode_status, b.state, b.redundancy, b.total_mb, b.free_mb
from v$asm_diskgroup a,
     v$asm_disk b
where a.group_number=b.group_number
order by 1,3,4;

set pages 1000
set head off
select path from v$asm_disk where path like '%NEW%' order by 1;

set pages 50
set head on

spool off
