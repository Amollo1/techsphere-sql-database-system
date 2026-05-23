-- =========================================================
-- FILE: group_by_and_order_by.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates GROUP BY and ORDER BY clauses
-- using TechSphere database tables.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: GROUP BY CLAUSE
-- PURPOSE:
-- Used to group rows with similar values and apply
-- aggregate functions (AVG, COUNT, MIN, MAX).
-- =========================================================

-- View all employee demographics
SELECT *
FROM employees;


-- Group employees by department
SELECT department_id
FROM employees
GROUP BY department_id;


-- NOTE:
-- Selecting non-grouped columns directly is not allowed
-- unless they are included in GROUP BY.


-- Group employees by department and count them
SELECT
    department_id,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;


-- Group employees by gender and calculate average age
SELECT
    gender,
    AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS average_age
FROM employees
GROUP BY gender;


-- Group job roles by title
SELECT
    role_title
FROM job_roles
GROUP BY role_title;


-- Group job roles and salaries (shows unique combinations)
SELECT
    role_title,
    base_salary
FROM job_roles
GROUP BY role_title, base_salary;


-- Salary analytics by role
SELECT
    role_title,
    MIN(base_salary) AS min_salary,
    MAX(base_salary) AS max_salary,
    AVG(base_salary) AS average_salary,
    COUNT(*) AS role_count
FROM job_roles
GROUP BY role_title;


-- =========================================================
-- SECTION 2: ORDER BY CLAUSE
-- PURPOSE:
-- Used to sort query results in ascending (ASC)
-- or descending (DESC) order.
-- =========================================================

-- Sort employees by first name (A-Z)
SELECT *
FROM employees
ORDER BY first_name;


-- Sort employees by first name (Z-A)
SELECT *
FROM employees
ORDER BY first_name DESC;


-- Sort employees by department then age
SELECT
    first_name,
    last_name,
    department_id,
    date_of_birth
FROM employees
ORDER BY department_id, date_of_birth;


-- Sort employees by department (DESC) and age (DESC)
SELECT
    first_name,
    last_name,
    department_id,
    date_of_birth
FROM employees
ORDER BY department_id DESC, date_of_birth DESC;


-- Sort job roles by salary (highest to lowest)
SELECT
    role_title,
    base_salary
FROM job_roles
ORDER BY base_salary DESC;


-- Sort job roles by salary (lowest to highest)
SELECT
    role_title,
    base_salary
FROM job_roles
ORDER BY base_salary ASC;


-- =========================================================
-- SECTION 3: ORDER BY USING COLUMN POSITION
-- NOTE:
-- Not recommended in production (use column names instead)
-- =========================================================

-- Order employees by first column then second column
SELECT
    first_name,
    last_name,
    department_id,
    date_of_birth
FROM employees
ORDER BY 3, 4;


-- =========================================================
-- SECTION 4: COMBINING GROUP BY + ORDER BY
-- =========================================================

-- Department employee count sorted by highest first
SELECT
    department_id,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department_id
ORDER BY total_employees DESC;


-- Salary summary per role sorted by highest average salary
SELECT
    role_title,
    AVG(base_salary) AS avg_salary
FROM job_roles
GROUP BY role_title
ORDER BY avg_salary DESC;


-- =========================================================
-- END OF FILE
-- =========================================================