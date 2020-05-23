alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.2;

SELECT so.* FROM sales_outlet so, customer c 
    WHERE SDO_RELATE(so.delivery_range, c.localization, 'mask=CONTAINS querytype=JOIN') = 'TRUE' AND c.id = 1;

TIMING STOP;

EXIT;