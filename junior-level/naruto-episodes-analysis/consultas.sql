-- 1) what are the top 10 highest-rated episodes?
create view top10_highest_rated_episodes as
select
    title,
    rate
from naruto
order by rate desc
limit 10;


-- 2) is there a relationship between rating and number of votes?
create view rating_votes_relationship as
select
    type,
    rate,
    votes
from naruto;


-- 3) which saga has the highest average rating?
create view saga_highest_avg_rating as
select
    saga,
    round(avg(rate), 2) as avg_rate
from naruto
group by saga
order by avg_rate desc
limit 1;


-- 4) which saga has the lowest average rating?
create view saga_lowest_avg_rating as
select
    saga,
    round(avg(rate), 2) as avg_rate
from naruto
group by saga
order by avg_rate asc
limit 1;


-- 5) average rating by saga and release year (exploratory)
create view avg_rating_by_saga_year as
select
    saga,
    year_launch,
    round(avg(rate), 2) as avg_rate
from naruto
group by saga, year_launch
order by year_launch;


-- 6) how does the average rating evolve over time?
create view avg_rating_per_year as
select
    year_launch,
    round(avg(rate), 2) as avg_rate
from naruto
group by year_launch
order by year_launch;


-- 7) are there significant differences between canon and filler episodes?
create view canon_vs_filler_comparison as
select
    type,
    count(*) as episode_count,
    round(avg(rate), 2) as avg_rating,
    round(avg(votes), 2) as avg_votes
from naruto
where type in ('Manga Canon', 'Filler', 'Mixed Canon/Filler')
group by type
order by type;

