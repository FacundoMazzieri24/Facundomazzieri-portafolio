-- analytical queries

-- 1) which companies generate the highest volume of impressions and clicks,
--    and how does their performance compare (ctr / roi)?
--    ctr = clicks / impressions
select
    company,
    sum(clicks) as total_clicks,
    sum(impressions) as total_impressions,
    round(sum(clicks)::numeric / sum(impressions), 4) as ctr,
    round(avg(roi), 2) as avg_roi
from tablamkt
group by company
order by total_impressions desc, total_clicks desc;


-- 2) which companies generate the lowest volume of impressions and clicks,
--    and how does their performance compare (ctr / roi)?
--    ctr = clicks / impressions
select
    company,
    sum(clicks) as total_clicks,
    sum(impressions) as total_impressions,
    round(sum(clicks)::numeric / sum(impressions), 4) as ctr,
    round(avg(roi), 3) as avg_roi
from tablamkt
group by company
order by total_impressions asc, total_clicks asc;


-- 3) are there significant differences in roi between campaign types?
select
    campaign_type,
    round(avg(roi), 3) as avg_roi
from tablamkt
group by campaign_type
order by avg_roi desc;


-- 4) how does click and impression performance vary across marketing channels?
select
    channel_used,
    round(sum(clicks)::numeric / sum(impressions), 4) as ctr
from tablamkt
group by channel_used
order by ctr desc;


-- 5) how does campaign performance evolve over time
--    in terms of clicks, impressions, and roi?
select
    campaign_type,
    round(sum(clicks)::numeric / sum(impressions), 4) as ctr,
    round(avg(roi), 3) as avg_roi,
    date
from tablamkt
group by campaign_type, date
order by date asc;


-- 6) which are the top 3 campaigns with the highest roi?
select
    campaign_type,
    round(avg(roi), 3) as avg_roi
from tablamkt
group by campaign_type
order by avg_roi desc
limit 3;


-- 7) which company has the highest customer acquisition cost (cac)?
--    cac = acquisition cost / number of customers
select
    company,
    round(sum(acquisition_cost) / count(customer_segment), 2) as cac
from tablamkt
group by company
order by cac desc
limit 1;


-- 8) which customer segments show the highest response
--    in terms of clicks and impressions, and how efficient are they (ctr)?
select
    customer_segment,
    sum(clicks) as total_clicks,
    sum(impressions) as total_impressions,
    round(sum(clicks)::numeric / sum(impressions), 5) as ctr
from tablamkt
group by customer_segment
order by total_impressions desc, total_clicks desc, ctr desc;


-- 9) is there a relationship between language and geographic location
--    with the volume of campaign impressions?
select
    campaign_type,
    language,
    location,
    sum(impressions) as total_impressions
from tablamkt
group by campaign_type, language, location
order by total_impressions desc;
