
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_2.sql

timing start trigger_2

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id) 
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,1540);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2806);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id) 
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4938);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4031);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2078);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2522);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3366);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,465);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,862);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (trunc(sysdate), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3743);

begin
    dbms_scheduler.run_job(job_name => 'sales_statement');
end;
/

timing stop   
exit rollback