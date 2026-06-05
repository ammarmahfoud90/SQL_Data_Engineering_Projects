# Data Warehouse & Mart Build: Production ETL Pipeline

A DuckDB-based SQL data-engineering project that ingests raw job-postings data, builds a star-schema data warehouse, and derives three analytics-ready data marts. The whole pipeline runs from a single master script.

## Overview

This project takes raw CSV data about job postings (jobs, companies, skills) and builds a normalized star-schema data warehouse (DW), loads data into the DW from remote CSV files, creates three purpose-built data marts for analytics and reporting, and demonstrates an incremental update / UPSERT pattern for keeping a mart fresh.

The engine is [DuckDB](https://duckdb.org/), an in-process analytical database.

## Tech Stack

Database / Engine: DuckDB. Language: SQL (DuckDB dialect). Data source: Remote CSV files (Google Cloud Storage).

## Project Structure

| File | Purpose |
| ---- | ------- |
| 01_Create_Tables_dw.sql | Creates the DW star-schema tables (dimensions + fact). |
| 02_load_schema_dw.sql | Loads data from remote CSVs into the DW tables. |
| 03_create_flat_mart.sql | Builds a denormalized flat mart for wide-table analysis. |
| 04_create_skills_mart.sql | Builds a skills_mart star schema (skill demand by month). |
| 05_create_priority_mart.sql | Builds a priority_mart for high-priority roles. |
| 06_update_priority_mart.sql | Incremental update / MERGE (UPSERT) for the priority mart. |
| build_dw_marts.sql | Master orchestration script - runs steps 1-6 in order. |
| .gitignore | Ignores local DBs, raw data, secrets, logs, tooling artifacts. |

## Data Warehouse Schema (Star Schema)

The warehouse uses a star schema with two dimensions, one fact table, and a bridge table. company_dim holds companies (company_id, name). skill_dim holds skills (skill_id, skills, type). job_postings_fact is the central fact table (job details, salary, flags, FK to company_dim). skills_job_dim is a bridge table linking jobs to skills (composite PK, FKs to both).

## Data Marts

Flat Mart (flat_mart.job_postings) is a fully denormalized table joining all DW tables, with each job's skills aggregated into a nested STRUCT array. Skills Mart (skills_mart) is a star schema with dim_skills, dim_date_month, and fact_skill_demand_monthly holding monthly skill-demand metrics (total postings, remote, health-insurance, no-degree-required counts). Priority Mart (priority_mart) contains priority_roles (prioritized target roles) and priority_jobs_snapshot, a maintained snapshot of postings for those roles.

## How to Run

Run the entire pipeline with a single DuckDB command:

`duckdb dw_mart.duckdb -c ".read build_dw_marts.sql"`

This creates a dw_mart.duckdb database file and executes all six steps in sequence.

## Notes

Source CSVs are read directly over HTTPS from cloud storage using DuckDB's read_csv(..., AUTO_DETECT TRUE). The .gitignore excludes local database files (*.duckdb), raw/intermediate data, secrets (.env, keys), and common tooling artifacts.
