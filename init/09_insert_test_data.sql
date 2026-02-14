COPY test.countries
FROM '/data/countries.csv'
CSV HEADER;

COPY test.category
FROM '/data/category.csv'
CSV HEADER;

COPY test.regions
FROM '/data/regions.csv'
CSV HEADER;

COPY test.cities
FROM '/data/cities.csv'
CSV HEADER;

COPY test.customers
FROM '/data/customers.csv'
CSV HEADER;

COPY test.order_status
FROM '/data/order_status.csv'
CSV HEADER;

COPY test.product
FROM '/data/product.csv'
CSV HEADER;

COPY test.sales
FROM '/data/sales.csv'
CSV HEADER;

COPY test.sale_item
FROM '/data/sale_item.csv'
CSV HEADER;