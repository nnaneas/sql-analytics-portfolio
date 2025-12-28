-- PART 1
-- task1 & task2
-- Employee phone numbers must be mandatory
ALTER TABLE employees
ADD COLUMN phone_number TEXT;

ALTER TABLE employees
ALTER COLUMN phone_number
SET DEFAULT '043538353';

UPDATE employees
SET phone_number = '043538353'
WHERE employee_id >= 0;

ALTER TABLE employees
ALTER COLUMN phone_number
SET NOT NULL;

-- Product prices must be non-negative
ALTER TABLE products
ADD CONSTRAINT check_price
CHECK (price >= 0);

-- Sales totals must be non-negative
ALTER TABLE sales
ADD CONSTRAINT check_total
CHECK (total_sales >= 0);

-- task3
CREATE INDEX idx_sales_prod_id
ON sales (product_id);

CREATE INDEX idx_sales_customer_id
ON sales (customer_id);

CREATE INDEX idx_prod_cat
ON products (category);

-- task4
EXPLAIN
SELECT product_id,
       SUM(discount) AS total_discount
FROM sales
GROUP BY product_id;

-- task5
SELECT *
FROM orders;
-- When we are exploring the data

SELECT order_id,
       order_date
FROM orders;
-- Less data is read

-- task6
EXPLAIN
SELECT product_id,
       COUNT(product_id) AS product_quantity
FROM sales
GROUP BY product_id
ORDER BY COUNT(product_id) DESC
LIMIT 10;

-- task7
SELECT *
FROM products;

SELECT DISTINCT category,
                price
FROM products;

SELECT category,
       price
FROM products
GROUP BY category,
         price;

-- task8
UPDATE products
SET price = -1000
WHERE product_id = 1;

INSERT INTO employees (employee_id, first_name, last_name, email, salary, phone_number)
VALUES ( 101, 'Nane', 'Beglaryan', 'nanebeglaryan@gmail.com', 1000000, NULL);
