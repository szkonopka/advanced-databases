using System.Collections.Generic;
using CsvHelper.Configuration.Attributes;

namespace Parser
{
    public class SalesOutlet
    {
        [Index(0)]
        public int Id { get; set; }
        [Index(1)]
        public int SquareFeet { get; set; }
        [Index(2)]
        public string Address { get; set; }
        [Index(3)]
        public string City { get; set; }
        [Index(4)]
        public string Province { get; set; }
        [Index(5)]
        public string Telephone { get; set; }
        [Index(6)]
        public string PostalCode { get; set; }
        [Index(7)]
        public decimal Longitude { get; set; }
        [Index(8)]
        public decimal Latitude { get; set; }
        [Index(9)]
        public int SalesOutletTypeId { get; set; }
        [Index(10)]
        public int ManagerStaffId { get; set; }
        [Ignore]
        public List<SalesTarget> SalesTargets { get; set; } = new List<SalesTarget>();
    }
}