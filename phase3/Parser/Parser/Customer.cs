using System.Collections.Generic;
using CsvHelper.Configuration.Attributes;

namespace Parser 
{
    public class Customer 
    {
        [Index(0)]
        public int Id { get; set; }
        [Index(1)]
        public string FullName { get; set; }
        [Index(2)]
        public string Email { get; set; }
        [Index(3)]
        public string Since { get; set; }
        [Index(4)]
        public string LoyaltyCardNumber { get; set; }
        [Index(5)]
        public string BirthDate { get; set; }
        [Index(6)]
        public string Gender { get; set; }
        [Index(7)]
        public int HomeSalesOutletId { get; set; }
        [Index(8)]
        public int GenerationId { get; set; }
        [Ignore]
        public List<AgeDetails> AgeDetails { get; set; } = new List<AgeDetails>();
    }
}