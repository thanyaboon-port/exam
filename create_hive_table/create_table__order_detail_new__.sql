CREATE EXTERNAL TABLE __order_detail_new__
(
    order_created_timestamp     timestamp
    status                      string,
    price                       integer,
    discount                    float,
    id                          string,
    driver_id                   string,
    user_id                     string,
    restaurant_id               string,
    discount_no_null            string
)
PARTITIONED BY (dt string)
STORED AS parquet
LOCATION /data/datawarehouse/order_detail;