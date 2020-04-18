alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_9.sql

timing start trigger_9

timing stop   
exit rollback