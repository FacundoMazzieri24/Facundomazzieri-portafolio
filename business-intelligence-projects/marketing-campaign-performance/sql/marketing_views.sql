-- views

-- base view: full marketing dataset
create view vw_marketing_base as
select *
from tablamkt;


-- 1) which companies generate the highest volume of impressions and clicks,
--    and how does their performance compare (ctr / roi)?
-- 2) which companies generate the lowest volume of impressions and clicks,
--    and how does their performance compare (ctr / roi)?
create view vw_company_performance as
select
    company,
    sum(clicks) as total_clicks,
    sum(impressions) as total_impressions,
    round(sum(clicks)::numeric / sum(impressions), 4) as ctr,
    round(avg(roi), 2) as avg_roi
from tablamkt
group by company;


-- 3) are there significant differences in roi between campaign types?
create view vw_campaign_roi as
select
    campaign_type,
    round(avg(roi), 3) as avg_roi
from tablamkt
group by campaign_type;


-- 4) how does click and impression performance vary across marketing channels?
create view vw_channel_performance as
select
    channel_used,
    round(sum(clicks)::numeric / sum(impressions), 4) as ctr
from tablamkt
group by channel_used;


-- 5) how does campaign performance evolve over time
--    in terms of clicks, impressions, and roi?
create view vw_campaign_time_performance as
select
    campaign_type,
    round(sum(clicks)::numeric / sum(impressions), 4) as ctr,
    round(avg(roi), 3) as avg_roi,
    date
from tablamkt
group by campaign_type, date;


-- 6) which are the top 3 campaigns with the highest roi?
create view vw_campaign_roi_ranking as
select
    campaign_type,
    round(avg(roi), 3) as avg_roi
from tablamkt
group by campaign_type;


-- 7) which company has the highest customer acquisition cost (cac)?
--    cac = acquisition cost / number of customers
create view vw_company_cac as
select
    company,
    round(sum(acquisition_cost) / count(customer_segment), 2) as cac
from tablamkt
group by company;


-- 8) which customer segments show the highest response
--    in terms of clicks and impressions, and how efficient are they (ctr)?
create view vw_customer_segment_performance as
select
    customer_segment,
    sum(clicks) as total_clicks,
    sum(impressions) as total_impressions,
    round(sum(clicks)::numeric / sum(impressions), 5) as ctr
from tablamkt
group by customer_segment;


-- 9) is there a relationship between language and geographic location
--    with the volume of campaign impressions?
create view vw_language_location_impressions as
select
    campaign_type,
    language,
    location,
    sum(impressions) as total_impressions
from tablamkt
group by campaign_type, language, location;
