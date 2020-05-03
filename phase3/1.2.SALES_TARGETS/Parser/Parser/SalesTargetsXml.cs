using System.Collections.Generic;
using System.Xml.Serialization;

namespace Parser
{
    [XmlRoot(ElementName = "sales_targets")]
    public class SalesTargetsXml
    {
        [XmlElement(ElementName = "sales_target")]
        public List<SalesTarget> SalesTargets { get; set; }
    }
}