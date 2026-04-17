-- creamos tabla cruda
create table geolocation_raw(
		geolocation_zip_code_prefix text,
	  	geolocation_lat text,
	  	geolocation_lng text,
  		geolocation_city text,
  		geolocation_state text
)

-- importamos csv

--creamos tabla geolocation
create table geolocation(
		geolocation_zip_code_prefix int,
	  	geolocation_lat float,
	  	geolocation_lng float,
  		geolocation_city text,
  		geolocation_state text
)

-- pasamos datos limpios
insert into geolocation
select 	geolocation_zip_code_prefix::int,
	  	geolocation_lat::float,
	  	geolocation_lng::float,
  		geolocation_city,
  		geolocation_state
from geolocation_raw;
drop table geolocation_raw;