# PROJECT INFORMATION - 2_DW_Mart_Build

This document captures all information about the project located at `SQL_Data_Engineering_Projects/2_DW_Mart_Build`.

## 1. Purpose

An end-to-end SQL ETL pipeline that turns raw job-postings CSV data into a star-schema data warehouse and three analytics-ready data marts, orchestrated by a single master DuckDB script. It is the second project in a larger SQL Data Engineering repository that also contains a 1_EDA folder and a Lessons folder.

## 2. Architecture & Data Flow

Raw CSVs (cloud storage) feed the Data Warehouse (star schema), which in turn feeds three downstream marts: the Flat Mart (denormalized wide table), the Skills Mart (monthly skill-demand star schema), and the Priority Mart (priority roles plus a maintained snapshot kept current with incremental updates).

Engine: DuckDB (in-process analytical database). Dialect: DuckDB SQL.

## 3. File-by-File Detail

### build_dw_marts.sql (Master orchestration script)

Run command at top: `duckdb dw_mart.duckdb -c ".read build_dw_marts.sql"`. It executes the steps in order using DuckDB's `.read`: Step 1 reads 01_Create_Tables_dw.sql, Step 2 reads 02_load_schema_dw.sql, Step 3 reads 03_create_flat_mart.sql, Step 4 reads 04_create_skills_mart.sql, Step 5 reads 05_create_priority_mart.sql, and Step 6 reads 06_update_priority_mart.sql.

### 01_Create_Tables_dw.sql (Step 1 - DW: create star-schema tables)

Drops (IF EXISTS) the four tables for a clean rebuild, then creates them. company_dim(company_id INTEGER PK, name VARCHAR). skill_dim(skill_id INTEGER PK, skills VARCHAR, type VARCHAR). job_postings_fact(job_id INTEGER PK, company_id INTEGER, job_title_short VARCHAR, job_title VARCHAR, job_location VARCHAR, job_via VARCHAR, job_schedule_type VARCHAR, job_work_from_home BOOLEAN, search_location VARCHAR, job_posted_date TIMESTAMP, job_no_degree_mention BOOLEAN, job_health_insurance BOOLEAN, job_country VARCHAR, salary_rate VARCHAR, salary_year_avg DOUBLE, salary_hour_avg DOUBLE, FK company_id to company_dim). skills_job_dim(skill_id INTEGER, job_id INTEGER, PK(skill_id, job_id), FK skill_id to skill_dim, FK job_id to job_postings_fact) is the bridge/junction table. Ends with a query against information_schema.tables to list created tables.

### 02_load_schema_dw.sql (Step 2 - DW: load data from CSV)

Loads each table from a remote CSV via read_csv(..., AUTO_DETECT TRUE). company_dim from company_dim.csv, skill_dim from skills_dim.csv, job_postings_fact from job_postings_fact.csv, and skills_job_dim from skills_job_dim.csv (all hosted on Google Cloud Storage at storage.googleapis.com/sql_de/). Prints progress messages and ends with a row-count validation using COUNT(*) plus UNION ALL across all four tables.

### 03_create_flat_mart.sql (Step 3 - Flat Mart)

DROP SCHEMA IF EXISTS flat_mart CASCADE, then CREATE SCHEMA flat_mart. Creates flat_mart.job_postings as a fully denormalized table that selects all fact columns from job_postings_fact (alias jpf), adds company name from company_dim, and aggregates each job's skills into a nested array of structs via ARRAY_AGG(STRUCT_PACK(type, name)) AS skills_and_types. Joins: jpf LEFT JOIN company_dim, LEFT JOIN skills_job_dim, LEFT JOIN skill_dim, with GROUP BY ALL. Includes record-count validation and a sample SELECT ... LIMIT.

### 04_create_skills_mart.sql (Step 4 - Skills Mart star schema)

