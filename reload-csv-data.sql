CREATE DIRECTORY ext_tab_dir as 'D:\Projects\advanced-databases\data\processed';

INSERT INTO generation(birthYear, generationName)
SELECT birthYearExt, generationNameExt
FROM EXTERNAL (   
    (birthYearExt NUMBER(10, 0) NOT NULL,     
     generationNameExt VARCHAR2(128) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('generation.csv') REJECT LIMIT UNLIMITED) generation_external;
   
INSERT INTO productGroup(id, "group")
SELECT idExt, groupExt
FROM EXTERNAL (   
    (idExt NUMBER(10) NOT NULL,     
     groupExt VARCHAR2(255) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('productGroup.csv') REJECT LIMIT UNLIMITED) productGroup_external;
   
INSERT INTO productType(id, type)
SELECT idExt, typeExt
FROM EXTERNAL (   
    (idExt NUMBER(10) NOT NULL,     
     typeExt VARCHAR2(255) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('productType.csv') REJECT LIMIT UNLIMITED) productType_external;

INSERT INTO productCategory(id, category)
SELECT idExt, categoryExt
FROM EXTERNAL (   
    (idExt NUMBER(10) NOT NULL,     
     categoryExt VARCHAR2(255) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('productCategory.csv') REJECT LIMIT UNLIMITED) productCategory_external;  
   
INSERT INTO product(id, description, currentWholesalePrice, currentRetailPrice, taxExempt, promo, newProduct, unitOfMeasure, productGroup, productCategory, productType)
SELECT idExt, descriptionExt, currentWholesalePriceExt, currentRetailPriceExt, taxExemptExt, promoExt, newProductExt, unitOfMeasureExt, productGroupExt, productCategoryExt, productTypeExt
FROM EXTERNAL (
    (idExt number(10) NOT NULL, 
     descriptionExt varchar2(2048) NOT NULL, 
     currentWholesalePriceExt number(10, 2) NOT NULL, 
     currentRetailPriceExt number(10, 2) NOT NULL, 
     taxExemptExt number NOT NULL, 
     promoExt number NOT NULL, 
     newProductExt number(10) NOT NULL, 
     unitOfMeasureExt varchar2(8) NOT NULL, 
     productGroupExt number(10) NOT NULL, 
     productCategoryExt number(10) NOT NULL, 
     productTypeExt number(10) NOT NULL)
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')   
    LOCATION ('product.csv') REJECT LIMIT UNLIMITED) product_external;
    
INSERT INTO position(id, name)
SELECT idExt, nameExt
FROM EXTERNAL (   
    (idExt NUMBER(10) NOT NULL,     
     nameExt VARCHAR2(128) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('position.csv') REJECT LIMIT UNLIMITED) position_external;  

INSERT INTO staff(id, firstName, lastName, startDate, location, position)
SELECT idExt, firstNameExt, lastNameExt, startDateExt, locationExt, positionExt
FROM EXTERNAL (   
    (idExt number(10) NOT NULL, 
     firstNameExt varchar2(128) NOT NULL, 
     lastNameExt varchar2(128) NOT NULL, 
     startDateExt date NOT NULL, 
     locationExt varchar(10) NOT NULL, 
     positionExt number(10) NOT NULL)  
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        idExt, 
        firstNameExt, 
        lastNameExt, 
        startDateExt CHAR(10) DATE_FORMAT DATE MASK "mm/dd/yyyy", 
        locationExt, 
        positionExt))     
   LOCATION ('staff.csv') REJECT LIMIT UNLIMITED) staff_external;  
   
INSERT INTO salesOutletType(id, type)
SELECT idExt, typeExt
FROM EXTERNAL (   
    (idExt NUMBER(10) NOT NULL,     
     typeExt VARCHAR2(128) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('salesOutletType.csv') REJECT LIMIT UNLIMITED) salesOutletType_external;  
   
INSERT INTO salesOutlet(id, storeSquareFeet, storeAddress, storeCity, storeProvince, storeTelephone, storePostalCode, storeLongitude, storeLatitude, neighborhood, salesOutletType, manager)
SELECT idExt, storeSquareFeetExt, storeAddressExt, storeCityExt, storeProvinceExt, storeTelephoneExt, storePostalCodeExt, storeLongitudeExt, storeLatitudeExt, neighborhoodExt, salesOutletTypeExt, managerExt
FROM EXTERNAL (   
    (idExt number(10) NOT NULL, 
     storeSquareFeetExt number(10) NOT NULL, 
     storeAddressExt varchar2(512) NOT NULL, 
     storeCityExt varchar2(256) NOT NULL, 
     storeProvinceExt varchar2(256) NOT NULL, 
     storeTelephoneExt number(10) NOT NULL, 
     storePostalCodeExt number(10) NOT NULL, 
     storeLongitudeExt float(10) NOT NULL, 
     storeLatitudeExt float(10) NOT NULL, 
     neighborhoodExt varchar2(512) NOT NULL, 
     salesOutletTypeExt number(10) NOT NULL, 
     managerExt number(10))     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';')     
   LOCATION ('salesOutlet.csv') REJECT LIMIT UNLIMITED) salesOutlet_external;  
   
INSERT INTO salesTarget(id, yearMonthDate, beansGoal, beverageGoal, foodGoal, merchandiseGoal, totalGoal, salesOutlet)
SELECT idExt, yearMonthDateExt, beansGoalExt, beverageGoalExt, foodGoalExt, merchandiseGoalExt, totalGoalExt, salesOutletExt
FROM EXTERNAL (   
    (idExt number(10) NOT NULL, 
     yearMonthDateExt date NOT NULL, 
     beansGoalExt number(10) NOT NULL, 
     beverageGoalExt number(10) NOT NULL,
     foodGoalExt number(10) NOT NULL, 
     merchandiseGoalExt number(10) NOT NULL, 
     totalGoalExt number(10) NOT NULL, 
     salesOutletExt number(10) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        idExt, 
        yearMonthDateExt CHAR(11) DATE_FORMAT DATE MASK "mm/yyyy",
        beansGoalExt, 
        beverageGoalExt,
        foodGoalExt, 
        merchandiseGoalExt, 
        totalGoalExt, 
        salesOutletExt))     
   LOCATION ('salesTarget.csv') REJECT LIMIT UNLIMITED) salesTarget_external;  
   
INSERT INTO dates(transactionDate, dateId, weekId, weekDescription, monthId, monthName, quarterId, quarterName, yearId)
SELECT transactionDateExt, dateIdExt, weekIdExt, weekDescriptionExt, monthIdExt, monthNameExt, quarterIdExt, quarterNameExt, yearIdExt
FROM EXTERNAL (   
    (transactionDateExt date NOT NULL, 
     dateIdExt varchar2(16) NOT NULL, 
     weekIdExt number(10) NOT NULL, 
     weekDescriptionExt varchar2(64) NOT NULL, 
     monthIdExt number(10) NOT NULL, 
     monthNameExt varchar2(16) NOT NULL, 
     quarterIdExt number(10) NOT NULL, 
     quarterNameExt varchar2(2) NOT NULL, 
     yearIdExt number(10) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        transactionDateExt CHAR(10) DATE_FORMAT DATE MASK "mm/dd/yyyy", 
        dateIdExt, 
        weekIdExt, 
        weekDescriptionExt, 
        monthIdExt, 
        monthNameExt, 
        quarterIdExt, 
        quarterNameExt, 
        yearIdExt))     
   LOCATION ('dates.csv') REJECT LIMIT UNLIMITED) dates_external; 
   
INSERT INTO pastryInventory(transactionDate, startOfDay, quantitySold, waste, wastePercentage, salesOutlet, product)
SELECT transactionDateExt, startOfDayExt, quantitySoldExt, wasteExt, wastePercentageExt, salesOutletExt, productExt
FROM EXTERNAL (   
    (transactionDateExt date NOT NULL, 
     startOfDayExt number(10) NOT NULL, 
     quantitySoldExt number(10) NOT NULL, 
     wasteExt number(10) NOT NULL, 
     wastePercentageExt number(10) NOT NULL, 
     salesOutletExt number(10) NOT NULL, 
     productExt number(10) NOT NULL)
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        transactionDateExt CHAR(10) DATE_FORMAT DATE MASK "mm/dd/yyyy", 
        startOfDayExt, 
        quantitySoldExt, 
        wasteExt, 
        wastePercentageExt, 
        salesOutletExt, 
        productExt))
   LOCATION ('pastryInventory.csv') REJECT LIMIT UNLIMITED) pastryInventory_external;  
   
