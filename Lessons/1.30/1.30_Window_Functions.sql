-- Count Rows - Aggregation Only
SELECT
    COUNT(*)
FROM 
    job_postings_fact;

-- Count Rows - Window Function
SELECT
    Job_id,
    count(*) over ()
FROM
    job_postings_fact;





SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    company_id,
    AVG(salary_hour_avg) OVER(
        PARTITION BY job_title_short, company_id
    )
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL
ORDER BY
    RANDOM()
LIMIT 10;




SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    company_id,
    RANK() OVER(
            ORDER BY salary_hour_avg DESC
    ) AS  rank_hourly_salary
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC
LIMIT 10;



SELECT
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(
            PARTITION BY job_title_short
            ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL AND
    job_title_short = 'Data Engineer'
ORDER BY
    job_title_short,
    job_posted_date
LIMIT 10;



SELECT
    *,
    ROW NUMBER () OVER (
      ORDER BY job_posted_date
      )
FROM
    job_postings_fact
ORDER BY
    job_posted_date
LIMIT 20;



-- LAG - TIME BASED COMPARATION OF COMPANY YEARLY SALARY
SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_posting_salary,
    salary_year_avg - LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS SALARY_CHANGE
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    company_id,
    job_posted_date
LIMIT 60;