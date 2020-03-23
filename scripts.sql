-- ZESTAW SZYMON KONOPKA

-- QUERY 1
select so.ID as salesOutletId, round(avg(sr.LINEITEMAMOUNT),2) as avgLineItemAmount  from SALESOUTLET so
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    where so.ID = :firstSalesOutletId
    group by so.ID
union
select so.ID as salesOutletId, round(avg(sr.LINEITEMAMOUNT),2) as avgLineItemAmount  from SALESOUTLET so
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    where so.ID = :sectSalesOutletId
    group by so.ID;

-- QUERY 2
select sr.* from SALESRECIEPTS sr
    join DATES d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    join PRODUCT p on sr.PRODUCT = p.ID
    where d.WEEKID = :weekId and so.ID = :salesOutletId and p.PROMO = 1;

-- QUERY 3
select sr.* from SALESRECIEPTS sr
    join CUSTOMER cu on sr.CUSTOMER = cu.ID
    join GENERATION g on cu.BIRTHYEAR = g.BIRTHYEAR
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    where g.GENERATIONNAME = :generationName and so.ID = :salesOutletId;


-- QUERY 4
select st.YEARMONTHDATE, so.ID as salesOutletId, st.TOTALGOAL, COUNT(*) as sales, ROUND(COUNT(*) * 100 / st.TOTALGOAL,2) as percOfTotalGoal,
       SUM(sr.LINEITEMAMOUNT) as sumLineItemAmount from SALESTARGET st
    join SALESOUTLET so on st.SALESOUTLET = so.ID
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET and sr.TRANSACTIONDATE = st.YEARMONTHDATE
    where so.ID = :salesOutletId
    group by st.YEARMONTHDATE, st.TOTALGOAL, so.ID;

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

