alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.3;

SELECT c.id, SDO_GEOM.SDO_DISTANCE(c.localization, so.localization, 0.005, 'unit=KM') as distance
FROM customer c JOIN sales_outlet so ON c.home_sales_outlet_id = so.id
ORDER BY distance DESC;

TIMING STOP;

EXIT;