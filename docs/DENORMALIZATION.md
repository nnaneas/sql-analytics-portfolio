## Table Creation Query

```sql
CREATE TABLE project.fact_jobs AS
SELECT
  j.job_id,
  r.job_role,
  i.industry,
  c.country,
  y.year,
  j.education_requirement_level,
  j.automation_risk_percent,
  j.ai_replacement_score,
  j.skill_gap_index,
  j.salary_before_usd,
  j.salary_after_usd,
  j.salary_change_percent,
  j.skill_demand_growth_percent,
  j.remote_feasibility_score,
  j.ai_adoption_level,
  c.geom
FROM project.jobs j
JOIN project.roles r ON j.role_id = r.role_id
JOIN project.industries i ON j.industry_id = i.industry_id
JOIN project.countries c ON j.country_id = c.country_id
JOIN project.years y ON j.year_id = y.year_id;
```

This creates a denormalized analytics table with 16 columns combining job metrics, dimensions, and spatial data.

## Table Preview

```sql
SELECT * FROM project.fact_jobs;
```