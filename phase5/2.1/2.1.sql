alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics;

timing start no_col_tables;

select g.name, sr.sales_outlet_id, sum(sr.line_item_amount), sum(sr.unit_price)
from sales_receipt sr
    join customer c on sr.customer_id = c.id
    join generation g on c.generation_id = g.id
    group by g.name, sr.sales_outlet_id order by g.name;

timing stop;

timing start col_tables;

select g.name, sr.sales_outlet_id, sum(sr.line_item_amount), sum(sr.unit_price)
from sales_receipt_col sr
    join customer_col c on sr.customer_id = c.id
    join generation g on c.generation_id = g.id
    group by g.name, sr.sales_outlet_id order by g.name;    

timing stop;

EXIT;