alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

timing start experiment_2

select g.name, sr.sales_outlet_id, sum(sr.line_item_amount), sum(sr.unit_price)
from sales_receipt_col sr
    join customer_col c on sr.customer_id = c.id
    join generation g on c.generation_id = g.id
    group by g.name, sr.sales_outlet_id order by g.name;    

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

timing stop

timing start experiment_2_inmemory

select g.name, sr.sales_outlet_id, sum(sr.line_item_amount), sum(sr.unit_price)
from sales_receipt_col sr
    join customer_col c on sr.customer_id = c.id
    join generation g on c.generation_id = g.id
    group by g.name, sr.sales_outlet_id order by g.name;    

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

timing stop
EXIT;