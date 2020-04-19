CREATE OR REPLACE TRIGGER experiment_1_1
    AFTER INSERT
    ON generation
BEGIN
    insert into customer (full_name,email,since,loyalty_card_number,birth_date,gender,home_sales_outlet_id,generation_id)
    values ('name', 'email', sysdate, 1, sysdate, 'M', 1, 1);
END;
/