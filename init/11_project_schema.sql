CREATE TABLE project.roles (
  role_id SERIAL PRIMARY KEY,
  job_role VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE project.industries (
  industry_id SERIAL PRIMARY KEY,
  industry VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE project.countries (
  country_id SERIAL PRIMARY KEY,
  country VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE project.years (
  year_id SERIAL PRIMARY KEY,
  year SMALLINT NOT NULL UNIQUE
);

CREATE TABLE project.jobs (
  job_id BIGINT PRIMARY KEY,
  role_id INTEGER NOT NULL REFERENCES project.roles(role_id),
  industry_id INTEGER NOT NULL REFERENCES project.industries(industry_id),
  country_id INTEGER NOT NULL REFERENCES project.countries(country_id),
  year_id INTEGER NOT NULL REFERENCES project.years(year_id),
  education_requirement_level SMALLINT NOT NULL,
  automation_risk_percent NUMERIC(6,2) NOT NULL,
  ai_replacement_score NUMERIC(6,2) NOT NULL,
  skill_gap_index NUMERIC(6,2) NOT NULL,
  salary_before_usd NUMERIC(12,2) NOT NULL,
  salary_after_usd NUMERIC(12,2) NOT NULL,
  salary_change_percent NUMERIC(7,2)  NOT NULL,
  skill_demand_growth_percent NUMERIC(7,2)  NOT NULL,
  remote_feasibility_score NUMERIC(6,2)  NOT NULL,
  ai_adoption_level NUMERIC(6,2)  NOT NULL,
  CONSTRAINT chk_automation_risk_percent CHECK (automation_risk_percent BETWEEN 0 AND 100),
  CONSTRAINT chk_skill_gap_index CHECK (skill_gap_index BETWEEN 0 AND 100),
  CONSTRAINT chk_remote_feasibility_score CHECK (remote_feasibility_score BETWEEN 0 AND 100),
  CONSTRAINT chk_ai_adoption_level CHECK (ai_adoption_level BETWEEN 0 AND 100)
);

CREATE INDEX idx_jobs_role ON project.jobs(role_id);
CREATE INDEX idx_jobs_industry ON project.jobs(industry_id);
CREATE INDEX idx_jobs_country ON project.jobs(country_id);
CREATE INDEX idx_jobs_year ON project.jobs(year_id);
