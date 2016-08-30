--http://asmsupportguy.blogspot.in/2012/07/when-will-my-rebalance-complete.html
select INST_ID, OPERATION, STATE, POWER, SOFAR, EST_WORK, EST_RATE, EST_MINUTES from GV$ASM_OPERATION where GROUP_NUMBER=1;


/*******************
   INST_ID OPERA STAT      POWER      SOFAR   EST_WORK   EST_RATE EST_MINUTES
---------- ----- ---- ---------- ---------- ---------- ---------- -----------
         3 REBAL WAIT          1
         2 REBAL RUN           1        516      53736       2012          26
         4 REBAL WAIT          1

About 10 minutes into the rebalance, the estimate is 24 minutes:

16:50:25 SQL> /

   INST_ID OPERA STAT      POWER      SOFAR   EST_WORK   EST_RATE EST_MINUTES
---------- ----- ---- ---------- ---------- ---------- ---------- -----------
         3 REBAL WAIT          1
         2 REBAL RUN           1      19235      72210       2124          24
         4 REBAL WAIT          1

While that EST_MINUTES doesn't give me much confidence, I see that the SOFAR (number of allocation units moved so far) 
is going up, which is a good sign.

*******************/
