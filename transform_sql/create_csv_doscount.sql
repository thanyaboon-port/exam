select rd.category , avg(discount)
from order_detail od left join restaurant_detail rd on od.restaurant_id = rd.id 
group by 1