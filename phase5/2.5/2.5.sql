ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;
SET AUTOTRACE TRACEONLY STATISTICS;

TIMING START no_col_tables; 

update sales_outlet so
set so.sales_outlet_type_id = 2
where so.id in (
    select so.id from sales_outlet so
    join sales_outlet_type sot on sot.id = so.sales_outlet_type_id
    where city = 'Akron'
);

rollback;
    
TIMING STOP;

TIMING START col_tables;        

update sales_outlet_col so
set so.sales_outlet_type_id = 2
where so.id in (
    select so.id from sales_outlet_col so
    join sales_outlet_type sot on sot.id = so.sales_outlet_type_id
    where city = 'Akron'
);

rollback;

TIMING STOP;

EXIT;


