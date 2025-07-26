use apple;

select * from category;
select * from products;
select top 10 * from sales;
select * from stores;
select * from warranty;

/* EDA(Exploratary data analysis)*/
select distinct category_id from category;      /* 10 -CAT-1 to CAT-10 */

select distinct product_id from products;       /* 64  */

select distinct sale_id from sales;             /* 1040191 */

select distinct store_id from stores;           /* 73 */

select distinct claim_id from warranty;         /* 30836 */

/* Questions */
--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>
/* 1.Find each country and number of stores */
select country, count(store_id) as num_of_stores
from stores
group by country
order by num_of_stores desc;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>
/* 2. What is the total number of units sold by each store? */
select s.store_id,st.store_name,sum(s.quantity) as num_of_units
from sales s join stores st 
on s.store_id = st.store_id
group by s.store_id,st.store_name
order by store_id desc;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 3. How many sales occurred in December 2023? */
select count(quantity)  as total_sales
from sales 
where sale_date >= '2023-12-01' and sale_date < '2024-01-01'

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/*4. How many stores have never had a warranty claim filed against any of their products? */
select count(*) from stores
where store_id not in (
select  distinct s.store_id  from sales s right join warranty w 
on s.sale_id = w.sale_id)

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 5. What percentage of warranty claims are marked as "Warranty Void"? */

select 
round 
     (
	   cast
	       (
		     sum
			     (
				  case when repair_status = 'warranty void' then 1 else 0 end)as float)*100.0/count(*),2) as warranty_void_percentage
from warranty;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 6. Which store had the highest total units sold in the last year? */

select top 1 s.store_id,ss.store_name,sum(s.quantity) as highest_unit_sold       
from sales s join stores ss
on s.store_id = ss.store_id
where s.sale_date >= DATEADD(year,-1,'2024')
group by s.store_id,ss.store_name
order by highest_unit_sold desc;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 7. Count the number of unique products sold in the last year. */

select 
      count(distinct product_id) as unique_product_sale
from 
      sales 
where 
      sale_date >= dateadd(year,-1,'2024')

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 8. What is the average price of products in each category? */
select p.category_id,
       c.category_name,
       avg(price) as average_price
from 
        products p 
join 
        category c 
on 
        p.category_id = c.category_id
group by
        p.category_id,c.category_name
order by 
        average_price desc;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 9.How many warranty claims were filed in 2020? */
select  
     count(claim_id) as num_of_warranty_claims
from
     warranty
where
     year(claim_date) = '2020';

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 10. Identify each store and best selling day based on highest qty sold */
select store_id , Day,highest_sale from (select 
       store_id,
       format(sale_date,'dddd') as "Day",
	   sum(quantity) as highest_sale,
	   rank() over (partition by store_id order by sum(quantity) desc) as rnk
from 
      sales
group by 
        store_id,sale_date) as sub_query
where 
     rnk = 1
order by highest_sale desc;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>
/* 11. Identify least selling product of each country  based on total unit sold. */

with least_sold_date 
as(select 
      st.country as country,p.product_name as product_name,sum(s.quantity) as num_sold
	  ,RANK() over (PARTITION by st.country order by sum(s.quantity)) as rnk
	  from products p join  sales s
	  on p.product_id = s.product_id
	  join stores st
	  on s.store_id = st.store_id
	  group by st.country,p.product_name
	 )
select  country,product_name,num_sold from least_sold_date
where rnk = 1
order by num_sold;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 12. How many warranty claims were filed within 180 days of a product sale?*/
with day_diff 
as(
   select 
         s.sale_date,w.*
   from  
         warranty w left join sales s
   on 
         s.sale_id = w.sale_id
   where 
         DATEDIFF(day,s.sale_date,w.claim_date)<= 180
)
select 
      count(*) as num_of_claims 
from 
     day_diff;

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 13. How many warranty claims have been filed for products launched in the last two years? */

select 
      p.product_name,
	  count(w.claim_id) as num_claims,
      count(s.sale_id)  as total_sale 
from 
      warranty as w 
right join 
      sales as s 
on w.sale_id = s.sale_id
 join 
      products as p 
on s.product_id = p.product_id
where 
      p.launch_date >= dateadd(YEAR,-2,GETDATE())
group by 
      p.product_name

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 14. List the months in the last 3 years where sales exceeded 5000 units from usa */

select  
      format(s.sale_date,'yyyy-MM') as months ,
      sum(quantity) as total_quantity
from 
     sales s 
 join 
     stores st
on 
    s.store_id = st.store_id
where 
    st.country = 'USA' 
and 
    sale_date > DATEADD(YEAR,-3,GETDATE())
group by 
      format(s.sale_date,'yyyy-MM')
having 
     sum(quantity) > 5000
order by 
    months

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>

/* 15. Which product category had the most warranty claims filed in the last 2 years? */

