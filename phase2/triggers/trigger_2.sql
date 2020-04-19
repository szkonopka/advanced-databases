PROMPT '2nd rule - sales_statement scheduler job'
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME        => 'sales_statement',
        JOB_TYPE        => 'PLSQL_BLOCK',
        JOB_ACTION      => '
            BEGIN
                FOR sr IN (SELECT * FROM sales_receipt)
                LOOP
                    DBMS_OUTPUT.PUT_LINE( ''id: '' || sr.id || '' quantity: '' || sr.quantity || '' line_item_amount: '' || sr.line_item_amount || '' product_id:'' || sr.product_id || '' staff_id: '' || sr.staff_id || '' sales_outlet_id: '' || sr.sales_outlet_id || '' customer_id: '' || sr.customer_id);
                END LOOP;
            END;',
        START_DATE       => SYSTIMESTAMP,
        REPEAT_INTERVAL => 'FREQ=DAILY; BYHOUR=00; BYMINUTE=00',
        END_DATE         => NULL,
        ENABLED          => TRUE);
END;
/
