-- ANALYTICAL QUERIES

-- 1) Which companies generate the highest volume of impressions and clicks,
--    and how does their performance compare (CTR / ROI)?
--    CTR = Clicks / Impressions
SELECT company,
       SUM(clicks) AS total_clicks,
       SUM(impressions) AS total_impressions,
       ROUND(SUM(clicks)::numeric / SUM(impressions), 4) AS ctr,
       ROUND(AVG(roi), 2) AS avg_roi
FROM tablamkt
GROUP BY company
ORDER BY total_impressions DESC, total_clicks DESC;


-- 2) Which companies have the lowest volume of impressions and clicks,
--    and how does their performance compare (CTR / ROI)?
--    CTR = Clicks / Impressions
SELECT company,
       SUM(clicks) AS total_clicks,
       SUM(impressions) AS total_impressions,
       ROUND(SUM(clicks)::numeric / SUM(impressions), 4) AS ctr,
       ROUND(AVG(roi), 3) AS avg_roi
FROM tablamkt
GROUP BY company
ORDER BY total_impressions ASC, total_clicks ASC;


-- 3) Are there significant differences in ROI between campaign types?
SELECT campaign_type,
       ROUND(AVG(roi), 3) AS avg_roi
FROM tablamkt
GROUP BY campaign_type
ORDER BY avg_roi DESC;


-- 4) How does click and impression performance vary across different marketing channels?
SELECT channel_used,
       ROUND(SUM(clicks)::numeric / SUM(impressions), 4) AS ctr
FROM tablamkt
GROUP BY channel_used
ORDER BY ctr DESC;


-- 5) How does campaign performance evolve over time
--    in terms of clicks, impressions, and ROI?
SELECT campaign_type,
       ROUND(SUM(clicks)::numeric / SUM(impressions), 4) AS ctr,
       ROUND(AVG(roi), 3) AS avg_roi,
       date
FROM tablamkt
GROUP BY campaign_type, date
ORDER BY date ASC;


-- 6) Which are the top 3 campaigns with the highest ROI?
SELECT campaign_type,
       ROUND(AVG(roi), 3) AS avg_roi
FROM tablamkt
GROUP BY campaign_type
ORDER BY avg_roi DESC
LIMIT 3;


-- 7) Which company has the highest Customer Acquisition Cost (CAC)?
--    CAC = Acquisition Cost / Number of Customers
SELECT company,
       ROUND(SUM(acquisition_cost) / COUNT(customer_segment), 2) AS cac
FROM tablamkt
GROUP BY company
ORDER BY cac DESC
LIMIT 1;


-- 8) Which customer segments show the highest response
--    in terms of clicks and impressions, and how efficient are they (CTR)?
SELECT customer_segment,
       SUM(clicks) AS total_clicks,
       SUM(impressions) AS total_impressions,
       ROUND(SUM(clicks)::numeric / SUM(impressions), 5) AS ctr
FROM tablamkt
GROUP BY customer_segment
ORDER BY total_impressions DESC, total_clicks DESC, ctr DESC;


-- 9) Is there a relationship between language and geographic location
--    and the volume of campaign impressions?
SELECT campaign_type,
       language,
       location,
       SUM(impressions) AS total_impressions
FROM tablamkt
GROUP BY campaign_type, language, location
ORDER BY total_impressions DESC;
