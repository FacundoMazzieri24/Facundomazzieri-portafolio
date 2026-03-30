-- analytical queries
-- 1. overall churn rate
with resumen as (
		select 
   			 	count(*) as total_customers,
    			sum(churn) as lost_customers,
    			round(avg(churn::decimal) * 100, 2) as churn_rate_pct
		from fact_churn
)
select 
	 total_customers,
	 lost_customers,
	 churn_rate_pct
from resumen;

	 
-- 2. churn by contract type

with resumen as (
		select 
    		dc.contract,
    		count(*) as total_customers,
    		sum(ch.churn) as lost_customers,
    		round(avg(ch.churn::decimal) * 100, 2) as churn_rate_pct
		from fact_churn ch
		join dim_contract dc
		on ch.customerid = dc.customerid
		group by dc.contract
)

select 
	contract,
	total_customers,
	lost_customers,
	churn_rate_pct
from resumen
order by churn_rate_pct desc;

-- 3. churn by payment method
with resumen as (
		select 
    		dc.PaymentMethod ,
    		count(*) as total_customers,
    		sum(ch.churn) as lost_customers,
    		round(avg(ch.churn::decimal) * 100, 2) as churn_rate_pct
		from fact_churn ch
		join dim_contract dc
		on ch.customerid = dc.customerid
		group by dc.PaymentMethod 
)

select 
	PaymentMethod,
	total_customers,
	lost_customers,
	churn_rate_pct
from resumen
order by churn_rate_pct desc;


-- 4. churn by gender and senior citizen
with resumen as (
    select 
        dcu.gender,
        case 
			when dcu.seniorcitizen = 1 then 'Senior'
			else 'No Senior' 
		end as senior_label,
        count(*) as total_customers,
        sum(ch.churn) as lost_customers,
        round(avg(ch.churn::decimal) * 100, 2) as churn_rate_pct
    from fact_churn ch
	join dim_customer dcu
	on ch.customerid = dcu.customerid
    group by dcu.gender, dcu.seniorcitizen
)
select 
    gender,
    senior_label,
    total_customers,
    lost_customers,
    churn_rate_pct
from resumen
order by churn_rate_pct desc;


-- 5. do customers who pay more have higher churn?
with resumen as (
		select 
			risklevel,
			count(*) as total_customers,
			sum(churn) as lost_customers,
			round(avg(churn::decimal) * 100, 2) as churn_rate_pct,
			round(avg(monthlycharges),2) as avg_monthly_charges,
			round(sum(churn * monthlycharges),2) as monthly_revenue_lost
		from fact_churn 
		group by risklevel
)
select 
	 risklevel,
	 total_customers,
	 churn_rate_pct,
	 avg_monthly_charges,
	 monthly_revenue_lost
from resumen
order by monthly_revenue_lost desc;



-- 6. churn by paperless billing
with resumen as (
		select
			dc.paperlessbilling,
			count(*) as total_customers,
			sum(ch.churn) as lost_customers,
			round(avg(ch.churn::decimal) * 100, 2) as churn_rate_pct
		from fact_churn ch
		join dim_contract dc
		on ch.customerid = dc.customerid
		group by dc.paperlessbilling
)
select 
	paperlessbilling,
	total_customers,
	lost_customers,
	churn_rate_pct
from resumen
order by churn_rate_pct desc;


-- 7a. churn by internet service
with resumen as (
    select 
        ds.internetservice,
        count(*) as total_customers,
        sum(ch.churn) as lost_customers,
        round(avg(ch.churn::decimal) * 100, 2) as churn_rate_pct
    from fact_churn ch
    join dim_services ds 
	on ch.customerid = ds.customerid
    group by ds.internetservice
)
select * 
from resumen
order by churn_rate_pct desc;


-- 7b. churn by binary services (yes/no)
select 	
	   'PhoneService' as servicio, 
	   ds.phoneservice as valor,
       round(avg(ch.churn::decimal) * 100, 2) as churn_rate_pct
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.phoneservice in ('Yes', 'No')
group by ds.phoneservice

