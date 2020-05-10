using System;
using System.Xml.Serialization;
using CsvHelper.Configuration.Attributes;

namespace Parser
{
    [XmlRoot(ElementName = "sales_target")]
    public class SalesReceipt
    {
        [Index(0)]
        [XmlAttribute(AttributeName = "id")]
        public int Id { get; set; }
        [Index(1)]
        [XmlElement(ElementName = "transaction_datetime")]
        public string TransactionDateTime { get; set; }
        [Index(2)]
        [XmlElement(ElementName = "in_store")]
        public bool InStore { get; set; }
        [Index(3)]
        [XmlElement(ElementName = "order")]
        public int Order { get; set; }
        [Index(4)]
        [XmlElement(ElementName = "line_item_id")]
        public int LineItemId { get; set; }
        [Index(5)]
        [XmlElement(ElementName = "quantity")]
        public float Quantity { get; set; }
        [Index(6)]
        [XmlElement(ElementName = "line_item_amount")]
        public float LineItemAmount { get; set; }
        [Index(7)]
        [XmlElement(ElementName = "unit_price")]
        public float UnitPrice { get; set; }
        [Index(8)]
        [XmlElement(ElementName = "promo")]
        public bool Promo { get; set; }
        [Index(9)]
        [XmlElement(ElementName = "sales_outlet_id")]
        public int SalesOutletId { get; set; }
        [Index(10)]
        [XmlElement(ElementName = "staff_id")]
        public int StaffId { get; set; }
        [Index(11)]
        [XmlElement(ElementName = "customer_id")]
        public int CustomerId { get; set; }
        [Index(12)]
        [XmlElement(ElementName = "product_id")]
        public int ProductId { get; set; }
    }
}