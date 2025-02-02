-- UPDATE NULL VALUES WITH AVAILABLE STOCK CODES
UPDATE sales_data
SET description = (
    SELECT description
    FROM sales_data AS sub
    WHERE sales_data.stockcode = sub.stockcode
      AND sub.description IS NOT NULL
    LIMIT 1
)
WHERE description IS NULL;

SELECT stockcode, description
FROM sales_data
GROUP BY 1,2
ORDER BY 1
LIMIT 200;

SELECT stockcode, description
FROM sales_data
WHERE description = 'check'
GROUP BY 1,2
ORDER BY 1
LIMIT 200;

UPDATE sales_data
SET description = (
    SELECT description
    FROM sales_data AS sub
    WHERE sales_data.stockcode = sub.stockcode
      AND sub.description IS NOT NULL
    LIMIT 1
)
WHERE description = 'check';

-- INSPECT WHICH STOCKCODES HAVE MULTIPLE DESCRIPTIONS
SELECT stockcode, COUNT(DISTINCT description) AS count
FROM sales_data
GROUP BY stockcode
HAVING COUNT(DISTINCT description) > 1
ORDER BY stockcode ASC;

-- INSPECT DESCRIPTIONS FOR stockcode 20713
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '20713';

-- INSPECT DESCRIPTIONS FOR stockcode = 23343
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '23343';

--UPDATE DESCRIPTIONS
UPDATE sales_data
SET Description = 'JUMBO BAG OWLS'
WHERE StockCode = '20713' AND (description = 'Found' OR description = 'found' OR description = "Marked as 23343");

-- CHECK
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '23343';

-- BACK UP TABLE
CREATE TABLE sales_data_backup AS
SELECT * FROM sales_data;

-- UPDATE DESCRIPTION WHERE stockcode = 20713	  
UPDATE sales_data
SET description = 'JUMBO BAG OWLS'
WHERE stockcode = '20713' 
  AND (description = 'Found' 
       OR description = 'found' 
       OR description = 'Marked as 23343'
       OR description IS NULL);

-- CHECK
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '20713';

-- UPDATE description AND stockcode FOR REMAINING ITEMS
UPDATE sales_data
SET description = 'JUMBO BAG VINTAGE CHRISTMAS', stockcode = '23343'
WHERE stockcode = '20713' AND description != 'JUMBO BAG OWLS';

-- CHECK
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '20713';

SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '23343';

-- UPDATE description WHERE stockcode = 23343	  
UPDATE sales_data
SET description = 'JUMBO BAG VINTAGE CHRISTMAS '
WHERE stockcode = '23343' 
  AND (description = 'came coded as 20713' 
       OR description = 'wrongly coded 20713' );
	   
-- CHECK
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '23343';

-- UPDATE description AND stockcode FOR REMAINING ITEMS
UPDATE sales_data
SET description = 'JUMBO BAG OWLS', stockcode = '20713'
WHERE stockcode = '23343' AND (description = '20713' OR description = '20713 wrongly marked');

UPDATE sales_data
SET description = TRIM(description)
WHERE stockcode = '23343' AND description IS NOT NULL;

-- CHECK
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '23343';

-- INSPECT DESCRIPTIONS FOR stockcode 20713
SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '20713';

-- UPDATE BACK UP
TRUNCATE TABLE sales_data_backup;
CREATE TABLE sales_data_backup AS
SELECT * FROM sales_data;

-- TRIM WHITESPACES
UPDATE sales_data
SET description = TRIM(description)

-- INSPECT DESCRIPTIONS
SELECT DISTINCT stockcode, description
FROM sales_data
ORDER BY stockcode;

-- FILL IN THE BLANKS
UPDATE sales_data AS main
SET description = (
    SELECT sub.description
    FROM sales_data AS sub
    WHERE sub.stockcode = main.stockcode
      AND sub.description IS NOT NULL
    LIMIT 1
)
WHERE main.description IS NULL;

SELECT COUNT(stockcode)
FROM sales_data
WHERE description IS NULL;

DELETE FROM sales_data
WHERE description = 'damaged';

SELECT COUNT(stockcode)
FROM sales_data
WHERE description IS NULL;

UPDATE sales_data
SET stockcode = UPPER(stockcode);

