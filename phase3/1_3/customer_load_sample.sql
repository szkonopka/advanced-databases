CREATE OR REPLACE DIRECTORY ext_tab_dir as 'D:\projects\advanced-databases\data\new_dataset';

TIMING START load_sample_insert_timing;

INSERT INTO customer (full_name,email,since,loyalty_card_number,birth_date,gender,home_sales_outlet_id,generation_id)
SELECT full_name_ext,email_ext,since_ext,loyalty_card_number_ext,birthdate_ext,gender_ext,home_sales_outlet_id_ext,generation_id_ext
FROM EXTERNAL (   
    (id_ext number(10) NOT NULL,
	 full_name_ext varchar2(128) NOT NULL, 
     email_ext varchar2(256) NOT NULL, 
     since_ext date NOT NULL, 
     loyalty_card_number_ext varchar2(16) NOT NULL, 
     birthdate_ext date NOT NULL, 
     gender_ext varchar2(1) NOT NULL, 
     home_sales_outlet_id_ext number(10) NOT NULL, 
     generation_id_ext number(10) NOT NULL)
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        id_ext, 
        full_name_ext, 
        email_ext, 
        since_ext CHAR(10) DATE_FORMAT DATE MASK "dd.mm.yyyy", 
        loyalty_card_number_ext, 
        birthdate_ext CHAR(10) DATE_FORMAT DATE MASK "dd.mm.yyyy", 
        gender_ext, 
        home_sales_outlet_id_ext, 
        generation_id_ext))     
   LOCATION ('customer.csv') REJECT LIMIT UNLIMITED) customer_external; 

TIMING STOP;
EXIT ROLLBACK;
/