-- 😎 Problem 01, Statement:
/*
 From the job_poting_facr table, recive the following columns for posting where the job location is missing(job_location is Null):
 . 👉 job_id
 . 👉 job_title_short
 . 👉 job_location
 . 👉 job_via
 . 👉 salary_year_avg

😒 Then:
      . Show only the top 10 highest salaries
      . Including an inline SQL comment next to the filter in the where clause explaining that this selects rows with missing location.
 */

SELECT 
 job_id,
 job_title_short,
 job_location,
 job_via,
 salary_year_avg
 FROM 'Dataset_files/job_postings_fact.csv'
  WHERE job_location IS NOT NULL                 -- It get the rows that consits on mising values.
 ORDER BY
 salary_year_avg DESC
 LIMIT 10;