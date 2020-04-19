PROMPT '5th rule - percent_promo scheduler job'
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME        => 'percent_promo',
        JOB_TYPE        => 'PLSQL_BLOCK',
        JOB_ACTION      => '
            BEGIN
                UPDATE product
                SET current_retail_price = current_retail_price * 0.05, promo = 1
                WHERE id = (
                    SELECT product_id 
                    FROM (    
                        SELECT p.id as product_id, SUM(line_item_amount * current_retail_price) as incomes_last_week FROM sales_receipt sr 
                        JOIN product p ON sr.product_id = p.id
                        WHERE sr.transaction_datetime BETWEEN SYSDATE - 7 AND SYSDATE
                        GROUP BY p.id 
                        ORDER BY incomes_last_week ASC)
                    WHERE ROWNUM <= 1);
            END;',
        START_DATE      => SYSTIMESTAMP,
        REPEAT_INTERVAL => 'FREQ=WEEKLY; BYDAY=MON; BYHOUR=07; BYMINUTE=00',
        END_DATE        => NULL,
        ENABLED         => TRUE);
END;
/