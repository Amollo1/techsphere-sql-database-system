-- =========================================================
-- FILE: unions.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates UNION, UNION ALL, and practical use cases
-- for combining row-based datasets.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO UNION
-- PURPOSE:
-- UNION combines results vertically (row-wise),
-- unlike JOIN which combines data horizontally.
-- =========================================================


-- =========================================================
-- SECTION 2: BASIC UNION (INCONSISTENT DATA - DEMO)
-- =========================================================

-- Combines unrelated datasets (not best practice, for learning only)
SELECT first_name, last_name
FROM employees

UNION

SELECT role_title, base_salary
FROM job_roles;

-- WHAT IT DOES:
-- Stacks results into one output table
-- Column names are taken from the first SELECT
-- Data types are implicitly converted where possible


-- =========================================================
-- SECTION 3: UNION DISTINCT (DEFAULT BEHAVIOR)
-- =========================================================

-- UNION automatically removes duplicates
SELECT first_name, last_name
FROM employees

UNION

SELECT first_name, last_name
FROM employees;

-- WHAT IT DOES:
-- Removes duplicate rows automatically


-- =========================================================
-- SECTION 4: UNION ALL (KEEPS DUPLICATES)
-- =========================================================

-- UNION ALL returns all records including duplicates
SELECT first_name, last_name
FROM employees

UNION ALL

SELECT first_name, last_name
FROM employees;

-- WHAT IT DOES:
-- Returns duplicate rows as well
-- Faster than UNION because no deduplication step


-- =========================================================
-- SECTION 5: PRACTICAL BUSINESS USE CASE
-- =========================================================

-- Identify employees based on risk categories:
-- 1. High age employees
-- 2. High salary employees
-- 3. Senior experienced staff classification

SELECT
    first_name,
    last_name,
    'Senior Employee' AS category
FROM employees
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > 50

UNION

SELECT
    first_name,
    last_name,
    'Experienced Employee' AS category
FROM employees
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 40 AND 50

UNION

SELECT
    e.first_name,
    e.last_name,
    'High Salary Employee' AS category
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
WHERE jr.base_salary >= 100000

ORDER BY first_name;

-- WHAT IT DOES:
-- Combines multiple analytical filters into one dataset:
-- - Older employees
-- - Mid-aged experienced employees
-- - High earning employees


-- =========================================================
-- SECTION 6: KEY RULES OF UNION
-- =========================================================

-- RULE 1:
-- Each SELECT must have same number of columns

-- RULE 2:
-- Corresponding columns must have compatible data types

-- RULE 3:
-- Column names come from first SELECT statement

-- RULE 4:
-- UNION removes duplicates, UNION ALL keeps them


-- =========================================================
-- SECTION 7: BUSINESS INSIGHT USE CASE
-- =========================================================

-- Used for:
-- - HR analysis
-- - Risk classification
-- - Employee segmentation
-- - Reporting dashboards
-- - KPI grouping across datasets


-- =========================================================
-- END OF FILE
-- =========================================================