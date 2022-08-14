create table order_detail
(
    order_created_timestamp     timestamp without time zone,
    status                      varchar(100),
    price                       integer,
    discount                    float,
    id                          varchar(100),
    driver_id                   varchar(100),
    user_id                     varchar(100),
    restaurant_id               varchar(100)
);

