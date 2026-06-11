-- Author: Harshit Panchal
-- GitHub: github.com/harshitgitprofile
-- Project: HR Analytics — IBM Attrition Dataset


-- ============================================================
-- HR ANALYTICS PROJECT — SQL SCRIPT 2
-- Step: Basic Analysis Queries
-- Tool: pgAdmin4 / PostgreSQL
-- Author: Harshit Panchal
-- ============================================================

-- ── QUERY 1: Overall attrition count and rate ────────────────

SELECT
    COUNT(*)  AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    SUM(CASE WHEN attrition = 'No'  THEN 1 ELSE 0 END) AS retained,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employees;


-- ── QUERY 2: Attrition by department ─────────────────────────

SELECT
    department,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)  AS attrited,
    ROUND(
      SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employees
GROUP BY department
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 3: Attrition by gender ─────────────────────────────

SELECT
    gender,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)  AS attrition_rate_pct
FROM hr_employees
GROUP BY gender
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 4: Average age, income, tenure by attrition ────────

SELECT
    attrition,
    ROUND(AVG(age), 1)  AS avg_age,
    ROUND(AVG(monthly_income), 0)   AS avg_monthly_income,
    ROUND(AVG(years_at_company), 1) AS avg_tenure_years
FROM hr_employees
GROUP BY attrition;


-- ── QUERY 5: Attrition by job role ───────────────────────────

SELECT
    job_role,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employees
GROUP BY job_role
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 6: Attrition by overtime ───────────────────────────

SELECT
    overtime,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employees
GROUP BY overtime
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 7: Attrition by business travel ────────────────────

SELECT
    business_travel,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employees
GROUP BY business_travel
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 8: Job satisfaction distribution ───────────────────

SELECT
    job_satisfaction,
    CASE job_satisfaction
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Very High'
    END  AS satisfaction_label,
    COUNT(*)AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    )AS attrition_rate_pct
FROM hr_employees
GROUP BY job_satisfaction
ORDER BY job_satisfaction;
