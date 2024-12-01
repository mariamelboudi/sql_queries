-- [1] Query table to count rows
SELECT COUNT(id)
FROM customers;

-- [2] Query table to count duplicates
SELECT COUNT(DISTINCT(id)) - COUNT(id) as duplicates
FROM customers;

-- [3] Query table to count missing values
SELECT 
    COUNT(CASE WHEN year_birth IS NULL THEN 1 END) AS year_birth_null,
    COUNT(CASE WHEN education IS NULL THEN 1 END) AS education_null,
	COUNT(CASE WHEN marital_status IS NULL THEN 1 END) AS marital_status,
	COUNT(CASE WHEN income IS NULL THEN 1 END) AS income_null,
	COUNT(CASE WHEN kidhome IS NULL THEN 1 END) AS kidhome_null,
	COUNT(CASE WHEN teenhome IS NULL THEN 1 END) AS teenhome_null,
	COUNT(CASE WHEN dt_customer IS NULL THEN 1 END) AS dt_customer_null,
	COUNT(CASE WHEN recency IS NULL THEN 1 END) AS recency_null,
	COUNT(CASE WHEN mntwines IS NULL THEN 1 END) AS mntwines_null,
	COUNT(CASE WHEN mntfruits IS NULL THEN 1 END) AS mntfruits_null,
	COUNT(CASE WHEN mntmeatproducts IS NULL THEN 1 END) AS mntmeatproducts_null,
	COUNT(CASE WHEN mntfishproducts IS NULL THEN 1 END) AS mntfishproducts_null,
	COUNT(CASE WHEN mntsweetproducts IS NULL THEN 1 END) AS mntsweetproducts_null,
	COUNT(CASE WHEN mntgoldprods IS NULL THEN 1 END) AS mntgoldprods_null,
	COUNT(CASE WHEN numdealspurchases IS NULL THEN 1 END) AS deals_null,
	COUNT(CASE WHEN numwebpurchases IS NULL THEN 1 END) AS webpurchases_null,
	COUNT(CASE WHEN numcatalogpurchases IS NULL THEN 1 END) AS catpurchases_null,
	COUNT(CASE WHEN numstorepurchases IS NULL THEN 1 END) AS storepurchase_null,
	COUNT(CASE WHEN numwebvisitsmonth IS NULL THEN 1 END) AS webvisit_null,
	COUNT(CASE WHEN complain IS NULL THEN 1 END) AS complain_null
FROM 
    customers;
	
/* DELETE MISSING VALUES
DELETE FROM customers
WHERE income IS NULL;*/

-- RUN PREVIOUS QUERY AGAIN TO VERIFY

-- [4] QUERY TABLE FOR AGES
SELECT
	MIN(year_birth) as oldest_year,
	MAX(year_birth) as youngest_year,
	2024-MIN(year_birth) as oldest,
	2024-MAX(year_birth) as youngest,
	MAX(year_birth)-MIN(year_birth) as age_span,
	ROUND(2024-AVG(year_birth),0) as average_age
FROM customers;

-- [5] QUERY TABLE FOR MOST COMMON BIRTH YEAR
SELECT
	year_birth,
	COUNT(year_birth) AS count
FROM customers
GROUP BY year_birth
ORDER BY count DESC
LIMIT 5;

-- [5] QUERY TABLE FOR LEAST COMMON BIRTH YEAR
SELECT
	year_birth,
	COUNT(year_birth) AS count
FROM customers
GROUP BY year_birth
ORDER BY count ASC
LIMIT 5;

/*[6.1.] CREATE AGE COLUMN
ALTER TABLE customers
ADD age INT;

[6.2.] CALCULATE AGE AND ADD TO COLUMN
UPDATE customers
SET age = 2024-year_birth;

[6.3.] CREATE AGE GROUPS COLUMN
ALTER TABLE customers
ADD age_group VARCHAR(20);

[6.4.] CREATE AGE GROUPS
UPDATE customers
SET age_group = CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 29 THEN 'twenties'
    WHEN age BETWEEN 30 AND 39 THEN 'thirties'
    WHEN age BETWEEN 40 AND 49 THEN 'fourties'
    WHEN age BETWEEN 50 AND 59 THEN 'fifties'
    ELSE 'seniors'
END;*/

-- [6.5.] QUERY FOR AGE GROUP FREQUENCY
SELECT
    age_group,
    COUNT(age_group) AS group_count,
    ROUND(COUNT(age_group) * 100.0 / (SELECT COUNT(*) FROM customers),2) AS proportion
FROM customers
GROUP BY age_group
ORDER BY group_count DESC;

-- [7] QUERY FOR MARITAL STATUS TYPE AND DISTRIBUTION
SELECT
    marital_status,
    COUNT(marital_status) AS status_count,
    ROUND(COUNT(marital_status) * 100.0 / (SELECT COUNT(*) FROM customers),2) AS proportion
FROM customers
GROUP BY marital_status
ORDER BY status_count DESC;

/*SELECT COUNT(marital_status)
FROM customers
WHERE marital_status='YOLO' OR marital_status= 'Absurd';

DELETE VALUES
DELETE FROM customers
WHERE marital_status='YOLO' OR marital_status= 'Absurd';

MERGE ALONE WITH SINGLE
UPDATE customers
SET marital_status = 'Single'
WHERE marital_status = 'Alone';

VERIFY THE UPDATE
SELECT *
FROM customers
WHERE marital_status = 'Alone';*/

-- [8] QUERY FOR MARITAL STATUS TYPE AND DISTRIBUTION
SELECT
    education,
	COUNT(education) AS count,
    ROUND(COUNT(education) * 100.0 / (SELECT COUNT(*) FROM customers),2) AS proportion
