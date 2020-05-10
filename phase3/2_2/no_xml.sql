TIMING START no_xml_timing;

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

TIMING STOP;
EXIT ROLLBACK;