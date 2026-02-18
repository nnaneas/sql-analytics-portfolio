ALTER TABLE project.listings
ADD COLUMN geom GEOMETRY(Point, 4326);

UPDATE project.listings
SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)
WHERE longitude IS NOT NULL AND latitude IS NOT NULL;

CREATE INDEX idx_listings_geom
ON project.listings
USING GIST (geom);