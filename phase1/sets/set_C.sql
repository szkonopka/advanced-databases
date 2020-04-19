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

prompt '2nd QUERY'
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

prompt '3rd QUERY'
-- QUERY 3
SELECT SR.*
FROM STAFF SS
         JOIN SALESRECIEPTS SR on SS.ID = SR.STAFF
WHERE ss.LASTNAME = 'Octavia';

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

prompt '5th QUERY'
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
                  FROM SALESRECIEPTS SR
                           JOIN PRODUCT PP on SR.PRODUCT = PP.ID
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

prompt '3rd COMMAND'
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
/

timing stop
exit rollback