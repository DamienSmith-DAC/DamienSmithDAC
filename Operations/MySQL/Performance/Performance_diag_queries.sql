#########################################################################
-- Diagnostic queries for MySQL instances
-- Run as dac_support
#########################################################################
-- get Slow queries

Select sql_text, (timer_end - timer_start)/1000000000 as time 
From performance_schema.events_statements_history_long
Where 1 = 1
and  (timer_end - timer_start) > 4*1000000000 
And event_name = 'statement/sql/select';

select *
from performance_schema.events_statements_history
where event_name = 'statement/sql/select';


Select sql_text, (timer_end - timer_start)/1000000000 as time 
From performance_schema.events_statements_history
Where 1 = 1
 and  (timer_end - timer_start) > 4*1000000000 
And event_name = 'statement/sql/select';


-- get queries with high execution time
select 
digest_text as query, count_star as exec_count, 
sec_to_time(sum_timer_wait/1000000000000) as exec_time_total,
sec_to_time(max_timer_wait/1000000000000) as exec_time_max, 
(avg_timer_wait/1000000000) as exec_time_avg_ms,
sum_rows_sent as rows_sent,
sum_rows_examined as rows_scanned
from performance_schema.events_statements_summary_by_digest 
order by sum_timer_wait desc;


-- Check current queries
show full processlist;


SELECT PROCESSLIST_ID AS id, PROCESSLIST_USER AS user, PROCESSLIST_HOST AS host, PROCESSLIST_DB AS db
     , PROCESSLIST_COMMAND AS command, PROCESSLIST_TIME AS time, PROCESSLIST_STATE AS state, LEFT(PROCESSLIST_INFO, 80) AS info
  FROM performance_schema.threads
 WHERE PROCESSLIST_ID IS NOT NULL
   AND PROCESSLIST_COMMAND NOT IN ('Sleep', 'Binlog Dump')
 ORDER BY PROCESSLIST_TIME ASC
;


-- get database sizes per engine
SELECT table_schema AS `schema`, engine, COUNT(*) AS `tables`
     , ROUND(SUM(data_length)/1024/1024, 0) AS data_mb, ROUND(SUM(index_length)/1024/1024, 0) index_mb
  FROM information_schema.tables
 WHERE table_schema NOT IN ('mysql', 'information_schema', 'performance_schema')
   AND engine IS NOT NULL
 GROUP BY table_schema, engine;
 
 
 SELECT table_schema AS 'schema', COUNT(*) AS 'tables'
, ROUND(SUM(data_length)/1024/1024, 0) AS data_mb, ROUND(SUM(index_length)/1024/1024, 0) index_mb
FROM information_schema.tables
WHERE table_schema NOT IN ('mysql', 'information_schema', 'performance_schema')
AND engine IS NOT NULL
GROUP BY table_schema;

-- get average run time per database
SELECT schema_name
     , SUM(count_star) count
     , ROUND(   (SUM(sum_timer_wait) / SUM(count_star))
              / 1000000) AS avg_microsec
  FROM performance_schema.events_statements_summary_by_digest
 WHERE schema_name IS NOT NULL
 GROUP BY schema_name;
 
 -- get count of statements that generated error
 SELECT schema_name
     , SUM(sum_errors) err_count
  FROM performance_schema.events_statements_summary_by_digest
 WHERE schema_name IS NOT NULL
 GROUP BY schema_name;
 
 
 -- get stats on inserts/updates/deletes
 SELECT object_type, object_schema, object_name
     , count_star, count_read, count_write, count_fetch
     , count_insert, count_update, count_delete
  FROM performance_schema.table_io_waits_summary_by_table
 WHERE count_star > 0
 ORDER BY count_star DESC
 
 
-- check sys variables
SHOW VARIABLES LIKE 'long_query_time'; -- 10 sec


-- check connection utilisation


select *
from sys.statement_analysis;


select *
from sys.statements_with_full_table_scans;

select *
from sys.statements_with_runtimes_in_95th_percentile;

select *
from sys.statements_with_sorting;

select *
from sys.statements_with_temp_tables;

select *
from sys.statements_with_errors_or_warnings;

-- show index 

SELECT DISTINCT
    TABLE_NAME, INDEX_NAME
FROM
    INFORMATION_SCHEMA.STATISTICS;
    
    
    SELECT user, host, event_name
     , sum_created_tmp_disk_tables AS tmp_disk_tables
     , sum_select_full_join AS full_join
     , sum_select_range_check AS range_check
     , sum_sort_merge_passes AS sort_merge
  FROM performance_schema.events_statements_summary_by_account_by_event_name
 WHERE sum_created_tmp_disk_tables > 0
    OR sum_select_full_join > 0
    OR sum_select_range_check > 0
    OR sum_sort_merge_passes > 0
 ORDER BY sum_sort_merge_passes DESC
 LIMIT 10
;    


SELECT left(digest_text, 64)
     , ROUND(SUM(timer_end-timer_start)/1000000000, 1) AS tot_exec_ms
     , ROUND(SUM(timer_end-timer_start)/1000000000/COUNT(*), 1) AS avg_exec_ms
     , ROUND(MIN(timer_end-timer_start)/1000000000, 1) AS min_exec_ms
     , ROUND(MAX(timer_end-timer_start)/1000000000, 1) AS max_exec_ms
     , ROUND(SUM(timer_wait)/1000000000, 1) AS tot_wait_ms
     , ROUND(SUM(timer_wait)/1000000000/COUNT(*), 1) AS avg_wait_ms
     , ROUND(MIN(timer_wait)/1000000000, 1) AS min_wait_ms
     , ROUND(MAX(timer_wait)/1000000000, 1) AS max_wait_ms
     , ROUND(SUM(lock_time)/1000000000, 1) AS tot_lock_ms
     , ROUND(SUM(lock_time)/1000000000/COUNT(*), 1) AS avglock_ms
     , ROUND(MIN(lock_time)/1000000000, 1) AS min_lock_ms
     , ROUND(MAX(lock_time)/1000000000, 1) AS max_lock_ms
     , MIN(LEFT(DATE_SUB(NOW(), INTERVAL (isgs.VARIABLE_VALUE - TIMER_START*10e-13) second), 19)) AS first_seen
     , MAX(LEFT(DATE_SUB(NOW(), INTERVAL (isgs.VARIABLE_VALUE - TIMER_START*10e-13) second), 19)) AS last_seen
     , COUNT(*) as cnt
  FROM performance_schema.events_statements_history_long
  JOIN information_schema.global_status AS isgs
 WHERE isgs.variable_name = 'UPTIME'
 GROUP BY LEFT(digest_text,64)
 ORDER BY tot_exec_ms DESC
;
    
    
SHOW INDEX FROM SIRA_CLOUD.ClaimsData;  

-- get explain plan
explain  extended select * from SIRA_CLOUD.ClaimsData; 
