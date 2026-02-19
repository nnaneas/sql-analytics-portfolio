COPY project.countries
FROM '/docker-entrypoint-initdb.d/data/project_schema/countries.csv'
CSV HEADER;

SELECT * FROM project.countries;

COPY project.industries
FROM '/docker-entrypoint-initdb.d/data/project_schema/industries.csv'
CSV HEADER;

SELECT * FROM project.industries;

COPY project.jobs
FROM '/docker-entrypoint-initdb.d/data/project_schema/jobs.csv'
CSV HEADER;

SELECT * FROM project.jobs;

COPY project.roles
FROM '/docker-entrypoint-initdb.d/data/project_schema/roles.csv'
CSV HEADER;

SELECT * FROM project.roles;

COPY project.years
FROM '/docker-entrypoint-initdb.d/data/project_schema/years.csv'
CSV HEADER;

SELECT * FROM project.years;