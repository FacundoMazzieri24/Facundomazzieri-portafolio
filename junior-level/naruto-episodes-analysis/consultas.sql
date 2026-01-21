select * from naruto
--1)¿Cuáles son los Top 10 episodios con mayor rating?
create view top10_episodios_mayor_rating
as
select title,
	   rate
from naruto
order by rate desc
limit 10;

--2)¿Existe relación entre rating y cantidad de votos?
create view relacion_rating_votes
as 
select type,
	   rate,
	   votes
from naruto
order by rate,votes


--3)¿Qué saga presenta el rating promedio más alto?
create view saga_promedio_mas_alto
as
select saga,
	   round(avg(rate),2) as rating_mas_alto
from naruto
group by saga
order by rating_mas_alto desc
limit 1;


--4)¿Qué saga presenta el rating promedio más bajo?
create view saga_promedio_mas_bajo
as
select saga,
	   round(avg(rate),2) as rating_mas_bajo
from naruto
group by saga
order by rating_mas_bajo asc
limit 1;


--5)¿Cuál es la tendencia del rating a lo largo de las sagas/temporadas?
create view tendencia_rating_sagas
as
select round(avg(rate),2) as rate,
	   saga,
	   year_launch
from naruto
group by saga,year_launch
order by year_launch


--6)¿Cómo evoluciona el rating promedio por año?
create view evolucion_rating_promedio_año
as
select round(avg(rate),2) as rate,
	   year_launch
from naruto
group by year_launch
order by year_launch



--7)¿Existen diferencias significativas entre episodios canon y filler en rating y votos?
create view diferencias_canon_filler
as
select type,
	   count(*) as cantidad_episodios,
	   round(avg(rate),2) as rating_promedio,
	   round(avg(votes),2) as votes_promedio
from naruto
where type in ('Manga Canon', 'Filler', 'Mixed Canon/Filler')
group by type
order by type;