union all

select 
	   'MultipleLines', 
	    ds.multiplelines,
        round(avg(ch.churn::decimal) * 100, 2)
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.multiplelines in ('Yes', 'No')
group by ds.multiplelines

union all

select 
	   'OnlineSecurity', 
	    ds.onlinesecurity,
        round(avg(ch.churn::decimal) * 100, 2)
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.onlinesecurity in ('Yes', 'No')
group by ds.onlinesecurity

union all

select 
	   'OnlineBackup', 
		ds.onlinebackup,
        round(avg(ch.churn::decimal) * 100, 2)
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.onlinebackup in ('Yes', 'No')
group by ds.onlinebackup

union all

select 
	   'DeviceProtection', 
	    ds.deviceprotection,
        round(avg(ch.churn::decimal) * 100, 2)
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.deviceprotection in ('Yes', 'No')
group by ds.deviceprotection

union all

select 
	   'TechSupport', 
	    ds.techsupport,
        round(avg(ch.churn::decimal) * 100, 2)
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.techsupport in ('Yes', 'No')
group by ds.techsupport

union all

select 
	   'StreamingTV', 
	    ds.streamingtv,
        round(avg(ch.churn::decimal) * 100, 2)
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.streamingtv in ('Yes', 'No')
group by ds.streamingtv

union all

select 
	   'StreamingMovies', 
	    ds.streamingmovies,
        round(avg(ch.churn::decimal) * 100, 2)
from fact_churn ch 
join dim_services ds 
on ch.customerid = ds.customerid
where ds.streamingmovies in ('Yes', 'No')
group by ds.streamingmovies


order by servicio,churn_rate_pct desc;


-- 8. churn by tenure
with resumen as (
	 	select
		 	  tenure,
			  count(*) as total_customers,
			  sum(churn) as lost_customers,
			  round(avg(churn::decimal) * 100, 2) as churn_rate_pct 
		from fact_churn
		group by tenure
	
)
select 
	   tenure,
	   total_customers,
	   lost_customers,
	   churn_rate_pct 
from resumen
order by churn_rate_pct desc;

-- 9. estimated revenue lost by churn
with resumen as (
		select 
    			count(*) filter (where churn = 1) as lost_customers,
    			round(avg(monthlycharges) filter (where churn = 1), 2) as avg_monthly_charges_perdido,
    			round(sum(
			   			  case 
			   					when churn = 1 then monthlycharges 
			        			else 0 
			   			  end), 2) as monthly_revenue_lost,
    			round(sum(
			 			  case 
				  			    when churn = 1 then monthlycharges 
				   				else 0 
			  			  end) * 12, 2) as annual_revenue_lost
		from fact_churn
)
select 
	   lost_customers,
	   avg_monthly_charges_perdido,
	   monthly_revenue_lost,
	   annual_revenue_lost
from resumen;

-- 10. top 5 lost customers ranked by monthly charges per risk segment
with base as (
    select 
        customerid,
        risklevel,
        monthlycharges,
        churn
    from fact_churn
),

resumen as (
    select 
        risklevel,
        count(*) as total_customers,
        sum(churn) as lost_customers,
        round(avg(churn::decimal) * 100, 2) as churn_rate_pct
    from base
    group by risklevel
),

ranking as (
    select 
        customerid,
        risklevel,
        monthlycharges,
        row_number() over (
            partition by risklevel 
            order by monthlycharges desc
        ) as customer_rank
    from base
    where churn = 1
)

select 
    r.risklevel,
    r.total_customers,
    r.lost_customers,
    r.churn_rate_pct,
    rk.customerid,
    rk.monthlycharges,
    rk.customer_rank
from resumen r
join ranking rk 
on r.risklevel = rk.risklevel
where rk.customer_rank <= 5
order by 
    case r.risklevel
        when 'High Risk' then 1
        when 'Medium Risk' then 2
        when 'Low Risk' then 3
    end,
    rk.customer_rank;

