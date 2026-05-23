-- =========================================================
-- FILE: select queries.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Collection of SQL queries for data retrieval,
-- filtering, calculations, and relational analysis.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: BASIC SELECT STATEMENTS
-- =========================================================

-- Retrieve all employee records
SELECT *
FROM employees;


-- Retrieve only employee first names
SELECT first_name
FROM employees;


-- Retrieve employee first and last names
SELECT 
    first_name,
    last_name
FROM employees;


-- Retrieve selected employee details
SELECT
    first_name,
    last_name,
    gender,
    hire_date
FROM employees;


-- =========================================================
-- SECTION 2: SELECT WITH CALCULATIONS
-- =========================================================

-- Display salaries with an additional fixed bonus
SELECT
    role_title,
    base_salary,
    base_salary + 1000 AS salary_bonus_example
FROM job_roles;


-- Display projected salary increase by 10%
SELECT
    role_title,
    base_salary,
    (base_salary * 1.10) AS increased_salary_10_percent
FROM job_roles;


-- =========================================================
-- SECTION 3: DISTINCT VALUES
-- =========================================================

-- Display all department IDs (including duplicates)
SELECT department_id
FROM employees;


-- Display unique department IDs
SELECT DISTINCT department_id
FROM employees;


-- Display unique department names
SELECT DISTINCT department_name
FROM departments;


-- =========================================================
-- SECTION 4: FILTERING DATA USING WHERE
-- =========================================================

-- Retrieve employees from department 2
SELECT *
FROM employees
WHERE department_id = 2;


-- Retrieve employees hired after 2022
SELECT
    first_name,
    last_name,
    hire_date
FROM employees
WHERE hire_date > '2022-01-01';


-- =========================================================
-- SECTION 5: SORTING DATA USING ORDER BY
-- =========================================================

-- Sort employees alphabetically by first name
SELECT
    first_name,
    last_name
FROM employees
ORDER BY first_name ASC;


-- Sort job roles by highest salary
SELECT
    role_title,
    base_salary
FROM job_roles
ORDER BY base_salary DESC;


-- =========================================================
-- SECTION 6: LIMITING RESULTS
-- =========================================================

-- Retrieve first 3 employee records
SELECT *
FROM employees
LIMIT 3;


-- =========================================================
-- SECTION 7: INNER JOIN OPERATIONS
-- =========================================================

-- Retrieve employees with their department names
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;


-- =========================================================
-- SECTION 8: MULTI-TABLE JOIN ANALYSIS
-- =========================================================

-- Retrieve employees with job roles and salaries
SELECT
    e.first_name,
    e.last_name,
    jr.role_title,
    jr.base_salary
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id;


-- =========================================================
-- SECTION 9: AGGREGATE FUNCTIONS
-- =========================================================

-- Count total employees
SELECT COUNT(*) AS total_employees
FROM employees;


-- Calculate average salary
SELECT AVG(base_salary) AS average_salary
FROM job_roles;


-- Find highest salary
SELECT MAX(base_salary) AS highest_salary
FROM job_roles;


-- Find lowest salary
SELECT MIN(base_salary) AS lowest_salary
FROM job_roles;


-- =========================================================
-- SECTION 10: GROUP BY ANALYSIS
-- =========================================================

-- Average salary by department
SELECT
    d.department_name,
    AVG(jr.base_salary) AS average_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
GROUP BY d.department_name;


-- Count employees in each department
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;


-- =========================================================
-- SECTION 11: ALIASING COLUMNS
-- =========================================================

-- Rename output columns for readability
SELECT
    first_name AS FirstName,
    last_name AS LastName,
    hire_date AS EmploymentDate
FROM employees;


-- =========================================================
-- SECTION 12: CONDITIONAL FILTERING
-- =========================================================

-- Retrieve employees with salaries greater than 100,000
SELECT
    e.first_name,
    e.last_name,
    jr.role_title,
    jr.base_salary
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
WHERE jr.base_salary > 100000;


-- =========================================================
-- END OF FILE
-- =========================================================