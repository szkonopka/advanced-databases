-- THIS SCRIPT HAS BEEN GENERATED BY VPP BASED ON ERD SCHEMA -- 
CREATE TABLE staff (id number(10) GENERATED BY DEFAULT AS IDENTITY, firstName varchar2(128) NOT NULL, lastName varchar2(128) NOT NULL, startDate date NOT NULL, location varchar(10) NOT NULL, position number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE position (id number(10) GENERATED BY DEFAULT AS IDENTITY, name varchar2(128) NOT NULL UNIQUE, PRIMARY KEY (id));
CREATE TABLE product (id number(10) GENERATED BY DEFAULT AS IDENTITY, description varchar2(2048) NOT NULL, currentWholesalePrice number(10, 2) NOT NULL, currentRetailPrice number(10, 2) NOT NULL, taxExempt number NOT NULL, promo number NOT NULL, newProduct number(10) NOT NULL, unitOfMeasure varchar2(8) NOT NULL, productGroup number(10) NOT NULL, productCategory number(10) NOT NULL, productType number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE productType (id number(10) GENERATED BY DEFAULT AS IDENTITY, type varchar2(255) NOT NULL UNIQUE, PRIMARY KEY (id));
CREATE TABLE productCategory (id number(10) GENERATED BY DEFAULT AS IDENTITY, category varchar2(255) NOT NULL UNIQUE, PRIMARY KEY (id));
CREATE TABLE productGroup (id number(10) GENERATED BY DEFAULT AS IDENTITY, "group" varchar2(255) NOT NULL UNIQUE, PRIMARY KEY (id));
CREATE TABLE customer (id number(10) GENERATED BY DEFAULT AS IDENTITY, firstName varchar2(128) NOT NULL, email varchar2(256) NOT NULL, since date NOT NULL, loyaltyCardNumber varchar2(16) NOT NULL, birthdate date NOT NULL, gender varchar2(1) NOT NULL, homeStore number(10) NOT NULL, birthYear number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE generation (birthYear number(10), generationName varchar2(128), PRIMARY KEY (birthYear));
CREATE TABLE salesOutlet (id number(10) GENERATED BY DEFAULT AS IDENTITY, storeSquareFeet number(10) NOT NULL, storeAddress varchar2(512) NOT NULL, storeCity varchar2(256) NOT NULL, storeProvince varchar2(256) NOT NULL, storeTelephone number(10) NOT NULL, storePostalCode number(10) NOT NULL, storeLongitude float(10) NOT NULL, storeLatitude float(10) NOT NULL, neighborhood varchar2(512) NOT NULL, salesOutletType number(10) NOT NULL, manager number(10), PRIMARY KEY (id));
CREATE TABLE salesTarget (id number(10) GENERATED BY DEFAULT AS IDENTITY, yearMonthDate date NOT NULL, beansGoal number(10) NOT NULL, beverageGoal number(10) NOT NULL, foodGoal number(10) NOT NULL, merchandiseGoal number(10) NOT NULL, totalGoal number(10) NOT NULL, salesOutlet number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE pastryInventory (id number(10) GENERATED BY DEFAULT AS IDENTITY, transactionDate date NOT NULL, startOfDay number(10) NOT NULL, quantitySold number(10) NOT NULL, waste number(10) NOT NULL, wastePercentage number(10) NOT NULL, salesOutlet number(10) NOT NULL, product number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE salesReciepts (id number(10) GENERATED BY DEFAULT AS IDENTITY, transactionId number(10) NOT NULL, transactionTime timestamp NOT NULL, inStore number NOT NULL, "order" number(10) NOT NULL, lineItemId number(10) NOT NULL, quantity number(10) NOT NULL, lineItemAmount number(10) NOT NULL, unitPrice number(10, 2) NOT NULL, promo number NOT NULL, transactionDate date NOT NULL, salesOutlet number(10) NOT NULL, staff number(10) NOT NULL, customer number(10) NOT NULL, product number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE dates (transactionDate date NOT NULL, dateId varchar2(16) NOT NULL UNIQUE, weekId number(10) NOT NULL, weekDescription varchar2(64) NOT NULL, monthId number(10) NOT NULL, monthName varchar2(16) NOT NULL, quarterId number(10) NOT NULL, quarterName varchar2(2) NOT NULL, yearId number(10) NOT NULL, PRIMARY KEY (transactionDate));
CREATE TABLE salesOutletType (id number(10) GENERATED BY DEFAULT AS IDENTITY, type varchar2(128) NOT NULL UNIQUE, PRIMARY KEY (id));
ALTER TABLE product ADD CONSTRAINT FKproduct129337 FOREIGN KEY (productCategory) REFERENCES productCategory (id);
ALTER TABLE product ADD CONSTRAINT FKproduct218485 FOREIGN KEY (productGroup) REFERENCES productGroup (id);
ALTER TABLE product ADD CONSTRAINT FKproduct266502 FOREIGN KEY (productType) REFERENCES productType (id);
ALTER TABLE customer ADD CONSTRAINT FKcustomer929076 FOREIGN KEY (birthYear) REFERENCES generation (birthYear);
ALTER TABLE staff ADD CONSTRAINT FKstaff372050 FOREIGN KEY (position) REFERENCES position (id);
ALTER TABLE salesTarget ADD CONSTRAINT FKsalesTarge231367 FOREIGN KEY (salesOutlet) REFERENCES salesOutlet (id);
ALTER TABLE pastryInventory ADD CONSTRAINT FKpastryInve885858 FOREIGN KEY (salesOutlet) REFERENCES salesOutlet (id);
ALTER TABLE pastryInventory ADD CONSTRAINT FKpastryInve719785 FOREIGN KEY (product) REFERENCES product (id);
ALTER TABLE salesReciepts ADD CONSTRAINT FKsalesRecie348460 FOREIGN KEY (salesOutlet) REFERENCES salesOutlet (id);
ALTER TABLE salesReciepts ADD CONSTRAINT FKsalesRecie554213 FOREIGN KEY (staff) REFERENCES staff (id);
ALTER TABLE salesReciepts ADD CONSTRAINT FKsalesRecie717128 FOREIGN KEY (customer) REFERENCES customer (id);
ALTER TABLE salesOutlet ADD CONSTRAINT FKsalesOutle388223 FOREIGN KEY (salesOutletType) REFERENCES salesOutletType (id);
ALTER TABLE salesOutlet ADD CONSTRAINT FKsalesOutle241207 FOREIGN KEY (manager) REFERENCES staff (id);
ALTER TABLE customer ADD CONSTRAINT FKcustomer950011 FOREIGN KEY (homeStore) REFERENCES salesOutlet (id);
ALTER TABLE salesReciepts ADD CONSTRAINT FKsalesRecie17486 FOREIGN KEY (product) REFERENCES product (id);
ALTER TABLE salesReciepts ADD CONSTRAINT FKsalesRecie335741 FOREIGN KEY (transactionDate) REFERENCES dates (transactionDate);
ALTER TABLE pastryInventory ADD CONSTRAINT FKpastryInve898577 FOREIGN KEY (transactionDate) REFERENCES dates (transactionDate);
