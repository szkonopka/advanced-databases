
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

timing start trigger_5_prep

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

timing stop   
rollback
/

@triggers/trigger_5.sql

timing start trigger_5

begin
    dbms_scheduler.run_job(job_name => 'percent_promo');
end;
/

timing stop   
exit rollback