SELECT DISTINCT description
FROM sales_data
WHERE description = LOWER(description);

SELECT stockcode, description
FROM sales_data
WHERE description = 'code mix up? 84930'

SELECT stockcode, description
FROM sales_data
WHERE description = 'wrong barcode (22467)'

UPDATE sales_data
SET stockcode = '22467'
WHERE stockcode = '22719' AND description = 'wrong barcode (22467)';

SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '22467';

UPDATE sales_data
SET description = 'GUMBALL COAT RACK'
WHERE stockcode = '22467' AND description = 'wrong barcode (22467)';

SELECT DISTINCT description
FROM sales_data
WHERE stockcode = '22467';

SELECT *
FROM sales_data
WHERE description = 'wrongly sold (22719) barcode';

DELETE FROM sales_data
WHERE unitprice = 0;

SELECT COUNT(*)
FROM sales_data
WHERE unitprice = 0;

-- BACK UP TABLE
CREATE TABLE sales_data_backup AS
SELECT * FROM sales_data;

-- CHECK DESCRIPTION FOR TWO CLOSE stockcodes
SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '23235' OR stockcode = '23236';

-- UPDATE DESCRIPTIONS
UPDATE sales_data
SET description = 'LEAF VINTAGE STORAGE TIN'
WHERE stockcode = '23235';

UPDATE sales_data
SET description = 'DOILY VINTAGE STORAGE TIN'
WHERE stockcode = '23236';

UPDATE sales_data
SET description = 'LEAF VINTAGE MAGNETIC NOTEPAD'
WHERE stockcode = '23196';

UPDATE sales_data
SET description = 'ROUND LEAF VINTAGE STORAGE TIN'
WHERE stockcode = '23244';

UPDATE sales_data
SET description = 'ROUND LEAF VINTAGE STORAGE TIN'
WHERE stockcode = '23244';

UPDATE sales_data
SET description = REPLACE(description, ',', '')
WHERE stockcode = '16156L';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '16156L';

UPDATE sales_data
SET description = 'FLOWER FAIRY 5 DRAWER LINERS'
WHERE stockcode = '17107D';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '17107D'

UPDATE sales_data
SET description = 'VIP PASSPORT COVER'
WHERE stockcode = '20622';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '20622';

UPDATE sales_data
SET description = 'RED RETROSPOT LUNCH BAG'
WHERE stockcode = '20725';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '20725';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE description ~* '\w*LID GLASS BOWLS*\w';

UPDATE sales_data
SET description = 'SET/5 RED RETROSPOT LID GLASS BOWLS'
WHERE stockcode = '20914';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '20914';

-- BACK UP TABLE
CREATE TABLE sales_data_backup AS
SELECT * FROM sales_data;

UPDATE sales_data
SET description = REGEXP_REPLACE(description, ',', '')
WHERE stockcode = '21109';

UPDATE sales_data
SET description = REGEXP_REPLACE(description, ',', '')
WHERE stockcode = '21112';

UPDATE sales_data
SET description = REGEXP_REPLACE(description, '\+', 'AND')
WHERE stockcode = '21175';

UPDATE sales_data
SET description = REGEXP_REPLACE(description, 'POT', 'BOX')
WHERE stockcode = '21232';

UPDATE sales_data
SET description = TRIM(REGEXP_REPLACE(description, '\s+', ' '))
WHERE stockcode = '21243';

UPDATE sales_data
SET description = REGEXP_REPLACE(description, ',', '', 'g')
WHERE stockcode = '21507';

UPDATE sales_data
SET description = 'CHRISTMAS HANGING HEART WITH BELL'
WHERE stockcode = '21811';

UPDATE sales_data
SET description = 'GLITTER CHRISTMAS HEART'
WHERE stockcode = '21818';

UPDATE sales_data
SET description = 'KEY FOB, GARAGE'
WHERE stockcode = '21899';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '21899';

UPDATE sales_data
SET description = 'KEY FOB, SHED'
WHERE stockcode = '21900';

UPDATE sales_data
SET description = 'KEY FOB, BACK DOOR'
WHERE stockcode = '21901';

UPDATE sales_data
SET description = 'KEY FOB, FRONT DOOR'
WHERE stockcode = '21902';
	
