ALTER TABLE product DROP CONSTRAINT fk_product_category_id;
ALTER TABLE product DROP CONSTRAINT fk_product_group_id;
ALTER TABLE product DROP CONSTRAINT fk_product_type_id;
ALTER TABLE customer DROP CONSTRAINT fk_customer_generation_id;
ALTER TABLE staff DROP CONSTRAINT fk_staff_position_id;
ALTER TABLE sales_outlet_target DROP CONSTRAINT fk_sales_target_sales_outlet_id;
ALTER TABLE pastry_inventory DROP CONSTRAINT fk_pastry_inventory_sales_outlet_id;
ALTER TABLE pastry_inventory DROP CONSTRAINT fk_pastry_inventory_product_id;
ALTER TABLE sales_receipt DROP CONSTRAINT fk_sales_receipt_sales_outlet_id;
ALTER TABLE sales_receipt DROP CONSTRAINT fk_sales_receipt_staff_id;
ALTER TABLE sales_receipt DROP CONSTRAINT fk_sales_receipt_customer_id;
ALTER TABLE sales_outlet DROP CONSTRAINT fk_sales_outlet_type_id;
ALTER TABLE sales_outlet DROP CONSTRAINT fk_sales_outlet_manager_staff_id;
ALTER TABLE customer DROP CONSTRAINT fk_customer_home_sales_outlet_id;
ALTER TABLE sales_receipt DROP CONSTRAINT fk_sales_receipt_product_id;

truncate table sales_receipt;
truncate table customer;
truncate table pastry_inventory;
truncate table sales_outlet_target;
truncate table sales_outlet;
truncate table sales_outlet_type;
truncate table staff;
truncate table position;
truncate table product;
truncate table product_type;
truncate table product_category;
truncate table product_group;
truncate table generation;

ALTER TABLE product ADD CONSTRAINT fk_product_category_id FOREIGN KEY (product_category_id) REFERENCES product_category (id);
ALTER TABLE product ADD CONSTRAINT fk_product_group_id FOREIGN KEY (product_group_id) REFERENCES product_group (id);
ALTER TABLE product ADD CONSTRAINT fk_product_type_id FOREIGN KEY (product_type_id) REFERENCES product_type (id);
ALTER TABLE customer ADD CONSTRAINT fk_customer_generation_id FOREIGN KEY (generation_id) REFERENCES generation (id);
ALTER TABLE staff ADD CONSTRAINT fk_staff_position_id FOREIGN KEY (position_id) REFERENCES position (id);
ALTER TABLE sales_outlet_target ADD CONSTRAINT fk_sales_target_sales_outlet_id FOREIGN KEY (sales_outlet_id) REFERENCES sales_outlet (id);
ALTER TABLE pastry_inventory ADD CONSTRAINT fk_pastry_inventory_sales_outlet_id FOREIGN KEY (sales_outlet_id) REFERENCES sales_outlet (id);
ALTER TABLE pastry_inventory ADD CONSTRAINT fk_pastry_inventory_product_id FOREIGN KEY (product_id) REFERENCES product (id);
ALTER TABLE sales_receipt ADD CONSTRAINT fk_sales_receipt_sales_outlet_id FOREIGN KEY (sales_outlet_id) REFERENCES sales_outlet (id);
ALTER TABLE sales_receipt ADD CONSTRAINT fk_sales_receipt_staff_id FOREIGN KEY (staff_id) REFERENCES staff (id);
ALTER TABLE sales_receipt ADD CONSTRAINT fk_sales_receipt_customer_id FOREIGN KEY (customer_id) REFERENCES customer (id);
ALTER TABLE sales_outlet ADD CONSTRAINT fk_sales_outlet_type_id FOREIGN KEY (sales_outlet_type_id) REFERENCES sales_outlet_type (id);
ALTER TABLE sales_outlet ADD CONSTRAINT fk_sales_outlet_manager_staff_id FOREIGN KEY (manager_staff_id) REFERENCES staff (id);
ALTER TABLE customer ADD CONSTRAINT fk_customer_home_sales_outlet_id FOREIGN KEY (home_sales_outlet_id) REFERENCES sales_outlet (id);
ALTER TABLE sales_receipt ADD CONSTRAINT fk_sales_receipt_product_id FOREIGN KEY (product_id) REFERENCES product (id);

drop trigger sprzedane_produkty;

exit