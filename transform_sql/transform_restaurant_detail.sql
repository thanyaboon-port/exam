select *, case when esimated_cooking_time between 10 and 40 then 1
               when esimated_cooking_time between 41 and 80 then 2
               when esimated_cooking_time between 81 and 120 then 3
               when esimated_cooking_time > 120 then 4
               end as cooking_bin
from restaurant_detail
