CREATE OR REPLACE DIRECTORY ext_tab_dir as 'E:\advanced-databases\data\new_dataset';

INSERT INTO generation (name)
SELECT name_ext
FROM EXTERNAL (   
    (id_ext NUMBER(10) NOT NULL,  
	 name_ext VARCHAR2(128) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('generation.csv') REJECT LIMIT UNLIMITED) generation_external;
   
INSERT INTO product_group (name)
SELECT name_ext
FROM EXTERNAL (   
    (id_ext NUMBER(10) NOT NULL,  
	 name_ext VARCHAR2(255) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('product_group.csv') REJECT LIMIT UNLIMITED) product_group_external;
   
INSERT INTO product_type (name)
SELECT name_ext
FROM EXTERNAL (   
    (id_ext NUMBER(10) NOT NULL,  
	 name_ext VARCHAR2(255) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('product_type.csv') REJECT LIMIT UNLIMITED) product_type_external;

INSERT INTO product_category (name)
SELECT name_ext
FROM EXTERNAL (   
    (id_ext NUMBER(10) NOT NULL,  
	 name_ext VARCHAR2(255) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('product_category.csv') REJECT LIMIT UNLIMITED) product_category_external;  
   
INSERT INTO product (description, current_wholesale_price,current_retail_price, tax_exempt, promo, new_product, unit_of_measure, product_group_id, product_category_id, product_type_id)
SELECT description_ext,current_wholesale_price_ext,current_retail_price_ext,tax_exempt_ext,promo_ext,new_product_ext,unit_of_measure_ext,product_group_ext,product_category_ext,product_type_ext
FROM EXTERNAL (
    (id_ext NUMBER(10) NOT NULL,
	 description_ext varchar2(2048) NOT NULL, 
     current_wholesale_price_ext number(10, 2) NOT NULL, 
     current_retail_price_ext number(10, 2) NOT NULL, 
     tax_exempt_ext number NOT NULL, 
     promo_ext number NOT NULL,
     new_product_ext number(10) NOT NULL,
     unit_of_measure_ext varchar2(8) NOT NULL,
     product_group_ext number(10) NOT NULL, 
     product_category_ext number(10) NOT NULL, 
     product_type_ext number(10) NOT NULL
     )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')   
    LOCATION ('product.csv') REJECT LIMIT UNLIMITED) product_external;
    
INSERT INTO position (name)
SELECT name_ext
FROM EXTERNAL (   
    (id_ext NUMBER(10) NOT NULL,     
     name_ext VARCHAR2(128) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('position.csv') REJECT LIMIT UNLIMITED) position_external;  

INSERT INTO staff (first_name, last_name, start_date, sales_outlet_id, position_id)
SELECT first_name_ext, last_name_ext, start_date_ext, sales_outlet_id_ext, position_id_ext
FROM EXTERNAL (   
    (id_ext number(10) NOT NULL, 
     first_name_ext varchar2(128) NOT NULL, 
     last_name_ext varchar2(128) NOT NULL, 
     start_date_ext date NOT NULL, 
     sales_outlet_id_ext number(10) NOT NULL, 
     position_id_ext number(10) NOT NULL)  
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        id_ext, 
        first_name_ext, 
        last_name_ext, 
        start_date_ext CHAR(10) DATE_FORMAT DATE MASK "dd.mm.yyyy", 
        sales_outlet_id_ext, 
        position_id_ext))     
   LOCATION ('staff.csv') REJECT LIMIT UNLIMITED) staff_external;  
   
INSERT INTO sales_outlet_type (name)
SELECT name_ext
FROM EXTERNAL (   
    (id_ext NUMBER(10) NOT NULL,     
     name_ext VARCHAR2(128) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('sales_outlet_type.csv') REJECT LIMIT UNLIMITED) sales_outlet_type_external;  
   
INSERT INTO sales_outlet (square_feet, address, city, province, telephone, postal_code, longitude, latitude, sales_outlet_type_id, manager_staff_id)
SELECT square_feet_ext, address_ext, city_ext, province_ext, telephone_ext, postal_code_ext, longitude_ext, latitude_ext, sales_outlet_type_id_ext, manager_staff_id_ext
FROM EXTERNAL (   
    (id_ext number(10) NOT NULL, 
     square_feet_ext number(10) NOT NULL, 
     address_ext varchar2(512) NOT NULL, 
     city_ext varchar2(256) NOT NULL, 
     province_ext varchar2(256) NOT NULL, 
     telephone_ext varchar(128) NOT NULL, 
     postal_code_ext number(10) NOT NULL, 
     longitude_ext float(10) NOT NULL, 
     latitude_ext float(10) NOT NULL, 
     sales_outlet_type_id_ext number(10) NOT NULL, 
     manager_staff_id_ext number(10))     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('sales_outlet.csv') REJECT LIMIT UNLIMITED) sales_outlet_external;     
   
INSERT INTO sales_outlet_target (target_date, product_id, total_goal, sales_outlet_id)
SELECT target_date_ext, product_id_ext, total_goal_ext, sales_outlet_id_ext
FROM EXTERNAL (   
    (id_ext number(10) NOT NULL, 
     target_date_ext date NOT NULL,  
     product_id_ext number(10) NOT NULL,
     total_goal_ext number(10) NOT NULL, 
     sales_outlet_id_ext number(10) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        id_ext, 
        target_date_ext CHAR(11) DATE_FORMAT DATE MASK "dd.mm.yyyy",
        product_id_ext, 
        total_goal_ext,
        sales_outlet_id_ext))     
   LOCATION ('sales_outlet_target.csv') REJECT LIMIT UNLIMITED) sales_outlet_target_external;  
     
INSERT INTO pastry_inventory (transaction_date, start_of_day, quantity_sold, waste, waste_percentage, sales_outlet_id, product_id)
SELECT transaction_date_ext, start_of_day_ext, quantity_sold_ext, waste_ext, waste_percentage_ext, sales_outlet_id_ext, product_id_ext
FROM EXTERNAL (   
    (id_ext number(10) NOT NULL,
	 transaction_date_ext date NOT NULL, 
     start_of_day_ext number(10) NOT NULL, 
     quantity_sold_ext number(10) NOT NULL, 
     waste_ext number(10) NOT NULL, 
     waste_percentage_ext number(10) NOT NULL, 
     sales_outlet_id_ext number(10) NOT NULL, 
     product_id_ext number(10) NOT NULL)
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
		id_ext,
        transaction_date_ext CHAR(10) DATE_FORMAT DATE MASK "dd.mm.yyyy", 
        start_of_day_ext, 
        quantity_sold_ext, 
        waste_ext, 
        waste_percentage_ext, 
        sales_outlet_id_ext, 
        product_id_ext))
   LOCATION ('pastry_inventory.csv') REJECT LIMIT UNLIMITED) pastry_inventory_external;  
   
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

INSERT INTO sales_receipt (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
SELECT transaction_datetime_ext, in_store_ext, order_ext, line_item_id_ext, quantity_ext, line_item_amount_ext, unit_price_ext, promo_ext, sales_outlet_id_ext, staff_id_ext, customer_id_ext, product_id_ext
FROM EXTERNAL (   
    (id_ext number(10) NOT NULL, 
     transaction_datetime_ext timestamp NOT NULL, 
     in_store_ext number NOT NULL, 
     order_ext number(10) NOT NULL, 
     line_item_id_ext number(10) NOT NULL, 
     quantity_ext number(10) NOT NULL, 
     line_item_amount_ext number(10, 2) NOT NULL, 
     unit_price_ext number(10, 2) NOT NULL, 
     promo_ext number NOT NULL, 
     sales_outlet_id_ext number(10) NOT NULL, 
     staff_id_ext number(10) NOT NULL, 
     customer_id_ext number(10), 
     product_id_ext number(10) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        id_ext, 
        transaction_datetime_ext CHAR(20) DATE_FORMAT DATE MASK "yyyy.mm.dd HH24:MI:SS", 
        in_store_ext, 
        order_ext, 
        line_item_id_ext, 
        quantity_ext, 
        line_item_amount_ext, 
        unit_price_ext, 
        promo_ext, 
        sales_outlet_id_ext, 
        staff_id_ext, 
        customer_id_ext, 
        product_id_ext))     
   LOCATION ('sales_receipt.csv') REJECT LIMIT UNLIMITED) sales_receipt_external;    

EXIT