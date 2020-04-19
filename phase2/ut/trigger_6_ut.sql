
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

timing start trigger_6_prep

DELETE FROM sales_outlet_target sot 
WHERE sot.sales_outlet_id = 3;

DELETE FROM pastry_inventory pi
WHERE pi.sales_outlet_id = 3;

UPDATE sales_receipt sr
SET sr.sales_outlet_id = NULL
WHERE sr.sales_outlet_id = 3;

UPDATE staff s
SET s.sales_outlet_id = NULL
WHERE s.sales_outlet_id = 3;

UPDATE customer c
SET c.home_sales_outlet_id = NULL
WHERE c.home_sales_outlet_id = 3;

timing stop   
rollback
/

@triggers/trigger_6.sql

timing start trigger_6

DELETE FROM sales_outlet so
WHERE so.id = 3;

timing stop   

exit rollback