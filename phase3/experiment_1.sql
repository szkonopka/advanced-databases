alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

BEGIN
   DBMS_XMLSCHEMA.registerSchema(schemaurl       => 'experiment_1.xsd', 
                                 schemadoc       => '<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified" xmlns:xdb="http://xmlns.oracle.com/xdb">
  <xs:element name="experiment_1" xdb:defaultTable="">
    <xs:complexType xdb:SQLType="experiment_1_t">
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
  <xs:element name="transaction_datetime" type="xs:string" xdb:defaultTable=""/>
  <xs:element name="in_store" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="order" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="line_item_id" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="quantity" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="line_item_amount" type="xs:decimal" xdb:defaultTable=""/>
  <xs:element name="unit_price" type="xs:decimal" xdb:defaultTable=""/>
  <xs:element name="promo" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="sales_outlet_id" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="staff_id" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="customer_id" type="xs:integer" xdb:defaultTable=""/>
  <xs:element name="product_id" type="xs:integer" xdb:defaultTable=""/>
</xs:schema>',
                                 local           => FALSE,
                                 gentypes        => true,
                                 gentables       => true,
                                 enablehierarchy => DBMS_XMLSCHEMA.enable_hierarchy_none); 
END;
/

CREATE TABLE experiment_1 OF XMLType 
XMLType STORE AS object relational
XMLSCHEMA "experiment_1.xsd" ELEMENT "experiment_1";

timing start experiment_1_1_insert
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
timing stop

timing start experiment_1_1_select
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
timing stop

DROP TABLE experiment_1;

CREATE TABLE experiment_1 OF XMLType 
XMLType STORE AS OBJECT RELATIONAL 
XMLSCHEMA "experiment_1.xsd" ELEMENT "experiment_1";

timing start experiment_1_2_insert
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
insert into experiment_1 values (xmltype('<?xml version="1.0" encoding="UTF-8"?><experiment_1 id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></experiment_1>'));
timing stop

timing start experiment_1_2_select
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
select extract(e.OBJECT_VALUE, '/experiment_1/transaction_datetime').getStringVal() from experiment_1 e;
timing stop

DROP TABLE experiment_1;

begin
DBMS_XMLSCHEMA.deleteSchema('experiment_1.xsd', DBMS_XMLSCHEMA.DELETE_CASCADE_FORCE);
end;
/

exit;