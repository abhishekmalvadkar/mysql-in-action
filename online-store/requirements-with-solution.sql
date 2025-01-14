-- Calculate the total sales for each product 
-- (based on the quantity sold and product price).

select 
	p.product_id,
	p.product_name ,
	sum((oi.price * oi.quantity)) as total_amount
from order_items oi
join products p on p.product_id = oi.product_id
group by product_id, p.product_name 
;


-- Identify the top 3 products based on the quantity sold.
select 
  oi.product_id ,
  p.product_name ,
  sum(quantity) as quantity_sold 
from order_items oi 
join products p on p.product_id = oi.product_id 
group by oi.product_id , p.product_name 
order by quantity_sold desc limit 3;

-- Calculate the total revenue for each product category.
select 
	p.category ,
	sum(oi.quantity * oi.price) as total_revenue
from products p
join order_items oi on oi.product_id = p.product_id 
group by p.category
;

-- Track how much each customer is spending per month.
select 
	c.customer_id ,
	c.first_name ,
	date_format(o.order_date, '%M-%Y'),
	sum(o.total_amount) 
from orders o 
join customers c on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, date_format(o.order_date, '%M-%Y') 
;

-- Identify products with stock quantities lower than 20.
select p.product_name, p.stock_quantity from products p 
where stock_quantity < 20;

-- Find out how many orders each customer has placed.
select 
	c.customer_id ,
	c.first_name,
	count(o.order_id) as total_order
from orders o 
join customers c on c.customer_id = o.customer_id 
group by c.customer_id , c.first_name 
;

-- Identify orders that contain more than 1 product
select 
	oi.order_id,
	count(oi.product_id) as prodcut_count
from order_items oi 
group by oi.order_id
having prodcut_count > 1
; 


-- Calculate the daily revenue generated by the store.
select 
	o.order_date,
	sum(total_amount) as revenue
from orders o 
group by o.order_date ;
