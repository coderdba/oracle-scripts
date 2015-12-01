-- http://www.dbapundits.com/blog/query-script/hourly-daily-archive-generation/

-- Daily
set pages 1000
select trunc(COMPLETION_TIME,'DD') Day, thread#, round(sum(BLOCKS*BLOCK_SIZE)/1048576) MB,count(*) Archives_Generated from v$archived_log
group by trunc(COMPLETION_TIME,'DD'),thread# order by 1;

-- Hourly
set pages 1000
select trunc(COMPLETION_TIME,'HH') Hour,thread# , round(sum(BLOCKS*BLOCK_SIZE)/1048576) MB,count(*) Archives from v$archived_log
group by trunc(COMPLETION_TIME,'HH'),thread#  order by 1 ;

-- Hourly last one week
SELECT to_date(first_time) DAY,
to_char(sum(decode(to_char(first_time,'HH24'),'00',1,0)),'99') "00",
to_char(sum(decode(to_char(first_time,'HH24'),'01',1,0)),'99') "01",
to_char(sum(decode(to_char(first_time,'HH24'),'02',1,0)),'99') "02",
to_char(sum(decode(to_char(first_time,'HH24'),'03',1,0)),'99') "03",
to_char(sum(decode(to_char(first_time,'HH24'),'04',1,0)),'99') "04",
to_char(sum(decode(to_char(first_time,'HH24'),'05',1,0)),'99') "05",
to_char(sum(decode(to_char(first_time,'HH24'),'06',1,0)),'99') "06",
to_char(sum(decode(to_char(first_time,'HH24'),'07',1,0)),'99') "07",
to_char(sum(decode(to_char(first_time,'HH24'),'08',1,0)),'99') "08",
to_char(sum(decode(to_char(first_time,'HH24'),'09',1,0)),'99') "09",
to_char(sum(decode(to_char(first_time,'HH24'),'10',1,0)),'99') "10",
to_char(sum(decode(to_char(first_time,'HH24'),'11',1,0)),'99') "11",
to_char(sum(decode(to_char(first_time,'HH24'),'12',1,0)),'99') "12",
to_char(sum(decode(to_char(first_time,'HH24'),'13',1,0)),'99') "13",
to_char(sum(decode(to_char(first_time,'HH24'),'14',1,0)),'99') "14",
to_char(sum(decode(to_char(first_time,'HH24'),'15',1,0)),'99') "15",
to_char(sum(decode(to_char(first_time,'HH24'),'16',1,0)),'99') "16",
to_char(sum(decode(to_char(first_time,'HH24'),'17',1,0)),'99') "17",
to_char(sum(decode(to_char(first_time,'HH24'),'18',1,0)),'99') "18",
to_char(sum(decode(to_char(first_time,'HH24'),'19',1,0)),'99') "19",
to_char(sum(decode(to_char(first_time,'HH24'),'20',1,0)),'99') "20",
to_char(sum(decode(to_char(first_time,'HH24'),'21',1,0)),'99') "21",
to_char(sum(decode(to_char(first_time,'HH24'),'22',1,0)),'99') "22",
to_char(sum(decode(to_char(first_time,'HH24'),'23',1,0)),'99') "23"
from
v$log_history
where to_date(first_time) > sysdate -8
GROUP by
to_char(first_time,'YYYY-MON-DD'), to_date(first_time)
order by to_date(first_time)
/
