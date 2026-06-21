/*
Problem Statement:
1. Categorize the average yearly salary into 3 custom categories:
   - High salary
   - Standard salary
   - Low salary
2. Define your own salary ranges for each category (use BETWEEN for ranges).
3. Show these columns: job title short, average yearly salary, job location.
4. Create a new column named salary_category using CASE WHEN.
5. Only include jobs where the average yearly salary is NOT NULL.
*/


SELECT
   job_id,
   job_title_short,
   salary_year_avg,
   CASE
   WHEN salary_year_avg >= 300000 THEN 'High salary'
   WHEN salary_year_avg BETWEEN 100000 AND 290000 THEN 'Standard salary'
   ELSE 'Low salary'
 END AS Salary_category
FROM
   job_postings_fact
WHERE job_title_short = 'Data Analyst' AND 
salary_year_avg IS NOT NULL
ORDER BY
 salary_year_avg DESC;