TIMING START no_xml_timing;

select sr.* from SALES_RECEIPT sr
    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
    join PRODUCT p on sr.PRODUCT_ID = p.ID
    where so.ID = 3 and p.PROMO = 1;

TIMING STOP;
EXIT ROLLBACK;