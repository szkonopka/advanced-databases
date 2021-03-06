﻿using System;
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
            var dataBasePath = @"../../../data/new_dataset/";
            var statementsFilePath = @"../../1_2/inserts.sql";

            var salesTargetCsvPath = dataBasePath + "sales_outlet_target.csv";
            var salesTargets = GetSalesTargets(salesTargetCsvPath);

            var salesOutletCsvPath = dataBasePath + "sales_outlet.csv";
            var salesOutlets = GetSalesOutlets(salesOutletCsvPath);

            var joined = JoinTargets(salesOutlets, salesTargets);

            var insertStatements = joined.Select(ToInsertString).ToList();
            SaveStatementsToFile(statementsFilePath, insertStatements);

            var customerStatementsFilePath = @"../../1_3/inserts.sql";

            var customerCsvPath = dataBasePath + "customer.csv";
            var customers = GetCustomers(customerCsvPath);

            var generationCsvPath = dataBasePath + "generation.csv";
            var generations = GetGenerations(generationCsvPath);

            var customerJoined = JoinTargets(customers, generations);

            var customerInsertStatements = customerJoined.Select(ToInsertString).ToList();
            SaveStatementsToFile(customerStatementsFilePath, customerInsertStatements);

            var salesReceiptStatementsFilePath = @"../../1_1/inserts.sql";

            var salesReceiptCsvPath = dataBasePath + "sales_receipt.csv";
            var salesReceipts = GetSalesReceipts(salesReceiptCsvPath);

            var salesReceiptInsertStatements = salesReceipts.Select(ToInsertString).ToList();

            SaveStatementsToFile(salesReceiptStatementsFilePath, salesReceiptInsertStatements, false);
        }

        private static List<SalesReceipt> GetSalesReceipts(string path)
        {
            using var reader = new StreamReader(path);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            csv.Configuration.HasHeaderRecord = false;
            csv.Configuration.Delimiter = ";";

            var records = csv.GetRecords<SalesReceipt>();
            return records.ToList();
        }   

        private static List<Generation> GetGenerations(string path)
        {
            using var reader = new StreamReader(path);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            csv.Configuration.HasHeaderRecord = false;
            csv.Configuration.Delimiter = ";";

            var records = csv.GetRecords<Generation>();
            return records.ToList();
        }

        private static List<Customer> GetCustomers(string path)
        {
            using var reader = new StreamReader(path);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            csv.Configuration.HasHeaderRecord = false;
            csv.Configuration.Delimiter = ";";

            var records = csv.GetRecords<Customer>();
            return records.ToList();
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

        private static List<Customer> JoinTargets(List<Customer> customers, List<Generation> generations)
        {
            foreach (var customer in customers)
            {
                var resultGenerations = generations.Where(generation => generation.Id == customer.GenerationId);

                foreach (var resultGeneration in resultGenerations)
                {
                    AgeDetails ad = new AgeDetails();
                    ad.BirthDate = customer.BirthDate;
                    ad.Generation = resultGeneration.Name;

                    customer.AgeDetails.Add(ad);
                }
            }

            return customers;
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

        private static string ToInsertString(SalesReceipt salesReceipt)
        {
            return $@"INSERT INTO sales_receipt_xml VALUES(xmltype.createxml('<?xml version=""1.0"" encoding=""utf-16""?>
                <sales_receipt xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema""> 
                    <transaction_datetime>{salesReceipt.TransactionDateTime}</transaction_datetime>
                    <in_store>{salesReceipt.InStore}</in_store>
                    <order>{salesReceipt.Order}</order>
                    <line_item_id>{salesReceipt.LineItemId}</line_item_id>
                    <quantity>{salesReceipt.Quantity}</quantity>
                    <line_item_amount>{salesReceipt.LineItemAmount}</line_item_amount>
                    <unit_price>{salesReceipt.UnitPrice}</unit_price>
                    <promo>{salesReceipt.Promo}</promo>
                    <sales_outlet_id>{salesReceipt.SalesOutletId}</sales_outlet_id>
                    <staff_id>{salesReceipt.StaffId}</staff_id>
                    <customer_id>{salesReceipt.CustomerId}</customer_id>
                    <product_id>{salesReceipt.ProductId}</product_id>
                </sales_receipt>'));";
        }

        private static string ToInsertString(Customer customer)
        {

            return $@"INSERT INTO CUSTOMER_XML (ID, FULL_NAME, EMAIL, SINCE, LOYALTY_CARD_NUMBER, BIRTH_DATE, GENDER, HOME_SALES_OUTLET_ID, GENERATION_ID, AGE_DETAILS)
            VALUES (
                {customer.Id},
                '{customer.FullName}',
                '{customer.Email}',
                TO_DATE('{customer.Since}', 'DD.MM.YYYY'),
                '{customer.LoyaltyCardNumber}',
                TO_DATE('{customer.BirthDate}', 'DD.MM.YYYY'),
                '{customer.Gender}',
                {customer.HomeSalesOutletId},
                {customer.GenerationId},
                '{SerializeAgeDetails(customer.AgeDetails)}');";
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

        private static string SerializeAgeDetails(List<AgeDetails> ageDetails)
        {
            var ageDetailsXml = new AgeDetailsXml
            {
                AgeDetails = ageDetails
            };

            var serializer = new XmlSerializer(ageDetailsXml.GetType());

            using var sww = new StringWriter();
            using var writer = XmlWriter.Create(sww);
            serializer.Serialize(writer, ageDetailsXml);
            return sww.ToString();
        }

        private static void SaveStatementsToFile(string path, List<string> statements, bool rollback = true)
        {
            using var sw = new StreamWriter(path);

            sw.WriteLine("TIMING START insert_timing;");
            sw.WriteLine();

            foreach (var statement in statements)
            {
                sw.WriteLine(statement);
                sw.WriteLine();
            }

            sw.WriteLine();
            sw.WriteLine("TIMING STOP;");

            if (rollback)
                sw.WriteLine("EXIT ROLLBACK;");
            else
                sw.WriteLine("EXIT;");
        }
    }
}
