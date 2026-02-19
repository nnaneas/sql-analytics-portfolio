# Data Dictionary
Database: final_sql_project
Schema: project

---

## Table: roles

| Column | Type | Description | Constraints |
|--------|------|------------|------------|
| role_id | SERIAL | Unique identifier of job role | Primary Key |
| job_role | VARCHAR(100) | Name of the job role | NOT NULL, UNIQUE |

---

## Table: industries

| Column | Type | Description | Constraints |
|--------|------|------------|------------|
| industry_id | SERIAL | Unique identifier of industry | Primary Key |
| industry | VARCHAR(100) | Industry name | NOT NULL, UNIQUE |

---

## Table: countries

| Column | Type | Description | Constraints |
|--------|------|------------|------------|
| country_id | SERIAL | Unique identifier of country | Primary Key |
| country | VARCHAR(100) | Country name | NOT NULL, UNIQUE |
| geom | geometry(Point, 4326) | Geographic centroid of country | GIST indexed |

---

## Table: years

| Column | Type | Description | Constraints |
|--------|------|------------|------------|
| year_id | SERIAL | Unique identifier of year | Primary Key |
| year | SMALLINT | Calendar year | NOT NULL, UNIQUE |

---

## Table: jobs

| Column | Type | Description | Constraints |
|--------|------|------------|------------|
| job_id | BIGINT | Unique job record ID | Primary Key |
| role_id | INTEGER | Reference to roles table | NOT NULL, FK |
| industry_id | INTEGER | Reference to industries table | NOT NULL, FK |
| country_id | INTEGER | Reference to countries table | NOT NULL, FK |
| year_id | INTEGER | Reference to years table | NOT NULL, FK |
| education_requirement_level | SMALLINT | Required education level | NOT NULL |
| automation_risk_percent | NUMERIC(6,2) | Automation risk percentage | CHECK 0–100 |
| ai_replacement_score | NUMERIC(6,2) | AI replacement score | CHECK 0–100 |
| skill_gap_index | NUMERIC(6,2) | Skill gap index | CHECK 0–100 |
| salary_before_usd | NUMERIC(12,2) | Salary before AI impact | NOT NULL |
| salary_after_usd | NUMERIC(12,2) | Salary after AI impact | NOT NULL |
| salary_change_percent | NUMERIC(7,2) | Salary change percentage | NOT NULL |
| skill_demand_growth_percent | NUMERIC(7,2) | Skill demand growth | NOT NULL |
| remote_feasibility_score | NUMERIC(6,2) | Remote work feasibility | CHECK 0–100 |
| ai_adoption_level | NUMERIC(6,2) | AI adoption level | CHECK 0–100 |
