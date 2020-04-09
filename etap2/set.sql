alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics
timing start regula_3

insert into SALES_RECEIPT values (49895, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,1540);
insert into SALES_RECEIPT values (49896, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2806);
insert into SALES_RECEIPT values (49897, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4938);
insert into SALES_RECEIPT values (49898, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4031);
insert into SALES_RECEIPT values (49899, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2078);
insert into SALES_RECEIPT values (49900, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2522);
insert into SALES_RECEIPT values (49901, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3366);
insert into SALES_RECEIPT values (49902, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,465);
insert into SALES_RECEIPT values (49903, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,862);
insert into SALES_RECEIPT values (49904, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3743);

update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 1540 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 2806 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 4938 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 4031 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 2078 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 2522 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 3366 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 465 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 862 and pi.TRANSACTION_DATE = trunc(sysdate);
update PASTRY_INVENTORY pi
   set QUANTITY_SOLD = QUANTITY_SOLD + 1, pi.WASTE = pi.WASTE - 1,pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where pi.PRODUCT_ID = 3743 and pi.TRANSACTION_DATE = trunc(sysdate);
   
timing stop   
rollback
/
create or replace trigger sprzedane_produkty
   after insert
   on sales_receipt
   for each row
begin
   update pastry_inventory pi
   set pi.quantity_sold    = pi.quantity_sold + :new.quantity,
       pi.waste            = pi.waste - :new.quantity,
       pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
   where trunc(:new.transaction_datetime) = pi.transaction_date and :new.product_id = pi.product_id;
end;
/

timing start regula_3_trigger
insert into SALES_RECEIPT values (49895, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,1540);
insert into SALES_RECEIPT values (49896, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2806);
insert into SALES_RECEIPT values (49897, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4938);
insert into SALES_RECEIPT values (49898, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,4031);
insert into SALES_RECEIPT values (49899, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2078);
insert into SALES_RECEIPT values (49900, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,2522);
insert into SALES_RECEIPT values (49901, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3366);
insert into SALES_RECEIPT values (49902, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,465);
insert into SALES_RECEIPT values (49903, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,862);
insert into SALES_RECEIPT values (49904, sysdate, 0, 1, 1, 1, 2, 2, 0, 1, 1, 1,3743);
timing stop

exit rollback