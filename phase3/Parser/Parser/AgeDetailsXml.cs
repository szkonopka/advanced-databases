using System.Collections.Generic;
using System.Xml.Serialization;

namespace Parser
{
    [XmlRoot(ElementName = "age_details")]
    public class AgeDetailsXml
    {
        [XmlElement(ElementName = "age_details")]
        public List<AgeDetails> AgeDetails { get; set; }
    }
}