#!/bin/sh

set -e  # stop immediately on any error

#hdfs dfs -mkdir /data
for dir in source datalake datawarehouse
do
    echo "create path /data/$dir"
    hdfs dfs -mkdir /data/$dir
done

for dir in order_detail restaurant_detail
do
    echo "create path /data/source/$dir"
    hdfs dfs -mkdir /data/source/$dir
    echo "create path /data/datalake/$dir"
    hdfs dfs -mkdir /data/datalake/$dir
    echo "create path /data/datawarehouse/$dir"
    hdfs dfs -mkdir /data/datawarehouse/$dir
done

