# Database Schema Analysis Report

Copy the content below into a file named `database_analysis.md` for a complete Markdown report of your SQL queries.

## Table Row Counts

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
This query provides a summary of total rows across all core tables in the project schema, ordered alphabetically.

## Referential Integrity Checks

### Roles Check
```sql
SELECT 
	j.job_id, 
	j.role_id
FROM project.jobs j
LEFT JOIN project.roles r ON j.role_id = r.role_id
WHERE r.role_id IS NULL;
```
Identifies jobs referencing non-existent roles, revealing potential orphaned records.

### Industries Check
```sql
SELECT 
	j.job_id, 
	j.industry_id
FROM project.jobs j
LEFT JOIN project.industries i ON j.industry_id = i.industry_id
WHERE i.industry_id IS NULL;
```
Flags jobs with invalid industry foreign keys for data cleanup.

### Countries Check
```sql
SELECT 
	j.job_id, 
	j.country_id
FROM project.jobs j
LEFT JOIN project.countries c ON j.country_id = c.country_id
WHERE c.country_id IS NULL;
```
Detects invalid country references in the jobs table.

### Years Check
```sql
SELECT 
	j.job_id, 
	j.year_id
FROM project.jobs j
LEFT JOIN project.years y ON j.year_id = y.year_id
WHERE y.year_id IS NULL;
```
Checks for jobs linked to missing year records.

## Geometry Validation

```sql
-- NULL geometries check
SELECT 
	country_id, 
	country, 
	ST_IsValid(geom) AS is_valid
FROM project.countries
WHERE geom IS NULL;
```