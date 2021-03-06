DROP TABLE customer_xml;
CREATE TABLE customer_xml (
	id number(10) GENERATED BY DEFAULT AS IDENTITY, 
	full_name varchar2(128) NOT NULL, 
	email varchar2(256) NOT NULL, 
	since date NOT NULL, 
	loyalty_card_number varchar2(16) NOT NULL, 
	birth_date date NOT NULL, 
	gender varchar2(1) NOT NULL, 
	home_sales_outlet_id number(10), 
	generation_id number(10) NOT NULL, 
	age_details varchar2(500),
	PRIMARY KEY (id)
);

EXIT;
/