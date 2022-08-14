#!/bin/sh

set -e  # stop immediately on any error
path='/exam/postgres_create_table'

psql -c 'create database linemanwongnai;'

for script in create_table_order_detail.sql create_table_restaurant_detail.sql
do
  echo "processing $script"
  select=`cat $path/$script`
  psql -d linemanwongnai -U postgres <<EOF
$select
EOF
done

echo "start ingest data to order_detail"
THE_USER=postgres
THE_DB=linemanwongnai
THE_TABLE=order_detail
THE_DIR=/exam/data
THE_FILE=order_detail.csv

psql -c "\copy ${THE_TABLE} FROM '${THE_DIR}/${THE_FILE}' delimiter ',' csv"

echo "start ingest data to restaurant_detail"
THE_USER=postgres
THE_DB=linemanwongnai
THE_TABLE=restaurant_detail
THE_DIR=/exam/data
THE_FILE=restaurant_detail.csv

psql -c "\copy ${THE_TABLE} FROM '${THE_DIR}/${THE_FILE}' delimiter ',' csv"


