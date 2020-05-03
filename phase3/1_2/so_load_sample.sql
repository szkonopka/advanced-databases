CREATE OR REPLACE DIRECTORY ext_tab_dir as 'D:\projects\advanced-databases\data\new_dataset';

CREATE TABLE sales_outlet_load_sample (
  id number(10) GENERATED BY DEFAULT AS IDENTITY, 
  square_feet number(10) NOT NULL, 
  address varchar2(512) NOT NULL, 
  city varchar2(256) NOT NULL, 
  province varchar2(256) NOT NULL, 
  telephone varchar2(128) NOT NULL, 
  postal_code number(10) NOT NULL, 
  longitude float(10) NOT NULL, 
  latitude float(10) NOT NULL, 
  sales_outlet_type_id number(10) NOT NULL, 
  manager_staff_id number(10), 
  PRIMARY KEY (id)
);

TIMING START load_sample_insert_timing;

INSERT INTO sales_outlet_load_sample (square_feet, address, city, province, telephone, postal_code, longitude, latitude, sales_outlet_type_id, manager_staff_id)
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

TIMING STOP;

DROP TABLE sales_outlet_load_sample;

EXIT ROLLBACK;
/