```sql id="techsphere_case_statements_001"
-- =========================================================
-- FILE: case_statements.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates CASE statements in MySQL
-- using the TechSphere database structure.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO CASE STATEMENTS
-- PURPOSE:
-- CASE statements add conditional logic to SQL queries,
-- similar to IF...ELSE statements in programming.
-- =========================================================


-- View all employee records
SELECT *
FROM employees;


-- =========================================================
-- SECTION 2: SIMPLE CASE STATEMENT
-- PURPOSE:
-- Categorize employees by age group
-- =========================================================

SELECT
    first_name,
    last_name,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age,

    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) <= 30
            THEN 'Young Professional'
    END AS age_category

FROM employees;

-- WHAT IT DOES:
-- Calculates employee age
-- Labels employees aged 30 or below as:
-- "Young Professional"


-- =========================================================
-- SECTION 3: MULTIPLE CONDITIONS IN CASE
-- PURPOSE:
-- Create multiple employee age categories
-- =========================================================

SELECT
    first_name,
    last_name,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age,

    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) <= 30
            THEN 'Young Professional'

        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 31 AND 45
            THEN 'Experienced Professional'

        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > 45
            THEN 'Senior Professional'

    END AS age_category

FROM employees;

-- WHAT IT DOES:
-- Divides employees into:
-- 1. Young Professional
-- 2. Experienced Professional
-- 3. Senior Professional


-- =========================================================
-- SECTION 4: CASE WITH SALARY CALCULATIONS
-- PURPOSE:
-- Apply salary increment logic
-- =========================================================

SELECT
    role_title,
    base_salary,

    CASE
        WHEN base_salary >= 120000
            THEN base_salary + (base_salary * 0.10)

        WHEN base_salary < 120000
            THEN base_salary + (base_salary * 0.05)

    END AS revised_salary

FROM job_roles;

-- WHAT IT DOES:
-- Gives:
-- 10% increment for salaries >= 120000
-- 5% increment for salaries below 120000


-- =========================================================
-- SECTION 5: CASE WITH BONUS CALCULATIONS
-- PURPOSE:
-- Add department-specific bonuses
-- =========================================================

SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    jr.base_salary,

    CASE
        WHEN jr.base_salary >= 120000
            THEN jr.base_salary + (jr.base_salary * 0.10)

        WHEN jr.base_salary < 120000
            THEN jr.base_salary + (jr.base_salary * 0.05)

    END AS revised_salary,

    CASE
        WHEN d.department_name = 'AI Research'
            THEN jr.base_salary * 0.15

        WHEN d.department_name = 'Cybersecurity'
            THEN jr.base_salary * 0.10

        ELSE 0

    END AS bonus

FROM employees e

JOIN employee_positions ep
    ON e.employee_id = ep.employee_id

JOIN job_roles jr
    ON ep.role_id = jr.role_id

JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Calculates:
-- Salary increments
-- Department bonuses

-- BONUS RULES:
-- AI Research staff get 15%
-- Cybersecurity staff get 10%
-- Others get no bonus


-- =========================================================
-- SECTION 6: PERFORMANCE CLASSIFICATION
-- PURPOSE:
-- Simulate employee ranking system
-- =========================================================

SELECT
    role_title,
    base_salary,

    CASE
        WHEN base_salary >= 150000
            THEN 'Executive Level'

        WHEN base_salary BETWEEN 100000 AND 149999
            THEN 'Senior Level'

        WHEN base_salary BETWEEN 70000 AND 99999
            THEN 'Mid Level'

        ELSE 'Entry Level'

    END AS salary_grade

FROM job_roles;

-- WHAT IT DOES:
-- Categorizes job roles into salary bands


-- =========================================================
-- SECTION 7: PRACTICAL BUSINESS ANALYTICS
-- PURPOSE:
-- HR and payroll decision support
-- =========================================================

SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    jr.role_title,
    jr.base_salary,

    CASE
        WHEN jr.base_salary >= 140000
            THEN 'High Cost Employee'

        WHEN jr.base_salary BETWEEN 90000 AND 139999
            THEN 'Moderate Cost Employee'

        ELSE 'Low Cost Employee'

    END AS employee_cost_category

FROM employees e

JOIN employee_positions ep
    ON e.employee_id = ep.employee_id

JOIN job_roles jr
    ON ep.role_id = jr.role_id

JOIN departments d
    ON e.department_id = d.department_id;

-- WHAT IT DOES:
-- Helps management classify employees
-- based on payroll cost levels


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- CASE:
-- Adds conditional logic to SQL queries

-- WHEN:
-- Specifies condition to test

-- THEN:
-- Specifies returned value if condition is TRUE

-- ELSE:
-- Optional default value

-- END:
-- Closes CASE statement


-- =========================================================
-- END OF FILE
-- =========================================================
```
