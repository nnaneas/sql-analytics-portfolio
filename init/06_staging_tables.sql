CREATE TABLE IF NOT EXISTS analytics._stg_country_boundaries (
    country_id INT,
    wkt TEXT
);


CREATE TABLE IF NOT EXISTS analytics._stg_region_boundaries (
    region_id INT,
    wkt TEXT
);

CREATE TABLE IF NOT EXISTS analytics._stg_city_boundaries (
    city_id INT,
    wkt TEXT
);

CREATE TABLE IF NOT EXISTS analytics._stg_points (
    point_id INT,
    wkt TEXT
);

COPY analytics._stg_country_boundaries
FROM '/data/country_boundaries.csv'
CSV HEADER;

SELECT * FROM analytics._stg_country_boundaries;

COPY analytics._stg_region_boundaries
FROM '/data/region_boundaries.csv'
CSV HEADER;

SELECT * FROM analytics._stg_region_boundaries;

COPY analytics._stg_city_boundaries
FROM '/data/city_boundaries.csv'
CSV HEADER;

SELECT * FROM analytics._stg_city_boundaries;


COPY analytics._stg_points
FROM '/data/customer_locations.csv'
CSV HEADER;

SELECT * FROM analytics._stg_points;

INSERT INTO analytics.country_boundaries (country_id, geom)
SELECT
  country_id,
  ST_GeomFromText(wkt, 4326)
FROM analytics._stg_country_boundaries;

INSERT INTO analytics.region_boundaries (region_id, geom)
SELECT
  region_id,
  ST_GeomFromText(wkt, 4326)
FROM analytics._stg_region_boundaries;

INSERT INTO analytics.city_boundaries (city_id, geom)
SELECT
  city_id,
  ST_GeomFromText(wkt, 4326)
FROM analytics._stg_city_boundaries;

INSERT INTO analytics.customer_locations (customer_id, geom)
SELECT
  point_id,
  ST_GeomFromText(wkt, 4326)
FROM analytics._stg_points;

SELECT
  COUNT(*) FILTER (WHERE ST_IsValid(geom)) AS valid_geom,
  COUNT(*) AS total
FROM analytics.country_boundaries;

SELECT
  ST_GeometryType(geom),
  COUNT(*)
FROM analytics.country_boundaries
GROUP BY 1;

SELECT
  COUNT(*) FILTER (WHERE ST_IsValid(geom)) AS valid_geometries,
  COUNT(*) AS total_geometries
FROM analytics.city_boundaries;

SELECT
  COUNT(*) FILTER (WHERE ST_SRID(geom) = 4326) AS correct_srid,
  COUNT(*) AS total_geometries
FROM analytics.city_boundaries;