--#############################################################
--5th WEEK PROJECT Manuela Ciesielska
--SQL 

-- increase of orders by platform
--The desktop platform is the main platform chosen to make bookings. However, the growth in users choosing mobile in 2022 is significant. 
--The profit from mobile bookings is also significantly bigger in 22 than in 21.


with t21 as (
select Platform_Type_Name as platform, sum(Net_Orders) as orders, 
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1
),
t22 as (
select Platform_Type_Name as platform, sum(Net_Orders) as orders
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1
)
select 
t21.platform, t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase
from t21
join t22 on t21.platform = t22.platform



--#############################################################

-- increase of orders and value by platform
--The desktop platform is the main platform chosen to make bookings. However, the growth in users choosing mobile in 2022 is significant (percentage). 
---The growth in value brought by mobile platform is huge (percentage) 
with t21 as (
select Platform_Type_Name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1
),
t22 as (
select Platform_Type_Name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1
)
select 
t21.platform, t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase,
100*((t22.gross_value - t21.gross_value)/t21.gross_value) as value_increase
from t21
join t22 on t21.platform = t22.platform


--############
--the same as above but for mobile_indicator_name only(desktop, mobile)
 --as from the above query shows that dividing mobile platform into web and app on this step is not meaningful
with t21 as (
select mobile_indicator_name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1
),
t22 as (
select mobile_indicator_name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1
)
select 
t21.platform, t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase,
100*((t22.gross_value - t21.gross_value)/t21.gross_value) as value_increase
from t21
join t22 on t21.platform = t22.platform




--#############################################################

-- increase of orders and value by platform  and region 
-- based on this query - we will look closer at APAC as it shows that the biggest growth in value in 2022 brought customers 
---who originate from APAC region


with t21 as (
select Platform_Type_Name as platform, Super_Region as region, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1,2
),
t22 as (
select Platform_Type_Name as platform, Super_Region as region, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1,2
)
select 
t21.platform, t21.region, 
--t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase,
100*((t22.gross_value - t21.gross_value)/t21.gross_value) as value_increase
from t21
join t22 on t21.platform = t22.platform and t21.region = t22.region
order by 4 desc, 1

------------------------------------------
--the same as the above but with platform (instead of platform type) 
--(based on the results of this query - to check in the future -
--what type of marketing campaings has been introduced in Asia? 
--maybe the same (or different) should be applied in other regions? 
--do we have feedback data from users in Asia?
with t21 as (
select mobile_indicator_name as platform, Super_Region as region, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1,2
),
t22 as (
select mobile_indicator_name as platform, Super_Region as region, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1,2
)
select 
t21.platform, t21.region, 
--t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase,
100*((t22.gross_value - t21.gross_value)/t21.gross_value) as value_increase
from t21
join t22 on t21.platform = t22.platform and t21.region = t22.region
order by 4 desc, 1

--#############################################################

-- increase of orders and value by platform and country in APAC region
-- based on this query we will look closer at Australia and South Korea 
--(within APAC region, the biggest increase in orders and value brought Australia and South Korea)


with t21 as (
select Platform_Type_Name as platform, Super_Region as region, Country_Name as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1,2,3
),
t22 as (
select Platform_Type_Name as platform, Super_Region as region, Country_Name as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1,2,3
)
select 
t21.platform, t21.country,
--t21.region,
--t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase,
100*((t22.gross_value - t21.gross_value)/t21.gross_value) as value_increase
from t21
join t22 on t21.platform = t22.platform and t21.region = t22.region and t21.country = t22.country
where t21.region = 'APAC'
order by 4 desc, 1

--the same for platform only (mobile, desktop)
with t21 as (
select mobile_indicator_name as platform, Super_Region as region, Country_Name as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1,2,3
),
t22 as (
select mobile_indicator_name as platform, Super_Region as region, Country_Name as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1,2,3
)
select 
t21.platform, t21.country,
--t21.region,
--t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase,
100*((t22.gross_value - t21.gross_value)/t21.gross_value) as value_increase
from t21
join t22 on t21.platform = t22.platform and t21.region = t22.region and t21.country = t22.country
where t21.region = 'APAC'
order by 4 desc, 1




--#############################################################

-- increase of orders and value by platform and country in APAC region
-- based on this query we will look closer at Australia and South Korea


with t21 as (
select Platform_Type_Name as platform, Super_Region as region, Country_Name as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1,2,3
),
t22 as (
select Platform_Type_Name as platform, Super_Region as region, Country_Name as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1,2,3
)
select 
t21.platform, t21.country,
--t21.region,
--t21.orders as orders21, t22.orders as orders22,
100*((t22.orders - t21.orders)/t21.orders) as orders_increase,
100*((t22.gross_value - t21.gross_value)/t21.gross_value) as value_increase
from t21
join t22 on t21.platform = t22.platform and t21.region = t22.region and t21.country = t22.country
where t21.region = 'APAC' and t21.country in ('Australia', 'South Korea')
order by 4 desc, 1




--#############################################################
-- check what destinations are most popular within travelers fro Australia and South Korea
-- orders and value by platform and destination 
-- for Australia and South Korea in 2022
select country_name as traveler_country, property_country as destination_country, sum(net_orders) as orders, sum(net_gross_booking_value_usd) as value
from `prism_test.epic_1`
where country_name in ('Australia', 'South Korea') and Week like ('%22%')
group by 1, 2
order by 3 desc
limit 10
--in 2021
select country_name as traveler_country, property_country as destination_country, sum(net_orders) as orders, sum(net_gross_booking_value_usd) as value
from `prism_test.epic_1`
where country_name in ('Australia', 'South Korea') and Week like ('%21%')
group by 1, 2
order by 3 desc
limit 10


--are there destinations where clients travel in 2022 but not in 2021 
--it might be reasonable to increase the offer / advertising? for these selected countries 
select distinct Property_Country from `prism_test.epic_1` where Week like ('%22%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
)

Row	
Property_Country
1	
Democratic Republic of the Congo
2	
Mali
3	
Bhutan
4	
Guinea-Bissau
5	
Eritrea
6	
Mauritania
7	
Tajikistan
8	
State of Palestine
9	
Chad


--###########################################
--did the company extend the destination offer in 2022? Did this change make an impact on the profit?
--are there destinations where clients travel in 2021 but not in 2022
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%22%')
)
	
