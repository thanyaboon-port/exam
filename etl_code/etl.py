import configparser
import sys 
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

def write_dataframe_to_hdfs(df_final, write_mode, partition_column, target_path, target_file_format):
    if partition_column == 'no':
        if target_file_format == 'parquet':
            df_final.write.mode("{}".format(write_mode)).parquet("{}".format(target_path))
        elif target_file_format == 'csv':
            df_final.write.mode("{}".format(write_mode)).csv("{}".format(target_path))
        else:
            print("Target file format isn't CSV or Parquet")
            exit(1)
    else:
        if target_file_format == 'parquet':
            df_final.write.partitionBy('{}'.format(partition_column)).mode("{}".format(write_mode)).parquet("{}".format(target_path))
        elif target_file_format == 'csv':
             df_final.write.partitionBy('{}'.format(partition_column)).mode("{}".format(write_mode)).csv("{}".format(target_path))
        else:
            print("Target file format isn't CSV or Parquet")
            exit(1)    
    print("Write data success.")
    
if len(sys.argv) != 4:
    print("Parameter isn't complete")
    exit(1)
else:
    table = sys.argv[1]
    config_file_path = sys.argv[2]
    config_file_name = sys.argv[3]

config = configparser.ConfigParser()
try:
    config.read('{}/{}'.format(config_file_path, config_file_name))

    try:
        source_table_name = config[table]['source_table_name'].lower()
        source_data_file_format = config[table]['source_table_name'].lower()
        source_data_path = config[table]['source_data_path'].lower()
        transform_file_path = config[table]['transform_file_path'].lower()
        transform_file_name = config[table]['transform_file_name'].lower()
        target_file_format = config[table]['target_file_format'].lower()
        target_path = config[table]['target_path'].lower()
        partition_column = config[table]['partition_column'].lower()
        write_mode = config[table]['write_mode'].lower()
    except Exception as e:
        print(e)
        print("Value of {} in {}/{} is mistaked.".format(table, config_file_path, config_file_name))
        exit(1)

    try:
        spark  = SparkSession.builder.appName("{}_job".format(source_table_name)).enableHiveSupport().getOrCreate()
    except Exception as e:
        print(e)
        print("Start spark error")
        exit(1)
    
    if source_data_file_format == 'parquet':
        df_source = spark.read.parquet("{}/*".format(source_data_path))
    elif source_data_file_format == 'csv':
        df_source = spark.read.option("header",True).csv("{}/*".format(source_data_path))
    else:
        print("Source file format of data is't CSV or Parquet")
        exit(1)
    df_source.createOrReplaceTempView("{}".format(source_table_name))
    
    try:
        transform_file = open('{}/{}'.format(transform_file_path, transform_file_name), "r")
        transform_query = transform_file.read()
    except Exception as e:
        print(e)
        print("Read transform_file name {} error.".format(transform_file_path, transform_file_name))
        exit(1)

    try:
        df_final = spark.sql(transform_query)
        write_dataframe_to_hdfs(df_final, write_mode, partition_column, target_path, target_file_format)
    except Exception as e:
        print(e)
        print("Transform or write error")
        exit(1)

    print("ETL success")


except Exception as e:
    print("Cann't read file config or file config doesn't exists")
    exit(1)

spark.stop()
