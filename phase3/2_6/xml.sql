alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics
TIMING START xml_timing;

select extract(xmltype(age_details), '/age_details/age_details/generation/text()').getStringVal(), st.id, count(*) from staff st join
    sales_receipt sr on sr.staff_id = st.id join
    customer_xml cu on sr.customer_id = cu.id 
    group by extract(xmltype(age_details), '/age_details/age_details/generation/text()').getStringVal(), st.id;

TIMING STOP;
EXIT ROLLBACK;