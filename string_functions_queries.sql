-- =========================================================
-- FILE: string_functions.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Demonstrates commonly used MySQL string functions
-- using TechSphere database tables.
-- =========================================================


-- =========================================================
-- USE DATABASE
-- =========================================================
USE techsphere_solutions;


-- =========================================================
-- SECTION 1: INTRODUCTION TO STRING FUNCTIONS
-- PURPOSE:
-- String functions help manipulate, analyze,
-- clean, and transform textual data.
-- =========================================================


-- View employee records
SELECT *
FROM employees;


-- =========================================================
-- SECTION 2: LENGTH FUNCTION
-- PURPOSE:
-- Returns number of characters in a string
-- =========================================================

-- Length of a sample word
SELECT LENGTH('TechSphere');

-- Length of employee first names
SELECT
    first_name,
    LENGTH(first_name) AS name_length
FROM employees;

-- WHAT IT DOES:
-- Counts total characters in each first name


-- =========================================================
-- SECTION 3: UPPER FUNCTION
-- PURPOSE:
-- Converts text to uppercase
-- =========================================================

-- Convert sample word to uppercase
SELECT UPPER('techsphere');

-- Convert employee names to uppercase
SELECT
    first_name,
    UPPER(first_name) AS upper_name
FROM employees;

-- WHAT IT DOES:
-- Standardizes names into uppercase format


-- =========================================================
-- SECTION 4: LOWER FUNCTION
-- PURPOSE:
-- Converts text to lowercase
-- =========================================================

-- Convert sample word to lowercase
SELECT LOWER('TECHSPHERE');

-- Convert employee names to lowercase
SELECT
    first_name,
    LOWER(first_name) AS lower_name
FROM employees;

-- WHAT IT DOES:
-- Standardizes names into lowercase format


-- =========================================================
-- SECTION 5: TRIM FUNCTIONS
-- PURPOSE:
-- Removes unnecessary spaces
-- =========================================================

-- Remove spaces from both sides
SELECT TRIM('   TechSphere   ');

-- Remove spaces from left side only
SELECT LTRIM('     SQL Learning');

-- Remove spaces from right side only
SELECT RTRIM('SQL Learning     ');

-- WHAT IT DOES:
-- Cleans text formatting issues


-- =========================================================
-- SECTION 6: LEFT FUNCTION
-- PURPOSE:
-- Extract characters from left side
-- =========================================================

-- Extract first 4 letters from sample text
SELECT LEFT('Technology', 4);

-- Extract first 3 letters of employee names
SELECT
    first_name,
    LEFT(first_name, 3) AS short_name
FROM employees;

-- WHAT IT DOES:
-- Creates abbreviations or prefixes


-- =========================================================
-- SECTION 7: RIGHT FUNCTION
-- PURPOSE:
-- Extract characters from right side
-- =========================================================

-- Extract last 5 letters
SELECT RIGHT('Technology', 5);

-- Extract last 2 letters of employee names
SELECT
    first_name,
    RIGHT(first_name, 2) AS ending_letters
FROM employees;

-- WHAT IT DOES:
-- Retrieves suffixes or ending characters


-- =========================================================
-- SECTION 8: SUBSTRING FUNCTION
-- PURPOSE:
-- Extract part of a string from any position
-- =========================================================

-- Extract substring from sample word
SELECT SUBSTRING('Technology', 2, 4);

-- Extract hire year from hire date
SELECT
    hire_date,
    SUBSTRING(hire_date, 1, 4) AS hire_year
FROM employees;

-- WHAT IT DOES:
-- Retrieves year portion from date values


-- =========================================================
-- SECTION 9: REPLACE FUNCTION
-- PURPOSE:
-- Replace characters or words inside strings
-- =========================================================

-- Replace letters in sample text
SELECT REPLACE('Technology', 'o', '0');

-- Replace letter in employee names
SELECT
    first_name,
    REPLACE(first_name, 'a', '@') AS modified_name
FROM employees;

-- WHAT IT DOES:
-- Performs text substitution


-- =========================================================
-- SECTION 10: LOCATE FUNCTION
-- PURPOSE:
-- Finds position of a character or substring
-- =========================================================

-- Locate character in sample text
SELECT LOCATE('o', 'Technology');

-- Find position of letter in employee names
SELECT
    first_name,
    LOCATE('a', first_name) AS position_of_a
FROM employees;

-- WHAT IT DOES:
-- Returns position of searched character


-- =========================================================
-- SECTION 11: CONCAT FUNCTION
-- PURPOSE:
-- Combines multiple strings together
-- =========================================================

-- Combine sample strings
SELECT CONCAT('Tech', 'Sphere');

-- Create full employee names
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

-- WHAT IT DOES:
-- Merges first and last names into one column


-- =========================================================
-- SECTION 12: PRACTICAL BUSINESS EXAMPLE
-- =========================================================

-- Generate professional employee usernames
SELECT
    first_name,
    last_name,
    LOWER(CONCAT(LEFT(first_name,1), last_name)) AS username
FROM employees;

-- WHAT IT DOES:
-- Creates usernames like:
-- bomoga
-- lachieng
-- kotieno


-- =========================================================
-- KEY CONCEPT SUMMARY
-- =========================================================

-- LENGTH:
-- Counts characters

-- UPPER / LOWER:
-- Changes text case

-- TRIM / LTRIM / RTRIM:
-- Removes spaces

-- LEFT / RIGHT:
-- Extracts characters from sides

-- SUBSTRING:
-- Extracts text from any position

-- REPLACE:
-- Replaces characters or words

-- LOCATE:
-- Finds character position

-- CONCAT:
-- Combines strings


-- =========================================================
-- END OF FILE
-- =========================================================