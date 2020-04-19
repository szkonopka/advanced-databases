#!/bin/bash

rm -rf ../data/new_dataset/SYS_TEMP_*
rm -rf ./results/*

chmod u+x ../clear-all-tables.sql
chmod u+x ../reload-csv-data.sql
chmod 777 ./triggers/*

sqlplus.exe -S coffeeshop/pass@localhost @../delete-tables.sql
sqlplus.exe -S coffeeshop/pass@localhost @../erd-ddl-create-tables.sql
sqlplus.exe -S coffeeshop/pass@localhost @../reload-csv-data.sql

exec_trigger_ut() {
    sqlplus.exe -S coffeeshop/pass@localhost @ut/trigger_$1_ut.sql > ./results/trigger_$1_ut_results.log    
    echo "Trigger $1. UTs executed..."
    sqlplus.exe -S coffeeshop/pass@localhost @drop_rules.sql
}

exec_experiment_trigger_ut() {
    sqlplus.exe -S coffeeshop/pass@localhost @ut/experiment_trigger_$1_ut.sql > ./results/experiment_trigger_$1_ut_results.log    
    echo "Experiment Trigger $1. UTs executed..."
}

for i in $(seq 1 8);
do
    exec_trigger_ut $i
done

for i in $(seq 1 2);
do
    exec_experiment_trigger_ut $i
done