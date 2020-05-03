update SALES_OUTLET_TARGET st
set st.TOTAL_GOAL       = 0.05 * nvl((
                                           select sum(QUANTITY * UNIT_PRICE)
                                           from SALES_RECEIPT sr
                                                    join SALES_OUTLET so on sr.SALES_OUTLET_ID = so.ID
                                                    join SALES_OUTLET_TARGET st on so.ID = st.SALES_OUTLET_ID
                                                    join PRODUCT pp on sr.PRODUCT_ID = pp.ID
                                                    join PRODUCT_GROUP pg on pp.PRODUCT_GROUP_ID = pg.ID
                                           where so.ID = 3
                                       ), st.TOTAL_GOAL)
where st.SALES_OUTLET_ID = 3;