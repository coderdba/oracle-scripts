select b.object_name, a.session_id, a.os_user_name, a.locked_mode, c.machine, c.module
from gv$locked_object a, dba_objects b, gv$session c
where a.object_id= b.object_id and b.object_name='YFS_ORDER_HEADER'
and c.sid=a.session_id;
