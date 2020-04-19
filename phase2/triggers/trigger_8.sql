PROMPT '8th rule - employee_promotion scheduler job'
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
            JOB_NAME   => 'employee_promotion',
            JOB_TYPE   => 'PLSQL_BLOCK',
            JOB_ACTION => '
                UPDATE staff
                SET position_id = (SELECT id FROM position WHERE name = ''Roaster'')
                WHERE id IN (
                    SELECT * FROM (
                        SELECT st.ID FROM staff st
                        JOIN sales_receipt sr ON st.id = sr.staff_id
                        WHERE MONTHS_BETWEEN(SYSDATE, SR.transaction_datetime) < 13
                        GROUP BY st.id, st.first_name, st.last_name
                        ORDER BY SUM(sr.quantity * sr.unit_price) DESC)
                WHERE ROWNUM = 1);',
            START_DATE      => SYSTIMESTAMP,
            REPEAT_INTERVAL => 'FREQ=MONTHLY; BYMONTHDAY=-1;',
            END_DATE        => NULL,
            ENABLED         => TRUE);
END;
/
