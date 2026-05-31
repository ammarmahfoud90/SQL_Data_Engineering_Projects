SELECT ['SQL','PYTHON','R'] AS Skills_Array;


WITH skills AS (
    SELECT 'PYTHON' AS Skill
    UNION ALL
    SELECT 'SQL'
    UNION ALL
    SELECT 'R'
    )
SELECT ARRAY_AGG(skill) AS skills_array
FROM skills;


WITH SKILL_TABLE AS (
    SELECT 'PYTHON' AS SKILLS, 'PROGRAMMING' AS TYPES
    UNION ALL
    SELECT 'SQL' , 'QUERY_LANGUAGE'
    UNION ALL
    SELECT 'R' , 'PROGRAMMING'
)
SELECT SKILL
FROM SKILL_TABLE;



-- ARRAY- FINAL EXAMPLE
-- BUILD A FLAT SKILL TABLE FOR CO-WORKERS TO ACCESS JOB TITLES, SALARY INFO, AND SKILLS IN ONE TABLE

CREATE OR REPLACE TEMP TABLE job_skills_array AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills_array
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
group by ALL;