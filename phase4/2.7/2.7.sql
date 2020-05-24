alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.7;

DECLARE
    number_of_clients NUMBER(10,0) := 10;
    new_range NUMBER(10,2) := 0;
    outlet_id NUMBER(10,0) := 1;
BEGIN     
    SELECT distance
    INTO new_range
    FROM (
        SELECT distance FROM (
            SELECT c.id, SDO_GEOM.SDO_DISTANCE(c.localization, so.localization, 0.005, 'unit=KM') as distance
            FROM customer c JOIN sales_outlet so ON c.home_sales_outlet_id = so.id
            ORDER BY distance asc
        )
        WHERE ROWNUM <= number_of_clients
        ORDER BY distance desc
    )    
    WHERE ROWNUM <= 1;
    
    UPDATE sales_outlet
    SET delivery_range = SDO_UTIL.CIRCLE_POLYGON(longitude,latitude, new_range, 5)
    WHERE id = outlet_id;
END;
/
TIMING STOP;

EXIT;