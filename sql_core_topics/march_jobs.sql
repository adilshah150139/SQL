WITH march_jobs AS(
SELECT 
job_id,
job_title_short,
job_posted_date as date
FROM job_postings_fact
WHERE
EXTRACT(MONTH FROM job_posted_date) = 3
LIMIT 10
)
SELECT *
FROM march_jobs;