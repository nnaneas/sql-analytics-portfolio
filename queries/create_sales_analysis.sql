DROP TABLE IF EXISTS sales_analysis;

CREATE TABLE sales_analysis AS
SELECT
    s.transaction_id,

    o.order_date,
    DATE(o.order_date) AS order_date_date,
    o.year,
    o.quarter,
    o.month,

    c.customer_name,
    c.city,
    c.zip_code,

    p.product_name,
    p.category,
    p.price,

    e.first_name AS employee_first_name,
    e.last_name  AS employee_last_name,
    e.salary     AS employee_salary,

    s.quantity,
    s.discount,
    s.total_sales
FROM sales AS s
JOIN orders AS o
    ON s.order_id = o.order_id
JOIN customers AS c
    ON s.customer_id = c.customer_id
JOIN products AS p
    ON s.product_id = p.product_id
LEFT JOIN employees AS e
    ON s.employee_id = e.employee_id;

SELECT 
	*
FROM sales_analysis
LIMIT 5;

CREATE INDEX idx_sales_analysis_order_date
    ON sales_analysis(order_date_date);

CREATE INDEX idx_sales_analysis_year
    ON sales_analysis(year);

CREATE INDEX idx_sales_analysis_city
    ON sales_analysis(city);

CREATE INDEX idx_sales_analysis_category
    ON sales_analysis(category);

SELECT 
	transaction_id,
	customer_name,
	product_name,
	price,
	employee_first_name,
	total_sales
FROM sales_analysis
WHERE price>450
	AND (city='Vanessaport' OR city='Thommasside');

SELECT 
	transaction_id,
	customer_name,
	product_name,
	price,
	employee_first_name,
	total_sales
FROM sales_analysis
WHERE order_date_date BETWEEN '2021-01-01' AND '2022-01-01';

SELECT
	transaction_id,
	customer_name,
	product_name,
	price,
	employee_first_name,
	total_sales
FROM sales_analysis
WHERE month IN ('June', 'July', 'September', 'December');

SELECT
	transaction_id,
	customer_name,
	product_name,
	price,
	employee_first_name,
	total_sales
FROM sales_analysis
WHERE month NOT IN ('June', 'July', 'September', 'December');
-- or
SELECT 
	transaction_id,
	customer_name,
	product_name,
	price,
	employee_first_name,
	total_sales,
	month
FROM sales_analysis
WHERE month != 'July' 
	AND month != 'December'
	AND month != 'August';
-- or
SELECT 
	transaction_id,
	customer_name,
	product_name,
	price,
	employee_first_name,
	total_sales,
	month
FROM sales_analysis
WHERE month <> 'July' 
	AND month <> 'December'
	AND month <> 'August'
LIMIT 5;


SELECT 
	transaction_id,
	city,
	price
FROM sales_analysis
WHERE city LIKE 'West%';

SELECT
	transaction_id,
	city,
	price
FROM sales_analysis
WHERE city LIKE '%am%'
LIMIT 10;

SELECT
	transaction_id,
	city,
	price
FROM sales_analysis
WHERE city NOT LIKE '%na%'
	OR  city NOT LIKE '%am%';

-- there's one more character before 'ec'
SELECT 
	transaction_id,
	city,
	price,
	month
FROM sales_analysis
WHERE month LIKE '_ec%';

SELECT 
	transaction_id,
	city,
	price,
	month
FROM sales_analysis
WHERE city IS NOT NULL;

SELECT 
	transaction_id,
	city,
	price,
	month
FROM sales_analysis
WHERE city IS NULL;

SELECT DISTINCT city
FROM sales_analysis;

SELECT
	month,
	COUNT(month) as month_quantity
FROM sales_analysis
WHERE month LIKE '%n%'
GROUP BY month
HAVING COUNT(month)>300
ORDER BY COUNT(month) desc;
-- count(*) -> counts nulls too
-- count(month) -> counts only those rows where the value is not null
-- aggregate function are not allowed in WHERE


