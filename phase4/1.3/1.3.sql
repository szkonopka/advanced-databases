ALTER TABLE customer
    		ADD localization SDO_GEOMETRY;   

UPDATE customer c
    		SET localization = (
    		SELECT SDO_GEOMETRY(2001, 8307, 
     		SDO_POINT_TYPE (so.longitude + round(dbms_random.value(),3),so.latitude + 
		round(dbms_random.value(),3),NULL),NULL,NULL) 
    		 FROM sales_outlet so WHERE so.id = c.home_sales_outlet_id
    		); 

EXIT;