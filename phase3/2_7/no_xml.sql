alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START no_xml_timing;

select G.NAME, ROUND(AVG(S.LINE_ITEM_AMOUNT),2) as avgLineItemAmount from CUSTOMER C
    join GENERATION G on C.GENERATION_ID = G.ID
    join SALES_RECEIPT S on C.ID = S.CUSTOMER_ID
group by G.NAME;

TIMING STOP;
EXIT;