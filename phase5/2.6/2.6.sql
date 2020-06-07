ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;
SET AUTOTRACE TRACEONLY STATISTICS;

TIMING START no_col_tables; 

alter table sales_outlet_target
drop constraint FK_SALES_TARGET_SALES_OUTLET_ID;

alter table sales_receipt
drop constraint FK_SALES_RECEIPT_SALES_OUTLET_ID;

alter table customer
drop constraint FK_CUSTOMER_HOME_SALES_OUTLET_ID;

alter table sales_receipt_col
drop constraint FK_SALES_RECEIPT_COL_SALES_OUTLET_ID;

DELETE FROM sales_outlet
WHERE ID IN (    
    SELECT so.ID FROM sales_outlet so
    JOIN sales_outlet_target st ON st.sales_outlet_id = so.ID AND st.target_date >= add_months(sysdate, -18)
    JOIN sales_receipt sr ON sr.sales_outlet_id = so.ID
    WHERE sr.transaction_datetime >= add_months(sysdate, -18)
    GROUP BY so.ID
    HAVING SUM(sr.line_item_amount) < SUM(st.total_goal)
);

rollback;
    
TIMING STOP;

TIMING START col_tables;  

alter table sales_outlet_target
drop constraint FK_SALES_TARGET_SALES_OUTLET_ID;

alter table sales_receipt
drop constraint FK_SALES_RECEIPT_SALES_OUTLET_ID;

alter table customer
drop constraint FK_CUSTOMER_HOME_SALES_OUTLET_ID;

alter table sales_receipt_col
drop constraint FK_SALES_RECEIPT_COL_SALES_OUTLET_ID;

DELETE FROM sales_outlet_col
WHERE ID IN (    
    SELECT so.ID FROM sales_outlet_col so
    JOIN sales_outlet_target st ON st.sales_outlet_id = so.ID AND st.target_date >= add_months(sysdate, -18)
    JOIN sales_receipt_col sr ON sr.sales_outlet_id = so.ID
    WHERE sr.transaction_datetime >= add_months(sysdate, -18)
    GROUP BY so.ID
    HAVING SUM(sr.line_item_amount) < SUM(st.total_goal)
);

rollback;

TIMING STOP;

EXIT;


