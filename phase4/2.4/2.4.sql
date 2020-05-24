alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.4_1;

SELECT AVG(SDO_GEOM.SDO_DISTANCE(c.localization, so.localization, 0.005, 'unit=KM')) as distance
FROM customer c JOIN sales_outlet so ON c.home_sales_outlet_id = so.id;

TIMING STOP;

TIMING START 2.4_1;

SELECT AVG(SQRT(POWER(c.localization.sdo_point.x - so.localization.sdo_point.x, 2) + 
POWER(COS(so.localization.sdo_point.x * 3.14/180) * c.localization.sdo_point.y - so.localization.sdo_point.y, 2)) * 40075.704/360) distance 
FROM customer c JOIN sales_outlet so ON c.home_sales_outlet_id = so.id;

TIMING STOP;

EXIT;