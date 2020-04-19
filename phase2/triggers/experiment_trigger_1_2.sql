CREATE OR REPLACE TRIGGER experiment_1_2
    AFTER INSERT
    ON customer
BEGIN
    insert into generation (name) values ('generation');
END;
/