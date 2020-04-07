-- ZESTAW GRZEGORZ STALA

alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics
alter session set NLS_TIMESTAMP_FORMAT = 'HH:MI:SS.FF6';
timing start zestaw_transakcji_gs

-- QUERY 1
prompt '1st QUERY'
select G.NAME, ROUND(AVG(S.LINE_ITEM_AMOUNT),2) as avgLineItemAmount from CUSTOMER C
    join GENERATION G on C.GENERATION_ID = G.ID
    join SALES_RECEIPT S on C.ID = S.CUSTOMER_ID
group by G.NAME;

-- QUERY 2
prompt '2nd QUERY'
select * from (
select s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME,so.CITY, SUM(round(pi.waste * sr.LINE_ITEM_AMOUNT, 2)) as waste, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_OUTLET so on s.ID = so.MANAGER_STAFF_ID
    join SALES_RECEIPT sr on so.ID = sr.SALES_OUTLET_ID
    join PASTRY_INVENTORY pi on pi.TRANSACTION_DATE = trunc(sr.TRANSACTION_DATETIME) and pi.PRODUCT_ID = sr.PRODUCT_ID
    join PRODUCT on pi.PRODUCT_ID = PRODUCT.ID AND sr.PRODUCT_ID = PRODUCT.ID
    WHERE months_between(sysdate, SR.TRANSACTION_DATETIME) < 1000
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME, so.CITY
    order by WASTE) where ROWNUM <= 50
union
select * from (
select s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME,so.CITY, SUM(round(pi.waste * sr.LINE_ITEM_AMOUNT, 2)) as waste, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_OUTLET so on s.ID = so.MANAGER_STAFF_ID
    join SALES_RECEIPT sr on so.ID = sr.SALES_OUTLET_ID
    join PASTRY_INVENTORY pi on pi.TRANSACTION_DATE = trunc(sr.TRANSACTION_DATETIME) and pi.PRODUCT_ID = sr.PRODUCT_ID
    join PRODUCT on pi.PRODUCT_ID = PRODUCT.ID AND sr.PRODUCT_ID = PRODUCT.ID
    WHERE months_between(sysdate, SR.TRANSACTION_DATETIME) < 1000
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME, so.CITY
    order by WASTE DESC ) where ROWNUM <= 50

-- QUERY 3
prompt '3rd QUERY'
select * from (
select P.ID, PC.NAME, PY.WASTE_PERCENTAGE, PY.TRANSACTION_DATE, 'GOOD' as status from PRODUCT P
    join PASTRY_INVENTORY PY on P.ID = PY.PRODUCT_ID
    join PRODUCT_CATEGORY PC on P.PRODUCT_CATEGORY_ID = PC.ID
    order BY PY.WASTE_PERCENTAGE) res1 where months_between(sysdate, res1.TRANSACTION_DATE) < 1000 AND ROWNUM <= 50
union
select * from (
select P.ID, PC.NAME, PY.WASTE_PERCENTAGE, PY.TRANSACTION_DATE, 'BAD' as status from PRODUCT P
    join PASTRY_INVENTORY PY on P.ID = PY.PRODUCT_ID
    join PRODUCT_CATEGORY PC on P.PRODUCT_CATEGORY_ID = PC.ID
    order BY PY.WASTE_PERCENTAGE DESC) res2  where months_between(sysdate, res2.TRANSACTION_DATE) < 1000 AND ROWNUM <= 50;

-- QUERY 4
prompt '4th QUERY'
select * from (
select S.ID, S.FIRST_NAME, s.LAST_NAME, p.NAME, COUNT(*) as sales, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_RECEIPT sr on s.ID = sr.STAFF_ID
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME order by COUNT(*)) res1 where ROWNUM <= 50
union
select * from (
select S.ID, S.FIRST_NAME, s.LAST_NAME, p.NAME, COUNT(*) as sales, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_RECEIPT sr on s.ID = sr.STAFF_ID
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME order by COUNT(*) DESC) res2 where ROWNUM <= 50;

-- QUERY 5
prompt '5th QUERY'
select cus.id, cus.FULL_NAME, g.NAME, so.ID as salesOutletId, COUNT(*) as sales, SUM(sr.LINE_ITEM_AMOUNT) as total from CUSTOMER cus
    join SALES_RECEIPT sr on cus.ID = sr.CUSTOMER_ID
    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
    join GENERATION G on cus.GENERATION_ID = G.ID
    where months_between(sysdate, sr.TRANSACTION_DATETIME) < 1000 and ROWNUM <= 50
    group by cus.ID, cus.FULL_NAME, g.NAME, so.ID order by SUM(sr.LINE_ITEM_AMOUNT) DESC ;

-- COMMAND 1
prompt '1st COMMAND'
update STAFF
    set POSITION_ID = (select id from POSITION where NAME like 'CEO%')
    where ID in (
        select * from (
select st.ID from staff st
    join SALES_RECEIPT sr on st.ID = sr.STAFF_ID
    WHERE months_between(sysdate, SR.TRANSACTION_DATETIME) < 1000
    group by st.ID, st.FIRST_NAME, st.LAST_NAME
    order by count(*) DESC) where ROWNUM <= 50
            );
			
-- COMMAND 2
prompt '2nd COMMAND'
update PRODUCT set CURRENT_RETAIL_PRICE = CURRENT_RETAIL_PRICE + CURRENT_RETAIL_PRICE * 0.05
    where ID in (select distinct p.id from PRODUCT p
    join SALES_RECEIPT sr on p.ID = sr.PRODUCT_ID
    join PRODUCT_CATEGORY pc on p.PRODUCT_CATEGORY_ID = pc.ID
    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
    join PASTRY_INVENTORY pi on p.ID = pi.PRODUCT_ID
    where pc.NAME = 'Coffee beans' and so.ID = 1 and WASTE_PERCENTAGE < 50);

timing stop
exit rollback