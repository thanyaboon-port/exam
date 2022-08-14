select rd.cooking_bin, count(1)
from __restaurant_detail_new__ rd 
group by 1