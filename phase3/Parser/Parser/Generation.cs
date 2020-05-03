using System.Collections.Generic;
using CsvHelper.Configuration.Attributes;

namespace Parser 
{
    public class Generation 
    {
        [Index(0)]
        public int Id { get; set; }
        [Index(1)]
        public string Name { get; set; }
    }
}