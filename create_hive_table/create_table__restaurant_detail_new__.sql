CREATE EXTERNAL TABLE __restaurant_detail_new__
(
    id                      string,
    restaurant_name         string,
    category                string,
    esimated_cooking_time   float,
    latitude                float,
    longitude               float,
    cooking_bin             int
)
PARTITIONED BY (dt string)
STORED AS parquet
LOCATION /data/datawarehouse/restaurant_detail;