select top 1 p.category_id,c.category_name,count(claim_id) as total_claims from
warranty w left join sales s
on w.sale_id = s.sale_id
join 
products p 
on s.product_id = p.product_id
join category c
on p.category_id = c.category_id
where claim_date > DATEADD(year,-2,getdate())
group by p.category_id,c.category_name
order by total_claims desc

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>
/* 16. Determine the percentage chance of receiving claims after each purchase for each country. */
with main as 
(
select 
     st.country as Country,
     count(w.claim_id) as count_of_claims,
     count(s.sale_id) as Total_of_sales 
from 
     sales s
 join 
     stores st on s.store_id = st.store_id
left join 
    warranty w on s.sale_id = w.sale_id
group by 
     st.country
having 
     count(w.claim_id) >0
)
select country ,
       count_of_claims,
	   Total_of_sales,
	   Round(cast(count_of_claims*100.0/Total_of_sales as float),2) as percentage_of_claims
from 
    main
order by 
    percentage_of_claims desc

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>
/*  17. Analyze each stores year by year growth ratio */
-->for growth ratio we need sales that is quantity*price
with yearly_sales as 
(
select s.store_id,st.store_name,
year(s.sale_date) as years,
sum(s.quantity*p.price) as total_sales
 from sales as s 
join products as p 
on s.product_id=p.product_id
join 
stores as st
on s.store_id = st.store_id
group by s.store_id,st.store_name,year(s.sale_date)
),
pre_year_sales as 
(
select store_id,store_name,years,
Lag(total_sales) over (partition by store_name order by years) as Last_year_sale
,total_sales as current_year_sale
from yearly_sales
)
select store_id,
       store_name,
	   years,
	   Last_year_sale,
	   current_year_sale,
	   cast(round((current_year_sale-Last_year_sale)*100.0/Last_year_sale,2) as decimal(10,2)) as yearly_growth_ratio
from pre_year_sales
where Last_year_sale is not Null 
and years <> year(GETDATE())

/* 18. What is the correlation between product price and warranty claims for products sold in the
 last five years? (Segment based on diff price) */

 with details as (
 select claim_date, 
 product_name,
 price,
 (case 
     when price < 500 then 'Low_price_products'
	 when price >= 500 and price <=1000 then 'Average_price_products'
	 else 'high_cost_products' 
end) as prices_segmentation
 from warranty w 
 left join 
 sales s 
 on w.sale_id = s.sale_id
 join 
 products p
 on s.product_id = p.product_id
 where claim_date >= DATEADD(YEAR,-5,getdate())
 )
 select prices_segmentation , count(prices_segmentation) as Total_claims
 from details
 group by prices_segmentation
 order by Total_claims desc

 /* 19. Identify the store with the highest percentage of "Paid Repaired" claims in relation to total
 claims filed. */
 with count_of_paid as (
select store_id,
count(claim_id) as paid from warranty  w
left join 
 sales s 
 on w.sale_id = s.sale_id
 where repair_status = 'paid repaired'
 group by store_id)
,total_claims as 
(
select store_id,
count(claim_id) as total from warranty  w
left join 
 sales s 
 on w.sale_id = s.sale_id
 group by store_id
 )
 select c.store_id,
 paid,
 total,
 cast(round((paid * 100.0)/total,2) as decimal(10,2)) as percentage_of_paid_repaired
 from count_of_paid c
 join total_claims t
 on c.store_id = t.store_id

 --------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>
/* 20.Write SQL query to calculate the monthly running total of sales for each store over the past
 four years and compare the trends across this period? */

 with total_sale as 
 (
select  
      s.store_id as Store_id,
      datepart(YEAR,sale_date) as "Year",
      datepart(month,sale_date) as "Month" ,
      sum(p.price*s.quantity) as Total_Sales
from 
     sales s
join
     products p
on 
     s.product_id = p.product_id
group by 
     s.store_id,
     datepart(YEAR,sale_date) ,
     datepart(month,sale_date)
 )
 select 
      Store_id,
      year,
      month,
      Total_Sales,
      sum(Total_Sales) over (partition by store_id order by year,month) as running_total
 from
      total_sale
 order by 
      store_id,
	  Year,
	  Month

--------------------------------------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>
/*  20.Analyze sales trends of product over time, segmented into key time periods: from launch to 6
 months, 6-12 months, 12-18 months, and beyond 18 months? */

With sales_trend as (
 select 
       p.product_name as product_name,
       p.launch_date as launch_date ,
	   s.sale_date as sale_date,
	   s.quantity as quantity,
	   case 
	       when s.sale_date between p.launch_date and DATEADD(month,6,p.launch_date) then '0-6month_sale'
		   when s.sale_date between DATEADD(month,6,p.launch_date) and DATEADD(month,12,p.launch_date) then '6-12month_sale'
		   when s.sale_date between DATEADD(month,12,p.launch_date) and DATEADD(month,18,p.launch_date) then '12-18month_sale'   
		   else '18+_month_sale' 
		end as time_period
 from sales s 
 join products p 
 on s.product_id = p.product_id
 )
 select product_name,
        time_period,
		sum(quantity) as total_quantity_sold
from 
        sales_trend
group by 
        product_name,
        time_period
order by 
        product_name;







 







































