-- Bucket Salaries
-- < 25 = 'Low'
-- 25-50 = 'Medium'
-- > 50  = 'High'

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'LOW'
        WHEN salary_hour_avg >= 25 AND salary_hour_avg < 50 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
LIMIT 10;

-- Handling Missing Data (Nulls)
-- Filter Null salary values

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'No Data'
        WHEN salary_hour_avg < 25 THEN 'LOW'
        WHEN salary_hour_avg >= 25 AND salary_hour_avg < 50 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS salary_category,
FROM job_postings_fact
LIMIT 10;

-- Categorizing Categorical Values
-- Classify the 'job_title' column Values as:
    -- 'Data Analyst'
    -- 'Data Scientist'
    -- 'Data Engineer'
    SELECT
        job_title,
        CASE
            WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
            WHEN job_title LIKE '%Data%' AND job_title LIKE '%Engineer%' THEN 'Data Engineer'
            WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientist%' THEN 'Data Scientist'
            ELSE 'Other'
         END AS job_title_category,
        job_title_short
    FROM job_postings_fact
    ORDER BY RANDOM ()
    LIMIT 10;

-- Final Example: Conditional Calculations
-- Compute a standardized_salary using yearly salary and adjusted hourly salary (e.g. 2080 hours/year)
-- Categorize salaries into tiers of:
    -- < 75K 'Low'
    -- 75K - 150K 'Medium'
    -- >= 150K 'High'
WITH salaries AS (
SELECT
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    CASE
        WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
        WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
    END AS standardized_salary
FROM job_postings_fact

)
SELECT
    *,
    CASE
        WHEN standardized_salary IS NULL THEN 'Missing'
        WHEN salary_hour_avg * 2080 < 75_000 THEN 'LOW'
        WHEN salary_hour_avg * 2080 < 150_000 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS salary_bucket
FROM salaries
ORDER BY standardized_salary DESC
LIMIT 10;
