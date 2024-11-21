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
SELECT MIN(year_birth) as oldest_year,
MAX(year_birth) as youngest_year,
2024-MIN(year_birth) as oldest,
2024-MAX(year_birth) as youngest,
MAX(year_birth)-MIN(year_birth) as age_span,
ROUND(2024-AVG(year_birth),0) as average_age
FROM customers;

-- [5] QUERY TABLE FOR MOST COMMON BIRTH YEAR
SELECT year_birth, COUNT(year_birth) AS count
FROM customers
GROUP BY year_birth
ORDER BY count DESC
LIMIT 5;

-- [5] QUERY TABLE FOR LEAST COMMON BIRTH YEAR
SELECT year_birth, COUNT(year_birth) AS count
FROM customers
GROUP BY year_birth
ORDER BY count ASC
LIMIT 5;