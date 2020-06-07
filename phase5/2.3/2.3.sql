alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics;

timing start no_col_tables;

select so.id, avg(sr.unit_price), avg(sr.line_item_amount)
from sales_receipt sr
    join sales_outlet so on sr.sales_outlet_id = so.id
    where so.id = 1 
    group by so.id
union    
select so.id, avg(sr.unit_price), avg(sr.line_item_amount)
from sales_receipt sr
    join sales_outlet so on sr.sales_outlet_id = so.id
    where so.id = 2
    group by so.id;    

timing stop;

timing start col_tables;

select so.id, avg(sr.unit_price), avg(sr.line_item_amount)
from sales_receipt_col sr
    join sales_outlet_col so on sr.sales_outlet_id = so.id
    where so.id = 1 
    group by so.id
union    
select so.id, avg(sr.unit_price), avg(sr.line_item_amount)
from sales_receipt_col sr
    join sales_outlet_col so on sr.sales_outlet_id = so.id
    where so.id = 2
    group by so.id;          

timing stop;

EXIT;