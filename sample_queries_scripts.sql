-- =========================================================
-- FILE: queries.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Collection of SQL validation and relational
-- analysis queries for the TechSphere Solutions
-- database management system.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: DATA VALIDATION QUERIES
-- PURPOSE:
-- Verify that records were inserted correctly
-- into all database tables.
-- =========================================================


-- ---------------------------------------------------------
-- Query 1: View all departments
-- PURPOSE:
-- Display all department records stored in the
-- departments table.
-- ---------------------------------------------------------
SELECT *
FROM departments;


-- ---------------------------------------------------------
-- Query 2: View all employees
-- PURPOSE:
-- Display all employee records including personal
-- and employment details.
-- ---------------------------------------------------------
SELECT *
FROM employees;


-- ---------------------------------------------------------
-- Query 3: View all job roles
-- PURPOSE:
-- Display all available company job roles and
-- their associated salaries.
-- ---------------------------------------------------------
SELECT *
FROM job_roles;


-- ---------------------------------------------------------
-- Query 4: View all employee positions
-- PURPOSE:
-- Display employee-role assignment records.
-- ---------------------------------------------------------
SELECT *
FROM employee_positions;


-- =========================================================
-- SECTION 2: RELATIONAL ANALYSIS QUERIES
-- PURPOSE:
-- Demonstrate SQL JOIN operations and analytical
-- queries across multiple related tables.
-- =========================================================


-- ---------------------------------------------------------
-- Query 5: Retrieve employees with departments
-- PURPOSE:
-- Combine employee data with department names
-- using a LEFT JOIN relationship.
-- ---------------------------------------------------------
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id;


-- ---------------------------------------------------------
-- Query 6: Retrieve employees with job roles
-- PURPOSE:
-- Display employee names together with their
-- assigned job roles and salaries.
-- ---------------------------------------------------------
SELECT
    e.first_name,
    e.last_name,
    jr.role_title,
    jr.base_salary
FROM employee_positions ep
JOIN employees e
    ON ep.employee_id = e.employee_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id;


-- ---------------------------------------------------------
-- Query 7: Calculate average salary by department
-- PURPOSE:
-- Analyze departmental salary distribution using
-- aggregate functions and GROUP BY.
-- ---------------------------------------------------------
SELECT
    d.department_name,
    AVG(jr.base_salary) AS average_salary
FROM employee_positions ep
JOIN employees e
    ON ep.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
JOIN job_roles jr
    ON ep.role_id = jr.role_id
GROUP BY d.department_name;


-- =========================================================
-- END OF FILE
-- =========================================================