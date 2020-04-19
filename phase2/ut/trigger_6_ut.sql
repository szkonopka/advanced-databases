
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_6.sql

timing start trigger_6

timing stop   

exit rollback