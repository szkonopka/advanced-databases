#!/bin/bash

execute_sql() {
    if [ $# == 1 ]
        then sqlplus.exe -S coffeeshop/pass@localhost @$1
    fi

    if [ $# == 2 ]
        then sqlplus.exe -S coffeeshop/pass@localhost @$1 > $2
    fi
}

echo "Creating SPATIAL objects - 1.1, 1.2, 1.3"
execute_sql ./1.3/1.3.sql
execute_sql ./1.2/1.2.sql
execute_sql ./1.1/1.1.sql
echo "SPATIAL objects - 1.1, 1.2, 1.3 - created"


echo "2.1 - performing tests"
execute_sql ./2.1/2.1.sql > ./results/2.1.sql
echo "2.1 - finished"

echo "2.2 - performing tests"
execute_sql ./2.2/2.2.sql > ./results/2.2.sql
echo "2.2 - finished"

echo "2.3 - performing tests"
execute_sql ./2.3/2.3.sql > ./results/2.3.sql
echo "2.3 - finished"

echo "2.4 - performing tests"
execute_sql ./2.4/2.4.sql > ./results/2.4.sql
echo "2.4 - finished"

echo "2.5 - performing tests"
execute_sql ./2.5/2.5.sql > ./results/2.5.sql
echo "2.5 - finished"

echo "2.6 - performing tests"
execute_sql ./2.6/2.6.sql > ./results/2.6.sql
echo "2.6 - finished"

echo "2.7 - performing tests"
execute_sql ./2.7/2.7.sql > ./results/2.7.sql
echo "2.7 - finished"