UPDATE sales_data
SET description = 'JUMBO BAG BLUE SCANDINAVIAN PAISLEY'
WHERE stockcode = '21928';

UPDATE sales_data
SET description = 'JUMBO BAG BLUE SCANDINAVIAN PAISLEY'
WHERE stockcode = '21928';

UPDATE sales_data
SET description = 'SET 10 NIGHT OWL LIGHTS'
WHERE stockcode = '22179';

UPDATE sales_data
SET description = TRIM(REGEXP_REPLACE(description, 'SMALL ', ' '))
WHERE stockcode = '22197';

UPDATE sales_data
SET description = REGEXP_REPLACE(description, 'RETROSPOT', 'POLKADOT')
WHERE stockcode = '22199';

UPDATE sales_data
SET description = REGEXP_REPLACE(description, 'RETROSPOT', 'POLKADOT');

UPDATE sales_data
SET description = 'HANGING DECORATION HEN ON NEST'
WHERE stockcode = '22285';

UPDATE sales_data
SET description = 'HANGING DECORATION HEN ON NEST'
WHERE stockcode = '22285';

UPDATE sales_data
SET description = 'HANGING METAL RABBIT DECORATION',
    stockcode = '22288'
WHERE stockcode = '22286';

UPDATE sales_data
SET description = 'HANGING METAL CHICKEN DECORATION',
    stockcode = '22289'
WHERE stockcode = '22287';

UPDATE sales_data
SET description = 'LUNCH BAG SUKI DESIGN'
WHERE stockcode = '22383';

UPDATE sales_data
SET description = 'MONEY BOX FIRST AID DESIGN'
WHERE stockcode = '22407';

UPDATE sales_data
SET description = 'SET OF 36 PAPER DOILIES SPACEBOY DESIGN'
WHERE stockcode = '22416';

UPDATE sales_data
SET description = REGEXP_REPLACE(description, 'NIGHTLIGHT', 'NIGHT LIGHT')
WHERE stockcode = '22466';

SELECT DISTINCT description, stockcode
FROM sales_data
WHERE stockcode = '22502'
	OR stockcode = '22501'
--	OR stockcode = '22384'
--  OR stockcode = '22388'
--	OR stockcode = '22384'
	OR stockcode = '22500'
ORDER BY stockcode;

-- ASSESS IMPACT FROM NOW ON IF WE DROP DATA
-- CREATE TABLE WHERE PRODUCTS HAVE MULTIPLE DESCRIPTIONS

CREATE TABLE messy_data AS (
SELECT invoiceno, stockcode, unitprice, quantity
FROM sales_data
WHERE stockcode IN (
    SELECT stockcode
    FROM sales_data
    GROUP BY stockcode
    HAVING COUNT(DISTINCT description) > 1
));

SELECT * FROM messy_data
ORDER BY invoiceno DESC
LIMIT 20;

-- TOTAL LOSSES AND GAINS FOR EACH TABLE
SELECT
    SUM(CASE WHEN invoiceno ~* '^C' THEN unitprice * quantity ELSE 0 END) AS total_loss,
    SUM(CASE WHEN invoiceno !~* '^C' THEN unitprice * quantity ELSE 0 END) AS total_gain
FROM messy_data AS md

UNION ALL

-- Total loss and gain from sales_data (excluding messy_data invoices)
SELECT
    SUM(CASE WHEN invoiceno ~* '^C' THEN unitprice * quantity ELSE 0 END) AS total_loss,
    SUM(CASE WHEN invoiceno !~* '^C' THEN unitprice * quantity ELSE 0 END) AS total_gain
FROM sales_data
WHERE invoiceno NOT IN (
    SELECT invoiceno
    FROM messy_data
);

-- EVALUATE PERCENTAGES
SELECT
	ROUND((-25412.33*100/-802486.52),2) AS relative_pctg_loss,
	ROUND((902485.57*10/3081439.70),2) AS relative_pctg_gain
	
-- DROPPING THE DATA WOULD REPRESENT A LOSS OF 3.17% and 2.93% OF THE DATA
-- BACK UP TABLE
CREATE TABLE sales_data_backup AS
SELECT * FROM sales_data;

-- REMOVE messy_data FROM sales_data
DELETE FROM sales_data  
USING messy_data  
WHERE sales_data.invoiceno = messy_data.invoiceno;