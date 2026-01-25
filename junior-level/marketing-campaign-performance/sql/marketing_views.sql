-- VIEWS

-- Base view: full marketing dataset
CREATE VIEW vw_marketing_base AS
SELECT *
FROM tablamkt;


-- 1) Which companies generate the highest volume of impressions and clicks,
--    and how does their performance compare (CTR / ROI)?
-- 2) Which companies generate the lowest volume of impressions and clicks,
--    and how does their performance compare (CTR / ROI)?
CREATE VIEW vw_company_performance AS
SELECT
    company,
    SUM(clicks) AS total_clicks,
    SUM(impressions) AS total_impressions,
    ROUND(SUM(clicks)::numeric / SUM(impressions), 4) AS ctr,
    ROUND(AVG(roi), 2) AS avg_roi
FROM tablamkt
GROUP BY company;


-- 3) Are there significant differences in ROI between campaign types?
CREATE VIEW vw_campaign_roi AS
SELECT
    campaign_type,
    ROUND(AVG(roi), 3) AS avg_roi
FROM tablamkt
GROUP BY campaign_type;


-- 4) How does click and impression performance vary across marketing channels?
CREATE VIEW vw_channel_performance AS
SELECT
    channel_used,
    ROUND(SUM(clicks)::numeric / SUM(impressions), 4) AS ctr
FROM tablamkt
GROUP BY channel_used;


-- 5) How does campaign performance evolve over time
--    in terms of clicks, impressions, and ROI?
CREATE VIEW vw_campaign_time_performance AS
SELECT
    campaign_type,
    ROUND(SUM(clicks)::numeric / SUM(impressions), 4) AS ctr,
    ROUND(AVG(roi), 3) AS avg_roi,
    date
FROM tablamkt
GROUP BY campaign_type, date;


-- 6) Which are the top 3 campaigns with the highest ROI?
CREATE VIEW vw_campaign_roi_ranking AS
SELECT
    campaign_type,
    ROUND(AVG(roi), 3) AS avg_roi
FROM tablamkt
GROUP BY campaign_type;


-- 7) Which company has the highest customer acquisition cost (CAC)?
--    CAC = Acquisition Cost / Number of Customers
CREATE VIEW vw_company_cac AS
SELECT
    company,
    ROUND(SUM(acquisition_cost) / COUNT(customer_segment), 2) AS cac
FROM tablamkt
GROUP BY company;


-- 8) Which customer segments show the highest response
--    in terms of clicks and impressions, and how efficient are they (CTR)?
CREATE VIEW vw_customer_segment_performance AS
SELECT
    customer_segment,
    SUM(clicks) AS total_clicks,
    SUM(impressions) AS total_impressions,
    ROUND(SUM(clicks)::numeric / SUM(impressions), 5) AS ctr
FROM tablamkt
GROUP BY customer_segment;


-- 9) Is there a relationship between language and geographic location
--    with the volume of campaign impressions?
CREATE VIEW vw_language_location_impressions AS
SELECT
    campaign_type,
    language,
    location,
    SUM(impressions) AS total_impressions
FROM tablamkt
GROUP BY campaign_type, language, location;
