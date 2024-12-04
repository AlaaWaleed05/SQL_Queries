--Q1: Write a query to retrieve the product names, their prices, and the brand names using an INNER JOIN between the `products` and `brands` tables."
select product_name,list_price,brand_name
from production.products pp join production.brands pb
on pp.brand_id =pb.brand_id

--Q2: Write a query to retrieve the product names, the stores they are available in, and the quantity available using an INNER JOIN between the `products`, `stocks`, and `stores` tables."
select product_name,store_name,quantity
from sales.stores ss inner join production.stocks ps
on ss.store_id =ps.store_id
inner join production.products pp 
on ps.product_id = pp.product_id;

--Q3: Write a query to retrieve all orders that have been shipped (where `shipped_date` is not NULL).
select*
from sales.orders
where shipped_date IS NOT NULL;

--Q4: Write a query to retrieve the first and last names of customers who live in the city of 'New York'.
select first_name, last_name
from sales.customers
where city = 'New York';

--Q5: Write a query to count the number of different products for each brand using `GROUP BY` on `brand_id`.
select brand_id, count(product_id) as product_count
from production.products
group by brand_id;

--Q6: Write a query to count the total number of orders for each order status (`order_status`) using `GROUP BY`.
select order_status, count(order_id) as Total_orders
from sales.orders
group by order_status
order by order_status

--Q7: Write a query to retrieve the details of stores that have more than 1000 units of any product in stock.
select ss.store_id, ss.store_name, ss.phone, ss.email, ss.city
from production.stocks ps join sales.stores ss 
on ps.store_id = ss.store_id
where ps.quantity > 1000;

--Q8: Write a query to retrieve the names of products that are priced higher than the average price of all products in the table.
select product_name, list_price
from production.products
where list_price > (select avg (list_price) 
                    from production.products);


--Q9: Create a view named `active_staff` that contains the first and last names of all staff members who are active (`active = 1`).
CREATE VIEW Active_Staff AS
select first_name, last_name
from sales.staffs
where active = 1;

--Q10: Create a view named `top_selling_products` that contains the names of products that have sold more than 100 units.
CREATE VIEW top_selling_products AS
select pp.product_name, sum(quantity) as units_sold
from production.products pp join sales.order_items so 
on pp.product_id = so.product_id
GROUP BY pp.product_name
HAVING sum(quantity) > 100;

--Q11: Write a query to retrieve the top 10 customers who have made the most purchases based on total purchase amount.
select top 10 sc.customer_id, sc.first_name, sc.last_name, sum(soi.quantity * soi.list_price - soi.discount) as purchase_amount
from sales.customers sc join sales.orders so 
on sc.customer_id = so.customer_id
join sales.order_items soi 
on soi.order_id = so.order_id
GROUP BY sc.customer_id, sc.first_name, sc.last_name
ORDER BY purchase_amount DESC

--Q12: Write a query to retrieve the top 10 best-selling products based on the total quantity sold.

SELECT TOP 10 pp.product_id, pp.product_name, sum(soi.quantity) AS Quantity_sold
FROM production.products pp join sales.order_items soi 
on pp.product_id = soi.product_id
join sales.orders so 
on soi.order_id = so.order_id
group by  pp.product_id, pp.product_name
order by Quantity_sold DESC;


--Q13: Write a query to calculate the total quantities sold for each product using `SUM` on the `quantity` column.
select pp.product_id,pp.product_name,sum(quantity)as Total_quantities
from production.products pp join sales.order_items so
on pp.product_id=so.product_id
group by pp.product_id,pp.product_name

--Q14: Write a query to calculate the average price of products in each category (`category_id`) using `AVG` on `list_price`.
select pc.category_id,pc.category_name,avg(list_price) as Average_price
from  production.products pp join production.categories pc
on pp.category_id=pc.category_id 
group by pc.category_id,pc.category_name


--Q15: Write a query to retrieve the details of staff members who have not handled any orders (you can use a `LEFT JOIN` and `IS NULL`).
select s.staff_id, s.first_name, s.last_name, s.email, s.phone
from sales.staffs s
left join sales.orders o on s.staff_id = o.staff_id
where o.order_id IS NULL
order by s.staff_id


