alter system flush buffer_cache;
alter system flush shared_pool;

create table experiment_2 (
	id number(10) generated as identity,
	xml_data xmltype
);

BEGIN
   DBMS_XMLSCHEMA.registerSchema(schemaurl       => 'experiment_2.xsd', 
                                 schemadoc       => '<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">
  <xs:element name="experiment_2">
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
</xs:schema>',
                                 local           => FALSE,
                                 gentypes        => FALSE,
                                 gentables       => FALSE,
                                 enablehierarchy => DBMS_XMLSCHEMA.enable_hierarchy_none); 
END;
/

timing start experiment_2_1

insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));


timing stop

drop table experiment_2;

create table experiment_2 (
	id number(10) generated as identity,
	xml_data xmltype
)
XMLTYPE COLUMN xml_data
XMLSCHEMA "experiment_2.xsd" ELEMENT "experiment_2";

timing start experiment_2_2

insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));
insert into experiment_2 (xml_data) values (xmltype('<?xml version="1.0" encoding="UTF-8"?><sales_receipt id="1"><transaction_datetime>01-APR-19 11.28.50</transaction_datetime><in_store>1</in_store><order>1</order><line_item_id>1</line_item_id><quantity>2</quantity><line_item_amount>2.5</line_item_amount><unit_price>2.55</unit_price><promo>1</promo><sales_outlet_id>1</sales_outlet_id><staff_id>1</staff_id><customer_id>1</customer_id><product_id>1</product_id></sales_receipt>'));


timing stop

drop table experiment_2;

begin
DBMS_XMLSCHEMA.deleteSchema('experiment_2.xsd', DBMS_XMLSCHEMA.DELETE_CASCADE_FORCE);
end;
/

exit;