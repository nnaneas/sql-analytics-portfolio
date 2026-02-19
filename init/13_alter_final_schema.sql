ALTER TABLE project.countries
ADD COLUMN geom geometry(Point, 4326);

UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(133.7751, -25.2744), 4326) WHERE country_id = 1;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(-51.9253, -14.2350), 4326) WHERE country_id = 2;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(-106.3468, 56.1304), 4326) WHERE country_id = 3;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(10.4515, 51.1657), 4326) WHERE country_id = 4;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(78.9629, 20.5937), 4326) WHERE country_id = 5;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(138.2529, 36.2048), 4326) WHERE country_id = 6;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(103.8198, 1.3521), 4326) WHERE country_id = 7;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(-3.4360, 55.3781), 4326) WHERE country_id = 8;
UPDATE project.countries SET geom = ST_SetSRID(ST_MakePoint(-95.7129, 37.0902), 4326) WHERE country_id = 9;

CREATE INDEX IF NOT EXISTS idx_countries_geom
ON project.countries
USING GIST (geom);