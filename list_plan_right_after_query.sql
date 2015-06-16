--
-- This will list rows selected and rows scanned as well
--
-- https://blogs.oracle.com/optimizer/entry/how_do_i_know_if
-- http://www.oracle.com/technetwork/issue-archive/2014/14-nov/o64asktom-2298498.html
--

select *
     from table(dbms_xplan.display_cursor( format=> 'allstats last' ));
