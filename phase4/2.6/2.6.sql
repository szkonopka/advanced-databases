alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.6;

SELECT 

TIMING STOP;

EXIT;