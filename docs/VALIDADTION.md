# Validation

This document describes the validation checks performed after loading all CSV data into the database.  
The goal is to confirm:

1. **Row counts** look realistic (tables are populated as expected)
2. **Referential integrity** is preserved (no orphan foreign key references)
3. **Spatial geometries** are valid using PostGIS (`ST_IsValid`)

Schema used: `project`  
Database: `final_sql_project`

---

## 1. Row Count Validation

After loading all CSV files with `COPY`, row counts were verified to ensure each table was populated.

### SQL

```sql
SELECT 
  'countries' AS table, 
  COUNT(*) 
FROM project.countries
UNION ALL 
SELECT 
  'neighbourhood_groups', 
  COUNT(*) 
FROM project.neighbourhood_groups
UNION ALL 
SELECT 
  'neighbourhoods', 
  COUNT(*) 
FROM project.neighbourhoods
UNION ALL 
SELECT 
  'hosts', 
  COUNT(*) 
FROM project.hosts
UNION ALL 
SELECT 
  'room_types', 
  COUNT(*) 
FROM project.room_types
UNION ALL 
SELECT 
  'cancellation_policies', 
  COUNT(*) 
FROM project.cancellation_policies
UNION ALL 
SELECT 
  'listings', 
  COUNT(*) 
FROM project.listings
UNION ALL 
SELECT 
  'listing_review_summary', 
  COUNT(*) 
FROM project.listing_review_summary;


## 2. Foreign Key Integrity Checks (Orphan Records)

Even though the schema uses foreign keys, these checks are still useful because some FK columns are nullable (e.g., `neighbourhood_id`, `country_code`), data might be loaded in the wrong order, or cleaned inconsistently in different environments.

### 2.1 Listings → Hosts (host_id must exist)

**Goal**  
Ensure every listing references a valid host.

**SQL**
```sql
SELECT 
  COUNT(*) AS quantity
FROM project.listings l
LEFT JOIN project.hosts h ON h.host_id = l.host_id
WHERE h.host_id IS NULL;
```

**Expected Result**  
`quantity = 0`

**Fail Meaning**  
Listings exist whose `host_id` doesn't exist in `project.hosts`. This breaks referential integrity or indicates missing/incomplete host data.

**Pass Criteria**  
✅ `quantity = 0`

### 2.2 Listings → Neighbourhoods (only when neighbourhood_id is provided)

**Goal**  
If `neighbourhood_id` is not null, it must match an existing neighbourhood.

**SQL**
```sql
SELECT 
  COUNT(*) AS quantity
FROM project.listings l
LEFT JOIN project.neighbourhoods n ON n.neighbourhood_id = l.neighbourhood_id
WHERE l.neighbourhood_id IS NOT NULL
  AND n.neighbourhood_id IS NULL;
```

**Expected Result**  
`quantity = 0`

**Fail Meaning**  
Listings have a `neighbourhood_id` that does not exist in `project.neighbourhoods`.

**Pass Criteria**  
✅ `quantity = 0`

### 2.3 Listings → Countries (only when country_code is provided)

**Goal**  
If `country_code` is not null, it must match an existing country code.

**SQL**
```sql
SELECT 
  COUNT(*) AS quantity
FROM project.listings l
LEFT JOIN project.countries c ON c.country_code = l.country_code
WHERE l.country_code IS NOT NULL
  AND c.country_code IS NULL;
```

**Expected Result**  
`quantity = 0`

**Fail Meaning**  
Listings have a `country_code` not found in `project.countries` (typo, missing code, inconsistent casing, etc.).

**Pass Criteria**  
✅ `quantity = 0`

## 3. Geometry Validation (PostGIS)

**Context**  
A `geom` column is created using:  
`ST_MakePoint(longitude, latitude)`  
`ST_SetSRID(..., 4326)` (WGS84)

**Goal**  
Ensure geometries created in `project.listings.geom` are valid.

**SQL**
```sql
SELECT  
  COUNT(*) AS invalid_geom
FROM project.listings
WHERE geom IS NOT NULL
  AND NOT ST_IsValid(geom);
```

**Expected Result**  
`invalid_geom = 0`

**Fail Meaning**  
Some geometries are invalid (rare for simple points, but can happen if data types were wrong, geometry was corrupted by updates, or invalid coordinates were inserted).

**Pass Criteria**  
✅ `invalid_geom = 0`
