DROP TABLE sales_receipt_xml;

TIMING START create_timing;

DECLARE
  extension_1_1 CLOB;
BEGIN
  extension_1_1 := '<?xml version="1.0" encoding="UTF-8"?>
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    elementFormDefault="qualified">
      <xs:element name="sales_receipt">
        <xs:complexType>
          <xs:sequence>
            <xs:element ref="transaction_datetime"/>
            <xs:element ref="in_store"/>
            <xs:element ref="order"/>
            <xs:element ref="line_item_id"/>
            <xs:element ref="quantity"/>
            <xs:element ref="line_item_amount"/>
            <xs:element ref="unit_price"/>
            <xs:element ref="promo"/>
            <xs:element ref="sales_outlet_id"/>
            <xs:element ref="staff_id"/>
            <xs:element ref="customer_id"/>
            <xs:element ref="product_id"/>
          </xs:sequence>
          <xs:attribute name="id" use="required" type="xs:integer"/>
        </xs:complexType>
      </xs:element>
      <xs:element name="transaction_datetime" type="xs:string"/>
      <xs:element name="in_store" type="xs:integer"/>
      <xs:element name="order" type="xs:integer"/>
      <xs:element name="line_item_id" type="xs:integer"/>
      <xs:element name="quantity" type="xs:integer"/>
      <xs:element name="line_item_amount" type="xs:decimal"/>
      <xs:element name="unit_price" type="xs:decimal"/>
      <xs:element name="promo" type="xs:integer"/>
      <xs:element name="sales_outlet_id" type="xs:integer"/>
      <xs:element name="staff_id" type="xs:integer"/>
      <xs:element name="customer_id" type="xs:integer"/>
      <xs:element name="product_id" type="xs:integer"/>
    </xs:schema>';
 
    DBMS_XMLSCHEMA.registerSchema(
      schemaurl       => 'sales_receipt.xsd',
      schemadoc       => extension_1_1,
      local           => TRUE,
      gentypes        => FALSE,
      gentables       => FALSE,
      enablehierarchy => DBMS_XMLSCHEMA.enable_hierarchy_none);
END;
/

TIMING STOP;
 
SELECT * FROM user_xml_schemas;

CREATE TABLE sales_receipt_xml OF XMLTYPE
XMLSCHEMA "sales_receipt.xsd"
ELEMENT "sales_receipt";

INSERT INTO sales_receipt_xml VALUES(xmltype.createxml('<?xml version="1.0" encoding="utf-16"?>
  <sales_receipt xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"> 
    <transaction_datetime>2019.04.01 12:04:43</transaction_datetime>
    <in_store>0</in_store>
    <order>1</order>
    <line_item_id>1</line_item_id>
    <quantity>1</quantity>
    <line_item_amount>2.5</line_item_amount>
    <unit_price>2.5</unit_price>
    <promo>0</promo>
    <sales_outlet_id>1661</sales_outlet_id>
    <staff_id>4621</staff_id>
    <customer_id>1159</customer_id>
    <product_id>3945</product_id>
  </sales_receipt>'));

BEGIN
	DBMS_XMLSCHEMA.deleteSchema('sales_receipt.xsd');
END;
/

DROP TABLE sales_receipt_xml;

EXIT;
/
