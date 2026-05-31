select
    table_name,
    column_name,
    data_type
From information_schema.columns
Where
table_name ='job_postings_fact';

DESCRIBE
job_postings_fact;

SELECT
    CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR), --more unique identifier
    CAST(job_work_from_home AS INT) AS job_work_from_home, --From bolean to numeric value
    CAST(job_posted_date AS date) AS job_posted_date, --From timestamp to date only
    CAST(salary_year_avg AS decimal (10,0)) AS salary_year_avg --From double to no decimal places
FROM
    job_postings_fact
Where
    salary_year_avg IS NOT NULL
LIMIT 10;

--OR--

SELECT
    job_id::VARCHAR || '-' || company_id::VARCHAR, --more unique identifier
    job_work_from_home:: INT AS job_work_from_home, --From bolean to numeric value
    job_posted_date::date AS job_posted_date, --From timestamp to date only
    salary_year_avg::DECIMAL (10,0) AS salary_year_avg --From double to no decimal places
FROM
    job_postings_fact
Where
    salary_year_avg IS NOT NULL
LIMIT 10;
