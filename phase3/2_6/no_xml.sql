alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START no_xml_timing;

select g.name, st.id, count(*) from staff st join
    sales_receipt sr on sr.staff_id = st.id join
    customer cu on sr.customer_id = cu.id join
    generation g on g.id = cu.generation_id
    group by g.name, st.id;

TIMING STOP;
EXIT;