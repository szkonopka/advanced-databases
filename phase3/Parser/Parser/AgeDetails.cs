using System;
using System.Xml.Serialization;
using CsvHelper.Configuration.Attributes;

namespace Parser
{
    [XmlRoot(ElementName = "age_details")]
    public class AgeDetails
    {
        [Index(0)]
        [XmlAttribute(AttributeName = "id")]
        public static int Id { get; set; }
        [Index(1)]
        [XmlElement(ElementName = "birth_date")]
        public string BirthDate { get; set; }
        [Index(2)]
        [XmlElement(ElementName = "generation")]
        public string Generation { get; set; }
        [Index(3)]
        [XmlIgnore]
        public int CustomerId { get; set; }
    }
}