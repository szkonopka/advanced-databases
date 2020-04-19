PROMPT '1st rule - unsold_products scheduler job'
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME        => 'unsold_products',
        JOB_TYPE        => 'PLSQL_BLOCK',
        JOB_ACTION      => '
            BEGIN
                    UPDATE pastry_inventory pi SET quantity_sold = (
                    SELECT SUM(quantity) AS quantity_sold
                    FROM sales_receipt sr
                    WHERE TRUNC(sr.transaction_datetime) = TRUNC(sysdate) AND TRUNC(sr.transaction_datetime) = TRUNC(pi.transaction_date) AND sr.product_id = pi.product_id
                    GROUP BY TRUNC(sr.transaction_datetime), sr.product_id),
                    WASTE = start_of_day - quantity_sold, waste_percentage = TRUNC(pi.quantity_sold * 100 / pi.start_of_day)
                    WHERE EXISTS(SELECT SUM(quantity) as quantity_sold
                    FROM sales_receipt sr
                    WHERE TRUNC(sr.transaction_datetime) = TRUNC(sysdate) AND TRUNC(sr.transaction_datetime) = TRUNC(pi.transaction_date) AND sr.product_id = pi.product_id
                    GROUP BY TRUNC(sr.transaction_datetime), sr.product_id);
            END;',
        START_DATE      => SYSTIMESTAMP,
        REPEAT_INTERVAL => 'FREQ=DAILY; BYHOUR=00; BYMINUTE=00',
        END_DATE        => NULL,
        ENABLED         => TRUE);
END;
/