DROP SCHEMA IF EXISTS skills_mart CASCADE, then CREATE SCHEMA skills_mart. Builds dim_skills(skill_id PK, skills, type) from skill_dim. Builds dim_date_month(month_start_date DATE PK, year, month, quarter, quarter_name, year_quarter) using DATE_TRUNC('month', ...) and EXTRACT(...) on job_posted_date. Builds fact_skill_demand_monthly(skill_id, month_start_date, job_title_short, postings_count, remote_postings_count, health_insurance_postings_count, no_degree_mention_postings_count, PK(skill_id, month_start_date, job_title_short), FK skill_id to dim_skills, FK month_start_date to dim_date_month). The fact is populated via a CTE (job_postings_prep) that flags each posting (is_remote, has_health_insurance, no_degree_required via CASE) joining job_postings_fact INNER JOIN skills_job_dim, then aggregates COUNT(*) and SUM(flags) grouped by skill, month, and title. Includes per-table record-count validation and sample SELECTs.

### 05_create_priority_mart.sql (Step 5 - Priority Mart)

DROP SCHEMA IF EXISTS priority_mart CASCADE, then CREATE SCHEMA priority_mart. Creates priority_roles(role_id PK, role_name, priority_lvl) seeded with Data Engineer, Senior Data Engineer, and Software Engineer with priority levels. Creates priority_jobs_snapshot(jobs_id PK, job_title_short, company_name, job_posted_date, salary_year_average DOUBLE, priority_lvl, update_at TIMESTAMP), populated by joining job_postings_fact LEFT JOIN company_dim INNER JOIN priority_roles ON job_title_short = role_name, stamping CURRENT_TIMESTAMP as update_at. Ends with a summary query: job_count, MIN(priority_lvl), MIN(update_at) grouped by job_title_short ordered by job_count DESC.

### 06_update_priority_mart.sql (Step 6 - Incremental update / UPSERT)

Demonstrates a production-style refresh pattern. Updates priority_roles SET priority_lvl WHERE role_name = 'Data Engineer'. Inserts a new role, 'Data Scientist'. Runs a validation SELECT of priority_roles. Creates a temp table src_priority_jobs (rebuilds the latest source set from job_postings_fact plus company_dim plus priority_roles, with CURRENT_TIMESTAMP). Then MERGE INTO priority_jobs_snapshot USING src_priority_jobs: WHEN MATCHED AND priority_lvl IS DISTINCT FROM source then UPDATE, WHEN NOT MATCHED then INSERT, WHEN NOT MATCHED BY SOURCE then DELETE (a full UPSERT plus delete-orphans synchronization). Ends with a final validation summary query grouped by job_title_short.

### .gitignore

Ignores local databases (*.duckdb, *.duckdb.wal, *.sqlite, *.db), raw/intermediate data (data/raw, data/tmp, data/intermediate, exports), secrets (.env, .env.*, *.key, *.pem), system files (.DS_Store, Thumbs.db), logs and temp files (logs, tmp, *.log), tooling artifacts (target, .idea, .vscode, __pycache__), and course/author-specific files (data, course_build.sql, .cursorrules).

## 4. Data Warehouse Schema Summary

Dimensions: company_dim, skill_dim. Fact: job_postings_fact. Bridge: skills_job_dim (many-to-many between jobs and skills).

## 5. Data Marts Summary

flat_mart provides one wide denormalized job_postings table with skills nested as a STRUCT array. skills_mart provides dim_skills, dim_date_month, and fact_skill_demand_monthly. priority_mart provides priority_roles and priority_jobs_snapshot, kept fresh via MERGE.

## 6. Key SQL / Engineering Techniques Demonstrated

Star-schema modeling (dimensions, fact, bridge table, PK/FK constraints). Remote CSV ingestion with read_csv(..., AUTO_DETECT TRUE). Denormalization with ARRAY_AGG plus STRUCT_PACK (nested types). Date dimension construction via DATE_TRUNC and EXTRACT. Boolean-flag fact aggregation (CASE then SUM) for KPI counts. Idempotent rebuilds (DROP ... IF EXISTS / CREATE OR REPLACE). Incremental loading with MERGE (UPSERT plus delete-by-source). Pipeline orchestration via a single master script using `.read`.

## 7. How to Run

`duckdb dw_mart.duckdb -c ".read build_dw_marts.sql"`

This creates dw_mart.duckdb and runs steps 1 through 6 in order.

## 8. Source

GitHub: ammarmahfoud90/SQL_Data_Engineering_Projects. Path: 2_DW_Mart_Build. Latest commit observed prior to documentation: "load schemas and create master build script" (b16d2c7).
