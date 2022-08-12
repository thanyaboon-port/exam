#!/bin/sh

set -e  # stop immediately on any error


for dir in source datalake datawarehouse
do
    hadoop fs mkdir /user/hdfs/$dir
done

for dir in order_detail restaurant_detail
do
    hadoop fs mkdir /user/hdfs/$dir
done

