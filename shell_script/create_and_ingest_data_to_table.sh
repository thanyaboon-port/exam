#!/bin/sh

set -e  # stop immediately on any error
for script in create_table_order_detail.sql create_table_restaurant_detail.sql
do
  echo "processing $script"
  select=`cat $script`
  psql -d linemanwongnai -U postgres <<EOF
DROP TABLE IF EXISTS "$script";
$select
EOF
done

echo "start ingest data to order_detail"
THE_USER=postgres
THE_DB=linemanwongnai
THE_TABLE=order_detail
THE_DIR=/var/lib/postgresql/data
THE_FILE=order_detail.csv

psql -c "\copy ${THE_TABLE} FROM '${THE_DIR}/${THE_FILE}' delimiter ',' csv"

echo "start ingest data to restaurant_detail"
THE_USER=postgres
THE_DB=linemanwongnai
THE_TABLE=restaurant_detail
THE_DIR=/var/lib/postgresql/data
THE_FILE=restaurant_detail.csv

psql -c "\copy ${THE_TABLE} FROM '${THE_DIR}/${THE_FILE}' delimiter ',' csv"



