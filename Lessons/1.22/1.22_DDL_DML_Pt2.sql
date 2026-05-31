CREATE OR REPLACE TABLE staging.job_postings_flat AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.search_location,
    jpf.job_no_degree_mention,
    jpf.job_country,
    jpf.salary_year_avg,
    cd.name                       AS company_name,
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON cd.company_id = jpf.company_id;


    SELECT COUNT(*)
    FROM staging.job_postings_flat
    ;

CREATE OR REPLACE VIEW staging.priority_jobs_flat_view AS
SELECT
     jpf.*
FROM
    staging.job_postings_flat AS jpf
JOIN main.priority_roles AS r
    ON jpf.job_title_short = r.role_name
WHERE r.priority_level = 1;

SELECT 
    job_title_short,
    count(*) AS job_count
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;