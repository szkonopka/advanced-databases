PROMPT '6th rule - delete_sales_outlet trigger'
CREATE OR REPLACE TRIGGER delete_sales_outlet
    BEFORE DELETE
    ON sales_outlet
    FOR EACH ROW 
BEGIN
    DELETE FROM sales_outlet_target sot 
    WHERE sot.sales_outlet_id = :old.id;

    DELETE FROM pastry_inventory pi
    WHERE pi.sales_outlet_id = :old.id;

    UPDATE sales_receipt sr
    SET sr.sales_outlet_id = NULL
    WHERE sr.sales_outlet_id = :old.id;

    UPDATE staff s
    SET s.sales_outlet_id = NULL
    WHERE s.sales_outlet_id = :old.id;
END;
/