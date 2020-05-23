ALTER TABLE customer
    		ADD localization SDO_GEOMETRY
   		ADD longitude FLOAT
    		ADD latitude FLOAT;

UPDATE (
    SELECT c.localization as c_localization, 
    SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE (so.longitude + round(dbms_random.value(),3), so.latitude + round(dbms_random.value(),3), NULL),NULL,NULL) as new_localization
     FROM customer c JOIN sales_outlet so ON so.id = c.home_sales_outlet_id
) SET c_localization = new_localization;

UPDATE (
    SELECT c.longitude as c_longitude, c.latitude as c_latitude, 
    c.localization.sdo_point.x as new_longitude, c.localization.sdo_point.y as new_latitude from customer c
) SET c_longitude = new_longitude,
      c_latitude = new_latitude;

EXIT;