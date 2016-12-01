select B.USERNAME ||' ('||B.SID||','||B.SERIAL#||',@'||B.INST_ID||') is Currently '||B.STATUS||' for last '||B.LAST_CALL_ET||' Sec and it''s BLOCKING user'||
W.USERNAME|| ' ('||W.SID||','||W.SERIAL#||',@'||W.INST_ID||')' from
(select INST_ID,SID,SERIAL#,USERNAME,STATUS,BLOCKING_INSTANCE,BLOCKING_SESSION, LAST_CALL_ET from gv\$session where BLOCKING_SESSION >0) W,
(select INST_ID,SID,SERIAL#,USERNAME,STATUS,LAST_CALL_ET from gv\$session ) B
where W.BLOCKING_INSTANCE=B.INST_ID and W.BLOCKING_SESSION=B.SID;
