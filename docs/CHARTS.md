## Query 1: AI Replacement Risk by Country (with Geometry)

```sql
SELECT
  c.country,
  c.geom,
  ROUND(AVG(j.ai_replacement_score), 2) AS avg_ai_replacement
FROM project.jobs j
JOIN project.countries c ON j.country_id = c.country_id
GROUP BY c.country, c.geom
ORDER BY avg_ai_replacement DESC;
```

## Query 2: Remote Work Feasibility by Country

```sql
SELECT
  c.country,
  c.geom,
  ROUND(AVG(j.remote_feasibility_score), 2) AS avg_remote_feasibility
FROM project.jobs j
JOIN project.countries c ON j.country_id = c.country_id
GROUP BY c.country, c.geom
ORDER BY avg_remote_feasibility DESC;
```

## Query 3: AI Adoption Trends Over Time

```sql
SELECT
  y.year,
  ROUND(AVG(j.ai_adoption_level), 2) AS avg_ai_adoption
FROM project.jobs j
JOIN project.years y ON j.year_id = y.year_id
GROUP BY y.year
ORDER BY y.year;
```

## Query 4: Salary Change Trends Over Time

```sql
SELECT
  y.year,
  ROUND(AVG(j.salary_change_percent), 2) AS avg_salary_change_pct
FROM project.jobs j
JOIN project.years y ON j.year_id = y.year_id
GROUP BY y.year
ORDER BY y.year;
```

## Query 5: Top 10 Most Automatable Job Roles

```sql
SELECT
  r.job_role,
  ROUND(AVG(j.automation_risk_percent), 2) AS avg_automation_risk
FROM project.jobs j
JOIN project.roles r ON j.role_id = r.role_id
GROUP BY r.job_role
ORDER BY avg_automation_risk DESC
LIMIT 10;
```