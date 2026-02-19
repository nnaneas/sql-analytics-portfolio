```markdown
# Database Referential Integrity Checks

## Purpose
These SQL queries check for referential integrity issues in the `project` schema and invalid geometries in the `countries` table. [code_file:1]

## Referential Integrity Checks (Jobs Table) [code_file:1]

### Orphaned Role, Industry, Country, and Year IDs [code_file:1]
```sql
-- referential integrity
SELECT 
	j.job_id, 
	j.role_id
FROM project.jobs j
LEFT JOIN project.roles r ON j.role_id = r.role_id
WHERE r.role_id IS NULL;

SELECT 
	j.job_id, 
	j.industry_id
FROM project.jobs j
LEFT JOIN project.industries i ON j.industry_id = i.industry_id
WHERE i.industry_id IS NULL;

SELECT 
	j.job_id, 
	j.country_id
FROM project.jobs j
LEFT JOIN project.countries c ON j.country_id = c.country_id
WHERE c.country_id IS NULL;

SELECT 
	j.job_id, 
	j.year_id
FROM project.jobs j
LEFT JOIN project.years y ON j.year_id = y.year_id
WHERE y.year_id IS NULL;
```
These LEFT JOINs identify `job_id`s referencing non-existent IDs in lookup tables. [code_file:1]

### Invalid or NULL Geometries [code_file:1]
```sql
-- invalid or NULL geometries
SELECT 
	country_id, 
	country, 
	ST_IsValid(geom) AS is_valid
FROM project.countries
WHERE geom IS NULL;
```
This flags countries with missing `geom` (PostGIS geometry); extend the WHERE clause to `NOT ST_IsValid(geom)` for invalid ones. [code_file:1]

## Table Row Counts [code_file:1]
Query to get total row counts across key tables in the `project` schema. [code_file:1]

```sql
-- Row counts for each table
SELECT 
	'roles' AS table_name, 
	COUNT(*) AS row_count 
FROM project.roles
UNION ALL
SELECT 
	'industries' AS table_name, 
	COUNT(*) AS row_count 
FROM project.industries
UNION ALL
SELECT 
	'countries' AS table_name, 
	COUNT(*) AS row_count 
FROM project.countries
UNION ALL
SELECT 
	'years' AS table_name, 
	COUNT(*) AS row_count 
FROM project.years
UNION ALL
SELECT 
	'jobs' AS table_name, 
	COUNT(*) AS row_count 
FROM project.jobs
ORDER BY table_name;
```
Use this UNION ALL query for a quick overview of table sizes, ordered alphabetically. [code_file:1]
```
