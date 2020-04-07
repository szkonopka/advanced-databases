-- ZESTAW SZYMON KONOPKA

alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics
alter session set NLS_TIMESTAMP_FORMAT = 'HH:MI:SS.FF6';
timing start zestaw_transakcji_sk

prompt '1st QUERY'
-- QUERY 1
@test_params.sql
select so.ID as salesOutletId, round(avg(sr.LINE_ITEM_AMOUNT),2) as avgLineItemAmount  from SALES_OUTLET so
    join SALES_RECEIPT sr on so.ID = sr.SALES_OUTLET_ID
    where so.ID = :firstSalesOutletId
    group by so.ID
union
select so.ID as salesOutletId, round(avg(sr.LINE_ITEM_AMOUNT),2) as avgLineItemAmount  from SALES_OUTLET so
    join SALES_RECEIPT sr on so.ID = sr.SALES_OUTLET_ID
    where so.ID = :sectSalesOutletId
    group by so.ID;

prompt '2nd QUERY'
-- QUERY 2
@test_params.sql
select sr.* from SALES_RECEIPT sr
    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
    join PRODUCT p on sr.PRODUCT_ID = p.ID
    where to_number(to_char(sr.TRANSACTION_DATETIME,'WW')) = :weekId and so.ID = :salesOutletId and p.PROMO = 1;

select sr.* from SALES_RECEIPT sr
    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
    join PRODUCT p on sr.PRODUCT_ID = p.ID
    where to_number(to_char(sr.TRANSACTION_DATETIME,'WW')) = :weekId and so.ID = :salesOutletId;

prompt '3rd QUERY'
-- QUERY 3
@test_params.sql
select sr.* from SALES_RECEIPT sr
    join CUSTOMER cu on sr.CUSTOMER_ID = cu.ID
    join GENERATION g on cu.GENERATION_ID = g.ID
    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
    where g.NAME = :generationName and so.ID = :salesOutletId;

prompt '4th QUERY'
-- QUERY 4
@test_params.sql
select st.TARGET_DATE, so.ID as salesOutletId, st.TOTALGOAL, COUNT(*) as sales, ROUND(COUNT(*) * 100 / st.TOTALGOAL,2) as percOfTotalGoal,
       SUM(sr.LINE_ITEM_AMOUNT) as sumLineItemAmount from SALES_OUTLET_TARGET st
    join SALES_OUTLET so on st.SALES_OUTLET_ID = so.ID
    join SALES_RECEIPT sr on so.ID = sr.SALES_OUTLET_ID and trunc(sr.TRANSACTION_DATETIME) = st.TARGET_DATE
    group by st.TARGET_DATE, st.TOTALGOAL, so.ID;


prompt '5th QUERY'
-- QUERY 5
select NAME,
       pp.DESCRIPTION,
       round(100 * count(*) / sum(count(*)) over (partition by pp.DESCRIPTION), 2) percentage_by_product
from customer cc
         join GENERATION gg on cc.GENERATION_ID = gg.ID
         join SALES_RECEIPT sr on cc.ID = sr.CUSTOMER_ID
         join product pp on sr.PRODUCT_ID = pp.ID
where sr.SALES_OUTLET_ID = 3
group by NAME, pp.DESCRIPTION
order by pp.DESCRIPTION;

prompt '1st COMMAND'
-- COMMAND 1
create or replace procedure Sell_Product(in_product_id number,
                                         in_sales_outlet_id number,
                                         in_staff_id number,
                                         in_customer_id number,
                                         in_quantity number,
                                         in_line_item_amount number,
                                         in_unit_price number,
                                         in_promo number)
    is
begin
    insert into SALES_RECEIPT (ID,
                               TRANSACTION_DATETIME,
                               QUANTITY,
                               LINE_ITEM_AMOUNT,
                               UNIT_PRICE,
                               PROMO,
                               SALES_OUTLET_ID,
                               PRODUCT_ID,
                               STAFF_ID,
                               CUSTOMER_ID,
                               IN_STORE,
                               "order",
                               LINE_ITEM_ID)
    values (50000,
            sysdate,
            in_quantity,
            in_line_item_amount,
            in_unit_price,
            in_promo,
            in_sales_outlet_id,
            in_product_id,
            in_staff_id,
            in_customer_id,
            1,
            1,
            1);
end;
/

begin
    SELL_PRODUCT(
        1,
        2,
        1,
        1,
        2,
        3,
        50,
        1,
        in_promo => 1);
end;
/

prompt '2nd COMMAND'
-- COMMAND 2
@test_params.sql
update SALES_OUTLET_TARGET st
set st.TOTALGOAL       = 0.05 * nvl((
                                           select sum(QUANTITY * UNIT_PRICE)
                                           from SALES_RECEIPT sr
                                                    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
                                                    join SALES_OUTLET_TARGET st on so.ID = st.SALES_OUTLET_ID
                                                    join PRODUCT pp on sr.PRODUCT_ID = pp.ID
                                                    join PRODUCT_GROUP pg on pp.PRODUCT_GROUP_ID = pg.ID
                                           where so.ID = 3
                                       ), st.TOTALGOAL)
where st.SALES_OUTLET_ID = 3;

prompt '3rd COMMAND'
-- COMMAND 3
@test_params.sql
update PRODUCT pp
set pp.CURRENT_WHOLESALE_PRICE = (100 - :perc_discount) / 100 * pp.CURRENT_WHOLESALE_PRICE,
    pp.CURRENT_RETAIL_PRICE    = (100 - :perc_discount) / 100 * pp.CURRENT_RETAIL_PRICE
where pp.id in (
    select ppp.id
    from PRODUCT ppp
             join SALES_RECEIPT sr on ppp.ID = sr.PRODUCT_ID
    where TO_CHAR(sr.TRANSACTION_DATETIME, 'Q') = :quarter
      and TO_CHAR(sr.TRANSACTION_DATETIME, 'YYYY') = :year
    group by ppp.id
    having sum(sr.UNIT_PRICE * sr.QUANTITY) < (
        select sum(srr.UNIT_PRICE * srr.QUANTITY)
        from SALES_RECEIPT srr
                 join PRODUCT pppp on srr.PRODUCT_ID = pppp.ID and pppp.ID = ppp.id
        group by pppp.ID
        having max(srr.TRANSACTION_DATETIME) < add_months(max(sr.TRANSACTION_DATETIME), -12)
    )
);
timing stop

exit rollback