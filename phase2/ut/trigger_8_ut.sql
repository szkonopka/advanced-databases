alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

timing start trigger_8_prep

UPDATE staff
SET position_id = (SELECT id FROM position WHERE name = 'Roaster')
WHERE id IN (
    SELECT * FROM (
        SELECT st.ID FROM staff st
        JOIN sales_receipt sr ON st.id = sr.staff_id
        WHERE MONTHS_BETWEEN(SYSDATE, SR.transaction_datetime) < 13
        GROUP BY st.id, st.first_name, st.last_name
        ORDER BY SUM(sr.quantity * sr.unit_price) DESC)
WHERE ROWNUM = 1);

timing stop   
rollback
/

@triggers/trigger_8.sql

timing start trigger_8

begin
    dbms_scheduler.run_job(job_name => 'employee_promotion');
end;
/
timing stop   
exit rollback