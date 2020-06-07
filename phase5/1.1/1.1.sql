CREATE TABLE sales_receipt_col (id number(10) GENERATED BY DEFAULT AS IDENTITY, transaction_datetime timestamp NOT NULL, in_store number NOT NULL, "order" number(10) NOT NULL, line_item_id number(10) NOT NULL, quantity number(10) NOT NULL, line_item_amount number(10, 2) NOT NULL, unit_price number(10, 2) NOT NULL, promo number NOT NULL, sales_outlet_id number(10), staff_id number(10) NOT NULL, customer_id number(10), product_id number(10) NOT NULL, PRIMARY KEY (id)) INMEMORY;
ALTER TABLE sales_receipt_col ADD CONSTRAINT fk_sales_receipt_col_sales_outlet_id FOREIGN KEY (sales_outlet_id) REFERENCES sales_outlet (id);
ALTER TABLE sales_receipt_col ADD CONSTRAINT fk_sales_receipt_col_staff_id FOREIGN KEY (staff_id) REFERENCES staff (id);
ALTER TABLE sales_receipt_col ADD CONSTRAINT fk_sales_receipt_col_customer_id FOREIGN KEY (customer_id) REFERENCES customer_col (id);
ALTER TABLE sales_receipt_col ADD CONSTRAINT fk_sales_receipt_col_product_id FOREIGN KEY (product_id) REFERENCES product (id);

CREATE OR REPLACE DIRECTORY ext_tab_dir as 'E:\advanced-databases\data\new_dataset';

INSERT INTO sales_receipt_col (transaction_datetime, in_store, "order", line_item_id, quantity, line_item_amount, unit_price, promo, sales_outlet_id, staff_id, customer_id, product_id)
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

EXIT;