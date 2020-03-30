#!/bin/bash

chmod u+x ./clear-all-tables.sql
chmod u+x ./reload-csv-data.sql

sqlplus.exe -S coffeeshop/pass@localhost @clear-all-tables.sql
sqlplus.exe -S coffeeshop/pass@localhost @reload-csv-data.sql
sqlplus.exe -S coffeeshop/pass@localhost @set_A.sql > ./results/set_A_results.log

