-- ZESTAW SZYMON KONOPKA

set autotrace traceonly statistics
set timing on
alter session set NLS_TIMESTAMP_FORMAT = 'HH:MI:SS.FF6';

prompt '1st QUERY'
-- QUERY 1
@test_params.sql
select so.ID as salesOutletId, round(avg(sr.LINEITEMAMOUNT),2) as avgLineItemAmount  from SALESOUTLET so
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    where so.ID = :firstSalesOutletId
    group by so.ID
union
select so.ID as salesOutletId, round(avg(sr.LINEITEMAMOUNT),2) as avgLineItemAmount  from SALESOUTLET so
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    where so.ID = :sectSalesOutletId
    group by so.ID;

prompt '2nd QUERY'
-- QUERY 2
@test_params.sql
select sr.* from SALESRECIEPTS sr
    join DATES d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    join PRODUCT p on sr.PRODUCT = p.ID
    where d.WEEKID = :weekId and so.ID = :salesOutletId and p.PROMO = 1;

select sr.* from SALESRECIEPTS sr
    join DATES d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    join PRODUCT p on sr.PRODUCT = p.ID
    where d.WEEKID = :weekId and so.ID = :salesOutletId;

prompt '3rd QUERY'
-- QUERY 3
@test_params.sql
select sr.* from SALESRECIEPTS sr
    join CUSTOMER cu on sr.CUSTOMER = cu.ID
    join GENERATION g on cu.BIRTHYEAR = g.BIRTHYEAR
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    where g.GENERATIONNAME = :generationName and so.ID = :salesOutletId;

prompt '4th QUERY'
-- QUERY 4
@test_params.sql
select st.YEARMONTHDATE, so.ID as salesOutletId, st.TOTALGOAL, COUNT(*) as sales, ROUND(COUNT(*) * 100 / st.TOTALGOAL,2) as percOfTotalGoal,
       SUM(sr.LINEITEMAMOUNT) as sumLineItemAmount from SALESTARGET st
    join SALESOUTLET so on st.SALESOUTLET = so.ID
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET and sr.TRANSACTIONDATE = st.YEARMONTHDATE
    where so.ID = :salesOutletId
    group by st.YEARMONTHDATE, st.TOTALGOAL, so.ID;


prompt '5th QUERY'
-- QUERY 5
select GENERATIONNAME,
       pp.DESCRIPTION,
       round(100 * count(*) / sum(count(*)) over (partition by pp.DESCRIPTION), 2) percentage_by_product
from customer cc
         join GENERATION gg on cc.BIRTHYEAR = gg.BIRTHYEAR
         join SALESRECIEPTS sr on cc.ID = sr.CUSTOMER
         join product pp on sr.PRODUCT = pp.ID
where sr.SALESOUTLET = 3
group by GENERATIONNAME, pp.DESCRIPTION
order by pp.DESCRIPTION;

prompt '1st COMMAND'
-- COMMAND 1
create or replace procedure Sell_Product(in_product_id number,
                                         in_sales_outlet_id number,
                                         in_staff_id number,
                                         in_customer_id number,
                                         in_transaction_id number,
                                         in_quantity number,
                                         in_line_item_amount number,
                                         in_unit_price number,
                                         in_promo number)
    is
