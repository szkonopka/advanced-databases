alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_7.sql

timing start trigger_7

timing stop   
exit rollback