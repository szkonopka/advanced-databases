ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;
SET AUTOTRACE TRACEONLY STATISTICS;

TIMING START no_col_tables; 

SELECT cc.ID, SUM(sr.line_item_amount) FROM customer cc
JOIN sales_receipt sr ON sr.customer_id = cc.ID AND sr.transaction_datetime >= add_months(sysdate, -18)
GROUP BY cc.ID
ORDER BY SUM(sr.line_item_amount) DESC;
    
TIMING STOP;

TIMING START col_tables;        

SELECT cc.ID, SUM(sr.line_item_amount) FROM customer_col cc
JOIN sales_receipt_col sr ON sr.customer_id = cc.ID AND sr.transaction_datetime >= add_months(sysdate, -18)
GROUP BY cc.ID
ORDER BY SUM(sr.line_item_amount) DESC;

TIMING STOP;

EXIT;


