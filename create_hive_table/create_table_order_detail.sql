CREATE EXTERNAL TABLE order_detail
(
    order_created_timestamp     timestamp
    status                      string,
    price                       integer,
    discount                    float,
    id                          string,
    driver_id                   string,
    user_id                     string,
    restaurant_id               string
)
PARTITIONED BY (dt string)
STORED AS parquet
LOCATION /data/datalake/order_detail;;
