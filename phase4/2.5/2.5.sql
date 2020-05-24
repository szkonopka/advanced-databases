alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.5;

SELECT 

TIMING STOP;

EXIT;