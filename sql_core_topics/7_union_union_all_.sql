/*
============================================
           UNION & UNION ALL NOTES
============================================
- UNION: Combines 2 queries + REMOVES duplicates
- UNION ALL: Combines 2 queries + KEEPS all rows (faster)
- RULE: Both queries MUST have same columns, same order, same data types
*/


--        MY ATTEMPT
WITH january_jobs AS(
SELECT 
 job_title_short,
 job_posted_date::Date AS job_date,
 job_location
FROM job_postings_fact
WHERE
EXTRACT(MONTH FROM job_posted_date) = 1
),
march_jobs AS (
SELECT 
 job_title_short,
 job_posted_date::Date AS job_date,
 job_location
FROM job_postings_fact
WHERE
EXTRACT(MONTH FROM job_posted_date) = 3
)

SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM march_jobs;


--        CLEAN VERSION (REVISED)
-- CTEs to get JANUARY + MARCH jobs
WITH january_jobs AS (
    SELECT 
        job_title_short,
        job_posted_date::DATE AS job_date,
        job_location
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    LIMIT 10
),
march_jobs AS (
    SELECT 
        job_title_short,
        job_posted_date::DATE AS job_date,
        job_location
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3
    LIMIT 10
)

-- =========================================
-- OPTION 1: UNION (removes duplicates)
-- =========================================
SELECT * FROM january_jobs
UNION         -- min rows
SELECT * FROM march_jobs;

-- =========================================
-- OPTION 2: UNION ALL (keeps all rows - faster)
-- =========================================
-- SELECT * FROM january_jobs
-- UNION ALL     -- max rows 
-- SELECT * FROM march_jobs;

SELECT *
FROM job_postings_fact;