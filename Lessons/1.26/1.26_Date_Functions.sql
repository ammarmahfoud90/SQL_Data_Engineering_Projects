SELECT
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time,
    job_posted_date::TIMESTAMP AS timestamp,
    job_posted_date::TIMESTAMPTZ AS timestamptz
FROM
    job_postings_fact
LIMIT 10;


SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE   job_title_short = 'Data Engineer'
    AND
        EXTRACT(YEAR FROM job_posted_date) = '2024'
GROUP BY 
    DATE_TRUNC('month',job_posted_date)
ORDER BY
   DATE_TRUNC('month',job_posted_date);
-- FOR THE ORDER BY HERE , WE COULD USE THE ALIAS BECAUSE DUCKDB ALLOWS THEM
-- BUT FOR GENERAL USE I KEPT THE OREDER BY AS IT SHOUL BE GLOBALY..



SELECT
    job_posted_date,
    DATE_TRUNC('month',job_posted_date) AS job_posted_month
FROM
    job_postings_fact
ORDER BY RANDOM()
LIMIT 10;
