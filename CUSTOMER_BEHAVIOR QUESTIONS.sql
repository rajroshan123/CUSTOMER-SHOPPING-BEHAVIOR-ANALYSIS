USE customer_behavior;
select*from customer;
-- que1: what is the revenue generated genderwise
select gender, sum(purchase_amount) as revenue
from customer
group by gender;
-- que2:which customer is spending more even after dicount
select customer_id, purchase_amount 
from customer
where discount_applied='yes' and purchase_amount>=(select avg(purchase_amount)from customer);
-- que3 which are the top5 products with highest reveiw ratings
select item_purchased,avg(review_rating) as "average product rating"
from customer
group by item_purchased
order by avg(review_rating)desc
limit 5;
-- que4 COMPARE THE AVERAGE PURCHASED AMOUNT BETWEEN STANDARD AND EXPRESS SHIPPING
select shipping_type,
avg(purchase_amount)
from customer
where shipping_type in ('standard','express')
group by shipping_type;
-- que5 do subscribed customer spend more? 
select subscription_status,
count(customer_id) as total_customers ,
round(avg(purchase_amount),2) as avg_spend ,
round(sum(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue,avg_spend desc;
-- que6 which top 5 products have highest purchase amount of discount applied?
select item_purchased,
round(100*sum(case when discount_applied='yes' then 1 else 0 end)/count(*) ,2) as discount_rate
from customer group by item_purchased
order by discount_rate desc
limit 5;
-- que 7 segment customers into new, returning , loyal based on their total number of previous purchases , and show the count of each segment
with customer_type as(
select customer_id,previous_purchases,
case
     when previous_purchases=1 then 'new'
     when previous_purchases  between 2 and 10 then 'returning'
     else 'loyal'
     end as customer_segment
from customer
)
select customer_segment, count(*) as "number of customers"
from customer_type
group by customer_segment desc;
-- que8 what are the top 5 products bought in each category
with item_counts as (
select category,
item_purchased,
count(customer_id) as total_orders,
row_number() over(partition by category order by count(customer_id) desc) as item_rank
from customer
group by category, item_purchased
)
select item_rank, category, item_purchased, total_orders
from item_counts
where item_rank<=3;
-- ques 9 are customers who are repeat buyers(more than 5 times) are also subscribers ?
select subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchases>5
group by subscription_status;
-- que 10 what is revenue contribution of each sub group ?
select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc; 