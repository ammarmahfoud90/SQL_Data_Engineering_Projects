CREATE OR REPLACE TEMP TABLE jobs_2023 AS
SELECT
    * EXCLUDE(job_id, job_posted_date)
FROM
    job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * FROM jobs_2023;

CREATE OR REPLACE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE( job_id, job_posted_date)
FROM 
    job_postings_fact
WHERE EXTRACT (YEAR FROM job_posted_date) = 2024;

SELECT * FROM jobs_2024;

-- which unique job postings appeared in either 2023 or 2024?

SELECT COUNT(*) FROM jobs_2023
UNION
SELECT COUNT(*) FROM jobs_2024;