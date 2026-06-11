-- Author: Harshit Panchal
-- GitHub: github.com/harshitgitprofile
-- Project: HR Analytics — IBM Attrition Dataset


-- ============================================================
-- HR ANALYTICS PROJECT — SQL SCRIPT 1
-- Step: Create Table & Load Data
-- Tool: pgAdmin4 / PostgreSQL
-- Author: Harshit Pancha

-- ============================================================

-- STEP 1: Create the database 
-- In pgAdmin4: right-click Databases > Create > Database
-- Name it: hr_analytics

CREATE  DATABASE hr_analytics;

-- STEP 2: Create the table
DROP TABLE IF EXISTS hr_employees;

CREATE TABLE hr_employees (
    employee_id             INT PRIMARY KEY,
    age                     INT,
    attrition               VARCHAR(5),
    department              VARCHAR(50),
    distance_from_home      INT,
    education_field         VARCHAR(30),
    gender                  VARCHAR(10),
    monthly_income          INT,
    marital_status          VARCHAR(15),
    job_role                VARCHAR(40),
    overtime                VARCHAR(5),
    performance_rating      INT,
    job_satisfaction        INT,
    environment_satisfaction INT,
    years_at_company        INT,
    business_travel         VARCHAR(25),
    work_life_balance       INT
);

select * from  hr_employees;

-- STEP 3: import the Excel data 

COPY hr_employees(employee_id ,age,attrition,department,distance_from_home ,education_field ,gender ,monthly_income, marital_status ,job_role ,overtime,performance_rating,job_satisfaction,environment_satisfaction ,years_at_company,business_travel,work_life_balance)
from '‪D:\Data anayst\project\HR_Analytics_Dataset.csv'
DELIMITER ','
CSV HEADER;


-- STEP 4: Verify the import

SELECT COUNT(*) AS total_rows FROM hr_employees;

-- Expected: 1470 rows

SELECT * FROM hr_employees LIMIT 5;
