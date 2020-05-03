-- Test insert value
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

-- Actual command
DECLARE
    new_value NUMBER(10,0) := 0;
    sales_outlet_id NUMBER(10,0) := 10000;
BEGIN     
    select to_number(so.sales_targets.extract('/sales_targets/sales_target/total_id/text()').getstringval()) * 0.9
    into new_value
    from sales_outlet_xml so
    where id = sales_outlet_id;
    
    update sales_outlet_xml
    set sales_targets = UpdateXml(sales_targets, '/sales_targets/sales_target/total_id/text()', new_value)
    where id = sales_outlet_id;    
END;

-- Check if updated
select so.sales_targets.extract('/sales_targets/sales_target/total_id/text()').getstringval()
from sales_outlet_xml so
where id = 10000;