Property_Country
1	
Burundi
2	 
Comoros
3	
Federated States of Micronesia
4	
Cocos Islands

--did we earn on cutting out some destinations and adding others in 2022? 
--is the income from the destinations added in 2022 meaningful addition to the total income?
 --old query

-- increase of orders and value by platform
with t21 as (
select Property_Country as country, Platform_Type_Name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%21%')
group by 1, 2
),
t22s as (
select Property_country as country, Platform_Type_Name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
group by 1)
group by 1, 2
),
t22 as (
select Property_country as country, Platform_Type_Name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1, 2
)
select distinct t22s.country as country, t22.platform as platform,
100 * (t22.orders / t22s.orders) as percent_of_total_orders,
100 * (t22.gross_value / t22s.gross_value) as percent_of_gross_value
from t22s
join t22 
on t22s.platform = t22.platform
group by 1, 2, 3, 4--#############################################################




--#############################################################

with
t22s as (
select Property_country as country, Platform_Type_Name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
group by 1)
group by 1, 2
),

t22 as (
select Property_country as country, Platform_Type_Name as platform, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1, 2
),
t3 as(
select distinct t22.country as country22, t22.orders as orders22, t22.platform as platform22, 
coalesce(t22s.country, t22.country) as country22s, 
coalesce(t22s.orders, 0) as orders22s, 
coalesce(t22s.platform, t22.platform) as platfrom22s
from t22
left join t22s on t22.country = t22s.country and t22.platform = t22s.platform)
select * from t3
where t3.orders22s > 0



--#############################################################
---select total orders for all countries in 2022 and total orders only for coutnries added to destinations in 2022
with
t22s as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
group by 1)
group by 1
),

t22 as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1
),
t3 as(
select distinct t22.country as country22, t22.orders as orders22,  
coalesce(t22s.country, t22.country) as country22s, 
coalesce(t22s.orders, 0) as orders22s, 
from t22
left join t22s on t22.country = t22s.country)
select * from t3




--#############################################################

---find total orders and gross_value for all countries in 2022 and total orders only for coutnries added to destinations in 2022
with
t22s as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
group by 1)
group by 1
),

t22 as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1
),
t3 as(
select distinct t22.country as country22, t22.orders as orders22, t22.gross_value as gross_value22,
coalesce(t22s.country, t22.country) as country22s, 
coalesce(t22s.orders, 0) as orders22s, 
coalesce(t22s.gross_value, 0) as gross_value22s
from t22
left join t22s on t22.country = t22s.country)
select * from t3
where orders22s > 0 and gross_value22s > 0




--#####################################################################

-- 
with
t22s as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
group by 1)
group by 1
),

t22 as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1
),
t3 as(
select distinct t22.country as country22, t22.orders as orders22, t22.gross_value as gross_value22,
coalesce(t22s.country, t22.country) as country22s, 
coalesce(t22s.orders, 0) as orders22s, 
coalesce(t22s.gross_value, 0) as gross_value22s
from t22
left join t22s on t22.country = t22s.country)

--select * from t3
--where orders22s > 0 and gross_value22s > 0

--select sum(t3.orders22s) from t3
--select sum(t3.orders22) from t3

select 100* sum(t3.orders22s) / sum(t3.orders22) as new_destinations_percentage_of_total_orders, 
100* sum(t3.gross_value22s) / sum(t3.gross_value22) as new_destinations_percentage_of_total_value
from t3


---########################
--the above query with total orders 22 and total value 22 as numbers (not percentage) in final select statement 
with
t22s as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
and Property_Country not in (
select distinct Property_Country from `prism_test.epic_1` where Week like ('%21%')
group by 1)
group by 1
),

t22 as (
select Property_country as country, sum(Net_Orders) as orders, sum(net_gross_booking_value_usd) as gross_value
from `prism_test.epic_1` 
where Week like ('%22%')
group by 1
),
t3 as(
select distinct t22.country as country22, t22.orders as orders22, t22.gross_value as gross_value22,
coalesce(t22s.country, t22.country) as country22s, 
coalesce(t22s.orders, 0) as orders22s, 
coalesce(t22s.gross_value, 0) as gross_value22s
from t22
left join t22s on t22.country = t22s.country)

--select * from t3
--where orders22s > 0 and gross_value22s > 0

--select sum(t3.orders22s) from t3
--select sum(t3.orders22) from t3

select sum(t3.orders22) as orders22, sum(t3.gross_value22) as gross_value22,
sum(t3.orders22s) / sum(t3.orders22) as new_destinations_of_total_orders, 
sum(t3.gross_value22s) / sum(t3.gross_value22) as new_destinations_of_total_value
from t3


--#############################################################
--#############################################################
--#############################################################
