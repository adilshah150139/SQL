/*
===============================
  SQL REVISION NOTES
  CTEs | GROUP BY | LEFT JOIN
===============================
*/

-- =========================================
-- 1. CTE Example: Get January jobs (with salary)
-- =========================================
WITH january_jobs AS (
    SELECT * 
    FROM job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 1  -- January jobs
        AND salary_year_avg IS NOT NULL          -- Only jobs with salary
)
SELECT * FROM january_jobs;


-- =========================================
-- 2. PRACTICE PROBLEM:
-- Find companies with the most job postings
-- =========================================

/*
Steps:
  1. Count jobs per company + job title
  2. Join with company table to get company name
*/

-- Normal Query (without CTE)
SELECT 
    company_id,
    job_title_short,
    COUNT(*) AS job_count
FROM job_postings_fact
GROUP BY company_id, job_title_short;


-- Same Query Using CTE (Temporary Table)
WITH company_job_count AS (
    SELECT 
        company_id,
        job_title_short,
        COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id, job_title_short
)
SELECT * FROM company_job_count;


-- =========================================
-- 3. FINAL QUERY:
-- LEFT JOIN Company Names + Job Counts
-- =========================================
WITH company_job_count AS (
    SELECT 
        company_id,
        job_title_short,
        COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id, job_title_short
)
SELECT 
    cd.name AS company_name,   -- Company name (from LEFT table)
    cjc.*                      -- ALL job data (from RIGHT table)
FROM company_dim cd            -- LEFT TABLE (all companies)
LEFT JOIN company_job_count cjc
    ON cjc.company_id = cd.company_id;




-- MY CODE:




-- Common table Expression (CTEs): define a temporary result set that you can reference
-- within a select, insert, delete, update the table

WITH january_jobs AS (
     SELECT * 
     From job_postings_fact
     WHERE 
      EXTRACT(MONTH FROM job_posted_date) = 1 AND
      salary_year_avg IS NOT Null
) -- definition CTEs end here

SELECT *
from january_jobs;

/* Find the companies that have the most job
- Get the total number of job posting per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

--1. simple form queries to get that data:
SELECT 
    company_id,
    job_title_short,
    COUNT(*)
FROM 
   job_postings_fact
GROUP BY
   company_id, job_title_short;
   

-- (Both 1 and 2 will identical result)

-- 2.
-- CTE table (temporary table)
WITH company_job_count AS(
      SELECT 
            company_id,
            job_title_short,
            COUNT(*) AS job_count
      FROM  job_postings_fact
      GROUP BY
            company_id, job_title_short
)

SELECT *
 FROM 
    company_job_count;



--------------------------------------------




-- LEFT JOING company_job_count and company_dim;

-- company_job_count table:
WITH company_job_count AS(
      SELECT 
            company_id,
            job_title_short,
            COUNT(*) AS job_count
      FROM  job_postings_fact
      GROUP BY
            company_id, job_title_short
)

SELECT 
    cd.name -- SHOW COMPANY NAME
    cjc.*,  -- SHOW EVERYTHING FROM RIGHT TABLE
    
FROM 
    company_dim cd
LEFT JOIN
   company_job_count cjc
   ON cjc.company_id = cd.company_id;