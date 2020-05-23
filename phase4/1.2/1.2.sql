ALTER TABLE SALES_OUTLET 
    ADD delivery_range SDO_GEOMETRY;

UPDATE sales_outlet
    SET delivery_range = SDO_UTIL.CIRCLE_POLYGON(longitude,latitude, floor(dbms_random.value(1000,100000)), 5);

EXIT;