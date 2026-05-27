-- =========================================================
-- FILE: stored_procedures.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates Stored Procedures in MySQL
-- using the TechSphere database schema.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: BASIC QUERY
-- PURPOSE:
-- Retrieve high-paying job roles
-- =========================================================

SELECT *
FROM job_roles
WHERE base_salary >= 100000;

-- WHAT IT DOES:
-- Returns all job roles
-- with salaries greater than or equal to 100000.


-- =========================================================
-- SECTION 2: SIMPLE STORED PROCEDURE
-- PURPOSE:
-- Create reusable SQL logic
-- =========================================================

CREATE PROCEDURE high_salary_roles()
SELECT *
FROM job_roles
WHERE base_salary >= 100000;

-- WHAT IT DOES:
-- Creates a stored procedure named:
-- high_salary_roles

-- The procedure stores the query
-- for future reuse.


-- =========================================================
-- SECTION 3: EXECUTING STORED PROCEDURE
-- PURPOSE:
-- Run the stored procedure
-- =========================================================

CALL high_salary_roles();

-- WHAT IT DOES:
-- Executes the stored procedure
-- and displays high-paying job roles.


-- =========================================================
-- SECTION 4: STORED PROCEDURE WITH MULTIPLE QUERIES
-- PURPOSE:
-- Demonstrate BEGIN and END blocks
-- =========================================================

DELIMITER $$

CREATE PROCEDURE salary_reports()
BEGIN

    SELECT *
    FROM job_roles
    WHERE base_salary >= 100000;

    SELECT *
    FROM job_roles
    WHERE base_salary >= 70000;

END $$

DELIMITER ;

-- WHAT IT DOES:
-- Creates a procedure containing
-- multiple SQL queries.

-- Query 1:
-- Returns salaries >= 100000

-- Query 2:
-- Returns salaries >= 70000


-- =========================================================
-- SECTION 5: EXECUTE MULTI-QUERY PROCEDURE
-- PURPOSE:
-- Run multiple result sets
-- =========================================================

CALL salary_reports();

-- WHAT IT DOES:
-- Produces two separate outputs
-- from the stored procedure.


-- =========================================================
-- SECTION 6: DROP PROCEDURE IF EXISTS
-- PURPOSE:
-- Prevent duplicate procedure errors
-- =========================================================

DROP PROCEDURE IF EXISTS employee_salary_filter;

-- WHAT IT DOES:
-- Deletes procedure if it already exists.
-- Helps avoid duplicate procedure errors.


-- =========================================================
-- SECTION 7: STORED PROCEDURE WITH PARAMETERS
-- PURPOSE:
-- Pass values dynamically into procedures
-- =========================================================

DELIMITER $$

CREATE PROCEDURE employee_salary_filter(employee_id_param INT)

BEGIN

    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        d.department_name,
        jr.role_title,
        jr.base_salary

    FROM employees e

    JOIN departments d
        ON e.department_id = d.department_id

    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id

    JOIN job_roles jr
        ON ep.role_id = jr.role_id

    WHERE e.employee_id = employee_id_param
    AND jr.base_salary >= 70000;

END $$

DELIMITER ;

-- WHAT IT DOES:
-- Creates parameterized stored procedure.

-- Accepts employee ID as input.

-- Returns:
-- - Employee details
-- - Department
-- - Job role
-- - Salary


-- =========================================================
-- SECTION 8: EXECUTING PARAMETERIZED PROCEDURE
-- PURPOSE:
-- Run stored procedure using parameter
-- =========================================================

CALL employee_salary_filter(1);

-- WHAT IT DOES:
-- Executes stored procedure
-- for employee with ID = 1.


-- =========================================================
-- SECTION 9: ADVANCED BUSINESS ANALYTICS PROCEDURE
-- PURPOSE:
-- Generate department salary reports
-- =========================================================

DROP PROCEDURE IF EXISTS department_salary_analysis;

DELIMITER $$

CREATE PROCEDURE department_salary_analysis()

BEGIN

    SELECT
        d.department_name,
        COUNT(e.employee_id) AS total_employees,
        AVG(jr.base_salary) AS average_salary,
        MAX(jr.base_salary) AS highest_salary,
        MIN(jr.base_salary) AS lowest_salary,
        SUM(jr.base_salary) AS total_department_salary

    FROM employees e

    JOIN departments d
        ON e.department_id = d.department_id

    JOIN employee_positions ep
        ON e.employee_id = ep.employee_id

    JOIN job_roles jr
        ON ep.role_id = jr.role_id

    GROUP BY d.department_name
    ORDER BY average_salary DESC;

END $$

DELIMITER ;

-- WHAT IT DOES:
-- Generates complete salary analytics
-- for all departments.

-- Includes:
-- - Employee count
-- - Average salary
-- - Highest salary
-- - Lowest salary
-- - Total payroll cost


-- =========================================================
-- SECTION 10: EXECUTE ANALYTICS PROCEDURE
-- PURPOSE:
-- Run department analytics report
-- =========================================================

CALL department_salary_analysis();

-- WHAT IT DOES:
-- Produces department-level
-- payroll and salary insights.


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- STORED PROCEDURE:
-- Saved SQL program stored in database

-- CALL:
-- Executes stored procedure

-- DELIMITER:
-- Changes SQL statement separator

-- BEGIN ... END:
-- Defines multi-statement block

-- PARAMETERS:
-- Allow dynamic input values


-- =========================================================
-- BENEFITS OF STORED PROCEDURES
-- =========================================================

-- - Reusable SQL logic
-- - Improved performance
-- - Better security
-- - Reduced code repetition
-- - Centralized business logic
-- - Easier maintenance


-- =========================================================
-- BUSINESS USE CASES
-- =========================================================

-- Stored Procedures are used for:
-- - Payroll systems
-- - Financial reporting
-- - HR analytics
-- - Dashboard reporting
-- - Data validation
-- - Automation workflows
-- - Enterprise applications


-- =========================================================
-- END OF FILE
-- =========================================================
