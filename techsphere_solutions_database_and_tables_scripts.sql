-- =========================================================
-- FILE: database_schema.sql
-- PROJECT: TechSphere Solutions Database System
-- AUTHOR: Benard Onyango Omoga
-- DATABASE: MySQL
-- DESCRIPTION:
-- Professional relational database schema for
-- managing employees, departments, job roles,
-- and employee position assignments in a
-- technology company environment.
-- =========================================================


-- =========================================================
-- SECTION 1: DATABASE INITIALIZATION
-- =========================================================

-- Remove database if it already exists
DROP DATABASE IF EXISTS techsphere_solutions;

-- Create database
CREATE DATABASE techsphere_solutions;

-- Select database for use
USE techsphere_solutions;


-- =========================================================
-- SECTION 2: TABLE CREATION
-- =========================================================


-- ---------------------------------------------------------
-- TABLE: departments
-- PURPOSE:
-- Stores company department information
-- ---------------------------------------------------------
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_location VARCHAR(100)
);


-- ---------------------------------------------------------
-- TABLE: employees
-- PURPOSE:
-- Stores employee personal and employment details
-- ---------------------------------------------------------
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    
    gender ENUM('Male', 'Female', 'Other'),
    
    date_of_birth DATE,
    
    email VARCHAR(100) UNIQUE,
    
    phone_number VARCHAR(20),
    
    hire_date DATE NOT NULL,
    
    department_id INT,
    
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- ---------------------------------------------------------
-- TABLE: job_roles
-- PURPOSE:
-- Stores company job titles and salary structures
-- ---------------------------------------------------------
CREATE TABLE job_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    
    role_title VARCHAR(100) NOT NULL UNIQUE,
    
    base_salary DECIMAL(10,2) NOT NULL
);


-- ---------------------------------------------------------
-- TABLE: employee_positions
-- PURPOSE:
-- Links employees to their assigned job roles
-- ---------------------------------------------------------
CREATE TABLE employee_positions (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    
    employee_id INT NOT NULL,
    
    role_id INT NOT NULL,
    
    start_date DATE NOT NULL,
    
    CONSTRAINT fk_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_role
        FOREIGN KEY (role_id)
        REFERENCES job_roles(role_id)
        ON DELETE CASCADE
);


-- =========================================================
-- SECTION 3: INSERTING SAMPLE DATA
-- =========================================================


-- ---------------------------------------------------------
-- INSERT DATA INTO departments
-- ---------------------------------------------------------
INSERT INTO departments (
    department_name,
    department_location
)
VALUES
('Software Engineering', 'Nairobi'),
('Data Analytics', 'Kisumu'),
('Cybersecurity', 'Mombasa'),
('Cloud Infrastructure', 'Nakuru'),
('AI Research', 'Eldoret'),
('Technical Support', 'Nairobi');


-- ---------------------------------------------------------
-- INSERT DATA INTO employees
-- ---------------------------------------------------------
INSERT INTO employees (
    first_name,
    last_name,
    gender,
    date_of_birth,
    email,
    phone_number,
    hire_date,
    department_id
)
VALUES

('Benard', 'Omoga', 'Male',
 '1998-06-15',
 'benard@techsphere.com',
 '+254700111111',
 '2023-01-10',
 2),

('Lilian', 'Achieng', 'Female',
 '1995-09-20',
 'lilian@techsphere.com',
 '+254700222222',
 '2022-05-14',
 1),

('Kevin', 'Otieno', 'Male',
 '1993-11-08',
 'kevin@techsphere.com',
 '+254700333333',
 '2021-03-19',
 3),

('Faith', 'Njeri', 'Female',
 '1999-02-11',
 'faith@techsphere.com',
 '+254700444444',
 '2024-01-03',
 5),

('Brian', 'Mwangi', 'Male',
 '1990-07-29',
 'brian@techsphere.com',
 '+254700555555',
 '2020-09-18',
 4),

('Mercy', 'Atieno', 'Female',
 '1997-12-05',
 'mercy@techsphere.com',
 '+254700666666',
 '2022-11-25',
 6);


-- ---------------------------------------------------------
-- INSERT DATA INTO job_roles
-- ---------------------------------------------------------
INSERT INTO job_roles (
    role_title,
    base_salary
)
VALUES
('Data Analyst', 85000.00),
('Software Engineer', 120000.00),
('Cybersecurity Analyst', 135000.00),
('Cloud Engineer', 140000.00),
('AI Engineer', 160000.00),
('IT Support Specialist', 65000.00);


-- ---------------------------------------------------------
-- INSERT DATA INTO employee_positions
-- ---------------------------------------------------------
INSERT INTO employee_positions (
    employee_id,
    role_id,
    start_date
)
VALUES
(1, 1, '2023-01-10'),
(2, 2, '2022-05-14'),
(3, 3, '2021-03-19'),
(4, 5, '2024-01-03'),
(5, 4, '2020-09-18'),
(6, 6, '2022-11-25');

-- =========================================================
-- END OF FILE
-- =========================================================