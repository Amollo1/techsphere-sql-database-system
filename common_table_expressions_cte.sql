-- =========================================================
-- FILE: common_table_expressions_cte.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates Common Table Expressions (CTEs) in MySQL
-- using the TechSphere database schema.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO CTEs
-- PURPOSE:
-- A Common Table Expression (CTE) creates a temporary
-- result set that can be referenced within a query.
-- =========================================================


-- =========================================================
-- SECTION 2: BASIC CTE EXAMPLE
-- PURPOSE:
-- Calculate department salary statistics
-- =========================================================

WITH department_salary_stats AS
(
    SELECT
        d.department_name,
        SUM(jr.base_salary) AS total_salary,
        MIN(jr.base_salary) AS minimum_salary,
        MAX(jr.base_salary) AS maximum_salary,
        COUNT(jr.base_salary) AS total_roles,
        AVG(jr.base_salary) AS average_salary

    FROM employees e

    JOIN departments d
        ON e.department_id = d.department_id

    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id

    JOIN job_roles jr
        ON ep.role_id = jr.role_id

    GROUP BY d.department_name
)

SELECT *
FROM department_salary_stats;

-- WHAT IT DOES:
-- Creates a temporary table containing:
-- - Total salary per department
-- - Minimum salary
-- - Maximum salary
-- - Total roles
-- - Average salary


-- =========================================================
-- SECTION 3: USING CTE VALUES FOR FURTHER ANALYSIS
-- PURPOSE:
-- Perform calculations using CTE output
-- =========================================================

WITH department_salary_stats AS
(
    SELECT
        d.department_name,
        SUM(jr.base_salary) AS total_salary,
        COUNT(jr.base_salary) AS total_roles

    FROM employees e

    JOIN departments d
        ON e.department_id = d.department_id

    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id

    JOIN job_roles jr
        ON ep.role_id = jr.role_id

    GROUP BY d.department_name
)

SELECT
    department_name,
    ROUND(total_salary / total_roles, 2) AS calculated_avg_salary

FROM department_salary_stats;

-- WHAT IT DOES:
-- Uses previously calculated CTE data
-- Computes average salary manually
-- Improves readability and query organization


-- =========================================================
-- SECTION 4: MULTIPLE CTEs
-- PURPOSE:
-- Demonstrate multiple temporary datasets
-- =========================================================

WITH recent_employees AS
(
    SELECT
        employee_id,
        first_name,
        last_name,
        hire_date,
        department_id

    FROM employees

    WHERE hire_date > '2022-01-01'
),

high_salary_roles AS
(
    SELECT
        role_id,
        role_title,
        base_salary

    FROM job_roles

    WHERE base_salary >= 120000
)

SELECT
    re.employee_id,
    re.first_name,
    re.last_name,
    hsr.role_title,
    hsr.base_salary

FROM recent_employees re

JOIN employee_positions ep
    ON re.employee_id = ep.employee_id

JOIN high_salary_roles hsr
    ON ep.role_id = hsr.role_id;

-- WHAT IT DOES:
-- Creates two separate CTEs:
-- 1. Recently hired employees
-- 2. High-paying job roles

-- Then joins them together
-- to identify recently hired employees
-- working in high-paying positions


-- =========================================================
-- SECTION 5: RENAMING CTE COLUMNS
-- PURPOSE:
-- Improve readability of calculated fields
-- =========================================================

WITH salary_summary
(
    department_name,
    total_salary,
    minimum_salary,
    maximum_salary,
    total_roles
) AS
(
    SELECT
        d.department_name,
        SUM(jr.base_salary),
        MIN(jr.base_salary),
        MAX(jr.base_salary),
        COUNT(jr.base_salary)

    FROM employees e

    JOIN departments d
        ON e.department_id = d.department_id

    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id

    JOIN job_roles jr
        ON ep.role_id = jr.role_id

    GROUP BY d.department_name
)

SELECT
    department_name,
    ROUND(total_salary / total_roles, 2) AS avg_salary

FROM salary_summary;

-- WHAT IT DOES:
-- Renames CTE output columns directly
-- Makes calculations easier to read
-- Eliminates complex column names


-- =========================================================
-- SECTION 6: PRACTICAL BUSINESS ANALYTICS
-- PURPOSE:
-- Identify departments with high salary expenditure
-- =========================================================

WITH department_costs AS
(
    SELECT
        d.department_name,
        SUM(jr.base_salary) AS total_department_salary

    FROM employees e

    JOIN departments d
        ON e.department_id = d.department_id

    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id

    JOIN job_roles jr
        ON ep.role_id = jr.role_id

    GROUP BY d.department_name
)

SELECT *
FROM department_costs
WHERE total_department_salary > 200000
ORDER BY total_department_salary DESC;

-- WHAT IT DOES:
-- Identifies departments with high payroll costs
-- Useful for:
-- - HR budgeting
-- - payroll analytics
-- - financial planning


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- CTE:
-- Temporary named result set

-- WITH:
-- Starts a Common Table Expression

-- AS:
-- Defines the CTE query block

-- Multiple CTEs:
-- Can be separated using commas

-- BENEFITS:
-- - Improves readability
-- - Simplifies complex queries
-- - Makes SQL modular and reusable


-- =========================================================
-- BUSINESS USE CASES
-- =========================================================

-- CTEs are commonly used for:
-- - Dashboard reporting
-- - KPI calculations
-- - Financial analytics
-- - HR reporting
-- - Recursive queries
-- - Data transformation pipelines


-- =========================================================
-- END OF FILE
-- =========================================================