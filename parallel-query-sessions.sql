

set echo on
-- Parent

prompt Parent Sessions
WITH px_session AS (
   SELECT
      qcsid,
      qcserial#,
      MAX (degree) degree,
      MAX (req_degree) req_degree,
      COUNT ( * ) no_of_processes
   FROM
      v$px_session p
   GROUP BY qcsid, qcserial#)
SELECT
   s.sid,
   s.username,
   degree,
   req_degree,
   no_of_processes,
   sql_text
FROM
   v$session s
JOIN
   px_session p
ON
   (s.sid = p.qcsid AND s.serial# = p.qcserial#)
JOIN
   v$sql sql
ON
   (sql.sql_id = s.sql_id
AND
   sql.child_number = s.sql_child_number);

-- Child
prompt Child Sessions
 select

     ps.qcsid,

     ps.sid,

     p.spid,

     ps.inst_id,

     ps.degree,

     ps.req_degree

   from
 For full scripts, download the Oracle script collection.  

     gv$px_session ps

     join

     gv$session s

        on ps.sid=s.sid

           and

           ps.inst_id=s.inst_id

     join

     gv$process p

        on p.addr=s.paddr

        and

        p.inst_id=s.inst_id

   order by

     qcsid,

     server_group desc,

     inst_id,

     sid;
