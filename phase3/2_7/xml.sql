alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

TIMING START xml_timing;

select extract(xmltype(age_details), '/age_details/age_details/generation/text()').getStringVal(), ROUND(AVG(S.LINE_ITEM_AMOUNT),2) as avgLineItemAmount from CUSTOMER_XML C
    join SALES_RECEIPT S on C.ID = S.CUSTOMER_ID
group by extract(xmltype(age_details), '/age_details/age_details/generation/text()').getStringVal();

TIMING STOP;
EXIT;