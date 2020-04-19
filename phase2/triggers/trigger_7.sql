PROMPT '7th rule - sales_goals_for_new_sales_outlet'
CREATE OR REPLACE TRIGGER sales_goals_for_new_sales_outlet
    AFTER INSERT
    ON SALES_OUTLET
    FOR EACH ROW
DECLARE
    avg_total       number(10, 2);
BEGIN
    SELECT AVG(st.total_goal)
    INTO avg_total
    FROM sales_outlet_target st;
    
    FOR p IN (SELECT * FROM product)
    LOOP
        INSERT INTO sales_outlet_target (target_date, product_id, total_goal, sales_outlet_id)
        VALUES (CURRENT_DATE, p.id, avg_total, :new.ID);
    END LOOP;
END;
/
