--creamos tabla raw
create table customers_raw (
		 customer_id text,
		 customer_unique_id text,
		 customer_zip_code_prefix text,
		 customer_city text,
		 customer_state text
)

--importamos tabla

--creamos tabla customer
create table customers (
		 customer_id text,
		 customer_unique_id text,
		 customer_zip_code_prefix int,
		 customer_city text,
		 customer_state text
)

--pasamos los datos limpios
insert into customers 
select customer_id,
		 customer_unique_id,
		 customer_zip_code_prefix::int,
		 customer_city,
		 customer_state
from customers_raw;
drop table customers_raw;
