-- =========================================================
-- FILE: subqueries.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DESCRIPTION:
-- Demonstrates Subqueries in MySQL using TechSphere schema.
-- Subqueries are queries nested inside other queries and used
-- for filtering, calculations, and derived tables.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO SUBQUERIES
-- PURPOSE:
-- Subqueries allow one query to be embedded inside another query.
-- They are used to return intermediate results for the main query.
-- =========================================================


-- View all employees
SELECT *
FROM employees;


-- =========================================================
-- SECTION 2: SUBQUERY IN WHERE CLAUSE
-- PURPOSE:
-- Filter employees using results from another query
-- =========================================================

SELECT *
FROM employees
WHERE employee_id IN (
    SELECT ep.employee_id
    FROM employee_positions ep
    JOIN job_roles jr
        ON ep.role_id = jr.role_id
    WHERE jr.role_title = 'Data Analyst'
);

-- WHAT IT DOES:
-- Inner query finds employees with Data Analyst role
-- Outer query returns full employee details
-- Demonstrates filtering using a dynamic list


-- =========================================================
-- SECTION 3: INVALID SUBQUERY EXAMPLE (IMPORTANT RULE)
-- PURPOSE:
-- Show common mistake when using subqueries
-- =========================================================

-- This query would fail:
-- SELECT *
-- FROM employees
-- WHERE employee_id IN (
--     SELECT employee_id, department_id
--     FROM employee_positions
-- );

-- WHAT IT DOES:
-- ERROR occurs because IN expects only ONE column

-- KEY RULE:
-- Subqueries used with IN must return a single column only


-- =========================================================
-- SECTION 4: SUBQUERY IN SELECT CLAUSE
-- PURPOSE:
-- Compare each employee against global salary average
-- =========================================================

SELECT
    e.first_name,
    e.last_name,
    jr.base_salary,
    (
        SELECT AVG(base_salary)
        FROM job_roles
    ) AS avg_salary

FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id;

-- WHAT IT DOES:
-- Displays each employee salary
-- Adds overall average salary (same value for all rows)
-- Useful for benchmarking performance


-- =========================================================
-- SECTION 5: SUBQUERY IN FROM CLAUSE (DERIVED TABLE)
-- PURPOSE:
-- Create temporary aggregated dataset for further querying
-- =========================================================

SELECT *
FROM (
    SELECT
        d.department_name,
        COUNT(e.employee_id) AS total_employees,
        AVG(jr.base_salary) AS avg_salary
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id
    JOIN job_roles jr
        ON ep.role_id = jr.role_id
    GROUP BY d.department_name
) AS dept_summary;

-- WHAT IT DOES:
-- Creates a virtual table (dept_summary)
-- Shows department size and average salary


-- =========================================================
-- SECTION 6: FILTERING DERIVED TABLE (ADVANCED USE)
-- PURPOSE:
-- Apply filtering on aggregated subquery results
-- =========================================================

SELECT department_name, total_employees, avg_salary
FROM (
    SELECT
        d.department_name,
        COUNT(e.employee_id) AS total_employees,
        AVG(jr.base_salary) AS avg_salary
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id
    JOIN job_roles jr
        ON ep.role_id = jr.role_id
    GROUP BY d.department_name
) AS dept_summary
WHERE total_employees > 1
ORDER BY avg_salary DESC;

-- WHAT IT DOES:
-- Filters departments with more than 1 employee
-- Sorts departments by highest average salary


-- =========================================================
-- KEY RULES OF SUBQUERIES
-- =========================================================

-- 1. Subqueries can be used in:
--    WHERE, SELECT, FROM clauses

-- 2. IN subqueries must return ONE column only

-- 3. FROM subqueries must have an alias

-- 4. Subqueries can return:
--    - Single value (scalar)
--    - List of values
--    - Derived table


-- =========================================================
-- BUSINESS USE CASES
-- =========================================================

-- Subqueries are used for:
-- - HR analytics (employee filtering)
-- - Salary benchmarking
-- - Department reporting
-- - KPI calculations
-- - Data aggregation for dashboards


-- =========================================================
-- END OF FILE
-- =========================================================