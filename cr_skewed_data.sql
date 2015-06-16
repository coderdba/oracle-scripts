-- Taken from Tom Kyte's http://www.oracle.com/technetwork/issue-archive/2014/14-nov/o64asktom-2298498.html

-- Code Listing 1: Creating table T and skewed data
create table t as
  select case when mod(rownum,200000) = 0 then 5
              else mod(rownum,4)
         end X,
         rpad( 'x', 100, 'x' ) data
      from dual
    connect by level <= 1000000;

create index t_idx on t(x);

exec dbms_stats.gather_table_stats( user, 'T' );

select x, count(*)
 from t
group by x
order by x;
--  OUTPUT ROW-COUNTS
--         X   COUNT(*)
-- ———————————  ———————————
--         0     249995
--         1     250000
--         2     250000
--         3     250000
--         5          5
