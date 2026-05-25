-- =========================================================
-- FILE: joins.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates INNER JOIN, LEFT JOIN, RIGHT JOIN,
-- SELF JOIN, and multi-table joins using TechSphere schema.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO JOINS
-- PURPOSE:
-- JOINs combine related data from multiple tables
-- using logical relationships (foreign keys).
-- =========================================================


-- View base tables
SELECT * FROM employees;
SELECT * FROM employee_positions;
SELECT * FROM job_roles;
SELECT * FROM departments;


-- =========================================================
-- SECTION 2: INNER JOIN
-- PURPOSE:
-- Returns only matching records in both tables.
-- =========================================================

-- Join employees with their departments
SELECT *
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Returns only employees who belong to a department


-- =========================================================
-- SECTION 3: INNER JOIN (EMPLOYEES + ROLES)
-- =========================================================

-- Join employees with job roles via positions table
SELECT *
FROM employees e
JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id;

-- WHAT IT DOES:
-- Shows employees and their assigned job roles


-- =========================================================
-- SECTION 4: LEFT JOIN
-- PURPOSE:
-- Returns all records from left table + matches from right
-- =========================================================

-- All employees including those without departments
SELECT *
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Keeps all employees even if department is NULL


-- =========================================================
-- SECTION 5: RIGHT JOIN
-- PURPOSE:
-- Returns all records from right table + matches from left
-- =========================================================

-- All departments including those without employees
SELECT *
FROM employees e
RIGHT JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Ensures all departments appear even if empty


-- =========================================================
-- SECTION 6: SELF JOIN
-- PURPOSE:
-- A table joins with itself for comparisons or pairing
-- =========================================================

-- Example: Pair employees as mentor-mentee (by ID sequence)
SELECT
    e1.employee_id AS mentor_id,
    e1.first_name AS mentor_name,
    e2.employee_id AS mentee_id,
    e2.first_name AS mentee_name
FROM employees e1
JOIN employees e2
    ON e1.employee_id + 1 = e2.employee_id;

-- WHAT IT DOES:
-- Creates artificial pairing based on employee ID order


-- =========================================================
-- SECTION 7: MULTI-TABLE JOIN
-- =========================================================

-- Employees + Departments + Roles
SELECT *
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
INNER JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
INNER JOIN job_roles jr
    ON ep.role_id = jr.role_id;

-- WHAT IT DOES:
-- Combines all related employee data into one dataset


-- =========================================================
-- SECTION 8: LEFT JOIN IN MULTI-TABLE CONTEXT
-- =========================================================

-- Keep all employees even if some data is missing
SELECT *
FROM employees e
INNER JOIN employee_positions ep
    ON e.employee_id = ep.employee_id
LEFT JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Ensures employees are not lost due to missing department


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- INNER JOIN:
-- Only matching records in both tables

-- LEFT JOIN:
-- All left table records + matching right records

-- RIGHT JOIN:
-- All right table records + matching left records

-- SELF JOIN:
-- A table joins itself

-- MULTI-JOIN:
-- Combines more than two related tables


-- =========================================================
-- END OF FILE
-- =========================================================
```
