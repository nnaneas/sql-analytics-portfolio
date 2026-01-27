COPY analytics.countries
FROM '/data/countries.csv'
CSV HEADER;

SELECT * FROM analytics.countries;

COPY analytics.regions
FROM '/data/regions.csv'
CSV HEADER;

SELECT * FROM analytics.regions;

COPY analytics.cities
FROM '/data/cities.csv'
CSV HEADER;

SELECT * FROM analytics.cities;

COPY analytics.customers
FROM '/data/customers.csv'
CSV HEADER;

SELECT * FROM analytics.customers LIMIT 10;

COPY analytics.products
FROM '/data/products.csv'
CSV HEADER;

SELECT * FROM analytics.products;

COPY analytics.orders
FROM '/data/orders.csv'
CSV HEADER;

SELECT * FROM analytics.orders LIMIT 10;

COPY analytics.order_items
FROM '/data/order_items.csv'
CSV HEADER;

SELECT * FROM analytics.order_items LIMIT 10;