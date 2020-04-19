alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

timing start trigger_7_prep

insert into sales_outlet values (100000, 5000, 'address', 'city', 'PR', '999-999-999', 0, 0, 0, 2, 364);

DECLARE 
    avg_total number(10, 2);
BEGIN
    SELECT AVG(st.total_goal) 
    INTO avg_total
    FROM sales_outlet_target st;

    FOR p IN (SELECT * FROM product)
    LOOP
        INSERT INTO sales_outlet_target (target_date, product_id, total_goal, sales_outlet_id)
        VALUES (CURRENT_DATE, p.id, avg_total, 100000);
    END LOOP;
END;
/

timing stop   
rollback
/

@triggers/trigger_7.sql

timing start trigger_7

insert into sales_outlet (square_feet, address, city, province, telephone, postal_code, longitude, latitude, sales_outlet_type_id, manager_staff_id) 
values (5000, 'address', 'city', 'PR', '999-999-999', 0, 0, 0, 2, 364);

timing stop   
exit rollback