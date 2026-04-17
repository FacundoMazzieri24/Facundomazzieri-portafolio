--creamos tabla raw
create table  category_translation_raw(
  		product_category_name text,
  		product_category_name_english text
)

--importamos csv

--creamos tabla category_traslation
create table category_translation(
  		product_category_name text,
  		product_category_name_english text
)

--pasamos datos limpios
insert into category_translation
select product_category_name,
  		product_category_name_english
from category_translation_raw;
drop table category_translation_raw;