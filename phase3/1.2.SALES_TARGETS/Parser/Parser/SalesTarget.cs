using System;
using System.Xml.Serialization;
using CsvHelper.Configuration.Attributes;

namespace Parser
{
    [XmlRoot(ElementName = "sales_target")]
    public class SalesTarget
    {
        [Index(0)]
        [XmlAttribute(AttributeName = "id")]
        public int Id { get; set; }
        [Index(1)]
        [XmlElement(ElementName = "target_date")]
        public string TargetDate { get; set; }
        [Index(2)]
        [XmlElement(ElementName = "product_id")]
        public int ProductId { get; set; }
        [Index(3)]
        [XmlElement(ElementName = "total_id")]
        public int TotalGoal { get; set; }
        [Index(4)]
        [XmlIgnore]
        public int SalesOutletId { get; set; }
    }
}