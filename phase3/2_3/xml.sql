TIMING START xml_timing;

select * from (
select s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME,so.CITY, SUM(round(pi.waste * sr_xml.LINE_ITEM_AMOUNT, 2)) as waste, 'GOOD' as status from 
    ( select
        EXTRACTVALUE(value(x), '/sales_receipt/sales_outlet_id') as sales_outlet_id,
        TO_DATE(EXTRACTVALUE(value(x), '/sales_receipt/transaction_datetime'), 'YYYY.MM.DD HH24:MI:SS') as transaction_datetime,
        EXTRACTVALUE(value(x), '/sales_receipt/product_id') as product_id,
        EXTRACTVALUE(value(x), '/sales_receipt/line_item_amount') as line_item_amount,
        EXTRACTVALUE(value(x), '/sales_receipt/staff_id') as staff_id
    from sales_receipt_xml x) sr_xml
    join staff s ON sr_xml.staff_id = s.id
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_OUTLET so on s.ID = so.MANAGER_STAFF_ID
    join PASTRY_INVENTORY pi on pi.TRANSACTION_DATE = trunc(sr_xml.TRANSACTION_DATETIME) and pi.PRODUCT_ID = sr_xml.PRODUCT_ID
    join PRODUCT on pi.PRODUCT_ID = PRODUCT.ID AND sr_xml.PRODUCT_ID = PRODUCT.ID
    WHERE months_between(sysdate, sr_xml.TRANSACTION_DATETIME) < 1000
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME, so.CITY
    order by WASTE) where ROWNUM <= 50
union
select * from (
select s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME,so.CITY, SUM(round(pi.waste * sr_xml.LINE_ITEM_AMOUNT, 2)) as waste, 'BAD' as status from
( select
        EXTRACTVALUE(value(x), '/sales_receipt/sales_outlet_id') as sales_outlet_id,
        TO_DATE(EXTRACTVALUE(value(x), '/sales_receipt/transaction_datetime'), 'YYYY.MM.DD HH24:MI:SS') as transaction_datetime,
        EXTRACTVALUE(value(x), '/sales_receipt/product_id') as product_id,
        EXTRACTVALUE(value(x), '/sales_receipt/line_item_amount') as line_item_amount,
        EXTRACTVALUE(value(x), '/sales_receipt/staff_id') as staff_id
    from sales_receipt_xml x) sr_xml
    join staff s ON sr_xml.staff_id = s.id
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_OUTLET so on s.ID = so.MANAGER_STAFF_ID
    join PASTRY_INVENTORY pi on pi.TRANSACTION_DATE = trunc(sr_xml.TRANSACTION_DATETIME) and pi.PRODUCT_ID = sr_xml.PRODUCT_ID
    join PRODUCT on pi.PRODUCT_ID = PRODUCT.ID AND sr_xml.PRODUCT_ID = PRODUCT.ID
    WHERE months_between(sysdate, sr_xml.TRANSACTION_DATETIME) < 1000
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME, so.CITY
    order by WASTE DESC ) where ROWNUM <= 50;

TIMING STOP;
EXIT ROLLBACK;