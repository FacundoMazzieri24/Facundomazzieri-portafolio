-- ============================================================
-- OLIST BRAZILIAN E-COMMERCE ANALYSIS
-- Views File — olist_ecommerce database (PostgreSQL)
-- Author: Facundo Mazzieri
-- ============================================================

-- ============================================================
-- STAKEHOLDER OBJECTIVE
-- ============================================================
-- Chief Revenue Officer — Olist
-- 100,000 real orders | 2016–2018 | 8 tables
--
-- Three core problems:
-- 1. Customers buy once and don't return — is it experience,
--    delivery, price, or seller quality?
-- 2. Sellers are highly uneven — some damage the platform's
--    reputation with late deliveries and poor reviews.
--    How do we identify and act on them?
-- 3. Logistics is costing us money and customers — late orders,
--    but unclear if the root cause is geographic, by category,
--    or by specific seller.
--
-- "Every lost order, every unsatisfied customer, and every bad
--  seller has a cost. Give me the numbers."
-- ============================================================

-- ============================================================
-- BUSINESS QUESTIONS
-- ============================================================
-- Q1  — What are the characteristics of repeat customers and
--        what value do they generate vs one-time buyers?
-- Q2  — Does seller performance relate to late deliveries?
-- Q3  — Does seller performance relate to bad reviews?
-- Q4  — Do high-price products generate more total revenue
--        despite selling fewer units?
-- Q5  — Does geolocation relate to review scores and revenue?
-- Q6  — Which categories have the lowest revenue and worst reviews?
-- Q7  — Which payment methods are associated with higher order
--        values and better reviews?
-- Q8  — How did customers and total revenue evolve from 2016–2018?
-- Q9  — Do late deliveries affect one-time buyers?
-- ============================================================


-- ============================================================
-- Q8 — Customer and Revenue Evolution 2016–2018
-- ============================================================
create view vw_monthly_evolution as
with resumen as (
	select 
	 	date_trunc('month',o.order_purchase_timestamp) as month,
	 	count(distinct o.order_id) as total_orders,
	 	count(distinct c.customer_unique_id) as unique_customers,
	 	round(sum(p.payment_value)::numeric,2) as total_revenue,
		round(avg(r.review_score)::numeric, 4) as avg_review_score
	from orders o
	join customers c
	on o.customer_id = c.customer_id
	join payments p
	on o.order_id = p.order_id
	left join reviews r 
	on o.order_id = r.order_id
	group by month
)	   

select 
	  month,
	  total_orders,
	  unique_customers,
	  total_revenue,
	  avg_review_score
from resumen
order by month;


-- ============================================================
-- Q9 — Late Deliveries Impact on One-Time Buyers
-- ============================================================
create view vw_late_delivery_impact as
with customer_orders as (
    select 
        c.customer_unique_id,
        count(distinct o.order_id) as total_orders,
        sum(case when o.is_late = 'true' then 1 else 0 end) as late_deliveries
    from orders o
    join customers c on o.customer_id = c.customer_id
    group by c.customer_unique_id
),
segmented as (
    select 
        customer_unique_id,
        total_orders,
        late_deliveries,
        case when total_orders = 1 then 'one-time' else 'repeat' end as segment
    from customer_orders
)
select 
    segment,
    count(customer_unique_id) as total_customers,
    round(avg(late_deliveries)::numeric, 4) as avg_late_deliveries
from segmented
group by segment
order by segment;


-- ============================================================
-- Q1 — One-Time vs Repeat Customers
-- ============================================================
create view vw_customer_segments as
with paso1 as (
    select
        c.customer_unique_id,
        count(distinct o.order_id) as total_orders,
        sum(p.payment_value) as total_revenue
    from orders o
    join payments p on o.order_id = p.order_id
    join customers c on o.customer_id = c.customer_id
    group by c.customer_unique_id 
),

paso2 as (
    select
        case 
            when total_orders = 1 then 'one-time' 
            else 'repeat'
        end as segment,
        count(customer_unique_id) as total_customers, 
        round(avg(total_revenue)::numeric, 4) as avg_revenue_per_customer,
        round(avg(total_orders), 2) as avg_orders,
        round(sum(total_revenue)::numeric, 2) as Total_revenue
    from paso1
    group by 1 
)

select
    segment,
    total_customers,
    avg_revenue_per_customer,
    avg_orders,
    Total_revenue
