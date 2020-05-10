TIMING START xml_timing;

SELECT * FROM 
    ( SELECT 
        EXTRACTVALUE(value(x), '/sales_receipt/product_id') as product_id,
        EXTRACTVALUE(value(x), '/sales_receipt/sales_outlet_id') as sales_outlet_id,
        to_number(to_char(to_date(EXTRACTVALUE(value(x), '/sales_receipt/transaction_datetime'), 'YYYY.MM.DD HH24:MI:SS'), 'WW')) as week
    FROM sales_receipt_xml x ) sr_xml
    JOIN sales_outlet so ON sr_xml.sales_outlet_id = so.ID
    JOIN product p ON sr_xml.product_id = p.ID
    WHERE so.ID = 3 and p.PROMO = 1;

TIMING STOP;
EXIT ROLLBACK;