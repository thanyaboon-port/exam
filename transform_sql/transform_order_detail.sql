select * ,coalesce(discount, 0) as discount_no_null 
from order_detail