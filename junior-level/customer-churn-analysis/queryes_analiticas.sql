select * from dim_contract
select * from dim_customer
select * from dim_services
select * from fact_churn
--queries analiticas
-- 1.tasa general de churn
with resumen as (
		select 
   			 	count(*) as total_clientes,
    			sum(churn) as clientes_perdidos,
    			round(avg(churn::decimal) * 100, 2) as tasa_churn_pct
		from fact_churn
)
select 
	 total_clientes,
	 clientes_perdidos,
	 tasa_churn_pct
from resumen;

	 
-- 2.churn por tipo de contrato

with resumen as (
		select 
    		dc.contract,
    		count(*) as total_clientes,
    		sum(ch.churn) as clientes_perdidos,
    		round(avg(ch.churn::decimal) * 100, 2) as tasa_churn_pct
		from fact_churn ch
		join dim_contract dc
		on ch.customerid = dc.customerid
		group by dc.contract
)

select 
	contract,
	total_clientes,
	clientes_perdidos,
	tasa_churn_pct
from resumen
order by tasa_churn_pct desc;

-- 3.churn por metodo de pago
with resumen as (
		select 
    		dc.PaymentMethod ,
    		count(*) as total_clientes,
    		sum(ch.churn) as clientes_perdidos,
    		round(avg(ch.churn::decimal) * 100, 2) as tasa_churn_pct
		from fact_churn ch
		join dim_contract dc
		on ch.customerid = dc.customerid
		group by dc.PaymentMethod 
)

select 
	PaymentMethod,
	total_clientes,
	clientes_perdidos,
	tasa_churn_pct
from resumen
order by tasa_churn_pct desc;


-- 4.churn por genero y senior citizen
with resumen as (
    select 
        dcu.gender,
        case 
			when dcu.seniorcitizen = 1 then 'Senior'
			else 'No Senior' 
		end as senior_label,
        count(*) as total_clientes,
        sum(ch.churn) as clientes_perdidos,
        round(avg(ch.churn::decimal) * 100, 2) as tasa_churn_pct
    from fact_churn ch
	join dim_customer dcu
	on ch.customerid = dcu.customerid
    group by dcu.gender, dcu.seniorcitizen
)
select 
    gender,
    senior_label,
    total_clientes,
    clientes_perdidos,
    tasa_churn_pct
from resumen
order by tasa_churn_pct desc;


--5.¿Los clientes que pagan más tienen mayor churn? 
with resumen as (
		select 
			risklevel,
			count(*) as total_clientes,
			sum(churn) as clientes_perdidos,
			round(avg(churn::decimal) * 100, 2) as tasa_churn_pct,
			round(avg(monthlycharges),2) as avg_monthly,
			round(sum(churn * monthlycharges),2) as ingreso_perdido_mensual
		from fact_churn 
		group by risklevel
)
select 
	 risklevel,
	 total_clientes,
	 tasa_churn_pct,
	 avg_monthly,
	 ingreso_perdido_mensual
from resumen
order by ingreso_perdido_mensual desc;



--6. Churn por facturación electrónica
with resumen as (
		select
			dc.paperlessbilling,
			count(*) as total_clientes,
			sum(ch.churn) as clientes_perdidos,
			round(avg(ch.churn::decimal) * 100, 2) as tasa_churn_pct
		from fact_churn ch
		join dim_contract dc
		on ch.customerid = dc.customerid
		group by dc.paperlessbilling
)
select 
	paperlessbilling,
	total_clientes,
	clientes_perdidos,
	tasa_churn_pct
from resumen
order by tasa_churn_pct desc;


--7.a Churn por internet service
-- churn por internet service
with resumen as (
    select 
        ds.internetservice,
        count(*) as total_clientes,
        sum(ch.churn) as clientes_perdidos,
        round(avg(ch.churn::decimal) * 100, 2) as tasa_churn_pct
    from fact_churn ch
    join dim_services ds 
	on ch.customerid = ds.customerid
    group by ds.internetservice
)
select * 
from resumen
order by tasa_churn_pct desc;


--7.b churn por servicios binarios
select 	
	   'PhoneService' as servicio, 
	   ds.phoneservice as valor,
       round(avg(ch.churn::decimal) * 100, 2) as tasa_churn_pct
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


order by servicio,tasa_churn_pct desc;


--8. churn por antiguedad
with resumen as (
	 	select
		 	  tenure,
			  count(*) as total_clientes,
			  sum(churn) as clientes_perdidos,
			  round(avg(churn::decimal) * 100, 2) as tasa_churn_pct 
		from fact_churn
		group by tenure
	
)
select 
	   tenure,
	   total_clientes,
	   clientes_perdidos,
	   tasa_churn_pct 
from resumen
order by tasa_churn_pct desc;

--9. Costo del churn en ingresos perdidos

-- costo total del churn en ingresos perdidos
with resumen as (
		select 
    			count(*) filter (where churn = 1) as clientes_perdidos,
    			round(avg(monthlycharges) filter (where churn = 1), 2) as avg_monthly_perdido,
    			round(sum(
			   			  case 
			   					when churn = 1 then monthlycharges 
			        			else 0 
			   			  end), 2) as ingreso_mensual_perdido,
    			round(sum(
			 			  case 
				  			    when churn = 1 then monthlycharges 
				   				else 0 
			  			  end) * 12, 2) as ingreso_anual_perdido
		from fact_churn
)
select 
	   clientes_perdidos,
	   avg_monthly_perdido,
	   ingreso_mensual_perdido,
	   ingreso_anual_perdido
from resumen;

--10. ranking de clientes perdidos por segmento de riesgo
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
        count(*) as totalclientes,
        sum(churn) as clientes_perdidos,
        round(avg(churn::decimal) * 100, 2) as tasa_churn_pct
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
        ) as rank_cliente
    from base
    where churn = 1
)

select 
    r.risklevel,
    r.totalclientes,
    r.clientes_perdidos,
    r.tasa_churn_pct,
    rk.customerid,
    rk.monthlycharges,
    rk.rank_cliente
from resumen r
join ranking rk 
on r.risklevel = rk.risklevel
where rk.rank_cliente <= 5
order by 
    case r.risklevel
        when 'High Risk' then 1
        when 'Medium Risk' then 2
        when 'Low Risk' then 3
    end,
    rk.rank_cliente;

