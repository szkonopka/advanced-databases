alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.5;

DROP TABLE temp_sales_outlet_deliveries;
CREATE TABLE temp_sales_outlet_deliveries (id number(10, 2), customers number(10, 2));

DECLARE 
    customers number(10, 2);
BEGIN 
FOR rec IN (
    SELECT so.id, so.delivery_range
    FROM sales_outlet so
    )
    LOOP
        SELECT SUM(COUNT(c.id))
        INTO customers
        FROM customer c
        WHERE SDO_RELATE(rec.delivery_range, c.localization, 'mask=CONTAINS querytype=JOIN') = 'TRUE'
        GROUP BY c.id;
        
        INSERT INTO temp_sales_outlet_deliveries (id, customers)
        VALUES (rec.id, customers);
    END LOOP;
    DELETE FROM sales_outlet
    WHERE id = (SELECT id 
                FROM (SELECT id, MIN(customers)
                    FROM temp_sales_outlet_deliveries));
END;
/

DROP TABLE temp_sales_outlet_deliveries;

TIMING STOP;

EXIT ROLLBACK;