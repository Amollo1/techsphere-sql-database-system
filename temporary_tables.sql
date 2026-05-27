-- =========================================================
-- FILE: temporary_tables.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates Temporary Tables in MySQL
-- using the TechSphere database schema.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO TEMPORARY TABLES
-- PURPOSE:
-- Temporary tables store intermediate results
-- during the current database session only.
-- =========================================================


-- =========================================================
-- SECTION 2: CREATING A TEMPORARY TABLE MANUALLY
-- PURPOSE:
-- Create a temporary table structure first,
-- then insert records manually.
-- =========================================================

CREATE TEMPORARY TABLE temp_project_assignments
(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    project_name VARCHAR(100)
);

-- WHAT IT DOES:
-- Creates a temporary table named:
-- temp_project_assignments

-- This table exists only during
-- the current MySQL session.


-- View temporary table
SELECT *
FROM temp_project_assignments;


-- =========================================================
-- SECTION 3: INSERTING DATA INTO TEMPORARY TABLE
-- PURPOSE:
-- Add records into temporary table
-- =========================================================

INSERT INTO temp_project_assignments
VALUES
('Benard', 'Omoga', 'AI Dashboard System');

-- View inserted data
SELECT *
FROM temp_project_assignments;

-- WHAT IT DOES:
-- Inserts temporary project assignment data
-- into memory-only table.


-- =========================================================
-- SECTION 4: CREATING TEMP TABLE FROM QUERY
-- PURPOSE:
-- Faster and preferred method for temp tables
-- =========================================================

CREATE TEMPORARY TABLE high_salary_roles
SELECT
    role_id,
    role_title,
    base_salary
FROM job_roles
WHERE base_salary > 100000;

-- WHAT IT DOES:
-- Creates a temporary table directly
-- from query results.

-- Stores high-paying job roles only.


-- =========================================================
-- SECTION 5: VIEW TEMP TABLE CONTENT
-- PURPOSE:
-- Display temporary table records
-- =========================================================

SELECT *
FROM high_salary_roles;

-- WHAT IT DOES:
-- Displays all high-paying job roles
-- stored inside the temporary table.


-- =========================================================
-- SECTION 6: TEMP TABLE WITH EMPLOYEE ANALYTICS
-- PURPOSE:
-- Store joined analytical data temporarily
-- =========================================================

CREATE TEMPORARY TABLE employee_salary_analysis
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    jr.role_title,
    jr.base_salary

FROM employees e

JOIN departments d
    ON e.department_id = d.department_id

JOIN employee_positions ep
    ON e.employee_id = ep.employee_id

JOIN job_roles jr
    ON ep.role_id = jr.role_id

WHERE jr.base_salary >= 90000;

-- WHAT IT DOES:
-- Creates temporary analytical dataset
-- containing:
-- - Employee names
-- - Departments
-- - Job roles
-- - Salaries

-- Only employees earning 90,000+
-- are included.


-- =========================================================
-- SECTION 7: QUERYING TEMP ANALYTICS TABLE
-- PURPOSE:
-- Perform further analysis on temp data
-- =========================================================

SELECT *
FROM employee_salary_analysis
ORDER BY base_salary DESC;

-- WHAT IT DOES:
-- Displays employees sorted
-- from highest salary to lowest.


-- =========================================================
-- SECTION 8: BUSINESS ANALYTICS EXAMPLE
-- PURPOSE:
-- Temporary reporting dataset for management
-- =========================================================

CREATE TEMPORARY TABLE department_salary_summary
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    AVG(jr.base_salary) AS average_salary,
    SUM(jr.base_salary) AS total_department_salary

FROM employees e

JOIN departments d
    ON e.department_id = d.department_id

JOIN employee_positions ep
    ON e.employee_id = ep.employee_id

JOIN job_roles jr
    ON ep.role_id = jr.role_id

GROUP BY d.department_name;

-- View summary report
SELECT *
FROM department_salary_summary;

-- WHAT IT DOES:
-- Creates temporary department salary report
-- for business analytics and HR review.


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- TEMPORARY TABLE:
-- A table visible only during current session

-- CREATE TEMPORARY TABLE:
-- Creates temporary in-memory table

-- BENEFITS:
-- - Simplifies complex queries
-- - Stores intermediate calculations
-- - Improves query organization
-- - Useful for analytics and ETL workflows


-- =========================================================
-- TEMP TABLE VS CTE
-- =========================================================

-- TEMP TABLE:
-- - Exists for entire session
-- - Can be queried multiple times
-- - Stores physical temporary data

-- CTE:
-- - Exists only during query execution
-- - Better for readability
-- - Does not persist after query


-- =========================================================
-- BUSINESS USE CASES
-- =========================================================

-- Temporary tables are commonly used for:
-- - Payroll analysis
-- - Dashboard preparation
-- - ETL processing
-- - Intermediate reporting
-- - Data transformation
-- - Large analytical workflows


-- =========================================================
-- END OF FILE
-- =========================================================
```
