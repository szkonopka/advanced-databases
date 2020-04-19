
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = 0, pi.WASTE = 0,pi.waste_percentage = 0
   where pi.PRODUCT_ID = 1540 and pi.TRANSACTION_DATE = trunc(sysdate);

@triggers/trigger_4.sql

timing start trigger_4

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id) 
values (sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,1540);

timing stop   
rollback
/

exit rollback