SELECT
	transaction_id,
	total_sales,
	CASE
		WHEN total_sales BETWEEN 200 AND 300 THEN 'low'
		WHEN total_sales BETWEEN 301 AND 400 THEN 'medium'
		ELSE 'high'
	END AS message_low_to_high
FROM sales_analysis;

SELECT
    SUM(total_sales) AS total_sales_amount,
    CASE
        WHEN discount > 0 THEN 'Discounted'
        ELSE 'Full Price'
    END AS pricing_type
FROM sales_analysis
GROUP BY pricing_type;
-- Եթե SELECT–ում կա ագրեգատ ֆունկցիա (SUM, COUNT, AVG …), ապա`
-- Մնացած բոլոր սյուները պետք է լինեն կամ GROUP BY–ի մեջ կամ նույնպես ագրեգատ ֆունկցիայի մեջ
-- Առաջին SELECT-ում GROUP BY չի օգտագործվում, որովհետև այնտեղ aggregate ֆունկցիա չկա
-- GROUP BY-ը սահմանում է խմբերը, իսկ SUM()-ը հաշվարկվում է արդեն ստեղծված խմբերի վրա, այդ պատճառով aggregate ֆունկցիաները չեն կարող օգտագործվել GROUP BY-ում։

SELECT 
	transaction_id,
	transaction_id % 2 as check,
	transaction_id/2 as divison
FROM sales_analysis
WHERE transaction_id % 2=0
ORDER BY transaction_id ASC;

SELECT 
	transaction_id,
	customer_name,
	city,
	year
INTO temp
FROM sales_analysis
WHERE year BETWEEN 2021 AND 2022;

SELECT * FROM temp;
-- Ինդեքսներն արդի են միայն այն table-ում, որի համար ստեղծվել են

SELECT DISTINCT customer_name
FROM sales_analysis;

SELECT 
	customer_name,
	SUM(total_sales) AS  customer_sales
FROM sales_analysis
GROUP BY customer_name
ORDER BY SUM(total_sales) DESC
LIMIT 10;

SELECT 
	customer_name,
	transaction_id,
	CASE 
		WHEN customer_name IN ('Laura Brown',
								'Michael Smith',
								'Kurt Hayes'
								'Justin Clark'
								'David Lopez'
								'Cathy Mckenzie'
								'Paul Smith'
								'James Moore'
								'Danielle Carter'
								'Julie Clark') THEN 'TOP 10'
		ELSE 'NOT TOP 10'
	END AS result
FROM sales_analysis
LIMIT 100;

-- ցույց ա տալիս unique customer-ների քանակը
SELECT COUNT(DISTINCT customer_name) AS unique_customer
FROM sales_analysis;

-- ցույց ա տալիս, թե ամեն product-ից որքան ա գնվել
SELECT product_name,
	COUNT(customer_name) AS count_prod
FROM sales_analysis
GROUP BY product_name;

-- ցույց ա տալիս mode-ը կամ ամենքիչ կրկնվողը
SELECT
	MAX(product_name) AS maxx,
	MIN(product_name) AS minn
FROM sales_analysis;

-- ցույց ա տալիս duplicates
SELECT 
	transaction_id,
	COUNT(*) AS duplicates
FROM sales_analysis
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT 
	month
	COUNT(*) AS duplicates
FROM sales_analysis
GROUP BY month
HAVING COUNT(*) > 1;



SELECT 
	product_name,
	price * quantity AS total_revenue
FROM sales_analysis
GROUP BY 
	product_name,
	price * quantity;

SELECT 
	product_name,
	ROUND(price * quantity) AS total_revenue
FROM sales_analysis;

SELECT 
	product_name,
	ROUND(price * quantity, 1) AS total_revenue
FROM sales_analysis;

SELECT 
	transaction_id,
	CEILING(total_sales) as rounded_up,
	FLOOR(total_sales) as rounded_down
FROM sales_analysis;

SELECT
  COUNT(transaction_id) AS transactions,
  SUM(total_sales) AS total_revenue,
  CEILING(total_sales / 50.0) * 50 AS revenue_range
FROM sales_analysis
GROUP BY 
	CEILING(total_sales / 50.0) * 50
ORDER BY revenue_range;

-- NULL-ին վերագրեցինք 0
SELECT
	AVG(COALESCE(discount, 0)) AS avg_discount_with_zero
FROM sales_analysis;

SELECT
	ROUND(AVG(COALESCE(discount, 0)), 2) AS avg_discount_with_zero
FROM sales_analysis;


UPDATE sales_analysis
SET discount = NULL
WHERE transaction_id <> 0 AND transaction_id % 2 = 0;

SELECT 
	* 
FROM sales_analysis
WHERE transaction_id <> 0 AND transaction_id % 2 = 0;

SELECT 
	AVG(discount) AS avg_discount,
	AVG(COALESCE(discount, 0)) AS avg_discount_with_null
FROM sales_analysis;

UPDATE sales_analysis
SET discount = (
	SELECT AVG(discount)
	FROM sales_analysis
)
WHERE discount IS NULL;

---------
DROP TABLE IF EXISTS customers_raw_text;

CREATE TABLE customers_raw_text (
  customer_id   INTEGER,
  first_name    TEXT,
  last_name     TEXT,
  raw_phone     TEXT,
  category_raw  TEXT,
  birth_date    DATE
);

INSERT INTO customers_raw_text (
  customer_id,
  first_name,
  last_name,
  raw_phone,
  category_raw,
  birth_date
) VALUES
  (1, 'joHN',     'doE',        '   077600945  ',   'Accessories (Promo)', DATE '1994-03-12'),
  (2, 'MARY',     'sMiTh',      '077-600-045',      'Electronics (Old)',   DATE '1988-11-05'),
  (3, 'aLEx',     'johnSON',    '(374)-77-600-945', 'Accessories',         DATE '2001-07-23'),
  (4, 'anna',     'VAN DYKE',   '37477600945',      'Electronics (Promo)', DATE '1999-01-30'),
  (5, NULL,       'brOwn',      '77600945',         'Accessories (Test)',  DATE '1994-03-12');

SELECT 
	raw_phone,
	LENGTH(raw_phone) AS length
FROM customers_raw_text;

SELECT ('HELLO');

SELECT
	raw_phone,
	LENGTH(raw_phone) AS length,
CASE
	WHEN LENGTH(raw_phone) = 8 THEN 'everything is correct'
	ELSE 'some clean up is needed'
END AS result
FROM customers_raw_text;

SELECT 
	raw_phone,
	LENGTH(raw_phone) AS initial_length,
	TRIM(raw_phone) AS trimmed,
	LENGTH(TRIM(raw_phone)) AS trimmed_length
FROM customers_raw_text;

-- trimmed from the left side
SELECT LTRIM(raw_phone)
FROM customers_raw_text;

-- trimmed from the right side
SELECT RTRIM(raw_phone)
FROM customers_raw_text;

SELECT 
	last_name,
	UPPER(last_name) AS upper_name
FROM customers_raw_text;

SELECT 
	last_name,
	LOWER(last_name) AS upper_name
FROM customers_raw_text;

SELECT 
	last_name,
	INITCAP(last_name) AS upper_name
FROM customers_raw_text;

SELECT 
	first_name,
	last_name,
	INITCAP(CONCAT(first_name, ' ', last_name)) AS full_name
FROM customers_raw_text;
-- or
SELECT 
	first_name,
	last_name,
	INITCAP(first_name || ' ' || last_name) AS full_name
FROM customers_raw_text;

SELECT 
	raw_phone,
	REPLACE(raw_phone, '-', '') AS replaced
FROM customers_raw_text;

SELECT 
	raw_phone,
	TRIM(REPLACE(raw_phone, '-', '')) AS replaced
FROM customers_raw_text;

SELECT
  raw_phone,
  REPLACE(
    REPLACE(
      REPLACE(TRIM(raw_phone), '-', ''),
    '(', ''),
  ')', '') AS phone_partial_clean
FROM customers_raw_text;

SELECT
  raw_phone,
  REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g') AS digits_only,
  LENGTH(REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g')) AS length
FROM customers_raw_text;

SELECT
    category_raw,
    REGEXP_REPLACE(category_raw, '\([^)]*\)', '', 'g') AS category_clean
FROM customers_raw_text;

SELECT 
	category_raw,
	SUBSTRING(category_raw FROM 1 FOR 11) AS final_result
FROM customers_raw_text;

SELECT
	first_name,
	last_name,
	INITCAP(CONCAT(first_name, ' ', last_name)) AS full_name
FROM customers_raw_text;

SELECT
	raw_phone,
	POSITION('-' IN raw_phone) AS position
FROM customers_raw_text;
-- or
SELECT
	raw_phone,
	STRPOS(raw_phone, '-') AS position
FROM customers_raw_text;

SELECT 
	raw_phone,
	STRPOS(raw_phone, '(') > 0 AS result
FROM customers_raw_text;

SELECT 
	raw_phone,
	SPLIT_PART(raw_phone, '-', 3) AS result
FROM customers_raw_text;

SELECT 
	first_name,
	NULLIF(first_name, '') AS result
FROM customers_raw_text;

DROP TABLE IF EXISTS transactions_text_demo;

CREATE TABLE transactions_text_demo (
  transaction_id INTEGER,
  customer_id    INTEGER,
  raw_phone      TEXT,
  category_raw   TEXT,
  quantity       INTEGER,
  price          NUMERIC(10,2)
);

INSERT INTO transactions_text_demo
SELECT
  gs AS transaction_id,
  (RANDOM() * 200)::INT + 1 AS customer_id,

  CASE (gs % 6)
    WHEN 0 THEN '   077600945  '
    WHEN 1 THEN '077-600-045'
    WHEN 2 THEN '(374)-77-600-945'
    WHEN 3 THEN '37477600945'
    WHEN 4 THEN '77600945'
    ELSE '077600945'
  END AS raw_phone,

  CASE (gs % 5)
    WHEN 0 THEN 'Accessories (Promo)'
    WHEN 1 THEN 'Accessories (Test)'
    WHEN 2 THEN 'Electronics (Old)'
    WHEN 3 THEN 'Electronics (Promo)'
    ELSE 'Accessories'
  END AS category_raw,

  (RANDOM() * 5)::INT + 1 AS quantity,
  (RANDOM() * 500 + 10)::NUMERIC(10,2) AS price
FROM generate_series(1, 1000) AS gs;

SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT raw_phone) AS distinct_raw_phones,
  COUNT(DISTINCT category_raw) AS distinct_categories
FROM transactions_text_demo;

-- task1
-- raw_phone
SELECT 
	raw_phone
FROM transactions_text_demo;

-- LENGTH(raw_phone)
SELECT 
	raw_phone,
	LENGTH(raw_phone) AS phone_length
FROM transactions_text_demo;

-- position of '-'
SELECT
	raw_phone,
	STRPOS(raw_phone, '-')
FROM transactions_text_demo;

-- position of '('
SELECT
	raw_phone,
	STRPOS(raw_phone, '(')
FROM transactions_text_demo;

-- count of rows per pattern
SELECT 
	raw_phone,
	COUNT(raw_phone),
	STRPOS(raw_phone, '(')
FROM transactions_text_demo
GROUP BY raw_phone;
--
SELECT 
	raw_phone,
	COUNT(raw_phone),
	STRPOS(raw_phone, '-')
FROM transactions_text_demo
GROUP BY raw_phone;

--task2
SELECT 
	DISTINCT(category_raw),
	COUNT(category_raw)
FROM transactions_text_demo
GROUP BY category_raw
ORDER BY COUNT(category_raw) DESC;

SELECT 
	order_date,
	EXTRACT(YEAR FROM order_date) AS year,
	EXTRACT(MONTH FROM order_date) AS month,
	EXTRACT(DAY FROM order_date) AS day,
	EXTRACT(DOW FROM order_date) AS weekday,
	EXTRACT(EPOCH FROM order_date) AS seconds
FROM sales_analysis;
-- or
SELECT 
	order_date,
	DATE_PART('year', order_date) AS year,
	DATE_PART('month', order_date) AS month,
	DATE_PART('day', order_date) AS day,
	DATE_PART('dow', order_date) AS weekday
FROM sales_analysis;

SELECT 
	order_date,
	DATE_TRUNC('year', order_date) AS year,
	DATE_TRUNC('month', order_date) AS month,
	DATE_TRUNC('quarter', order_date) AS quarter
FROM sales_analysis;

SELECT NOW();
-- OR
SELECT CURRENT_DATE;

SELECT 
	DATE(order_date),
	CURRENT_DATE - DATE(order_date) AS difference
FROM sales_analysis;

SELECT 
	order_date,
	order_date + INTERVAL '1 year'
FROM sales_analysis;

SELECT 
	order_date,
	AGE(CURRENT_DATE, DATE(order_date)) AS interval,
	AGE(CURRENT_DATE, order_date) AS interval_with_time_zone
FROM sales_analysis;


-- aggregate total sales by month
SELECT SUM(total_sales) AS summary,
EXTRACT(MONTH FROM order_date_date) AS month
FROM sales_analysis
GROUP BY EXTRACT(MONTH FROM order_date_date)
ORDER BY summary DESC;

-- aggregate total sales by quarter
SELECT SUM(total_sales) AS summary,
EXTRACT(QUARTER FROM order_date_date) AS quarter
FROM sales_analysis
GROUP BY EXTRACT(QUARTER FROM order_date_date)
ORDER BY summary DESC;

-- identify the top 3 months by revenue
SELECT SUM(total_sales) AS summary,
EXTRACT(MONTH FROM order_date_date) AS month
FROM sales_analysis
GROUP BY EXTRACT(MONTH FROM order_date_date)
ORDER BY summary DESC
LIMIT 3;

SELECT SUM(total_sales) AS summary,
EXTRACT(MONTH FROM order_date_date) AS month
FROM sales_analysis
GROUP BY EXTRACT(MONTH FROM order_date_date)
ORDER BY summary DESC
LIMIT 3;

-- identify the top quarter by revenue
SELECT SUM(total_sales) AS summary,
EXTRACT(QUARTER FROM order_date_date) AS quarter
FROM sales_analysis
GROUP BY EXTRACT(QUARTER FROM order_date_date)
ORDER BY summary DESC
LIMIT 1;

-- compute days since each transaction
SELECT 
	transaction_id,
	CURRENT_DATE - order_date_date + 'days' AS days
FROM sales_analysis;

-- transactions from the last 60 days (you should get the empty table)
SELECT 
	transaction_id,
	order_date
FROM sales_analysis
WHERE (CURRENT_DATE - order_date_date) <= 60;

-- compute days since last transaction per customer
SELECT 
	customer_name,
	CURRENT_DATE - order_date_date AS days_since_trans
FROM sales_analysis
GROUP BY 
	customer_name,
	days_since_trans;
	
-- use AGE() to describe customer recency in calendar terms
SELECT 
	customer_name,
	AGE(CURRENT_DATE, order_date_date) AS days_since_trans
FROM sales_analysis
GROUP BY 
	customer_name,
	days_since_trans;
