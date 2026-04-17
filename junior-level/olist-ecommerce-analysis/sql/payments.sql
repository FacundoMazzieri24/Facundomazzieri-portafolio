--creamos tabla cruda
create table payments_raw(
		 order_id text,
 		 payment_sequential text,
  		 payment_type text,
  		 payment_installments text,
 		 payment_value text
)

-- importamos csv

--creamos tabla payments
create table payments(
		 order_id text,
 		 payment_sequential int,
  		 payment_type text,
  		 payment_installments int,
 		 payment_value float
)

-- pasamos datos limpios
insert into payments
select   order_id,
 		 payment_sequential::int,
  		 payment_type,
  		 payment_installments::int,
 		 payment_value::float
from payments_raw;
drop table payments_raw;