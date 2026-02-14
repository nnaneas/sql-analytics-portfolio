CREATE TABLE test.category (
  category_id INT PRIMARY KEY,
  product_category TEXT NOT NULL
);

CREATE TABLE test.product (
  product_id INT PRIMARY KEY,
  product_name TEXT NOT NULL,
  category_id INT NOT NULL,
  CONSTRAINT fk_product_category
    FOREIGN KEY (category_id) REFERENCES test.category(category_id)
);

CREATE TABLE test.payment (
  payment_method_id INT PRIMARY KEY,
  payment_method TEXT NOT NULL
);

CREATE TABLE test.order_status (
  order_status_id INT PRIMARY KEY,
  order_status TEXT NOT NULL
);

CREATE TABLE test.countries (
  country_id INT PRIMARY KEY,
  country TEXT NOT NULL
);

CREATE TABLE test.regions (
  region_id INT PRIMARY KEY,
  region TEXT NOT NULL,
  country_id INT NOT NULL,
  CONSTRAINT fk_country_region
    FOREIGN KEY (country_id) REFERENCES test.countries(country_id)
);

CREATE TABLE test.cities (
  city_id INT PRIMARY KEY,
  city TEXT NOT NULL,
  city_lat NUMERIC(9,4),
  city_lon NUMERIC(9,4),
  region_id INT NOT NULL,
  CONSTRAINT fk_cities_regions
    FOREIGN KEY (region_id) REFERENCES test.regions(region_id)
);

CREATE TABLE test.customers (
  customer_id INT PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  customer_name TEXT NOT NULL,
  customer_email TEXT NOT NULL UNIQUE,
  customer_age INT,
  city_id INT NOT NULL,
  CONSTRAINT fk_customers_cities
    FOREIGN KEY (city_id) REFERENCES test.cities(city_id)
);

CREATE TABLE test.sales (
  sale_id INT PRIMARY KEY,
  sale_date DATE NOT NULL,
  customer_id INT NOT NULL,
  payment_method_id INT NOT NULL,
  order_status_id INT NOT NULL,
  CONSTRAINT fk_sales_customers
    FOREIGN KEY (customer_id) REFERENCES test.customers(customer_id),
  CONSTRAINT fk_sales_payment
    FOREIGN KEY (payment_method_id) REFERENCES test.payment(payment_method_id),
  CONSTRAINT fk_sales_order_status
    FOREIGN KEY (order_status_id) REFERENCES test.order_status(order_status_id)
);

CREATE TABLE test.sale_item (
  sale_item_id INT PRIMARY KEY,
  product_id INT NOT NULL,
  unit_price NUMERIC(12,2) NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  sale_id INT NOT NULL,
  CONSTRAINT fk_sale_item_product
    FOREIGN KEY (product_id) REFERENCES test.product(product_id),
  CONSTRAINT fk_sale_item_sales
    FOREIGN KEY (sale_id) REFERENCES test.sales(sale_id)
);
