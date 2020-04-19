CREATE OR REPLACE TRIGGER experiment_2_2
    AFTER INSERT
    ON customer
BEGIN
    insert into experiment_2 (tag, timestamp)
    values ('trigger 2', sysdate);
END;

/