-- =========================================================
-- FILE: triggers_and_events.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates Triggers and Events in MySQL
-- using the TechSphere database schema.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO TRIGGERS
-- PURPOSE:
-- Triggers automatically execute SQL code
-- when INSERT, UPDATE, or DELETE events occur.
-- =========================================================


-- View employee role data
SELECT *
FROM job_roles;


-- View employee records
SELECT *
FROM employees;


-- =========================================================
-- SECTION 2: CREATE TRIGGER
-- PURPOSE:
-- Automatically insert employee audit records
-- whenever a new employee is added.
-- =========================================================

DELIMITER $$

CREATE TRIGGER employee_after_insert

AFTER INSERT ON employees

FOR EACH ROW

BEGIN

    INSERT INTO employee_audit_log
    (
        employee_id,
        first_name,
        last_name,
        action_type,
        action_timestamp
    )

    VALUES
    (
        NEW.employee_id,
        NEW.first_name,
        NEW.last_name,
        'INSERT',
        NOW()
    );

END $$

DELIMITER ;

-- WHAT IT DOES:
-- Automatically logs newly inserted employees
-- into employee_audit_log table.

-- NEW keyword:
-- Refers to newly inserted row values.


-- =========================================================
-- SECTION 3: TESTING THE TRIGGER
-- PURPOSE:
-- Insert new employee and verify trigger execution
-- =========================================================

INSERT INTO employees
(
    employee_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    hire_date,
    department_id
)

VALUES
(
    101,
    'Benard',
    'Omoga',
    'Male',
    '1995-04-10',
    '2025-01-15',
    2
);

-- WHAT IT DOES:
-- Inserts new employee record.

-- Trigger automatically creates
-- audit log entry.


-- View audit log
SELECT *
FROM employee_audit_log;


-- =========================================================
-- SECTION 4: DELETE TEST DATA
-- PURPOSE:
-- Clean up inserted test records
-- =========================================================

DELETE FROM employees
WHERE employee_id = 101;

-- WHAT IT DOES:
-- Removes temporary test employee.


-- =========================================================
-- SECTION 5: INTRODUCTION TO EVENTS
-- PURPOSE:
-- Events execute SQL tasks automatically
-- based on schedules.
-- =========================================================


-- View existing events
SHOW EVENTS;


-- =========================================================
-- SECTION 6: CREATE AUTOMATED EVENT
-- PURPOSE:
-- Automatically archive inactive employees
-- =========================================================

DROP EVENT IF EXISTS archive_old_employees;

DELIMITER $$

CREATE EVENT archive_old_employees

ON SCHEDULE EVERY 1 DAY

DO

BEGIN

    INSERT INTO archived_employees

    SELECT *
    FROM employees
    WHERE hire_date < '2015-01-01';

END $$

DELIMITER ;

-- WHAT IT DOES:
-- Every day:
-- Copies employees hired before 2015
-- into archived_employees table.

-- Useful for:
-- - Archiving old records
-- - Data lifecycle management
-- - Historical reporting


-- =========================================================
-- SECTION 7: EVENT FOR AUTOMATED CLEANUP
-- PURPOSE:
-- Automatically remove inactive temp records
-- =========================================================

DROP EVENT IF EXISTS cleanup_temp_reports;

DELIMITER $$

CREATE EVENT cleanup_temp_reports

ON SCHEDULE EVERY 12 HOUR

DO

BEGIN

    DELETE
    FROM temporary_reports
    WHERE created_at < NOW() - INTERVAL 7 DAY;

END $$

DELIMITER ;

-- WHAT IT DOES:
-- Automatically deletes temporary reports
-- older than 7 days.

-- Helps maintain database performance
-- and storage efficiency.


-- =========================================================
-- SECTION 8: VERIFY EVENTS
-- PURPOSE:
-- Check active scheduled events
-- =========================================================

SHOW EVENTS;

-- WHAT IT DOES:
-- Displays all database events
-- and their schedules.


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- TRIGGER:
-- Automatically executes after table event

-- EVENT:
-- Scheduled SQL task automation

-- NEW:
-- Accesses newly inserted row values

-- FOR EACH ROW:
-- Executes trigger once per inserted row

-- DELIMITER:
-- Changes SQL statement separator


-- =========================================================
-- BENEFITS OF TRIGGERS
-- =========================================================

-- - Automatic auditing
-- - Data validation
-- - Activity tracking
-- - Business rule enforcement
-- - Real-time automation


-- =========================================================
-- BENEFITS OF EVENTS
-- =========================================================

-- - Scheduled automation
-- - Automatic cleanup
-- - Reporting automation
-- - Data archiving
-- - ETL scheduling
-- - Maintenance operations


-- =========================================================
-- BUSINESS USE CASES
-- =========================================================

-- Triggers:
-- - Audit logging
-- - Security tracking
-- - Payroll updates
-- - Inventory updates

-- Events:
-- - Daily reporting
-- - Data backups
-- - Automated cleanup
-- - Scheduled analytics
-- - Archive management


-- =========================================================
-- END OF FILE
-- =========================================================