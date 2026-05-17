# 🔍 Exploratory Data Analysis with SQL: Data Engineer Job Market Analytics

## 📌 Project Overview

This SQL project analyzes the data engineering job market using real-world job posting data stored in a star-schema data warehouse.

The analysis focuses on identifying:
- The most in-demand skills
- The highest-paying technologies
- The optimal balance between salary and market demand

Using analytical SQL, multi-table joins, aggregations, statistical analysis, and calculated scoring models, this project transforms raw job posting data into actionable market insights.

---

# 🖼️ Project Architecture

![Project Architecture](images/1_1_Project1_EDA.png)

---

# 🧾 Executive Summary

### ✅ Project Scope
Built analytical SQL queries to answer key business questions about the remote data engineering job market.

### ✅ Data Modeling
Worked with a star-schema warehouse containing:
- Fact tables
- Dimension tables
- Bridge tables
- Analytical data marts

### ✅ SQL & Analytics
Applied:
- Complex multi-table joins
- Aggregations and statistical functions
- Filtering and ranking techniques
- Derived scoring metrics
- Median-based salary analysis
- Window functions
- CTEs and subqueries

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

![Data Warehouse](images/1_2_Data_Warehouse.png)

---

# 📊 Skills Mart

The Skills Mart aggregates skill demand metrics and tracks hiring trends over time.

![Skills Mart](images/1_2_Skills_Mart.png)

---

# 🏢 Company Mart

The Company Mart organizes hiring analytics by company, role, and location dimensions.

![Company Mart](images/1_2_Company_Mart.png)

---

# 🧱 Flat Mart

The Flat Mart denormalizes warehouse tables into a simplified analytical structure optimized for reporting and BI tools.

![Flat Mart](images/1_2_Flat_Mart.png)

---

# 🚀 Priority Mart

The Priority Mart tracks prioritized hiring opportunities and incremental updates for high-value roles.

![Priority Mart](images/1_2_Priority_Mart.png)

---

# ⚙️ Data Pipeline Architecture

The pipeline ingests raw CSV job posting data into DuckDB/MotherDuck and transforms it into analytical marts for downstream consumption.

![Pipeline Architecture](images/1_2_Project2_Data_Pipeline.png)

---

# 🧰 Tech Stack

| Category | Technology |
|---|---|
| Query Engine | DuckDB |
| Cloud Warehouse | MotherDuck |
| Language | SQL |
| Data Modeling | Star Schema |
| Data Processing | Analytical SQL |
| Development | VS Code |
| Version Control | Git & GitHub |

---

# 📂 Repository Structure

```text
1_EDA/
├── images/
│   ├── 1_1_Project1_EDA.png
│   ├── 1_2_Company_Mart.png
│   ├── 1_2_Data_Warehouse.png
│   ├── 1_2_Flat_Mart.png
│   ├── 1_2_Priority_Mart.png
│   ├── 1_2_Project2_Data_Pipeline.png
│   └── 1_2_Skills_Mart.png
│
├── 01_top_demanded_skills.sql
├── 02_top_paying_skills.sql
├── 03_optimal_skills.sql
└── README.md
```

---

# 📈 Key Analytical Concepts Demonstrated

- Relational Data Modeling
- Star Schema Design
- Fact & Dimension Tables
- Bridge Tables
- Aggregations & Grouping
- Median Salary Analysis
- Ranking & Filtering
- Data Mart Architecture
- Analytical SQL Development

---

# ✅ Project Status

✔ Completed  
✔ Published to GitHub  
✔ Portfolio Ready