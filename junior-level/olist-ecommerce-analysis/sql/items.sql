--creamos tabla cruda
create table items_raw (
		order_id text,
  		order_item_id text,
  		product_id text,
  		seller_id text,
  		shipping_limit_date text,
  		price text,
  		freight_value text
)

--importamos

--creamos tabla items
create table items (
		order_id text,
  		order_item_id int,
  		product_id text,
  		seller_id text,
  		shipping_limit_date timestamp,
  		price float,
  		freight_value float
)


-- pasamos los datos limpios
insert into items
select 	order_id,
  		order_item_id::int,
  		product_id,
  		seller_id,
  		shipping_limit_date::timestamp,
  		price::float,
  		freight_value::float
from items_raw;
drop table items_raw;
