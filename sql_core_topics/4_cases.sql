/*
Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as 'Local'
- Otherwise 'Onsite'
*/

SELECT
   job_title_short,
   job_location,
   CASE 
      WHEN job_location = 'Anywhere' Then 'Remote'
      WHEN job_location = 'Paris, France' Then 'Local'
      ELSE 'Onsite'
   END AS Location_category
From job_postings_fact
LIMIT 10;


-- count by the jobs (remote, onsite, local)
SELECT
   COUNT(job_id) AS Number_of_jobs,
   CASE 
      WHEN job_location = 'Anywhere' Then 'Remote'
      WHEN job_location = 'Paris, France' Then 'Local'
      ELSE 'Onsite'
   END AS Location_category
From job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;
