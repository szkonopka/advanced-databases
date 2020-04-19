#!/bin/bash

rm -rf ../data/new_dataset/SYS_TEMP_*
chmod u+x ../clear-all-tables.sql
chmod u+x ../reload-csv-data.sql

sqlplus.exe -S coffeeshop/pass@localhost @../delete-tables.sql
sqlplus.exe -S coffeeshop/pass@localhost @../erd-ddl-create-tables.sql
sqlplus.exe -S coffeeshop/pass@localhost @../reload-csv-data.sql

exec_transaction_set() {
    sqlplus.exe -S coffeeshop/pass@localhost @set_$1.sql > ./results/set_$1_results.log    
    echo "Set $1 has been executed - results saved in ./results/set_$1_results.log"
}

exec_transaction_set A
exec_transaction_set B
exec_transaction_set C
