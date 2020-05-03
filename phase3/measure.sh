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
execute_sql 1_1/create_sr_load_sample.sql > 1.1_create_sr_load_sample.log
execute_sql 1_1/create_sr_xml_table.sql > 1.1_create_sr_xml.log
echo "1.1 - finished"

echo "1.2 - performing tests"
execute_sql 1_2/sr_load_sample.sql ./results/1.2_insert_sr_load_sample.log
execute_sql 1_2/create_sr_xml_table.sql 
execute_sql 1_2/inserts.sql ./results/1.2_insert_sr_xml.log
execute_sql 1_2/delete_sr_xml_table.sql
echo "1.2 - finished"

echo "1.3 - performing tests"
execute_sql 1_3/customer_load_sample.sql ./results/1.3_insert_customer_load_sample.log
execute_sql 1_3/create_c_xml_table.sql 
execute_sql 1_3/inserts.sql ./results/1.3_insert_customer_xml.log
execute_sql 1_3/delete_c_xml_table.sql
echo "1.3 - finished"