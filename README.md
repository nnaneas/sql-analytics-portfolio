# sql-analytics-portfolio

## Overview

This repository contains a reproducible SQL analytics environment built with PostgreSQL and Docker.
It is designed for practicing database schema design, data loading from CSV files, and analytical querying in a clean, production-like setup.

The project focuses on **structure, reproducibility, and clarity**, rather than manual setup steps.

---

## Technologies Used

* PostgreSQL
* Docker & Docker Compose
* pgAdmin
* SQL
* CSV datasets

---

## Project Structure

The repository is organized to separate configuration, data, and initialization logic:

* `data/` — raw CSV datasets
* `init/` — SQL scripts for schema creation and data loading
* `docker-compose.yaml` — service orchestration
* `.env` — environment configuration

---

## Database Design

The database schema represents a simple business domain and includes the following entities:

* employees
* customers
* products
* orders
* sales

Relationships, primary keys, foreign keys, and indexes are defined to ensure data integrity and support analytical queries.

The schema definition is handled entirely through SQL initialization scripts.

---

## Data Loading

CSV datasets are loaded automatically into PostgreSQL during container initialization.
This simulates a basic ETL process using native PostgreSQL capabilities.

No manual data import is required.

---

## Running the Environment

To start the PostgreSQL and pgAdmin services:

```bash
docker compose up
```

Docker automatically initializes the database, applies the schema, and loads the data.

---

## Database Access

pgAdmin is available via browser and can be used to explore the database, run queries, and inspect schemas.

```
http://localhost:5050
```

Connection details are defined in the environment configuration file.

---

## Data Validation

Sample queries can be executed to confirm that tables are populated correctly:

```sql
SELECT * FROM customers LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM sales LIMIT 10;
```

---

## Stopping the Environment

To stop the running containers:

```bash
docker compose down
```

To fully reset the environment (including database volumes):

```bash
docker compose down -v
docker compose up --build
```

---

## Purpose

This project is intended for:

* SQL analytics practice
* Portfolio demonstration
* Learning Dockerized database workflows
* Writing and testing analytical SQL queries
* Understanding schema-driven data loading
