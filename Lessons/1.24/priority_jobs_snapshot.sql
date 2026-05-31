    -- CREATE TEMP TABLE
    CREATE OR REPLACE TEMP TABLE src_priority_jobs AS
    SELECT 
    jpf.job_id,
    jpf.job_title_short,
    cd.name AS company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    r.priority_level,
    CURRENT_TIMESTAMP AS update_at

FROM
    data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
    INNER JOIN jobs_mart.priority_roles AS r
    ON jpf.job_title_short = r.role_name;

    -- UPDATE STATMENT
    UPDATE main.priority_jobs_snapshot AS tgt
    SET     
            priority_level = src.priority_level
            update_at = src.updated_at
    FROM src_priority_jobs AS src
    WHERE tgt.job_id = src.job_id
        AND tgt.priority_level IS DISTINCT FROM src.priority_level
 SELECT  
    job_title_short,
    count(*) AS job_count,
    MIN (priority_level) AS priority_level,
    MIN (update_at) AS updated_at
FROM priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;       
    -- INSERT STATMENT


    -- DELETE STATMENT