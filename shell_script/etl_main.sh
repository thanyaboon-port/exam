#!/bin/sh

hdfs dfs -test -d ~/data/source
if [ $? == 0 ]; then
    echo "path on hdfs has already created"
else
    echo "path on hdfs isn't created. Start create hdfs path"
    sh /exam/code/shell_script/shell_setup_hdfs.sh
fi

echo 'ingest data from table order_detail postgres to hdfs'
sqoop import --connect 'jdbc:postgresql://172.17.0.3:5432/linemanwongnai' --username 'postgres' -password 'password' --table 'order_detail' -target-dir '/code/sources/order_detail' -m 1
echo 'ingest data from table restaurant_detail postgres to hdfs'
sqoop import --connect 'jdbc:postgresql://172.17.0.3:5432/linemanwongnai' --username 'postgres' -password 'password' --table 'restaurant_detail' -target-dir '/code/sources/restaurant_detail' -m 1

echo 'start run etl from hdfs to table datalake.order_detail'
spark-submit order_detail /code/config config.ini
echo 'start run etl from hdfs to table datalake.restaurant_detail'
spark-submit restaurant_detail /code/config config.ini

