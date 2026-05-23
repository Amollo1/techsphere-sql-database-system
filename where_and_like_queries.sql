-- =========================================================
-- FILE: where_and_like_queries.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates WHERE clause and LIKE operator
-- using the TechSphere database structure.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: WHERE CLAUSE BASICS
-- =========================================================

-- Retrieve employees earning more than 50,000
SELECT *
FROM job_roles
WHERE base_salary > 50000;


-- Retrieve employees earning at least 50,000
SELECT *
FROM job_roles
WHERE base_salary >= 50000;


-- Retrieve employees in the Cybersecurity department
SELECT *
FROM departments
WHERE department_name = 'Cybersecurity';


-- Retrieve employees NOT in the Cybersecurity department
SELECT *
FROM departments
WHERE department_name != 'Cybersecurity';


-- =========================================================
-- SECTION 2: WHERE WITH DATES
-- =========================================================

-- Retrieve employees hired after 2022-01-01
SELECT *
FROM employees
WHERE hire_date > '2022-01-01';


-- Retrieve employees born after 1995-01-01
SELECT *
FROM employees
WHERE date_of_birth > '1995-01-01';


-- =========================================================
-- SECTION 3: LIKE OPERATOR (PATTERN MATCHING)
-- =========================================================

-- Employees whose first name starts with 'B'
SELECT *
FROM employees
WHERE first_name LIKE 'B%';


-- Employees whose first name has exactly 4 characters starting with 'A'
SELECT *
FROM employees
WHERE first_name LIKE 'A___';


-- Employees whose email contains 'techsphere'
SELECT *
FROM employees
WHERE email LIKE '%techsphere%';


-- Employees whose last name starts with 'O'
SELECT *
FROM employees
WHERE last_name LIKE 'O%';


-- =========================================================
-- SECTION 4: COMBINED CONDITIONS
-- =========================================================

-- Employees in department 1 hired after 2021
SELECT *
FROM employees
WHERE department_id = 1
AND hire_date > '2021-01-01';


-- Employees in department 2 OR department 3
SELECT *
FROM employees
WHERE department_id = 2
OR department_id = 3;


-- =========================================================
-- END OF FILE
-- =========================================================