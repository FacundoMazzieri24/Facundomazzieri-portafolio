-- creamos tabla cruda
create table products_raw(
		product_id text,
  		product_category_name text,
  		product_name_lenght text,
  		product_description_lenght text,
  		product_photos_qty text,
  		product_weight_g text,
  		product_length_cm text,
  		product_height_cm text,
 		product_width_cm text
)

-- importamos csv

--creamos tabla products
create table products(
		product_id text,
 		product_category_name text,
  		product_name_lenght float,
  		product_description_lenght float,
  		product_photos_qty float,
  		product_weight_g float,
  		product_length_cm float,
  		product_height_cm float,
  		product_width_cm float

)

-- pasamos datos limpios 
insert into products
select 	product_id,
 		product_category_name,
  		product_name_lenght::float,
  		product_description_lenght::float,
  		product_photos_qty::float,
  		product_weight_g::float,
  		product_length_cm::float,
  		product_height_cm::float,
  		product_width_cm::float
from products_raw;
drop table products_raw;
