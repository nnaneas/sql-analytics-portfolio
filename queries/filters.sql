-- TASK1
SELECT 
	transaction_id,
	city,
	category,
	total_sales,
	discount,
	CASE

		WHEN total_sales > 200 
			AND category = 'Electronics'
			AND discount < 0.2 
			THEN 'High-value Electronics transactions with low discount'

		WHEN total_sales BETWEEN 100 AND 200
			AND discount BETWEEN 0.2 AND 0.4
			THEN 'Medium-value transactions with moderate discount'

		WHEN total_sales < 100
			AND discount = 0.5
			THEN 'Low-value or heavily discounted transactions'

		ELSE 'Other'
	END AS result_is
FROM sales_analysis
WHERE year = '2023';

-- TASK2
SELECT
	SUM(total_sales) as sales,
	COUNT(transaction_id) as transaction_count,
	AVG(discount) as avarage_discount,
	category,
CASE

	WHEN SUM(total_sales) > 70000 
	AND COUNT(transaction_id) > 300 THEN 'Strong Performer'
	
	WHEN SUM(total_sales) > 60000 
	AND COUNT(transaction_id) > 280 THEN 'Avarage Performer'
	
	WHEN SUM(total_sales) > 60000 
	AND COUNT(transaction_id) BETWEEN 250  AND 280 THEN 'Underperformer'
	
	ELSE 'Very Low Activity'

END AS result_is
FROM sales_analysis
WHERE year = '2023'
GROUP BY category
HAVING SUM(total_sales) > 60000
		AND COUNT(transaction_id) > 250;

-- TASK3
SELECT transaction_id,
city,
COUNT(*) as count,
CASE

	WHEN COUNT(*) >= 10 THEN 'High Activity'
	WHEN COUNT(*) BETWEEN 5 AND 9 THEN 'Medium Acitivity'
	ELSE 'Low Activity'

END AS result_is
FROM sales_analysis
WHERE year = '2023' AND category = 'Clothing'
GROUP BY transaction_id,
			city
HAVING COUNT(*) >= 1;

-- TASK4
SELECT category,
AVG(discount),
SUM(total_sales) as sum_sales,
COUNT(transaction_id) as transaction_count,
CASE

	WHEN AVG(discount) > 0.2512 THEN 'Discount-Heavy'
	
	WHEN AVG(discount) BETWEEN 0.25 AND 0.2512 THEN 'Moderate Discount'

	ELSE 'Low or No Discount'

END AS result_is
FROM sales_analysis
GROUP BY category
HAVING COUNT(transaction_id) > 900;

