#!/bin/bash

execute_sql() {
    if [ $# == 1 ]
        then sqlplus.exe -S coffeeshop/pass@localhost @$1
    fi

    if [ $# == 2 ]
        then sqlplus.exe -S coffeeshop/pass@localhost @$1 > $2
    fi
}

echo "1.1 - performing tests"
execute_sql 1_1/create_sr_load_sample.sql ./results/1.1_create_sr_load_sample.log
execute_sql 1_1/create_sr_xml_table.sql ./results/1.1_create_sr_xml.log
echo "1.1 - finished"

echo "1.2 - performing tests"
execute_sql 1_2/so_load_sample.sql ./results/1.2_insert_so_load_sample.log
execute_sql 1_2/create_so_xml_table.sql 
execute_sql 1_2/inserts.sql ./results/1.2_insert_so_xml.log
execute_sql 1_2/delete_so_xml_table.sql
echo "1.2 - finished"

echo "1.3 - performing tests"
execute_sql 1_3/customer_load_sample.sql ./results/1.3_insert_customer_load_sample.log
execute_sql 1_3/create_c_xml_table.sql 
execute_sql 1_3/inserts.sql ./results/1.3_insert_customer_xml.log
execute_sql 1_3/delete_c_xml_table.sql
echo "1.3 - finished"

echo "2.1, 2.2, 2.3 - prepare table and data"
execute_sql 1_1/create_sr_xml_table.sql
execute_sql 1_1/inserts.sql

echo "2.1 - performing tests"
execute_sql 2_1/no_xml.sql > ./results/2.1_no_xml.log
execute_sql 2_1/xml.sql > ./results/2.1_xml.log
echo "2.1 - finished"

echo "2.2 - performing tests"
execute_sql 2_2/no_xml.sql > ./results/2.2_no_xml.log
execute_sql 2_2/xml.sql > ./results/2.2_xml.log
echo "2.2 - finished"

echo "2.3 - performing tests"
execute_sql 2_3/no_xml.sql > ./results/2.3_no_xml.log
execute_sql 2_3/xml.sql > ./results/2.3_xml.log
echo "2.3 - finished"

echo "2.1, 2.2, 2.3 - delete table and data"
execute_sql 1_1/delete_sr_xml_table.sql

echo "2.4 - performing tests"
execute_sql 2_4/no_xml.sql > ./results/2.4_no_xml.log
execute_sql 1_2/create_so_xml_table.sql 
execute_sql 2_4/xml.sql > ./results/2.4_xml.log
execute_sql 1_2/delete_so_xml_table.sql
echo "2.4 - finished"

echo "2.5 - performing tests"
execute_sql 2_5/no_xml.sql > ./results/2.5_no_xml.log
execute_sql 1_2/create_so_xml_table.sql 
execute_sql 2_5/xml.sql > ./results/2.5_xml.log
execute_sql 1_2/delete_so_xml_table.sql
echo "2.5 - finished"

echo "2.6 - performing tests"
execute_sql 1_3/create_c_xml_table.sql 
execute_sql 1_3/inserts.sql
execute_sql 2_6/no_xml.sql > ./results/2.6_no_xml.log
execute_sql 2_6/xml.sql > ./results/2.6_xml.log
execute_sql 1_3/delete_c_xml_table.sql
echo "2.6 - finished"

echo "2.7 - performing tests"
execute_sql 1_3/create_c_xml_table.sql 
execute_sql 1_3/inserts.sql
execute_sql 2_7/no_xml.sql > ./results/2.7_no_xml.log
execute_sql 2_7/xml.sql > ./results/2.7_xml.log
execute_sql 1_3/delete_c_xml_table.sql
echo "2.7 - finished"