from paso2
order by Total_revenue desc;


-- ============================================================
-- Q2 & Q3 — Seller Performance (Late Deliveries + Review Score)
-- ============================================================
create view vw_seller_performance as
with resumen as(
	select 
    	s.seller_id,
    	count(distinct o.order_id) as total_orders,
    	sum(case when o.is_late = true then 1 else 0 end) as late_deliveries,
    	round(avg(case when o.is_late = true then 1 else 0 end)::numeric, 4) as late_delivery_rate,
    	round(avg(r.review_score)::numeric, 4) as avg_review_score
	from orders o
	join items i 
	on o.order_id = i.order_id
	join sellers s 
	on s.seller_id = i.seller_id
	left join reviews r
	on o.order_id = r.order_id
	group by s.seller_id
	having count(distinct o.order_id) >= 10
)
select 
	 seller_id,
	 total_orders,
	 late_deliveries,
	 late_delivery_rate,
	 avg_review_score
from resumen
order by late_delivery_rate desc, avg_review_score asc;


-- ============================================================
-- Q4 — High-Price Products vs Revenue and Units Sold
-- ============================================================
create view vw_product_performance as
with resumen as (
		select 
	  		c.product_category_name_english,
	  		round(avg(i.price)::numeric,2) as avg_price,
	  		round(sum(py.payment_value)::numeric,2) as total_revenue,
	  		count(i.order_id) as unidades_vendidas
		from items i
		join products p
		on i.product_id = p.product_id
		join category_translation c
		on p.product_category_name = c.product_category_name
		join payments py
		on i.order_id = py.order_id
		group by c.product_category_name_english
)

select 
	 product_category_name_english,
	 dense_rank() over(order by avg_price desc) as ranking,
	 avg_price,
	 total_revenue,
	 unidades_vendidas
from resumen
order by avg_price desc;


-- ============================================================
-- Q5 — Geolocation vs Reviews and Revenue
-- ============================================================
create view vw_geo_analysis as
with geo_avg as (
    select 
        geolocation_state,
        round(avg(geolocation_lat)::numeric, 4) as lat,
        round(avg(geolocation_lng)::numeric, 4) as lng
    from geolocation
    group by geolocation_state
)
select 
    c.customer_state,
    round(avg(r.review_score)::numeric, 4) as avg_review_score,
    round(sum(p.payment_value)::numeric, 2) as total_revenue,
    count(distinct o.order_id) as total_orders,
    g.lat,
    g.lng
from orders o
join customers c on o.customer_id = c.customer_id
left join reviews r on o.order_id = r.order_id
join payments p on o.order_id = p.order_id
join geo_avg g on c.customer_state = g.geolocation_state
group by c.customer_state, g.lat, g.lng
order by avg_review_score desc;


-- ============================================================
-- Q6 — Categories with Lowest Revenue and Worst Reviews
-- ============================================================
create view vw_category_performance as 
with payments_per_order as (
    select order_id, sum(payment_value) as total_payment
    from payments
    group by order_id
),
resumen as (
    select 
        c.product_category_name_english,
        round(sum(p.total_payment)::numeric,2) as total_revenue,
        round(avg(r.review_score)::numeric, 4) as avg_review_score,
        count(i.order_id) as total_units
    from items i
    join payments_per_order p on i.order_id = p.order_id
    left join reviews r on i.order_id = r.order_id
    join products pr on i.product_id = pr.product_id
    join category_translation c on pr.product_category_name = c.product_category_name
    group by c.product_category_name_english
    having count(i.order_id) >= 50
)
select 
    dense_rank() over(order by avg_review_score asc, total_revenue asc) as ranking,
    *
from resumen;



-- ============================================================
-- Q7 — Payment Methods vs Order Value and Reviews
-- ============================================================
create view vw_payment_analysis as
with resumen as(
	select
	  	py.payment_type,
	  	count(distinct o.order_id) as total_orders,
	  	round(avg(py.payment_value)::numeric,2) as avg_order_value,
	  	round(avg(r.review_score)::numeric,4) as avg_review_score,
	  	round(sum(py.payment_value)::numeric,2) as total_revenue
	from orders o
	join payments py
	on o.order_id = py.order_id
	join reviews r
	on o.order_id = r.order_id
	group by py.payment_type
)

select 
	  dense_rank() over (order by avg_order_value desc,avg_review_score desc) as ranking,
	  *
from resumen
