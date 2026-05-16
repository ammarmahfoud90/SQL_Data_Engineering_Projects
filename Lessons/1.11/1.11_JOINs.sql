SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact as jpf
LEFT JOIN company_dim as cd
    ON jpf.company_id = cd.company_id
LIMIT 10;


SELECT
    skill_id,
     
FROM skill_dim
LEFT JOIN skills_job_dim AS skd
ON 
