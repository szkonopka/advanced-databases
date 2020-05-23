ALTER TABLE sales_outlet
    		ADD localization SDO_GEOMETRY;
	
UPDATE sales_outlet
   	SET localization = SDO_GEOMETRY(2001, 8307, 
     	SDO_POINT_TYPE (longitude,latitude,NULL),NULL,NULL);

EXIT;