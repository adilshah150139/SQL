-- 1)
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH From job_posted_date) = 1
) AS january_jobs;

-- 2)
SELECT *
From job_postings_fact
WHERE
 EXTRACT(MONTH From job_posted_date) = 1;


SELECT company_name AS name
FROM company_dim
WHERE company_id IN(
   SELECT 
   company_id,
   job_no_degree_mention
   FROM job_postings_fact
   WHERE 
   job_no_degree_mention = true
     

