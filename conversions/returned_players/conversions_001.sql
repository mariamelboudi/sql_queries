-- [1] Query column names
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'conversions';

-- [2] Query records and duplicates
SELECT COUNT(userid), COUNT(DISTINCT(userid))
FROM conversions;

-- [4] Gate distribution
SELECT
    COUNT(CASE WHEN version = 'gate_30' THEN 1 END) AS gate30_users,
	COUNT(CASE WHEN version = 'gate_40' THEN 1 END) AS gate40_users,
    
    -- Proportion of users with gate_30
    ROUND(AVG(CASE WHEN version = 'gate_30' THEN 1 ELSE 0 END) * 100, 2) AS gate30,
    
    -- Proportion of users retained on day 7
    ROUND(AVG(CASE WHEN  version = 'gate_40' THEN 1 ELSE 0 END) * 100, 2) AS gate40
FROM conversions;

-- [5] Overall descriptive statistics
SELECT
    COUNT(sum_gamerounds) AS total_entries,
    SUM(sum_gamerounds) AS total_gamerounds,
    ROUND(AVG(sum_gamerounds), 0) AS avg_gamerounds,
    MIN(sum_gamerounds) AS min_gamerounds,
    MAX(sum_gamerounds) AS max_gamerounds,
    ROUND(STDDEV(sum_gamerounds), 0) AS stddev_gamerounds,

    -- First quartile (25th percentile), cast to numeric and rounded to 2 decimal places
    ROUND(CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 0) AS Q1_gamerounds,
	
	-- Median (50th percentile), cast to numeric and rounded to 2 decimal places
	ROUND(CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 0) AS median_gamerounds,
    
	-- Third quartile (75th percentile), cast to numeric and rounded to 2 decimal places
    ROUND(CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 0) AS Q3_gamerounds,

    -- Interquartile range (IQR), cast to numeric and rounded to 2 decimal places
    ROUND(CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY sum_gamerounds)
         - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 2) AS IQR_gamerounds

FROM conversions;

-- [6] Descriptive statistics for each version
SELECT
	version,
    COUNT(sum_gamerounds) AS total_entries,
    SUM(sum_gamerounds) AS total_gamerounds,
    ROUND(AVG(sum_gamerounds), 0) AS avg_gamerounds,
    MIN(sum_gamerounds) AS min_gamerounds,
    MAX(sum_gamerounds) AS max_gamerounds,
    ROUND(STDDEV(sum_gamerounds), 0) AS stddev_gamerounds,

    -- First quartile (25th percentile), cast to numeric and rounded to 2 decimal places
    ROUND(CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 0) AS Q1_gamerounds,
	
	-- Median (50th percentile), cast to numeric and rounded to 2 decimal places
	ROUND(CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 0) AS median_gamerounds,
    
	-- Third quartile (75th percentile), cast to numeric and rounded to 2 decimal places
    ROUND(CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 0) AS Q3_gamerounds,

    -- Interquartile range (IQR), cast to numeric and rounded to 2 decimal places
    ROUND(CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY sum_gamerounds)
         - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY sum_gamerounds) AS NUMERIC), 2) AS IQR_gamerounds

FROM conversions
GROUP BY version;

-- [7] Overall return at day 1 and/or day 7
SELECT
    COUNT(userid) AS total_users,
    
    -- Proportion of users retained on day 1
    ROUND(AVG(CASE WHEN retention_1 = TRUE THEN 1 ELSE 0 END) * 100, 2) AS retention_1_percentage,
    
    -- Proportion of users retained on day 7
    ROUND(AVG(CASE WHEN retention_7 = TRUE THEN 1 ELSE 0 END) * 100, 2) AS retention_7_percentage
	
FROM conversions;

-- [8] Overall return at day 1 AND 7
SELECT
    COUNT(userid) AS total_users,
    
    -- Proportion of users retained on both day 1 and day 7
    ROUND(AVG(CASE 
        WHEN retention_1 = TRUE AND retention_7 = TRUE THEN 1 ELSE 0 END) * 100, 2) AS return_both_days_percentage
    
FROM conversions;

-- [10] Overall return at day 1 and/or day 7 for each version
SELECT
    version,
    
    -- Proportion of users retained on day 1
    ROUND(AVG(CASE WHEN retention_1 = TRUE THEN 1 ELSE 0 END) * 100, 2) AS retention_1_percentage,
    
    -- Proportion of users retained on day 7
    ROUND(AVG(CASE WHEN retention_7 = TRUE THEN 1 ELSE 0 END) * 100, 2) AS retention_7_percentage
	
FROM conversions
GROUP BY version;

-- [11] Overall return at day 1 AND 7
SELECT
    version,
    
    -- Proportion of users retained on both day 1 and day 7
    ROUND(AVG(CASE WHEN retention_1 = True AND retention_7 = True THEN 1 ELSE 0 END) * 100, 2) AS return_both_days_percentage
    
FROM conversions
GROUP BY version;

-- [13] Do people who return on day 1 have a higher chance of returning on day 7 ?
SELECT
    ROUND(COUNT(CASE WHEN retention_1 = True THEN 1 END) * 1.0 / COUNT(*), 2) AS day_1_retention_probability,
    -- Probability of returning on day 7 given that they returned on day 1 (conditional probability)
    ROUND(
        COUNT(CASE WHEN retention_1 = True AND retention_7 = True THEN 1 END) * 1.0 
        / NULLIF(COUNT(CASE WHEN retention_1 = True THEN 1 END), 0), 
    2) AS day_7_given_day_1_retention_probability
FROM conversions;

-- [14] Same question, grouped by versions
SELECT
    version,
    -- Probability of returning on day 1 (as a decimal)
    ROUND(COUNT(CASE WHEN retention_1 = True THEN 1 END) * 1.0 / COUNT(*), 2) AS day_1_retention_probability,

    -- Probability of returning on day 7 given that they returned on day 1 (conditional probability)
    ROUND(
        COUNT(CASE WHEN retention_1 = True AND retention_7 = True THEN 1 END) * 1.0 
        / NULLIF(COUNT(CASE WHEN retention_1 = True THEN 1 END), 0), 
    2) AS day_7_given_day_1_retention_probability
FROM conversions
GROUP BY version;

-- [15] Player return and sum game rounds