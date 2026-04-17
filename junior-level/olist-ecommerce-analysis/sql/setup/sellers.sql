-- creamos tabla base 
create table sellers_raw(
		seller_id text,
 		seller_zip_code_prefix text,
  		seller_city text,
  		seller_state text
)

--importamos csv

--creamos tabla sellers
create table sellers(
		seller_id text,
 		seller_zip_code_prefix int,
  		seller_city text,
  		seller_state text
)

-- pasamos datos limpios
insert into sellers
select	seller_id,
 		seller_zip_code_prefix::int,
  		seller_city,
  		seller_state
from sellers_raw;
drop table sellers_raw;
