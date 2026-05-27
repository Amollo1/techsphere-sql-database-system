-- =========================================================
-- FILE: window_functions.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates Window Functions in MySQL using TechSphere schema.
-- Includes AVG, SUM, ROW_NUMBER, RANK, and DENSE_RANK.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO WINDOW FUNCTIONS
-- PURPOSE:
-- Window functions perform calculations across a set of rows
-- without collapsing results like GROUP BY.
-- =========================================================


-- View employee dataset
SELECT *
FROM employees;


-- =========================================================
-- SECTION 2: GROUP BY VS WINDOW FUNCTION
-- PURPOSE:
-- Compare aggregation approaches
-- =========================================================

-- GROUP BY (collapses rows)
SELECT
    d.department_name,
    ROUND(AVG(jr.base_salary), 2) AS avg_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
GROUP BY d.department_name;


-- WINDOW FUNCTION (keeps all rows)
SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    jr.base_salary,
    AVG(jr.base_salary) OVER() AS company_avg_salary
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
JOIN departments d
    ON e.department_id = d.department_id;


-- WHAT IT DOES:
-- Shows each employee alongside global average salary
-- Unlike GROUP BY, no rows are removed


-- =========================================================
-- SECTION 3: PARTITION BY (GROUPED WINDOW CALCULATION)
-- PURPOSE:
-- Perform calculations within logical groups
-- =========================================================

SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    jr.base_salary,

    AVG(jr.base_salary) OVER(PARTITION BY d.department_name) AS dept_avg_salary

FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Calculates department-level average salary
-- Each employee still appears individually


-- =========================================================
-- SECTION 4: RUNNING TOTAL (ORDERED WINDOW FUNCTION)
-- PURPOSE:
-- Perform cumulative calculations
-- =========================================================

SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    jr.base_salary,

    SUM(jr.base_salary)
        OVER(PARTITION BY d.department_name ORDER BY e.employee_id)
        AS running_salary_total

FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Computes cumulative salary totals per department
-- Ordered by employee ID


-- =========================================================
-- SECTION 5: ROW NUMBER
-- PURPOSE:
-- Assign sequential numbering within groups
-- =========================================================

SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    jr.base_salary,

    ROW_NUMBER() OVER(
        PARTITION BY d.department_name
        ORDER BY jr.base_salary DESC
    ) AS row_num

FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Assigns unique ranking per department
-- No duplicates allowed in numbering


-- =========================================================
-- SECTION 6: RANK VS DENSE_RANK
-- PURPOSE:
-- Compare ranking behaviors
-- =========================================================

SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    jr.base_salary,

    ROW_NUMBER() OVER(
        PARTITION BY d.department_name
        ORDER BY jr.base_salary DESC
    ) AS row_num,

    RANK() OVER(
        PARTITION BY d.department_name
        ORDER BY jr.base_salary DESC
    ) AS salary_rank,

    DENSE_RANK() OVER(
        PARTITION BY d.department_name
        ORDER BY jr.base_salary DESC
    ) AS dense_salary_rank

FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- ROW_NUMBER → unique sequence
-- RANK → skips numbers after ties
-- DENSE_RANK → no gaps in ranking


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- WINDOW FUNCTIONS:
-- Perform calculations without collapsing rows

-- PARTITION BY:
-- Splits data into logical groups

-- ORDER BY (inside OVER):
-- Defines ranking or running calculation order

-- ROW_NUMBER:
-- Unique sequential numbering

-- RANK:
-- Ranking with gaps for ties

-- DENSE_RANK:
-- Ranking without gaps


-- =========================================================
-- BUSINESS USE CASES
-- =========================================================

-- Used for:
-- - Employee performance ranking
-- - Department salary analysis
-- - Payroll analytics
-- - KPI dashboards
-- - Data segmentation and scoring models


-- =========================================================
-- END OF FILE
-- =========================================================
```
