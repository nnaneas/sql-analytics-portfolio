-- task 1
-- phone number format diversity
SELECT 
	COUNT(raw_phone) AS raw_count,
	COUNT( DISTINCT raw_phone) AS distinct_count,
	COUNT( DISTINCT REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g')) AS regex_distinct
FROM transactions_text_demo;

-- category fragmentation
SELECT
  COUNT(DISTINCT category_raw) AS distinct_category_raw,
  COUNT(DISTINCT REGEXP_REPLACE(category_raw, '\s*\(.*\)\s*$', '')) AS distinct_category_base
FROM transactions_text_demo;

-- impact of dirty text on GROUP BY
SELECT 
	category_raw, 
	COUNT(category_raw) AS countity,
FROM transactions_text_demo
GROUP BY category_raw;

SELECT 
	REGEXP_REPLACE(category_raw, '\s*\(.*\)\s*$', '') AS cleaned,
	COUNT(REGEXP_REPLACE(category_raw, '\s*\(.*\)\s*$', '')) AS cleaned_counted
FROM transactions_text_demo
GROUP BY cleaned;

-- task 2
-- standardized phone number (last 8 digits)
SELECT 
	raw_phone,
	SUBSTRING(REPLACE(TRIM(raw_phone), '-', '') FROM LENGTH(REPLACE(TRIM(raw_phone), '-', '')) - 7 FOR 8) AS standardaized
FROM transactions_text_demo;

-- cleaned category (no annotations, trimmed)
SELECT 
	category_raw,
	SUBSTRING(category_raw FROM 1 FOR 11) AS cleaned,
	LENGTH((SUBSTRING(category_raw FROM 1 FOR 11))) AS length
FROM transactions_text_demo;

-- revenue per transaction
SELECT 
	transaction_id,
	quantity * price AS revenue
FROM transactions_text_demo
GROUP BY 
	transaction_id, 
	revenue;

-- task 3
-- revenue by raw category
SELECT 
	category_raw,
	SUM(quantity * price) AS revenue
FROM transactions_text_demo
GROUP BY 
	category_raw;
	
-- revenue by cleaned category
SELECT 
	SUBSTRING(category_raw FROM 1 FOR 11) AS cleaned,
	SUM(quantity * price) AS revenue
FROM transactions_text_demo
GROUP BY 
	cleaned;
 
-- unique customers (raw vs cleaned phone)
SELECT 
	DISTINCT customer_id,
	SUBSTRING(REPLACE(TRIM(raw_phone), '-', '') FROM LENGTH(REPLACE(TRIM(raw_phone), '-', '')) - 7 FOR 8) AS standardized
FROM transactions_text_demo
GROUP BY
	customer_id,
	standardized;

SELECT 
	DISTINCT customer_id,
	raw_phone
FROM transactions_text_demo
GROUP BY 
	customer_id,
	raw_phone;