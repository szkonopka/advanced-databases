-- ZESTAW JAKUB STEPANIAK

@measure_params.sql

alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics
alter session set NLS_TIMESTAMP_FORMAT = 'HH:MI:SS.FF6';
timing start zestaw_transakcji_js

prompt '1st QUERY'
-- QUERY 1
SELECT best.GENERATIONNAME, best.ID Best, worst.ID worst
FROM (
         SELECT GENERATIONNAME, SS.ID
         FROM CUSTOMER CC
                  JOIN SALES_RECEIPT SR on CC.ID = SR.CUSTOMER_ID
                  JOIN STAFF SS on SR.STAFF_ID = SS.ID
                  JOIN GENERATION GG ON CC.BIRTHYEAR = GG.BIRTHYEAR
         where ss.ID = (
             select inner_ss.id
             FROM CUSTOMER inner_cc
                      JOIN SALES_RECEIPT inner_sr on inner_cc.ID = inner_SR.CUSTOMER_ID
                      JOIN STAFF inner_ss on inner_SR.STAFF_ID = inner_ss.ID
                      JOIN GENERATION inner_gg ON inner_cc.BIRTHYEAR = inner_gg.BIRTHYEAR
             where inner_gg.GENERATIONNAME = gg.GENERATIONNAME
             group by GENERATIONNAME, inner_ss.id
             order by sum(inner_sr.UNIT_PRICE * inner_sr.QUANTITY) desc
             fetch first row only
         )
         group by GENERATIONNAME, SS.ID
     ) best
         FULL JOIN (
    SELECT GENERATIONNAME, SS.ID
    FROM CUSTOMER CC
             JOIN SALES_RECEIPT SR on CC.ID = SR.CUSTOMER_ID
             JOIN STAFF SS on SR.STAFF_ID = SS.ID
             JOIN GENERATION GG ON CC.BIRTHYEAR = GG.BIRTHYEAR
    where ss.ID = (
        select inner_ss.id
        FROM CUSTOMER inner_cc
                 JOIN SALES_RECEIPT inner_sr on inner_cc.ID = inner_SR.CUSTOMER_ID
                 JOIN STAFF inner_ss on inner_SR.STAFF_ID = inner_ss.ID
                 JOIN GENERATION inner_gg ON inner_cc.BIRTHYEAR = inner_gg.BIRTHYEAR
        where inner_gg.GENERATIONNAME = gg.GENERATIONNAME
        group by GENERATIONNAME, inner_ss.id
        order by sum(inner_sr.UNIT_PRICE * inner_sr.QUANTITY)
        fetch first row only
    )
    group by GENERATIONNAME, SS.ID
) worst on best.GENERATIONNAME = worst.GENERATIONNAME

prompt '2nd QUERY'
-- QUERY 2
SELECT nvl(with_promo.Category, without_promo.Category),
       with_promo.SalesSum    With_Promo,
       without_promo.SalesSum Without_Promo
FROM (
         SELECT PC.NAME Category, SUM(SR.UNIT_PRICE * SR.QUANTITY) SalesSum
         FROM SALES_RECEIPT SR
                  JOIN PRODUCT PP on SR.PRODUCT_ID = PP.ID
                  JOIN PRODUCT_CATEGORY PC on PP.PRODUCT_CATEGORY_ID = PC.ID
         WHERE SR.PROMO = 1
         GROUP BY PC.NAME
     ) with_promo
         FULL JOIN
     (
         SELECT PC.NAME Category, SUM(SR.UNIT_PRICE * SR.QUANTITY) SalesSum
         FROM SALES_RECEIPT SR
                  JOIN PRODUCT PP on SR.PRODUCT_ID = PP.ID
                  JOIN PRODUCT_CATEGORY PC on PP.PRODUCT_CATEGORY_ID = PC.ID
         WHERE SR.PROMO = 0
         GROUP BY PC.NAME
     ) without_promo on with_promo.Category = without_promo.Category;

prompt '3rd QUERY'
-- QUERY 3
SELECT SR.*
FROM STAFF SS
         JOIN SALES_RECEIPT SR on SS.ID = SR.STAFF_ID
WHERE ss.LAST_NAME = 'Octavia';

prompt '4th QUERY'
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
      SUM(SR.UNIT_PRICE * SR.QUANTITY) sales_sum
FROM SALES_RECEIPT SR
         JOIN STAFF SS on SR.STAFF_ID = SS.ID
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

prompt '5th QUERY'
-- QUERY 5
SELECT CASE
           WHEN SR.SALES_OUTLET_ID = CC.HOME_SALES_OUTLET_ID THEN 1
           WHEN SR.SALES_OUTLET_ID != CC.HOME_SALES_OUTLET_ID THEN 0
           END                                                                                          home_outlet,
       sum(sr.QUANTITY * sr.UNIT_PRICE)                                                                  group_cnt,
       sum(sum(sr.QUANTITY * sr.UNIT_PRICE)) over ()                                                     total_cnt,
       round(100 * (sum(sr.QUANTITY * sr.UNIT_PRICE) / sum(sum(sr.QUANTITY * sr.UNIT_PRICE)) over ()), 2) perc
FROM SALES_RECEIPT SR
         JOIN CUSTOMER CC on SR.CUSTOMER_ID = CC.ID
GROUP BY (
             CASE
                 WHEN SR.SALES_OUTLET_ID = CC.HOME_SALES_OUTLET_ID THEN 1
                 WHEN SR.SALES_OUTLET_ID != CC.HOME_SALES_OUTLET_ID THEN 0
                 END
             );

prompt '1st COMMAND'
-- COMMAND 1
CREATE OR REPLACE PROCEDURE SetProductNotNew(
    months_threshold IN integer
) IS
BEGIN
    UPDATE PRODUCT
    SET NEWPRODUCT = 0
    WHERE EXISTS(
                  SELECT 1
                  FROM SALES_RECEIPT SR
                           JOIN PRODUCT PP on SR.PRODUCT_ID = PP.ID
                  WHERE months_between(sysdate, SR.TRANSACTIONDATE) > months_threshold
              );

    commit;
end;
/

prompt '2nd COMMAND'
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

    merge into PRODUCT_CATEGORY pc
    using (select category_name name from dual) a
    on (PC.NAME = a.name)
    when not matched then
        insert (CATEGORY)
        values (a.name);

    merge into PRODUCTTYPE pt
    using (select type_name name from dual) a
    on (pt.TYPE = a.name)
    when not matched then
        insert (TYPE)
        values (a.name);

    insert into PRODUCT (name, PRODUCTGROUP, PRODUCT_CATEGORY, PRODUCTTYPE)
    values (name,
            (select id from PRODUCTGROUP where "group" = group_name),
            (select id from PRODUCT_CATEGORY where CATEGORY = category_name),
            (select id from PRODUCTTYPE where TYPE = type_name));
end;

prompt '3rd COMMAND'
-- COMMAND 3
create or replace procedure Delete_Customer(
    customer_id number
)
    is
begin
    delete
    from SALES_RECEIPT sr
    where SR.CUSTOMER_ID = customer_id;
    commit;

    delete
    from CUSTOMER cc
    where cc.ID = customer_id;
    commit;
end;
/

timing stop
exit rollback