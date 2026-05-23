-- =========================================================
-- FILE: having_vs_where.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates the difference between
-- WHERE and HAVING clauses in MySQL.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION
-- =========================================================

-- WHERE and HAVING are both used to filter data,
-- but they work differently.

-- WHERE:
-- Filters rows BEFORE grouping occurs.

-- HAVING:
-- Filters grouped or aggregated results AFTER
-- the GROUP BY operation.


-- =========================================================
-- SECTION 2: GROUP BY WITH AGGREGATE FUNCTION
-- =========================================================

-- Calculate average salary by job role
SELECT
    role_title,
    AVG(base_salary) AS average_salary
FROM job_roles
GROUP BY role_title;


-- =========================================================
-- SECTION 3: USING WHERE INCORRECTLY
-- =========================================================

-- The query below will produce an error because
-- aggregate functions cannot be used directly
-- inside the WHERE clause.

SELECT
    role_title,
    AVG(base_salary) AS average_salary
FROM job_roles
WHERE AVG(base_salary) > 100000
GROUP BY role_title;

-- WHY IT FAILS:
-- WHERE executes BEFORE GROUP BY.
-- At that stage, AVG(base_salary) does not yet exist.


-- =========================================================
-- SECTION 4: USING HAVING CORRECTLY
-- =========================================================

-- Filter grouped results using HAVING
SELECT
    role_title,
    AVG(base_salary) AS average_salary
FROM job_roles
GROUP BY role_title
HAVING AVG(base_salary) > 100000;

-- WHAT IT DOES:
-- 1. Groups records by role_title
-- 2. Calculates average salary
-- 3. Filters only groups with average salary > 100000


-- =========================================================
-- SECTION 5: USING COLUMN ALIAS IN HAVING
-- =========================================================

-- Using alias for readability
SELECT
    role_title,
    AVG(base_salary) AS avg_salary
FROM job_roles
GROUP BY role_title
HAVING avg_salary > 100000;

-- WHAT IT DOES:
-- Same result as above, but uses the alias
-- "avg_salary" for cleaner syntax.


-- =========================================================
-- SECTION 6: WHERE + HAVING TOGETHER
-- =========================================================

-- Example:
-- First filter salaries greater than 60000,
-- then group results and filter averages.

SELECT
    role_title,
    AVG(base_salary) AS avg_salary
FROM job_roles
WHERE base_salary > 60000
GROUP BY role_title
HAVING avg_salary > 100000;

-- WHAT HAPPENS:
-- WHERE filters individual rows first
-- GROUP BY creates grouped results
-- HAVING filters aggregated groups


-- =========================================================
-- SECTION 7: PRACTICAL BUSINESS ANALYTICS EXAMPLE
-- =========================================================

-- Count employees per department and
-- return only departments with more than 1 employee

SELECT
    department_id,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department_id
HAVING total_employees > 1;

-- BUSINESS USE:
-- Helps identify departments with larger workforce sizes.


-- =========================================================
-- KEY DIFFERENCE SUMMARY
-- =========================================================

-- WHERE:
-- Filters raw rows before grouping

-- HAVING:
-- Filters grouped/aggregated data after grouping


-- =========================================================
-- END OF FILE
-- =========================================================