PROMPT '3rd rule - sold_products trigger'
CREATE OR REPLACE TRIGGER sold_products
    AFTER INSERT
    ON sales_receipt
    FOR EACH ROW
BEGIN
    UPDATE pastry_inventory pi
    SET pi.quantity_sold    = pi.quantity_sold + :new.quantity,
        pi.waste            = pi.waste - :new.quantity,
        pi.waste_percentage = trunc(pi.quantity_sold * 100 / pi.start_of_day)
    WHERE TRUNC(:new.transaction_datetime) = pi.transaction_date AND :new.product_id = pi.product_id;
END;
/