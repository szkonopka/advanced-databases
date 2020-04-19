PROMPT '4th rule - check_stack_before_transaction trigger'
CREATE OR REPLACE TRIGGER check_stack_before_transaction
    BEFORE INSERT
    ON sales_receipt
    FOR EACH ROW
DECLARE
    waste   number(10, 2);
BEGIN
    SELECT waste 
    INTO waste
    FROM pastry_inventory pi
    WHERE pi.sales_outlet_id = :new.sales_outlet_id;

    IF (waste <= 0)
    THEN
        RAISE_APPLICATION_ERROR(-20001, 'Not enough products on stack');
    END IF;
END;
/