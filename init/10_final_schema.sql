CREATE DATABASE final_sql_project;

CREATE EXTENSION IF NOT EXISTS postgis;

CREATE SCHEMA IF NOT EXISTS project;

CREATE TABLE project.countries (
  country_code VARCHAR(10) PRIMARY KEY,
  country_name VARCHAR(100) NOT NULL
);

CREATE TABLE project.neighbourhood_groups (
  neighbourhood_group_id BIGSERIAL PRIMARY KEY,
  group_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE project.neighbourhoods (
  neighbourhood_id BIGSERIAL PRIMARY KEY,
  neighbourhood_group_id BIGINT NOT NULL REFERENCES project.neighbourhood_groups(neighbourhood_group_id),
  neighbourhood_name VARCHAR(150) NOT NULL,
  UNIQUE (neighbourhood_group_id, neighbourhood_name)
);

CREATE INDEX idx_neighbourhoods_group ON project.neighbourhoods(neighbourhood_group_id);

CREATE TABLE project.hosts (
  host_id BIGINT PRIMARY KEY,
  host_name VARCHAR(200),
  identity_verified_status VARCHAR(30),
  calculated_listings_count INT
);

CREATE TABLE project.room_types (
  room_type_id BIGSERIAL PRIMARY KEY,
  room_type_name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE project.cancellation_policies (
  cancellation_policy_id BIGSERIAL PRIMARY KEY,
  policy_name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE project.listings (
  listing_id BIGINT PRIMARY KEY,
  listing_name TEXT,
  host_id BIGINT NOT NULL REFERENCES project.hosts(host_id),
  neighbourhood_id BIGINT REFERENCES project.neighbourhoods(neighbourhood_id),
  country_code VARCHAR(10) REFERENCES project.countries(country_code),
  latitude NUMERIC(9,6),
  longitude NUMERIC(9,6),
  instant_bookable BOOLEAN,
  construction_year SMALLINT,
  room_type_id BIGINT REFERENCES project.room_types(room_type_id),
  cancellation_policy_id BIGINT REFERENCES project.cancellation_policies(cancellation_policy_id),
  price DECIMAL(12,2),
  service_fee DECIMAL(12,2),
  minimum_nights INT,
  availability_365 INT,
  house_rules TEXT,
  license VARCHAR(100)
);

CREATE INDEX idx_listings_host ON project.listings(host_id);
CREATE INDEX idx_listings_neighbourhood ON project.listings(neighbourhood_id);
CREATE INDEX idx_listings_country ON project.listings(country_code);

CREATE TABLE project.listing_review_summary (
  listing_id BIGINT PRIMARY KEY REFERENCES project.listings(listing_id),
  number_of_reviews INT,
  last_review DATE,
  reviews_per_month DECIMAL(6,2),
  review_rate_number DECIMAL(4,2)
);
