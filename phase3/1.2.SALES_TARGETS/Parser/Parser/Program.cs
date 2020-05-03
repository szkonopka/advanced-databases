using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Serialization;
using CsvHelper;

namespace Parser
{
    class Program
    {
        static void Main(string[] args)
        {
            var dataBasePath = @"c:\Users\kubas\sources\uczelnia\advanced-databases\data\new_dataset\";
            var statementsFilePath = @"c:\Users\kubas\sources\uczelnia\advanced-databases\phase3\1.2.SALES_TARGETS\inserts.sql";

            var salesTargetCsvPath = dataBasePath + "sales_outlet_target.csv";
            var salesTargets = GetSalesTargets(salesTargetCsvPath);

            var salesOutletCsvPath = dataBasePath + "sales_outlet.csv";
            var salesOutlets = GetSalesOutlets(salesOutletCsvPath);

            var joined = JoinTargets(salesOutlets, salesTargets);

            var insertStatements = joined.Select(ToInsertString).ToList();
            SaveStatementsToFile(statementsFilePath, insertStatements);
        }

        private static List<SalesTarget> GetSalesTargets(string path)
        {
            using var reader = new StreamReader(path);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            csv.Configuration.HasHeaderRecord = false;
            csv.Configuration.Delimiter = ";";

            var records = csv.GetRecords<SalesTarget>();
            return records.ToList();
        }

        private static List<SalesOutlet> GetSalesOutlets(string path)
        {
            using var reader = new StreamReader(path);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            csv.Configuration.HasHeaderRecord = false;
            csv.Configuration.Delimiter = ";";

            var records = csv.GetRecords<SalesOutlet>();
            return records.ToList();
        }

        private static List<SalesOutlet> JoinTargets(List<SalesOutlet> outlets, List<SalesTarget> targets)
        {
            foreach (var salesOutlet in outlets)
            {
                var resultTargets = targets.Where(target => target.SalesOutletId == salesOutlet.Id);
                salesOutlet.SalesTargets.AddRange(resultTargets);
            }

            return outlets;
        }

        private static string ToInsertString(SalesOutlet outlet)
        {
            return $@"INSERT INTO SALES_OUTLET_XML (ID, SQUARE_FEET, ADDRESS, CITY, PROVINCE, TELEPHONE, POSTAL_CODE, LONGITUDE, LATITUDE, SALES_OUTLET_TYPE_ID, MANAGER_STAFF_ID, SALES_TARGETS) 
VALUES (
{outlet.Id},
{outlet.SquareFeet},
'{outlet.Address}',
'{outlet.City}',
'{outlet.Province}',
'{outlet.Telephone}',
{outlet.PostalCode},
{outlet.Longitude},
{outlet.Latitude},
{outlet.SalesOutletTypeId},
{outlet.ManagerStaffId},
'{SerializeSalesTargets(outlet.SalesTargets)}');";
        }

        private static string SerializeSalesTargets(List<SalesTarget> targets)
        {
            var salesTargets = new SalesTargetsXml
            {
                SalesTargets = targets
            };

            var serializer = new XmlSerializer(salesTargets.GetType());

            using var sww = new StringWriter();
            using var writer = XmlWriter.Create(sww);
            serializer.Serialize(writer, salesTargets);
            return sww.ToString();
        }

        private static void SaveStatementsToFile(string path, List<string> statements)
        {
            using var sw = new StreamWriter(path);

            foreach (var statement in statements)
            {
                sw.WriteLine(statement);
                sw.WriteLine();
            }
        }
    }
}
