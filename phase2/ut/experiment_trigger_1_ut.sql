@triggers/experiment_trigger_1_1.sql
@triggers/experiment_trigger_1_2.sql

 insert into customer (full_name,email,since,loyalty_card_number,birth_date,gender,home_sales_outlet_id,generation_id)
    values ('name', 'email', sysdate, 1, sysdate, 'M', 1, 1);
	
DROP TRIGGER experiment_1_1;
DROP TRIGGER experiment_1_2;
	
exit rollback;	