-- http://dba.stackexchange.com/questions/31847/verifying-oraclenet-network-encryption
select a.sid,a.serial#, a.machine, a.username, a.osuser, b.osuser, 
b.AUTHENTICATION_TYPE, b.NETWORK_SERVICE_BANNER 
from v$session a, v$session_connect_info b
where a.sid=b.sid and a.serial#=b.serial# order by a.username, a.machine;
