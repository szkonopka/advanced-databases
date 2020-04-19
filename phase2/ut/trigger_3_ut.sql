alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics
timing start trigger_3_prep

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id) 
values (to_date('01/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,1540);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2806);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id) 
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4938);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4031);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2078);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2522);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3366);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('03/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,465);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('03/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,862);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('04/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3743);

update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 1540 and pi.TRANSACTION_DATE = to_date('01/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 2806 and pi.TRANSACTION_DATE = to_date('02/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 4938 and pi.TRANSACTION_DATE = to_date('02/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 4031 and pi.TRANSACTION_DATE = to_date('02/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 2078 and pi.TRANSACTION_DATE = to_date('02/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 2522 and pi.TRANSACTION_DATE = to_date('02/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 3366 and pi.TRANSACTION_DATE = to_date('02/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 465 and pi.TRANSACTION_DATE = to_date('03/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 862 and pi.TRANSACTION_DATE = to_date('03/04/2019', 'DD/MM/YYYY');
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 3743 and pi.TRANSACTION_DATE = to_date('04/04/2019', 'DD/MM/YYYY');
   
timing stop   
rollback
/

@triggers/trigger_3.sql

timing start trigger_3

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id) 
values (to_date('01/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,1540);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2806);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id) 
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4938);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4031);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2078);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2522);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('02/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3366);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('03/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,465);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('03/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,862);

insert into SALES_RECEIPT (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
values (to_date('04/04/2019', 'DD/MM/YYYY'), 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3743);
timing stop
exit rollback