## Query 1: Top AI Replacement Risk Countries

```sql
SELECT
  c.country,
  ROUND(AVG(j.ai_replacement_score), 2) AS avg_ai_replacement
FROM project.jobs j
JOIN project.countries c ON j.country_id = c.country_id
GROUP BY c.country
ORDER BY avg_ai_replacement DESC;
```

Identifies countries facing highest average AI replacement threat across all jobs.

## Query 2: Automation Risk Trends Over Time

```sql
SELECT
  c.country,
  y.year,
  ROUND(AVG(j.automation_risk_percent), 2) AS avg_automation_risk
FROM project.jobs j
JOIN project.countries c ON j.country_id = c.country_id
JOIN project.years y ON j.year_id = y.year_id
GROUP BY c.country, y.year
ORDER BY c.country, y.year;
```

Tracks automation risk evolution by country-year combinations.

## Query 3: Most AI-Impacted Industries

```sql
SELECT
  i.industry,
  ROUND(AVG(j.ai_replacement_score), 2) AS avg_ai_replacement
FROM project.jobs j
JOIN project.industries i ON j.industry_id = i.industry_id
GROUP BY i.industry
ORDER BY avg_ai_replacement DESC;
```

Ranks industries by average AI replacement exposure.

## Query 4: High-Risk Job Roles by Country

```sql
SELECT
  r.job_role,
  c.country,
  ROUND(AVG(j.ai_replacement_score), 2) AS avg_ai_replacement
FROM project.jobs j
JOIN project.roles r ON j.role_id = r.role_id
JOIN project.countries c ON j.country_id = c.country_id
GROUP BY r.job_role, c.country
ORDER BY avg_ai_replacement DESC;
```

Pinpoints most vulnerable job roles within specific countries.

## Query 5: Countries with Largest Salary Declines

```sql
SELECT
  c.country,
  ROUND(AVG(j.salary_change_percent), 2) AS avg_salary_change_pct
FROM project.jobs j
JOIN project.countries c ON j.country_id = c.country_id
GROUP BY c.country
ORDER BY avg_salary_change_pct ASC;
```

Reveals countries experiencing most significant post-AI salary reductions.

## Query 6: Top Remote Work Countries

```sql
SELECT
  c.country,
  ROUND(AVG(j.remote_feasibility_score), 2) AS avg_remote_score
FROM project.jobs j
JOIN project.countries c ON j.country_id = c.country_id
GROUP BY c.country
ORDER BY avg_remote_score DESC;
```

Identifies countries best positioned for remote work transition.

## Query 7: Education vs Automation Risk

```sql
SELECT
  education_requirement_level,
  ROUND(AVG(automation_risk_percent), 2) AS avg_automation_risk
FROM project.jobs
GROUP BY education_requirement_level
ORDER BY education_requirement_level;
```

Analyzes automation vulnerability across education requirements.
