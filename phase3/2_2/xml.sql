TIMING START xml_timing;

SELECT nvl(with_promo.Category, without_promo.Category),
    with_promo.SalesSum    With_Promo,
    without_promo.SalesSum Without_Promo
FROM (
    SELECT pc.name Category, SUM(sr_xml.unit_price * sr_xml.quantity) SalesSum FROM 
        ( SELECT 
            EXTRACTVALUE(value(x), '/sales_receipt/unit_price') as unit_price,
            EXTRACTVALUE(value(x), '/sales_receipt/product_id') as product_id,
            EXTRACTVALUE(value(x), '/sales_receipt/quantity') as quantity,
            EXTRACTVALUE(value(x), '/sales_receipt/promo') as promo
        FROM sales_receipt_xml x ) sr_xml
        JOIN product p ON sr_xml.product_id = p.id
        JOIN PRODUCT_CATEGORY pc ON p.product_category_id = pc.id
    WHERE sr_xml.promo = 1
    GROUP BY pc.name
    ) with_promo
        FULL JOIN
    (
        SELECT pc.name Category, SUM(sr_xml.unit_price * sr_xml.quantity) SalesSum FROM 
            ( SELECT 
                EXTRACTVALUE(value(x), '/sales_receipt/unit_price') as unit_price,
                EXTRACTVALUE(value(x), '/sales_receipt/product_id') as product_id,
                EXTRACTVALUE(value(x), '/sales_receipt/quantity') as quantity,
                EXTRACTVALUE(value(x), '/sales_receipt/promo') as promo
            FROM sales_receipt_xml x ) sr_xml
            JOIN product p ON sr_xml.product_id = p.id
            JOIN PRODUCT_CATEGORY pc ON p.product_category_id = pc.id
        WHERE sr_xml.promo = 0
        GROUP BY pc.name
    ) without_promo ON with_promo.Category = without_promo.Category;

TIMING STOP;
EXIT ROLLBACK;