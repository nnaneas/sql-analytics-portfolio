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