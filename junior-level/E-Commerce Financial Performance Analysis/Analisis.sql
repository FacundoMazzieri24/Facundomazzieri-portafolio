-- Top 3 products per region with profit share percentage

with resumen as (
	select 
			r.region,
		    p."Product Name",
			sum(fs.profit) as total_profit
	from fact_sales fs
	join dim_product p
	on fs.product_id = p.product_id
	join dim_region r
	on fs.region_id = r.region_id
	group by p."Product Name",r.region
),
ranking as (
	  select *,
	  dense_rank() over (
	  					partition by region
						order by total_profit desc
						) as ranking_productos,
	  sum(total_profit) over (
	 						 partition by region
							 ) as total_region_profit
	  from resumen
)

select 
		region,
		"Product Name",
		total_profit,
		round((total_profit * 100.0) / total_region_profit, 2) as share_profit_pct,
		ranking_productos
from ranking
where ranking_productos <= 3
order by region,ranking_productos;



--Which category has the highest sales volume (Sales) and which has the highest average margin (Profit/Sales)?

with category_stats as (
    select 
        p.category,
        sum(fs.sales) as totalventas,
        sum(fs.profit) as totalprofit,
        round(sum(fs.profit) / sum(fs.sales),4) as margen
    from fact_sales fs
    join dim_product p
        on fs.product_id = p.product_id
    group by p.category
)
select 
    category,
    totalventas,
    totalprofit,
    margen,
    case 
		when totalventas = (select max(totalventas) from category_stats) 
        then 'Mayor ventas'
        else null
    end as top_ventas,
    case 
		when margen = (select max(margen) from category_stats) 
        then 'Mayor margen'
        else null
    end as top_margen
from category_stats
order by totalventas desc;

--How do sales and profit evolve month by month in each region between 2022 and 2024?
with resumen as ( 
    select
        r.region,
        d.year,
        d.month,
        sum(fs.sales) as totalventas,
        sum(fs.profit) as totalprofit
    from fact_sales fs
    join dim_region r on fs.region_id = r.region_id
    join dim_date d on fs.date = d.date
    where d.year between 2022 and 2024
    group by r.region, d.year, d.month
)
select 
    region,
    year,
    month,
    totalventas,
    totalprofit
from resumen
order by region, year, month;


--Which products have high sales volume but low margin?
with resumen as (
    select 
        p."Product Name",
        sum(fs.sales) as total_sales,
        sum(fs.profit) as total_profit,
        round(sum(fs.profit)/sum(fs.sales), 4) as margen,
        dense_rank() over(
					order by sum(fs.sales) desc
					)as sales_rank,
        
		dense_rank() over(
					order by round(sum(fs.profit)/sum(fs.sales),4) asc
					) as margen_rank
    from fact_sales fs
    join dim_product p 
	on fs.product_id = p.product_id
    group by p."Product Name"
)
select
		"Product Name", 
		total_sales,
		margen
from resumen
where sales_rank <= 10
and margen_rank <= 10
order by total_sales desc, margen asc;