begin
    insert into SALESRECIEPTS (TRANSACTIONTIME,
                               TRANSACTIONDATE,
                               TRANSACTIONID,
                               QUANTITY,
                               LINEITEMAMOUNT,
                               UNITPRICE,
                               PROMO,
                               SALESOUTLET,
                               PRODUCT,
                               STAFF,
                               CUSTOMER,
                               INSTORE,
                               "order",
                               LINEITEMID)
    values (trunc(sysdate),
            sysdate,
            in_transaction_id,
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
update SALESTARGET st
set st.TOTALGOAL       = :change * nvl((
                                           @test_params.sql
                                           select sum(QUANTITY * UNITPRICE)
                                           from SALESRECIEPTS sr
                                                    join SALESOUTLET so on sr.SALESOUTLET = so.ID
                                                    join SALESTARGET st on so.ID = st.SALESOUTLET
                                                    join PRODUCT pp on sr.PRODUCT = pp.ID
                                                    join PRODUCTGROUP pg on pp.PRODUCTGROUP = pg.ID
                                           where so.ID = :outlet_id
                                       ), st.TOTALGOAL),
    st.FOODGOAL        = :change * nvl((
                                           @test_params.sql
                                           select sum(QUANTITY * UNITPRICE)
                                           from SALESRECIEPTS sr
                                                    join SALESOUTLET so on sr.SALESOUTLET = so.ID
                                                    join SALESTARGET st on so.ID = st.SALESOUTLET
                                                    join PRODUCT pp on sr.PRODUCT = pp.ID
                                                    join PRODUCTGROUP pg on pp.PRODUCTGROUP = pg.ID
                                           where so.ID = :outlet_id
                                             and "group" = 'Food'
                                           group by "group"
                                       ), st.FOODGOAL),
    st.BEANSGOAL       = :change * nvl((
                                           @test_params.sql
                                           select sum(QUANTITY * UNITPRICE)
                                           from SALESRECIEPTS sr
                                                    join SALESOUTLET so on sr.SALESOUTLET = so.ID
                                                    join SALESTARGET st on so.ID = st.SALESOUTLET
                                                    join PRODUCT pp on sr.PRODUCT = pp.ID
                                                    join PRODUCTGROUP pg on pp.PRODUCTGROUP = pg.ID
                                           where so.ID = :outlet_id
                                             and "group" = 'Whole Bean/Teas'
                                           group by "group"
                                       ), st.BEANSGOAL),
    st.BEVERAGEGOAL    = :change * nvl((
                                           @test_params.sql
                                           select sum(QUANTITY * UNITPRICE)
                                           from SALESRECIEPTS sr
                                                    join SALESOUTLET so on sr.SALESOUTLET = so.ID
                                                    join SALESTARGET st on so.ID = st.SALESOUTLET
                                                    join PRODUCT pp on sr.PRODUCT = pp.ID
                                                    join PRODUCTGROUP pg on pp.PRODUCTGROUP = pg.ID
                                           where so.ID = :outlet_id
                                             and "group" = 'Beverages'
                                           group by "group"
                                       ), st.BEVERAGEGOAL),
    st.MERCHANDISEGOAL = :change * nvl((
                                           @test_params.sql
                                           select sum(QUANTITY * UNITPRICE)
                                           from SALESRECIEPTS sr
                                                    join SALESOUTLET so on sr.SALESOUTLET = so.ID
                                                    join SALESTARGET st on so.ID = st.SALESOUTLET
                                                    join PRODUCT pp on sr.PRODUCT = pp.ID
                                                    join PRODUCTGROUP pg on pp.PRODUCTGROUP = pg.ID
                                           where so.ID = :outlet_id
                                             and "group" = 'Merchandise'
                                           group by "group"
                                       ), st.MERCHANDISEGOAL)
where st.SALESOUTLET = :outlet_id;

prompt '3rd COMMAND'
-- COMMAND 3
@test_params.sql
update PRODUCT pp
set pp.CURRENTWHOLESALEPRICE = (100 - :perc_discount) / 100 * pp.CURRENTWHOLESALEPRICE,
    pp.CURRENTRETAILPRICE    = (100 - :perc_discount) / 100 * pp.CURRENTRETAILPRICE
where pp.id in (
    select ppp.id
    from PRODUCT ppp
             join SALESRECIEPTS sr on ppp.ID = sr.PRODUCT
             join DATES dd on sr.TRANSACTIONDATE = dd.TRANSACTIONDATE
    where dd.QUARTERNAME = :quarter
      and dd.YEARID = :year
    group by ppp.id
    having sum(sr.UNITPRICE * sr.QUANTITY) < (
        select sum(srr.UNITPRICE * srr.QUANTITY)
        from SALESRECIEPTS srr
                 join PRODUCT pppp on srr.PRODUCT = pppp.ID and pppp.ID = ppp.id
                 join dates ddd on srr.TRANSACTIONDATE = ddd.TRANSACTIONDATE
        group by pppp.ID
        having max(ddd.TRANSACTIONDATE) < add_months(max(dd.TRANSACTIONDATE), -12)
    )
);

exit rollback