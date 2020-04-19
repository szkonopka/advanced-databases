CREATE OR REPLACE TRIGGER experiment_2_1
    AFTER INSERT
    ON customer
BEGIN
    insert into experiment_2 (tag, timestamp)
    values ('trigger 1', sysdate);
END;

/