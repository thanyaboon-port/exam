#!/bin/sh

set -e  # stop immediately on any error

hdfs dfs -mkdir /data
for dir in source datalake datawarehouse
do
    echo "create path /data/$dir"
    hdfs dfs -mkdir /data/$dir
    if [ $result -ne 0 ]; then
        echo "create path /data/$dir error"
        exit 1
    else
        echo "create path /data/$dir success"
    fi
done

for dir in order_detail restaurant_detail
do
    echo "create path /data/source/$dir"
    hdfs dfs -mkdir /data/source/$dir
    if [ $result -ne 0 ]; then
        echo "create path /data/source/$dir error"
        exit 1
    else
        echo "create path /data/source/$dir success"
    fi

    echo "create path /data/datalake/$dir"
    hdfs dfs -mkdir /data/datalake/$dir
    if [ $result -ne 0 ]; then
        echo "create path /data/datalake/$dir error"
        exit 1
    else
        echo "create path /data/datelake/$dir success"
    fi

    echo "create path /data/datawarehouse/$dir"
    hdfs dfs -mkdir /data/datawarehouse/$dir
    if [ $result -ne 0 ]; then
        echo "create path /data/datawarehouse/$dir error"
        exit 1
    else
        echo "create path /data/datawarehouse/$dir success"
    fi
done

for file_name in create_table__order_detail_new__.sql create_table__restaurant_detail_new__.sql create_order_detail.sql create_restaurant_detail.sql
do
    echo "run file $file_name "
    hive -f /exam/create_hive_table/$file_name
    if [ $result -ne 0 ]; then
        echo "run file $file_nmae error"
        exit 1
    else
        echo "run file $file_nmae success"
    fi
done