FROM customers
GROUP BY education
ORDER BY count DESC;

-- [8.1.] QUERY FOR EDUCATION LEVEL AND DISTRIBUTION
SELECT
    education,
	age_group,
	COUNT(age_group)
FROM customers
GROUP BY age_group, education
ORDER BY education;

-- [8.2.] QUERY FOR EDUCATION LEVEL DISTRIBUTION AMONGST AGE GROUPS
SELECT
    education,
    ROUND(COUNT(CASE WHEN age_group = 'twenties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "twenties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'thirties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "thirties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'fourties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "fourties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'fifties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "fifties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'seniors' THEN 1 END) * 100.0 / COUNT(*), 2) AS "seniors_percent"
FROM customers
GROUP BY education
ORDER BY education;

-- [8.3.] QUERY FOR EDUCATION LEVEL AND DISTRIBUTION AMONGST MARITAL STATUSES
SELECT
    education,
    ROUND(COUNT(CASE WHEN age_group = 'twenties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "twenties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'thirties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "thirties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'fourties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "fourties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'fifties' THEN 1 END) * 100.0 / COUNT(*), 2) AS "fifties_percent",
    ROUND(COUNT(CASE WHEN age_group = 'seniors' THEN 1 END) * 100.0 / COUNT(*), 2) AS "seniors_percent"
FROM customers
GROUP BY education
ORDER BY education;

-- [8.3.] QUERY FOR EDUCATION LEVEL AND DISTRIBUTION AMONGST MARITAL STATUSES
SELECT
    education,
    ROUND(COUNT(CASE WHEN marital_status = 'Together' THEN 1 END) * 100.0 / COUNT(*), 2) AS "Together",
    ROUND(COUNT(CASE WHEN marital_status = 'Married' THEN 1 END) * 100.0 / COUNT(*), 2) AS "Married",
    ROUND(COUNT(CASE WHEN marital_status = 'Widow' THEN 1 END) * 100.0 / COUNT(*), 2) AS "Widow",
    ROUND(COUNT(CASE WHEN marital_status = 'Divorced' THEN 1 END) * 100.0 / COUNT(*), 2) AS "Divorced",
    ROUND(COUNT(CASE WHEN marital_status = 'Single' THEN 1 END) * 100.0 / COUNT(*), 2) AS "Single"
FROM customers
GROUP BY education
ORDER BY education;

-- [9] QUERY FOR SUMMARY STATISTICS OF INCOME
SELECT
    MIN(income) AS "Min_Income",
    MAX(income) AS "Max_Income",
    ROUND(AVG(income),2) AS "Avg_Income",
    ROUND(STDDEV(income),2) AS "StdDev_Income",
    (SELECT income 
     FROM customers 
     ORDER BY income 
     LIMIT 1 OFFSET (SELECT FLOOR(COUNT(*) / 2) FROM customers)) AS "Median_Income"
FROM customers;

-- [9.1.] QUERY FOR SUMMARY STATISTICS OF INCOME AMONGST MARITAL STATUSES
SELECT
    marital_status,
    MIN(income) AS "Min_Income",
    MAX(income) AS "Max_Income",
    ROUND(AVG(income), 2) AS "Avg_Income",
    ROUND(STDDEV(income), 2) AS "StdDev_Income",
    (SELECT income 
     FROM customers AS sub
     WHERE sub.marital_status = c.marital_status
     ORDER BY income
     LIMIT 1 OFFSET (SELECT FLOOR(COUNT(*) / 2) 
                     FROM customers AS sub2
                     WHERE sub2.marital_status = c.marital_status)) AS "Median_Income"
FROM customers AS c
GROUP BY marital_status;

-- [9.2.] QUERY FOR SUMMARY STATISTICS OF INCOME AMONGST EDUCATION LEVEL
SELECT
    education,
    MIN(income) AS "Min_Income",
    MAX(income) AS "Max_Income",
    ROUND(AVG(income), 2) AS "Avg_Income",
    ROUND(STDDEV(income), 2) AS "StdDev_Income",
    (SELECT income 
     FROM customers AS sub
     WHERE sub.education = c.education
     ORDER BY income
     LIMIT 1 OFFSET (SELECT FLOOR(COUNT(*) / 2) 
                     FROM customers AS sub2
                     WHERE sub2.education = c.education)) AS "Median_Income"
FROM customers AS c
GROUP BY education;

-- [10] QUERY FOR CHILDREN AT HOME
SELECT
	COUNT(CASE WHEN kidhome > 0 THEN 1 END) AS "with_kids",
	ROUND(COUNT(CASE WHEN kidhome > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS "with_kids_pct",
	
	COUNT(CASE WHEN teenhome > 0 THEN 1 END) AS "with_teens",
	ROUND(COUNT(CASE WHEN teenhome > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS "with_teens_pct",
	
	COUNT(CASE WHEN kidhome > 0 AND teenhome = 0 THEN 1 END) AS "kids_only",
	ROUND(COUNT(CASE WHEN kidhome > 0 AND teenhome = 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS "kids_only_pct",
	
	COUNT(CASE WHEN teenhome > 0 AND kidhome = 0 THEN 1 END) AS "teens_only",
	ROUND(COUNT(CASE WHEN teenhome > 0 AND kidhome = 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS "teens_only_pct",
	
	COUNT(CASE WHEN teenhome > 0 AND kidhome > 0 THEN 1 END) AS "both",
	ROUND(COUNT(CASE WHEN teenhome > 0 AND kidhome > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS "both_pct",
	
	COUNT(CASE WHEN teenhome = 0 AND kidhome = 0 THEN 1 END) AS "no_children",
	ROUND(COUNT(CASE WHEN teenhome = 0 AND kidhome = 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS "no_children_pct"
FROM customers;
