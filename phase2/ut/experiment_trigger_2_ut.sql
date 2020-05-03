CREATE TABLE experiment_2 (
    id number(10) GENERATED BY DEFAULT AS IDENTITY,
    tag  varchar2(128),
    timestamp timestamp
);

@triggers/experiment_trigger_2_1.sql
@triggers/experiment_trigger_2_2.sql
@triggers/experiment_trigger_2_3.sql


insert into customer (full_name,email,since,loyalty_card_number,birth_date,gender,home_sales_outlet_id,generation_id)
    values ('name', 'email', sysdate, 1, sysdate, 'M', 1, 1);
insert into customer (full_name,email,since,loyalty_card_number,birth_date,gender,home_sales_outlet_id,generation_id)
    values ('name', 'email', sysdate, 1, sysdate, 'M', 1, 1);
insert into customer (full_name,email,since,loyalty_card_number,birth_date,gender,home_sales_outlet_id,generation_id)
    values ('name', 'email', sysdate, 1, sysdate, 'M', 1, 1);

select * from experiment_2;	


DROP TABLE experiment_2;
DROP TRIGGER experiment_2_1;
DROP TRIGGER experiment_2_2;
DROP TRIGGER experiment_2_3;

exit rollback;