
INSERT INTO SALES_OUTLET_XML (ID, SQUARE_FEET, ADDRESS, CITY, PROVINCE, TELEPHONE, POSTAL_CODE, LONGITUDE, LATITUDE, SALES_OUTLET_TYPE_ID, MANAGER_STAFF_ID, SALES_TARGETS) 
VALUES (
10000,
1200,
'Kazimierza Wielkiego 20',
'Wroclaw',
'PL',
'520-153-0843',
50231,
-110.9845,
32.2691,
1,
606,
'<?xml version="1.0" encoding="utf-16"?>
<sales_targets xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <sales_target id="10000">
        <target_date>20.05.2017</target_date>
        <product_id>2101</product_id>
        <total_id>1780</total_id>
    </sales_target>
</sales_targets>');

INSERT INTO STAFF (ID, FIRST_NAME, LAST_NAME, START_DATE, SALES_OUTLET_ID, POSITION_ID) 
VALUES (10000, 'Jakub', 'Stepaniak', CURRENT_DATE, 10000, 3);

INSERT INTO STAFF (ID, FIRST_NAME, LAST_NAME, START_DATE, SALES_OUTLET_ID, POSITION_ID) 
VALUES (10001, 'Grzegorz', 'Stala', CURRENT_DATE, 10000, 3);

INSERT INTO STAFF (ID, FIRST_NAME, LAST_NAME, START_DATE, SALES_OUTLET_ID, POSITION_ID) 
VALUES (10002, 'Szymon', 'Konopka', CURRENT_DATE, 10000, 3);

INSERT INTO STAFF (ID, FIRST_NAME, LAST_NAME, START_DATE, SALES_OUTLET_ID, POSITION_ID) 
VALUES (10003, 'Jan', 'Kowalski', CURRENT_DATE, 10000, 3);

INSERT INTO STAFF (ID, FIRST_NAME, LAST_NAME, START_DATE, SALES_OUTLET_ID, POSITION_ID) 
VALUES (10004, 'Adam', 'Nowak', CURRENT_DATE, 10000, 3);
