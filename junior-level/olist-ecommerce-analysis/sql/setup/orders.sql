-- creamos tabla cruda
create table orders_raw(
		order_id text,
		customer_id text,
		order_status text,
		order_purchase_timestamp text,
		order_approved_at text,
		order_delivered_carrier_date text,
		order_delivered_customer_date text,
		order_estimated_delivery_date text,
		delivery_delay_days text,
		is_late text
)

--importamos


--creamos tabla orders
create table orders (
		order_id text,
		customer_id text,
		order_status text,
		order_purchase_timestamp timestamp,
		order_approved_at timestamp,
		order_delivered_carrier_date timestamp,
		order_delivered_customer_date timestamp,
		order_estimated_delivery_date timestamp,
		delivery_delay_days float,
		is_late boolean
)

-- pasamos los datos limpios
insert into orders 
select  order_id,
		customer_id,
		order_status,
		order_purchase_timestamp::timestamp,
		order_approved_at::timestamp,
		order_delivered_carrier_date::timestamp,
		order_delivered_customer_date::timestamp,
		order_estimated_delivery_date::timestamp,
		delivery_delay_days::float,
		is_late::boolean
from orders_raw;
