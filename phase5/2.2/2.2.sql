alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics;

timing start no_col_tables;

delete from sales_receipt where customer_id=4286;
delete from customer where id=4286;

timing stop;

ROLLBACK;

timing start col_tables;

delete from sales_receipt_col where customer_id=4286;
delete from customer_col where id=4286;

timing stop;

ROLLBACK;

EXIT;