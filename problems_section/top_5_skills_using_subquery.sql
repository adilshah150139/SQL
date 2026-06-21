/*
================================================================================
PRACTICE PROBLEM 1:
Identify the top 5 skills that are most frequently mentioned in job postings.
- Use a subquery to find the skill IDs with the highest counts in skills_job_dim
- Join the result with skills_dim to get the skill names.

TABLES:
skills_job_dim = links jobs to skills (skill_id, job_id)
skills_dim     = stores skill names (skill_id, skills)
================================================================================
*/


-- =============================================
-- METHOD 1: USING CTE (WITH clause) - CLEAN & READABLE
-- =============================================
WITH top_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY skill_count DESC
    LIMIT 10
)
SELECT
    ts.skill_id,
    s.skills AS skill_name,
    ts.skill_count
FROM top_skills ts
INNER JOIN skills_dim s
    ON ts.skill_id = s.skill_id
ORDER BY ts.skill_count DESC;

-- =============================================
-- METHOD 2: USING NESTED SUBQUERY (inside FROM)
-- =============================================
SELECT
    ts.skill_id,
    s.skills AS skill_name,
    ts.skill_count
FROM (
    -- Subquery directly calculates top skills
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY skill_count DESC
    LIMIT 10
) AS ts
INNER JOIN skills_dim s
    ON ts.skill_id = s.skill_id
ORDER BY ts.skill_count DESC;

-- =============================================
-- METHOD 3: SHORT & SIMPLE (GROUP BY + JOIN + LIMIT)
-- =============================================
SELECT
    sjd.skill_id,
    s.skills AS skill_name,
    COUNT(*) AS skill_count
FROM skills_job_dim sjd
INNER JOIN skills_dim s
    ON sjd.skill_id = s.skill_id
GROUP BY sjd.skill_id, s.skills
ORDER BY skill_count DESC
LIMIT 10;


-- MY Code:
SELECT 
    s.skill_id,
    s.skills,
    top_skills.skill_count
FROM(
    SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM skills_job_dim
GROUP BY
    skill_id
ORDER BY
    skill_count DESC
LIMIT 10
) AS top_skills
INNER JOIN
    skills_dim  as s
    ON top_skills.skill_id = s.skill_id;



