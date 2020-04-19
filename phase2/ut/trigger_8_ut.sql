alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_8.sql

timing start trigger_8

timing stop   
exit rollback