```md
# sql-analytics-portfolio

## Creating a New Database

## Description

This document outlines the process of setting up a PostgreSQL database environment from scratch.
It covers repository initialization, containerized database deployment, schema definition,
data ingestion from CSV files, and database access through pgAdmin.
The environment is fully reproducible and managed using Docker Compose.

---

## 1. Repository Initialization

A new GitHub repository named `sql-analytics-portfolio` was created.
The repository includes a README file and a `.gitignore` file.

The repository was cloned locally and opened in Visual Studio Code for development.

---

## 2. Project Setup

A project directory was created locally and opened in Visual Studio Code.
All files related to database configuration, data storage, and initialization scripts
are maintained within this repository.

---

## 3. Dataset Preparation

A folder named `data` was created to store the source datasets.
The following CSV files were added:

- `customers.csv`
- `employees.csv`
- `orders.csv`
- `products.csv`
- `sales.csv`

These files are used to populate the database during initialization.

---

## 4. Database Schema Definition

Database tables and relationships are defined in an SQL initialization script.

File location:
```

init/01_schema.sql

```

The schema includes the following tables:

- employees
- customers
- products
- orders
- sales

Primary keys, foreign keys, and indexes are defined to ensure data integrity
and improve query performance.

---

## 5. Data Loading (ETL Process)

A second SQL initialization script is responsible for loading data from CSV files
into the database tables using PostgreSQL `COPY` commands.

File location:
```

init/02_etl.sql

```

Data is inserted automatically when the database container is created for the first time.

---

## 6. Environment Configuration

Database credentials and configuration parameters are stored in a `.env` file
located at the root of the project.

The file defines:
- database port
- database name
- user credentials
- pgAdmin login information

---

## 7. Docker Configuration

Docker Compose is used to manage the database environment.

The configuration includes:
- a PostgreSQL service
- a pgAdmin service
- persistent volumes for database data
- mounted initialization scripts and datasets

File location:
```

docker-compose.yaml

````

---

## 8. Running the Database

The database environment is started using Docker Compose:

```bash
docker compose up
````

Docker automatically executes the initialization scripts and loads the data.

---

## 9. Database Access

pgAdmin is available through a web browser.

```
http://localhost:5050
```

The PostgreSQL server is registered in pgAdmin using the service name defined in
the Docker Compose configuration.

---

## 10. Data Verification

After initialization, the data can be verified by executing sample queries:

```sql
SELECT * FROM public.customers LIMIT 10;
SELECT * FROM public.employees LIMIT 10;
SELECT * FROM public.orders LIMIT 10;
SELECT * FROM public.products LIMIT 10;
SELECT * FROM public.sales LIMIT 10;
```

---

## 11. Stopping the Environment

To stop and remove the running containers:

```bash
docker compose down
```

---

## 12. Reinitialization Notes

If changes are made to the Docker configuration, the environment must be reset
by removing existing volumes and restarting the containers.

```bash
docker compose down -v
docker compose up --build
```

---

## Project Structure

```
.
├── README.md
├── .gitignore
├── .env
├── docker-compose.yaml
├── data/
│   ├── customers.csv
│   ├── employees.csv
│   ├── orders.csv
│   ├── products.csv
│   ├── sales.csv
├── init/
│   ├── 01_schema.sql
│   ├── 02_etl.sql
```
