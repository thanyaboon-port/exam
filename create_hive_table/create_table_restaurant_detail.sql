CREATE EXTERNAL TABLE restaurant_detail
(
    id                      string,
    restaurant_name         string,
    category                string,
    esimated_cooking_time   float,
    latitude                float,
    longitude               float
)
PARTITIONED BY (dt string)
STORED AS parquet
LOCATION /data/datalake/restaurant_detail;