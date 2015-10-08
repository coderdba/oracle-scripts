set pages 1000
set echo on
spool check1

select * from DBA_2PC_PENDING;
select * from DBA_2PC_NEIGHBORS;
select * from sys.pending_trans$;
select * from SYS.PENDING_SESSIONS$;
select * from SYS.PENDING_SUB_SESSIONS$;

SELECT KTUXEUSN, KTUXESLT, KTUXESQN, /* Transaction ID */
KTUXESTA Status,
KTUXECFL Flags
FROM x$ktuxe
WHERE ktuxesta!='INACTIVE' ;

spool off
