OPY project.countries
FROM '/docker-entrypoint-initdb.d/data/project_schema/countries.csv'
CSV HEADER;

SELECT * FROM project.countries;

COPY project.neighbourhood_groups
FROM '/docker-entrypoint-initdb.d/data/project_schema/neighbourhood_groups.csv'
CSV HEADER;

SELECT * FROM project.neighbourhood_groups

COPY project.neighbourhoods
FROM '/docker-entrypoint-initdb.d/data/project_schema/neighbourhoods.csv'
CSV HEADER;

SELECT * FROM project.neighbourhoods

COPY project.hosts
FROM '/docker-entrypoint-initdb.d/data/project_schema/hosts.csv'
CSV HEADER;

SELECT * FROM project.hosts

COPY project.room_types
FROM '/docker-entrypoint-initdb.d/data/project_schema/room_types.csv'
CSV HEADER;

SELECT * FROM project.room_types

COPY project.cancellation_policies
FROM '/docker-entrypoint-initdb.d/data/project_schema/cancellation_policies.csv'
CSV HEADER;

SELECT * FROM project.cancellation_policies

COPY project.listings
FROM '/docker-entrypoint-initdb.d/data/project_schema/listings.csv'
CSV HEADER;

SELECT * FROM project.listings

COPY project.listing_review_summary
FROM '/docker-entrypoint-initdb.d/data/project_schema/listing_review_summary.csv'
CSV HEADER;

SELECT * FROM project.listing_review_summary
