-- Author: Harshit Panchal
-- GitHub: github.com/harshitgitprofile
-- Project: HR Analytics — IBM Attrition Dataset



-- ============================================================
-- HR ANALYTICS PROJECT — SQL SCRIPT 3
-- Step: Advanced Analysis Queries
-- Tool: pgAdmin4 / PostgreSQL
-- Author: Harshit Panchal
-- ============================================================

-- ── QUERY 9: Age group analysis using CASE ───────────────────

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 30 THEN '26-30'
        WHEN age BETWEEN 31 AND 35 THEN '31-35'
        WHEN age BETWEEN 36 AND 40 THEN '36-40'
        WHEN age BETWEEN 41 AND 45 THEN '41-45'
        WHEN age BETWEEN 46 AND 50 THEN '46-50'
        ELSE '51+'
    END  AS age_group,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM hr_employees
GROUP BY age_group
ORDER BY age_group;


-- ── QUERY 10: Income bracket analysis ────────────────────────

SELECT
    CASE
        WHEN monthly_income < 3000  THEN 'Below $3K'
        WHEN monthly_income < 5000  THEN '$3K - $5K'
        WHEN monthly_income < 8000  THEN '$5K - $8K'
        WHEN monthly_income < 12000 THEN '$8K - $12K'
        ELSE 'Above $12K'
    END AS income_bracket,
    COUNT(*)  AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    )AS attrition_rate_pct
FROM hr_employees
GROUP BY income_bracket
ORDER BY MIN(monthly_income);


-- ── QUERY 11: Multi-factor analysis (dept + overtime) ────────

SELECT
    department,
    overtime,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS attrition_rate_pct
FROM hr_employees
GROUP BY department, overtime
ORDER BY department, attrition_rate_pct DESC;


-- ── QUERY 12: COALESCE — handle nulls safely ─────────────────
-- Useful when working with real-world incomplete data

SELECT
    employee_id,
    COALESCE(job_role, 'Unknown Role')         AS job_role,
    COALESCE(department, 'Unknown Dept')       AS department,
    COALESCE(monthly_income, 0)                AS monthly_income
FROM hr_employees
LIMIT 10;


-- ── QUERY 13: Top 5 highest paid employees who left ──────────

SELECT
    employee_id,
    age,
    department,
    job_role,
    monthly_income,
    years_at_company
FROM hr_employees
WHERE attrition = 'Yes'
ORDER BY monthly_income DESC
LIMIT 5;


-- ── QUERY 14: Subquery — employees earning below dept avg ────

SELECT
    e.employee_id,
    e.department,
    e.job_role,
    e.monthly_income,
    ROUND(dept_avg.avg_income, 0) AS dept_avg_income
FROM hr_employees e
JOIN (
    SELECT
        department,
        AVG(monthly_income) AS avg_income
    FROM hr_employees
    GROUP BY department
) dept_avg ON e.department = dept_avg.department
WHERE e.monthly_income < dept_avg.avg_income
  AND e.attrition = 'Yes'
ORDER BY e.department, e.monthly_income;


-- ── QUERY 15: HAVING clause — roles with high attrition ──────
-- Find job roles where attrition rate > 20%

SELECT
    job_role,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    )                                                       AS attrition_rate_pct
FROM hr_employees
GROUP BY job_role
HAVING ROUND(
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
) > 20
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 16: Work-life balance vs attrition ─────────────────

SELECT
    work_life_balance,
    CASE work_life_balance
        WHEN 1 THEN 'Bad'
        WHEN 2 THEN 'Good'
        WHEN 3 THEN 'Better'
        WHEN 4 THEN 'Best'
    END   AS wlb_label,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    )                                                       AS attrition_rate_pct
FROM hr_employees
GROUP BY work_life_balance
ORDER BY work_life_balance;


-- ── QUERY 17: Full attrition risk profile ────────────────────
-- High-risk employees: overtime=Yes, low satisfaction, short tenure

SELECT
    employee_id,
    age,
    department,
    job_role,
    monthly_income,
    job_satisfaction,
    years_at_company,
    overtime,
    business_travel,
    attrition
FROM hr_employees
WHERE overtime = 'Yes'
  AND job_satisfaction <= 2
  AND years_at_company <= 3
ORDER BY monthly_income ASC
LIMIT 20;


-- ── QUERY 18: Summary stats using GROUP BY + HAVING ──────────
-- Departments with more than 100 employees and attrition > 15%

SELECT
    department,
    COUNT(*)  AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    )                                                       AS attrition_rate_pct
FROM hr_employees
GROUP BY department
HAVING COUNT(*) > 100
   AND ROUND(
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
   ) > 15
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 19: Education field vs attrition ───────────────────

SELECT
    education_field,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)     AS attrited,
    ROUND(AVG(monthly_income), 0)                          AS avg_income,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    )  AS attrition_rate_pct
FROM hr_employees
GROUP BY education_field
ORDER BY attrition_rate_pct DESC;


-- ── QUERY 20: Final insights summary view ────────────────────
-- Key findings to copy into your project report

SELECT 'Overall Attrition Rate'   AS metric,
       ROUND(SUM(CASE WHEN attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2)::TEXT || '%' AS value
FROM hr_employees
UNION ALL
SELECT 'Avg Income (Attrited)',
       '$' || ROUND(AVG(monthly_income))::TEXT
FROM hr_employees WHERE attrition='Yes'
UNION ALL
SELECT 'Avg Income (Retained)',
       '$' || ROUND(AVG(monthly_income))::TEXT
FROM hr_employees WHERE attrition='No'
UNION ALL
SELECT 'Avg Age (Attrited)',
       ROUND(AVG(age),1)::TEXT || ' yrs'
FROM hr_employees WHERE attrition='Yes'
UNION ALL
SELECT 'Overtime Attrition Rate',
       ROUND(SUM(CASE WHEN attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2)::TEXT || '%'
FROM hr_employees WHERE overtime='Yes';
