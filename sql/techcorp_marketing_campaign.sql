-- Which campaign + channel combinations have the strongest conversion rates?

SELECT 
    Campaign_Type, 
    Channel_Used, 
    AVG(Conversion_Rate) as Avg_Conversion_Rate 
FROM techcorp_marketing_campaign 
GROUP BY Campaign_Type, Channel_Used 
ORDER BY Avg_Conversion_Rate 
DESC LIMIT 1;

-- Which campaign + channel combinations perform best for each target audience?

WITH CampaignPerformance AS (
    SELECT 
        Target_Audience, 
        Campaign_Type, 
        Channel_Used, 
        AVG(Conversion_Rate) * 100 as Avg_Conversion_Rate
    FROM techcorp_marketing_campaign 
    GROUP BY Campaign_Type, Channel_Used, Target_Audience
),
BestAudiencePerformance AS (
    SELECT
        Target_Audience,
        MAX(Avg_Conversion_Rate) as Max_Conversion_Rate
    FROM CampaignPerformance 
    GROUP BY Target_Audience
)
SELECT 
        p.Target_Audience, 
        p.Campaign_Type, 
        p.Channel_Used, 
        p.Avg_Conversion_Rate
FROM CampaignPerformance p
JOIN BestAudiencePerformance b
    ON p.Target_Audience = b.Target_Audience 
    AND p.Avg_Conversion_Rate = b.Max_Conversion_Rate
ORDER BY p.Target_Audience, p.Avg_Conversion_Rate DESC;

-- Which channels generate the strongest click-through rates?

SELECT 
    Channel_Used, 
    SUM(Clicks)/SUM(Impressions) * 100 AS CTR
FROM techcorp_marketing_campaign 
GROUP BY Channel_Used
ORDER BY CTR DESC
LIMIT 1;

-- Which customer segments show stronger campaign engagement?

SELECT 
    Customer_Segment, 
    Channel_Used, 
    AVG(Engagement_Score) AS Avg_Engagement_Score 
FROM techcorp_marketing_campaign 
GROUP BY Customer_Segment, Channel_Used 
ORDER BY Avg_Engagement_Score DESC
LIMIT 1;

-- Which target audiences show stronger conversion performance

SELECT 
    Target_Audience, 
    AVG(Conversion_Rate) * 100 AS Avg_Conversion_Rate 
FROM techcorp_marketing_campaign 
GROUP BY Target_Audience 
ORDER BY Avg_Conversion_Rate DESC 
LIMIT 1;
