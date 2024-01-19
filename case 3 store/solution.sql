-- 1. What are the names of all the countries in the country table?
select * from country;

-- 2. What is the total number of customers in the customers table?
select
	count(customer_id)
from 
	customers;
    
-- 3. What is the average age of customers who can receive marketing emails (can_email is set to 'yes')?
select
	avg(age) as average_age
from 
	customers
where
	can_email = 'yes';
    
-- 4. How many orders were made by customers aged 30 or older?
select 
	count(o.order_id) as total_order
from 
	orders as o
	left join customers as c
		on o.customer_id = c.customer_id
where c.age >= 30;

-- 5. What is the total revenue generated by each product category?
select 
	p.category
    , sum(price) as total_revenue
from
	products as p
    left join baskets as b
		on p.product_id=b.product_id
group by p.category;

-- 6. What is the average price of products in the 'food' category?
select 
	avg(price) as avg_price
from 
	products
where 
	category = 'food';
    
-- 7. How many orders were made in each sales channel (sales_channel column) in the orders table?
select
	sales_channel 
    , count(order_id) AS total_order
from
	orders
group by 
	sales_channel;
    
-- 8.What is the date of the latest order made by a customer who can receive marketing emails?
select 
	o.date_shop as latest_order_date
from
	orders as o
    left join customers as c
		on o.customer_id = c.customer_id
where
	c.can_email = 'yes'
order by 
	o.date_shop desc
limit 1;

-- or 
 SELECT MAX(date_shop) AS latest_order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.can_email = 'yes';
	
-- 9. What is the name of the country with the highest number of orders?
select 
	c.country_name
from
	country as c
    left join orders as o
		on c.country_id = o.country_id
group by 
	c.country_name
order by
	count(*) desc
limit 1;


-- 10. What is the average age of customers who made orders in the 'vitamins' product category?
select
	round(avg(c.age)) as average_age
from
	customers c
	join orders o on c.customer_id = o.customer_id
	join baskets b on o.order_id = b.order_id
	join products p on b.product_id = p.product_id
where
	p.category = 'vitamins';
