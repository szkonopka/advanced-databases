BEGIN
	DBMS_XMLSCHEMA.deleteSchema('sales_receipt.xsd');
END;
/

DROP TABLE sales_receipt_xml;

EXIT;