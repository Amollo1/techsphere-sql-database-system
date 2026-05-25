-- =========================================================
-- FILE: limit_and_aliasing.sql
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- PROJECT: TechSphere Solutions Database System
-- DESCRIPTION:
-- Demonstrates LIMIT clause and column aliasing
-- using TechSphere database tables.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: LIMIT CLAUSE
-- PURPOSE:
-- LIMIT restricts the number of rows returned
-- in a query result.
-- =========================================================


-- Retrieve only the first 3 employees
SELECT *
FROM employees
LIMIT 3;


-- =========================================================
-- LIMIT WITH ORDER BY
-- =========================================================

-- Retrieve first 3 employees sorted alphabetically
SELECT *
FROM employees
ORDER BY first_name
LIMIT 3;

-- WHAT IT DOES:
-- 1. Sorts employees by first name (A-Z)
-- 2. Returns only the first 3 rows


-- =========================================================
-- LIMIT WITH OFFSET
-- =========================================================

-- Display all employees ordered by first name
SELECT *
FROM employees
ORDER BY first_name;


-- Retrieve 2 employees starting from position 3
SELECT *
FROM employees
ORDER BY first_name
LIMIT 3, 2;

-- WHAT IT DOES:
-- LIMIT 3,2 means:
-- Start from row position 3
-- Then return the next 2 rows


-- =========================================================
-- PRACTICAL ANALYTICS EXAMPLE
-- =========================================================

-- View employees ordered by hire date (oldest employees first)
SELECT *
FROM employees
ORDER BY hire_date;

-- Retrieve the third earliest hired employee
SELECT *
FROM employees
ORDER BY hire_date
LIMIT 2,1;

-- WHAT IT DOES:
-- 1. Sorts employees by hire date
-- 2. Skips first 2 rows
-- 3. Returns the next row only


-- =========================================================
-- SECTION 2: ALIASING
-- PURPOSE:
-- Aliasing temporarily renames columns or tables
-- for readability and cleaner output.
-- =========================================================


-- Average salary by gender
SELECT
    gender,
    AVG(base_salary)
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
GROUP BY gender;


-- =========================================================
-- USING ALIAS WITH AS KEYWORD
-- =========================================================

SELECT
    gender,
    AVG(base_salary) AS average_salary
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
GROUP BY gender;

-- WHAT IT DOES:
-- Renames AVG(base_salary) column to "average_salary"


-- =========================================================
-- ALIAS WITHOUT AS KEYWORD
-- =========================================================

SELECT
    gender,
    AVG(base_salary) average_salary
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
GROUP BY gender;

-- WHAT IT DOES:
-- Same result as above
-- "AS" keyword is optional in MySQL


-- =========================================================
-- TABLE ALIASING
-- =========================================================

-- Using shorter table aliases for readability
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- e = employees
-- d = departments
-- Makes JOIN queries shorter and easier to read


-- =========================================================
-- SECTION 3: LIMIT + ORDER BY + ALIASING
-- =========================================================

-- Top 3 highest paying job roles
SELECT
    role_title AS job_role,
    base_salary AS salary
FROM job_roles
ORDER BY salary DESC
LIMIT 3;

-- WHAT IT DOES:
-- 1. Renames output columns
-- 2. Sorts salaries highest to lowest
-- 3. Returns top 3 highest-paying roles


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- LIMIT:
-- Restricts number of rows returned

-- OFFSET:
-- Specifies starting position in LIMIT

-- ALIAS:
-- Temporarily renames columns or tables

-- ORDER BY:
-- Sorts query results


-- =========================================================
-- END OF FILE
-- =========================================================
```
