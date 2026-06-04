--duckdb dw_mart.duckdb -c ".read build_dw_marts.sql"


-- STEP 1 : DW - Create star schema tables
.read 01_Create_Tables_dw.sql

-- Step 2 : DW - Load data from CSV files into tables
.read 02_load_schema_dw.sql

-- step 3: Mart - Create_flat_mart.sql
.read 03_create_flat_mart.sql

-- step 4: Mart - Create skills demand mart
.read 04_create_skills_mart.sql

-- Step 5: Mart - Create priority mart
.read 05_create_priority_mart.sql

-- Step 6: Mart - Update priority mart
.read 06_update_priority_mart.sql