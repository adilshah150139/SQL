/*
================================================================================
PROBLEM STATEMENT:
Calculate total job postings per company and categorize company size.
Display: company_id, company_name, total_jobs, size_category
SIZE CATEGORY RULES:
   - Less than 10 jobs → Small
   - 10 to 50 jobs     → Medium
   - More than 50 jobs → Large

TABLES USED:
1. job_postings_fact → Contains job postings linked to company_id
2. company_dim       → Contains company names linked to company_id
================================================================================
*/

-- =============================================
-- METHOD 1: USING SUBQUERY (Inside FROM Clause)
-- LOGIC: Calculate job counts first, then join for company names
-- =============================================
SELECT
    job_posted.company_id,                -- Company unique ID
    cd.name AS company_name,              -- Actual company name
    job_posted.total_jobs,                -- Total jobs posted by company
    -- Classify company size using CASE statement
    CASE
        WHEN job_posted.total_jobs < 10 THEN 'Small'
        WHEN job_posted.total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS size_category
FROM (
    -- Subquery: Calculate total jobs per company
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id       -- Group by company to get total jobs
    ORDER BY total_jobs DESC -- Sort highest jobs first
) AS job_posted
-- Join to get company name from company_dim table
LEFT JOIN company_dim cd
    ON job_posted.company_id = cd.company_id;

-- =============================================
-- METHOD 2: USING CTE (WITH Clause) - CLEANEST & READABLE
-- LOGIC: Separate logic block for counting, then main query for output
-- =============================================
WITH company_job_counts AS (
    -- Step 1: Count total jobs for each company
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    cjc.company_id,
    cd.name AS company_name,
    cjc.total_jobs,
    -- Create size category
    CASE
        WHEN cjc.total_jobs < 10 THEN 'Small'
        WHEN cjc.total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS size_category
FROM company_job_counts cjc
LEFT JOIN company_dim cd
    ON cjc.company_id = cd.company_id
ORDER BY cjc.total_jobs DESC;

-- =============================================
-- METHOD 3: DIRECT JOIN + GROUP BY (SHORTEST METHOD)
-- LOGIC: Join tables first, then count & categorize in one step
-- =============================================
SELECT
    jpf.company_id,
    cd.name AS company_name,
    COUNT(*) AS total_jobs,                -- Directly count jobs
    -- Categorize using COUNT(*) directly
    CASE
        WHEN COUNT(*) < 10 THEN 'Small'
        WHEN COUNT(*) BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS size_category
FROM job_postings_fact jpf
LEFT JOIN company_dim cd
    ON jpf.company_id = cd.company_id
GROUP BY jpf.company_id, cd.name          -- Group by company & name
ORDER BY total_jobs DESC;



-- my code:
SELECT
    job_posted.company_id,
    cd.name AS company_name,
    job_posted.total_jobs,
    CASE
    WHEN
       job_posted.total_jobs < 10 Then 'Small'
    WHEN 
       job_posted.total_jobs BETWEEN 10 AND 50 Then 'Medium'
    ELSE 'Large'
 END AS size_category
FROM(
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM job_postings_fact
GROUP BY
    company_id
ORDER BY
total_jobs DESC
) AS job_posted 
LEFT JOIN company_dim AS cd
  ON job_posted.company_id = cd.company_id
ORDER BY
 job_posted.total_jobs DESC;

