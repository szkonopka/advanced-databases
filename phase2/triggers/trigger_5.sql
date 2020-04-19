PROMPT '5th rule - 5_percent_promo scheduler job'
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME        => '5_percent_promo',
        JOB_TYPE        => 'PLSQL_BLOCK',
        JOB_ACTION      => '
            DECLARE 
                min_week_incomes_product_id NUMBER(10, 2);
            BEGIN
                SELECT product_id 
                INTO min_week_incomes_product_id
                FROM (    
                    SELECT p.id as product_id, SUM(line_item_amount * current_retail_price) as incomes_last_week FROM sales_receipt sr 
                    JOIN product p ON sr.product_id = p.id
                    WHERE sr.transaction_datetime BETWEEN SYSDATE - 7 AND SYSDATE
                    GROUP BY p.id 
                    ORDER BY incomes_last_week ASC)
                WHERE ROWNUM <= 1;  

                UPDATE product
                SET current_retail_price = current_retail_price * 0.05, promo = 1
                WHERE id = min_week_incomes_product_id;
            END;',
        START_DATE      => SYSTIMESTAMP,
        REPEAT_INTERVAL => 'FREQ=WEEKLY; BYDAY=MON; BYHOUR=07; BYMINUTE=00',
        END_DATE        => NULL,
        ENABLED         => TRUE);
    );
END;
/