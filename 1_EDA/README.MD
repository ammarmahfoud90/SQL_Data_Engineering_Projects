# 🔍 Exploratory Data Analysis with SQL: Data Engineer Job Market Analytics

## 📌 Project Overview

This SQL project analyzes the data engineering job market using real-world job posting data stored in a star-schema data warehouse. The analysis focuses on identifying the most in-demand skills, the highest-paying technologies, and the optimal balance between salary and market demand for data engineering roles.

Using analytical SQL, multi-table joins, aggregations, statistical analysis, and calculated scoring models, this project transforms raw job posting data into actionable market insights.

---

# 🧾 Executive Summary

### ✅ Project Scope
Built analytical SQL queries to answer key business questions about the remote data engineering job market.

### ✅ Data Modeling
Worked with a star-schema warehouse containing fact, dimension, and bridge tables.

### ✅ SQL & Analytics
Applied:
- Complex multi-table joins
- Aggregations and statistical functions
- Filtering and ranking techniques
- Derived scoring metrics
- Median-based salary analysis

### ✅ Key Outcomes
The analysis revealed:
- SQL and Python dominate the data engineering market
- Cloud technologies like AWS and Azure remain highly valuable
- Infrastructure tools such as Kubernetes and Terraform correlate with premium salaries
- Big data technologies like Apache Spark show strong market demand

---

# 🎯 Business Questions

This project answers the following questions:

- Which skills are most in-demand for data engineers?
- Which skills command the highest salaries?
- Which skills provide the best balance between demand and compensation?

---

# 🏗️ Data Warehouse Schema

The project uses a star-schema data warehouse structure.

## Fact Table
### `job_postings_fact`
Contains job posting information including:
- job titles
- salaries
- locations
- remote status
- posting dates

## Dimension Tables
### `company_dim`
Company-related metadata.

### `skills_dim`
Catalog of technical skills and technologies.

## Bridge Table
### `skills_job_dim`
Resolves the many-to-many relationship between job postings and skills.

---

# 🧰 Tech Stack

| Category | Technology |
|---|---|
| Query Engine | DuckDB |
| Language | SQL |
| Data Model | Star Schema |
| Development | VS Code |
| Version Control | Git & GitHub |

---

# 📂 Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql
├── 02_top_paying_skills.sql
├── 03_optimal_skills.sql
└── README.md