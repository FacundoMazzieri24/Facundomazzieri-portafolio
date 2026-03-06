-- =====================================================
-- ecommerce financial performance analysis (2022–2024)
-- author: facundo
-- description:
-- sql queries used to transform the raw ecommerce dataset,
-- create a star schema, and perform analytical queries
-- for the power bi dashboard.
-- =====================================================


-- =====================================================
-- data normalization - star schema
-- =====================================================

--------------------------------------------------------
-- dimension: product
--------------------------------------------------------

create table dim_product as
select
    row_number() over(order by "Product Name") as product_id,
    "Product Name",
    category
from (
    select distinct
        "Product Name",
        category
    from raw_sales1
) t;


--------------------------------------------------------
-- dimension: region
--------------------------------------------------------

create table dim_region as
select
    row_number() over(order by region) as region_id,
    region
from (
    select distinct region
    from raw_sales1
) t;


--------------------------------------------------------
-- dimension: date
--------------------------------------------------------

create table dim_date as
select distinct
    "Order Date" as date,
    extract(year from "Order Date") as year,
    extract(month from "Order Date") as month,
    extract(quarter from "Order Date") as quarter
from raw_sales1;


--------------------------------------------------------
-- fact table
--------------------------------------------------------

create table fact_sales as
select
    row_number() over() as order_id,
    s."Order Date" as date,
    p.product_id,
    r.region_id,
    s.quantity,
    s.sales,
    s.profit
from raw_sales1 s
join dim_product p
    on s."Product Name" = p."Product Name"
join dim_region r
    on s.region = r.region;



-- =====================================================
-- analytical queries
-- =====================================================

/* Business questions answered in this analysis:

1. Which products generate the highest accumulated profit?
2. Which categories have the highest sales volume and profit margin?
3. How do sales and profit evolve month by month by region?
4. Which products have high sales volume but low profit margin?

Techniques used:
- Joins
- Aggregations
- CTEs (Common Table Expressions)
- Window Functions
- Ranking
- Profit Share Calculation
*/

----------------------------------------------------------
-- Top 3 products per region with profit share percentage
----------------------------------------------------------

with product_profit as (

	select 
		r.region,
		p."Product Name",
		sum(fs.profit) as total_profit

	from fact_sales fs
	join dim_product p
		on fs.product_id = p.product_id
	join dim_region r
		on fs.region_id = r.region_id

	group by r.region, p."Product Name"

),

ranking as (

	select *,
	
		dense_rank() over(
			partition by region
			order by total_profit desc
		) as product_rank,

		sum(total_profit) over(
			partition by region
		) as total_region_profit

	from product_profit

)

select 
	region,
	"Product Name",
	total_profit,
	round((total_profit * 100.0) / nullif(total_region_profit,0),2) as profit_share_pct,
	product_rank

from ranking

where product_rank <= 3

order by region, product_rank;


--------------------------------------------------------------------
-- Which category has the highest sales volume and profit margin?
--------------------------------------------------------------------

with category_stats as (

	select 
		p.category,
		sum(fs.sales) as total_sales,
		sum(fs.profit) as total_profit,
		round(sum(fs.profit) / nullif(sum(fs.sales),0),4) as profit_margin

	from fact_sales fs
	join dim_product p
		on fs.product_id = p.product_id

	group by p.category

)

select 
	category,
	total_sales,
	total_profit,
	profit_margin,

	case
		when total_sales = (select max(total_sales) from category_stats)
		then 'Highest Sales'
	end as top_sales,

	case
		when profit_margin = (select max(profit_margin) from category_stats)
		then 'Highest Margin'
	end as top_margin

from category_stats

order by total_sales desc;


-------------------------------------------------------------------
-- How do sales and profit evolve month by month by region?
-------------------------------------------------------------------

with monthly_sales as (

	select
		r.region,
		d.year,
		d.month,
		sum(fs.sales) as total_sales,
		sum(fs.profit) as total_profit

	from fact_sales fs

	join dim_region r
		on fs.region_id = r.region_id

	join dim_date d
		on fs.date = d.date

	where d.year between 2022 and 2024

	group by r.region, d.year, d.month

)

select 
	region,
	year,
	month,
	total_sales,
	total_profit

from monthly_sales

order by region, year, month;


-------------------------------------------------------------
-- Which products have high sales volume but low margin?
-------------------------------------------------------------

with product_sales as (

	select 
		p."Product Name",
		sum(fs.sales) as total_sales,
		sum(fs.profit) as total_profit,
		round(sum(fs.profit) / nullif(sum(fs.sales),0),4) as profit_margin,

		dense_rank() over(
			order by sum(fs.sales) desc
		) as sales_rank,

		dense_rank() over(
			order by round(sum(fs.profit) / nullif(sum(fs.sales),0),4) asc
		) as margin_rank

	from fact_sales fs

	join dim_product p
		on fs.product_id = p.product_id

	group by p."Product Name"

)

select
	"Product Name",
	total_sales,
	profit_margin

from product_sales

where sales_rank <= 10
and margin_rank <= 10

order by total_sales desc, profit_margin asc;





