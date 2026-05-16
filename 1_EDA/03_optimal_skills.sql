/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.

*/

SELECT
     sd.skills,
      ROUND(MEDIAN (JPF.salary_year_avg), 0) AS median_salary,
     COUNT(jpf.*) AS demand_count,
     COUNT(jpf.salary_year_avg) AS Corrected_Demand_Count,
     ROUND( MEDIAN(JPF.salary_year_avg) * COUNT(jpf.salary_year_avg),0 )/1_000_000 AS Optimal_Score,
     ROUND(LN(COUNT(jpf.salary_year_avg)),1) AS LN_DEMAND_COUNT
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE (job_work_from_home = true)
AND
(job_title_short = 'Data Engineer')
AND
(jpf.salary_year_avg IS NOT NULL)
GROUP BY
skills
HAVING
COUNT(jpf.*) >100
ORDER BY
Optimal_Score DESC
LIMIT 25;


/*
Here's a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries:

Top Skills by Optimal Score:
- Terraform leads the list with a $184K median salary and 193 postings, resulting in the highest overall "optimal score".
- Python and SQL dominate demand (over 1100 postings each), with strong median salaries of $135K and $130K, respectively.
- AWS (783 postings, $137K median), Spark (503 postings, $140K median), and Airflow (386 postings, $150K median) are all highly sought-after cloud and big data technologies.
- Kafka offers high compensation ($145K median) and solid demand (292 postings).
- Tools like Snowflake, Azure, and Databricks each have 250–475 postings and median salaries between $128–$137K.

DevOps & Engineering Tools:
- Airflow ($150K), Kubernetes ($150.5K), and Docker ($135K) stand out for their mix of demand and top median salaries.
- Git ($140K/208 postings) and Github ($135K/127 postings) have broad utility and competitive compensation.

Noteworthy Languages:
- Java (303 postings, $135K median) and Scala (247 postings, $137K median) remain strong choices for well-paid data engineering roles.
- Go ($140K/113 postings) is another programming language with excellent compensation.

Databases & Cloud:
- Redshift ($130K/274 postings), GCP ($136K/196 postings), Hadoop ($135K/198 postings), NoSQL ($134.4K/193 postings), and MongoDB ($135.8K/136 postings) add to a well-rounded data engineering skill set.
- R, Pyspark, and BigQuery each deliver competitive salaries and meet the threshold for demand.

Summary:
Skills that consistently appear near the top balance a strong combination of market demand (job security) and financial benefit. Python, SQL, AWS, Spark, Airflow, and Terraform are particularly strategic for both immediate opportunities and longer-term career growth in data engineering
┌────────────┬───────────────┬──────────────┬────────────────────────┬───────────────┬─────────────────┐
│   skills   │ median_salary │ demand_count │ Corrected_Demand_Count │ Optimal_Score │ LN_DEMAND_COUNT │
│  varchar   │    double     │    int64     │         int64          │    double     │     double      │
├────────────┼───────────────┼──────────────┼────────────────────────┼───────────────┼─────────────────┤
│ python     │      135000.0 │         1133 │                   1133 │       152.955 │             7.0 │
│ sql        │      130000.0 │         1128 │                   1128 │        146.64 │             7.0 │
│ aws        │      137320.0 │          783 │                    783 │    107.521805 │             6.7 │
│ spark      │      140000.0 │          503 │                    503 │         70.42 │             6.2 │
│ azure      │      128000.0 │          475 │                    475 │          60.8 │             6.2 │
│ snowflake  │      135500.0 │          438 │                    438 │        59.349 │             6.1 │
│ airflow    │      150000.0 │          386 │                    386 │          57.9 │             6.0 │
│ kafka      │      145000.0 │          292 │                    292 │         42.34 │             5.7 │
│ java       │      135000.0 │          303 │                    303 │        40.905 │             5.7 │
│ redshift   │      130000.0 │          274 │                    274 │         35.62 │             5.6 │
│ terraform  │      184000.0 │          193 │                    193 │        35.512 │             5.3 │
│ databricks │      132750.0 │          266 │                    266 │       35.3115 │             5.6 │
│ scala      │      137290.0 │          247 │                    247 │      33.91075 │             5.5 │
│ git        │      140000.0 │          208 │                    208 │         29.12 │             5.3 │
│ hadoop     │      135000.0 │          198 │                    198 │         26.73 │             5.3 │
│ gcp        │      136000.0 │          196 │                    196 │        26.656 │             5.3 │
│ nosql      │      134415.0 │          193 │                    193 │     25.942095 │             5.3 │
│ kubernetes │      150500.0 │          147 │                    147 │       22.1235 │             5.0 │
│ pyspark    │      140000.0 │          152 │                    152 │         21.28 │             5.0 │
│ docker     │      135000.0 │          144 │                    144 │         19.44 │             5.0 │
│ tableau    │      115000.0 │          164 │                    164 │         18.86 │             5.1 │
│ mongodb    │      135750.0 │          136 │                    136 │        18.462 │             4.9 │
│ r          │      134775.0 │          133 │                    133 │     17.925075 │             4.9 │
│ github     │      135000.0 │          127 │                    127 │        17.145 │             4.8 │
│ sql server │      120000.0 │          139 │                    139 │         16.68 │             4.9 │
└────────────┴───────────────┴──────────────┴────────────────────────┴───────────────┴─────────────────┘
  25 rows                                                                                    6 columns

  */