-- COMMAND 2
update SALESTARGET st
set st.TOTALGOAL       = :change * nvl((
                                           select sum(QUANTITY * UNITPRICE)
                                           from SALESRECIEPTS sr
                                                    join SALESOUTLET so on sr.SALESOUTLET = so.ID
                                                    join SALESTARGET st on so.ID = st.SALESOUTLET
                                                    join PRODUCT pp on sr.PRODUCT = pp.ID
                                                    join PRODUCTGROUP pg on pp.PRODUCTGROUP = pg.ID
                                           where so.ID = :outlet_id
                                       ), st.TOTALGOAL),
    st.FOODGOAL        = :change * nvl((
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

-- COMMAND 3
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

-- ZESTAW GRZEGORZ STALA

-- QUERY 1
select G.GENERATIONNAME, ROUND(AVG(S.LINEITEMAMOUNT),2) as avgLineItemAmount from CUSTOMER C
    join GENERATION G on C.BIRTHYEAR = G.BIRTHYEAR
    join SALESRECIEPTS S on C.ID = S.CUSTOMER
group by G.GENERATIONNAME;

-- QUERY 2
select * from (
select s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME,so.STORECITY, SUM(round(pi.waste * sr.LINEITEMAMOUNT, 2)) as waste, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESOUTLET so on s.ID = so.MANAGER
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    join dates on sr.TRANSACTIONDATE = DATES.TRANSACTIONDATE
    join PASTRYINVENTORY pi on DATES.TRANSACTIONDATE = pi.TRANSACTIONDATE
    join PRODUCT on pi.PRODUCT = PRODUCT.ID AND sr.PRODUCT = PRODUCT.ID
    WHERE months_between(sysdate, SR.TRANSACTIONDATE) < :months_threshold
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME, so.STORECITY
    order by WASTE) where ROWNUM <= :rownum
union
select * from (
select s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME,so.STORECITY, SUM(round(pi.waste * sr.LINEITEMAMOUNT, 2)) as waste, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESOUTLET so on s.ID = so.MANAGER
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    join dates on sr.TRANSACTIONDATE = DATES.TRANSACTIONDATE
    join PASTRYINVENTORY pi on DATES.TRANSACTIONDATE = pi.TRANSACTIONDATE
    join PRODUCT on pi.PRODUCT = PRODUCT.ID AND sr.PRODUCT = PRODUCT.ID
    WHERE months_between(sysdate, SR.TRANSACTIONDATE) < :months_threshold
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME, so.STORECITY
    order by WASTE DESC) where ROWNUM <= :rownum;

-- QUERY 3
select * from (
select P.ID, P.PRODUCTCATEGORY, PY.WASTEPERCENTAGE, D.TRANSACTIONDATE, 'GOOD' as status from GRZEGORZ.PRODUCT P
    join GRZEGORZ.PASTRYINVENTORY PY on P.ID = PY.PRODUCT
    join DATES D on PY.TRANSACTIONDATE = D.TRANSACTIONDATE
    order BY PY.WASTEPERCENTAGE) res1 where months_between(sysdate, res1.TRANSACTIONDATE) < :months_threshold AND ROWNUM <= :limit
union
select * from (
select P.ID, P.PRODUCTCATEGORY, PY.WASTEPERCENTAGE, D.TRANSACTIONDATE, 'BAD' as status from GRZEGORZ.PRODUCT P
    join GRZEGORZ.PASTRYINVENTORY PY on P.ID = PY.PRODUCT
    join DATES D on PY.TRANSACTIONDATE = D.TRANSACTIONDATE
    order BY PY.WASTEPERCENTAGE DESC) res2  where months_between(sysdate, res2.TRANSACTIONDATE) < :months_threshold AND ROWNUM <= :limit;

-- QUERY 4
select * from (
select S.ID, S.FIRSTNAME, s.LASTNAME, p.NAME, COUNT(*) as sales, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESRECIEPTS sr on s.ID = sr.STAFF
    join dates d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME order by COUNT(*)) res1 where ROWNUM <= :limit
union
select * from (
select S.ID, S.FIRSTNAME, s.LASTNAME, p.NAME, COUNT(*) as sales, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESRECIEPTS sr on s.ID = sr.STAFF
    join dates d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME order by COUNT(*) DESC) res2 where ROWNUM <= :limit;

-- QUERY 5
select cus.id, cus.FIRSTNAME, g.GENERATIONNAME, so.ID as salesOutletId, COUNT(*) as sales, SUM(sr.LINEITEMAMOUNT) as total from CUSTOMER cus
    join SALESRECIEPTS sr on cus.ID = sr.CUSTOMER
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    join GENERATION G on cus.BIRTHYEAR = G.BIRTHYEAR
    where months_between(sysdate, sr.TRANSACTIONDATE) < :months_threshold and ROWNUM <= :limit
    group by cus.ID, cus.FIRSTNAME, g.GENERATIONNAME, so.ID order by SUM(sr.LINEITEMAMOUNT) DESC ;

-- COMMAND 1
update STAFF
    set POSITION = (select id from POSITION where NAME = :name)
    where ID in (
        select * from (
select st.ID from staff st
    join SALESRECIEPTS sr on st.ID = sr.STAFF
    WHERE months_between(sysdate, SR.TRANSACTIONDATE) < :months_threshold
    group by st.ID, st.FIRSTNAME, st.LASTNAME
    order by count(*) DESC) where ROWNUM <= :limit
              );

-- COMMAND 2

update PRODUCT set CURRENTRETAILPRICE = CURRENTRETAILPRICE + CURRENTRETAILPRICE * :updatePricePct 
    where ID in (select distinct p.id from PRODUCT p
    join SALESRECIEPTS sr on p.ID = sr.PRODUCT
    join PRODUCTCATEGORY pc on p.PRODUCTCATEGORY = pc.ID
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    join PASTRYINVENTORY pi on p.ID = pi.PRODUCT
    where pc.CATEGORY = :productCategory and so.ID = :salesOutletId and WASTEPERCENTAGE < :wastePct);

-- ZESTAW JAKUB STEPANIAK
-- QUERY 1
SELECT best.GENERATIONNAME, best.ID Best, worst.ID worst
FROM (
         SELECT GENERATIONNAME, SS.ID
         FROM CUSTOMER CC
                  JOIN SALESRECIEPTS SR on CC.ID = SR.CUSTOMER
                  JOIN STAFF SS on SR.STAFF = SS.ID
                  JOIN GENERATION GG ON CC.BIRTHYEAR = GG.BIRTHYEAR
         where ss.ID = (
             select inner_ss.id
             FROM CUSTOMER inner_cc
                      JOIN SALESRECIEPTS inner_sr on inner_cc.ID = inner_sr.CUSTOMER
                      JOIN STAFF inner_ss on inner_sr.STAFF = inner_ss.ID
                      JOIN GENERATION inner_gg ON inner_cc.BIRTHYEAR = inner_gg.BIRTHYEAR
             where inner_gg.GENERATIONNAME = gg.GENERATIONNAME
             group by GENERATIONNAME, inner_ss.id
             order by sum(inner_sr.UNITPRICE * inner_sr.QUANTITY) desc
             fetch first row only
         )
         group by GENERATIONNAME, SS.ID
     ) best
         FULL JOIN (
    SELECT GENERATIONNAME, SS.ID
    FROM CUSTOMER CC
             JOIN SALESRECIEPTS SR on CC.ID = SR.CUSTOMER
             JOIN STAFF SS on SR.STAFF = SS.ID
             JOIN GENERATION GG ON CC.BIRTHYEAR = GG.BIRTHYEAR
    where ss.ID = (
        select inner_ss.id
        FROM CUSTOMER inner_cc
                 JOIN SALESRECIEPTS inner_sr on inner_cc.ID = inner_sr.CUSTOMER
                 JOIN STAFF inner_ss on inner_sr.STAFF = inner_ss.ID
                 JOIN GENERATION inner_gg ON inner_cc.BIRTHYEAR = inner_gg.BIRTHYEAR
        where inner_gg.GENERATIONNAME = gg.GENERATIONNAME
        group by GENERATIONNAME, inner_ss.id
        order by sum(inner_sr.UNITPRICE * inner_sr.QUANTITY)
        fetch first row only
    )
    group by GENERATIONNAME, SS.ID
) worst on best.GENERATIONNAME = worst.GENERATIONNAME

-- QUERY 2
SELECT nvl(with_promo.Category, without_promo.Category),
       with_promo.SalesSum    With_Promo,
       without_promo.SalesSum Without_Promo
FROM (
         SELECT PC.CATEGORY Category, SUM(SR.UNITPRICE * SR.QUANTITY) SalesSum
         FROM SALESRECIEPTS SR
                  JOIN PRODUCT PP on SR.PRODUCT = PP.ID
                  JOIN PRODUCTCATEGORY PC on PP.PRODUCTCATEGORY = PC.ID
         WHERE SR.PROMO = 1
         GROUP BY PC.CATEGORY
     ) with_promo
         FULL JOIN
     (
         SELECT PC.CATEGORY Category, SUM(SR.UNITPRICE * SR.QUANTITY) SalesSum
         FROM SALESRECIEPTS SR
                  JOIN PRODUCT PP on SR.PRODUCT = PP.ID
                  JOIN PRODUCTCATEGORY PC on PP.PRODUCTCATEGORY = PC.ID
         WHERE SR.PROMO = 0
         GROUP BY PC.CATEGORY
     ) without_promo on with_promo.Category = without_promo.Category;

-- QUERY 3
SELECT SR.*
FROM STAFF SS
         JOIN SALESRECIEPTS SR on SS.ID = SR.STAFF
WHERE ss.LASTNAME = 'Octavia';

-- QUERY 4
SELECT(
          case
              when
                  round(months_between(sysdate, SS.STARTDATE)) < 12 then '<1'
              when
                  round(months_between(sysdate, SS.STARTDATE)) < 24 then '1-2'
              when
                  round(months_between(sysdate, SS.STARTDATE)) < 60 then '2-5'
              else '5+'
              end
          ),
      SUM(SR.UNITPRICE * SR.QUANTITY) sales_sum
FROM SALESRECIEPTS SR
         JOIN STAFF SS on SR.STAFF = SS.ID
GROUP BY (
             case
                 when
                     round(months_between(sysdate, SS.STARTDATE)) < 12 then '<1'
                 when
                     round(months_between(sysdate, SS.STARTDATE)) < 24 then '1-2'
                 when
                     round(months_between(sysdate, SS.STARTDATE)) < 60 then '2-5'
                 else '5+'
                 end
             )
ORDER BY (
             case
                 when
                     round(months_between(sysdate, SS.STARTDATE)) < 12 then '<1'
                 when
                     round(months_between(sysdate, SS.STARTDATE)) < 24 then '1-2'
                 when
                     round(months_between(sysdate, SS.STARTDATE)) < 60 then '2-5'
                 else '5+'
                 end
             )

-- QUERY 5
SELECT CASE
           WHEN SR.SALESOUTLET = CC.HOMESTORE THEN 1
           WHEN SR.SALESOUTLET != CC.HOMESTORE THEN 0
           END                                                                                          home_outlet,
       sum(sr.QUANTITY * sr.UNITPRICE)                                                                  group_cnt,
       sum(sum(sr.QUANTITY * sr.UNITPRICE)) over ()                                                     total_cnt,
       round(100 * (sum(sr.QUANTITY * sr.UNITPRICE) / sum(sum(sr.QUANTITY * sr.UNITPRICE)) over ()), 2) perc
FROM SALESRECIEPTS SR
         JOIN CUSTOMER CC on SR.CUSTOMER = CC.ID
GROUP BY (
             CASE
                 WHEN SR.SALESOUTLET = CC.HOMESTORE THEN 1
                 WHEN SR.SALESOUTLET != CC.HOMESTORE THEN 0
                 END
             );

-- COMMAND 1
CREATE OR REPLACE PROCEDURE SetProductNotNew(
    months_threshold IN integer
) IS
BEGIN
    UPDATE PRODUCT
    SET NEWPRODUCT = 0
    WHERE EXISTS(
                  SELECT 1
                  FROM SALESRECIEPTS SR
                           JOIN PRODUCT PP on SR.PRODUCT = PP.ID
                  WHERE months_between(sysdate, SR.TRANSACTIONDATE) > months_threshold
              );

    commit;
end;

-- COMMAND 2
create or replace procedure Add_product(name in varchar2,
                                        group_name in varchar2,
                                        category_name in varchar2,
                                        type_name in varchar2) is
begin
    merge into PRODUCTGROUP pg
    using (select group_name name from dual) a
    on (pg."group" = a.name)
    when not matched then
        insert ("group")
        values (a.name);

    merge into PRODUCTCATEGORY pc
    using (select category_name name from dual) a
    on (pc.CATEGORY = a.name)
    when not matched then
        insert (CATEGORY)
        values (a.name);

    merge into PRODUCTTYPE pt
    using (select type_name name from dual) a
    on (pt.TYPE = a.name)
    when not matched then
        insert (TYPE)
        values (a.name);

    insert into PRODUCT (name, PRODUCTGROUP, PRODUCTCATEGORY, PRODUCTTYPE)
    values (name,
            (select id from PRODUCTGROUP where "group" = group_name),
            (select id from PRODUCTCATEGORY where CATEGORY = category_name),
            (select id from PRODUCTTYPE where TYPE = type_name));
end;

-- COMMAND 3
create or replace procedure Delete_Customer(
    customer_id number
)
    is
begin
    delete
    from SALESRECIEPTS sr
    where sr.CUSTOMER = customer_id;
    commit;

    delete
    from CUSTOMER cc
    where cc.ID = customer_id;
    commit;
end;
