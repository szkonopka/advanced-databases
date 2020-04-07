chmod u+x ../clear-all-tables.sql
chmod u+x ../reload-csv-data.sql

sqlplus.exe -S coffeeshop/pass@localhost @../clear-all-tables.sql
sqlplus.exe -S coffeeshop/pass@localhost @../reload-csv-data.sql
sqlplus.exe -S coffeeshop/pass@localhost @set.sql > ./set_results.log