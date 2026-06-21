SELECT 
 job_id,
 job_title_short,
 job_posted_date::Date AS Date,
 job_location
FROM job_postings_fact
WHERE
EXTRACT(MONTH FROM job_posted_date) = 1
LIMIT 10;

