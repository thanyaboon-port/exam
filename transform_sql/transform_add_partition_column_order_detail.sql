select * ,date_Format(order_created_timestamp, 'yyyyMMdd') as dt
from order_detail