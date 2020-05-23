ALTER TABLE customer
    		ADD localization SDO_GEOMETRY
   		ADD longitude FLOAT
    		ADD latitude FLOAT;

UPDATE (
    SELECT c.localization as c_localization, 
    SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE (so.longitude + round(dbms_random.value(),3), so.latitude + round(dbms_random.value(),3), NULL),NULL,NULL) as new_localization
     FROM customer c JOIN sales_outlet so ON so.id = c.home_sales_outlet_id
) SET c_localization = new_localization;

EXIT;