CREATE OR REPLACE TRIGGER experiment_2_3
    AFTER INSERT
    ON customer
BEGIN
    insert into experiment_2 (tag, timestamp)
    values ('trigger 3', sysdate);
END;

/