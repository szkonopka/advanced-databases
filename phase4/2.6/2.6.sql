alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START 2.6;

INSERT INTO sales_outlet (
    square_feet, 
    address, 
    city, 
    province, 
    telephone, 
    postal_code, 
    longitude, 
    latitude, 
    sales_outlet_type_id, 
    localization, 
    delivery_range)
VALUES (
    1000,
    'Temporary',
    'Temporary',
    'TEMP',
    '999-999-999',
    999,
    -122.7,
    42.5,
    2,
    NULL,
    SDO_UTIL.CIRCLE_POLYGON(-122.7, 42.5, ( SELECT 
                                            AVG(SQRT(SDO_GEOM.SDO_AREA(so.delivery_range, 0.005, 'unit=SQ_M')) /  3.14) 
                                            FROM sales_outlet so), 5)
);

TIMING STOP;

EXIT;