INSERT INTO customer(id, firstName, email, since, loyaltyCardNumber, birthdate, gender, homeStore, birthYear)
SELECT idExt, firstNameExt, emailExt, sinceExt, loyaltyCardNumberExt, birthdateExt, genderExt, homeStoreExt, birthYearExt
FROM EXTERNAL (   
    (idExt number(10) NOT NULL, 
     firstNameExt varchar2(128) NOT NULL, 
     emailExt varchar2(256) NOT NULL, 
     sinceExt date NOT NULL, 
     loyaltyCardNumberExt varchar2(16) NOT NULL, 
     birthdateExt date NOT NULL, 
     genderExt varchar2(1) NOT NULL, 
     homeStoreExt number(10) NOT NULL, 
     birthYearExt number(10) NOT NULL)
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        idExt, 
        firstNameExt, 
        emailExt, 
        sinceExt CHAR(10) DATE_FORMAT DATE MASK "yyyy-mm-dd", 
        loyaltyCardNumberExt, 
        birthdateExt CHAR(10) DATE_FORMAT DATE MASK "yyyy-mm-dd", 
        genderExt, 
        homeStoreExt, 
        birthYearExt))     
   LOCATION ('customer.csv') REJECT LIMIT UNLIMITED) customer_external; 

INSERT INTO salesReciepts(id, transactionId, transactionTime, inStore, "order", lineItemId, quantity, lineItemAmount, unitPrice, promo, transactionDate, salesOutlet, staff, customer, product)
SELECT idExt, transactionIdExt, transactionTimeExt, inStoreExt, orderExt, lineItemIdExt, quantityExt, lineItemAmountExt, unitPriceExt, promoExt, transactionDateExt, salesOutletExt, staffExt, customerExt, productExt
FROM EXTERNAL (   
    (idExt number(10) NOT NULL, 
     transactionIdExt number(10) NOT NULL, 
     transactionTimeExt timestamp NOT NULL, 
     inStoreExt number NOT NULL, 
     orderExt number(10) NOT NULL, 
     lineItemIdExt number(10) NOT NULL, 
     quantityExt number(10) NOT NULL, 
     lineItemAmountExt number(10, 2) NOT NULL, 
     unitPriceExt number(10, 2) NOT NULL, 
     promoExt number NOT NULL, 
     transactionDateExt date NOT NULL, 
     salesOutletExt number(10) NOT NULL, 
     staffExt number(10) NOT NULL, 
     customerExt number(10), 
     productExt number(10) NOT NULL)     
    TYPE ORACLE_LOADER     
    DEFAULT DIRECTORY ext_tab_dir
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY '\n'
      FIELDS TERMINATED BY ';' (
        idExt, 
        transactionIdExt, 
        transactionTimeExt CHAR(10) DATE_FORMAT DATE MASK "HH24:MI:SS", 
        inStoreExt, 
        orderExt, 
        lineItemIdExt, 
        quantityExt, 
        lineItemAmountExt, 
        unitPriceExt, 
        promoExt, 
        transactionDateExt CHAR(10) DATE_FORMAT DATE MASK "yyyy-mm-dd", 
        salesOutletExt, 
        staffExt, 
        customerExt, 
        productExt))     
   LOCATION ('salesReciepts.csv') REJECT LIMIT UNLIMITED) salesReciepts_external;  

EXIT