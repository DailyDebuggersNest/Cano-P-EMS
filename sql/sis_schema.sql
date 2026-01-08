-- ============================================================
-- STUDENT INFORMATION SYSTEM (SIS) - DATABASE SCHEMA
-- ============================================================
-- Version: 1.0.0
-- Database: MySQL 5.7+ / MariaDB 10.2+
-- 
-- This file contains only the database structure definitions.
-- For sample data, see: sis_sample_data.sql
-- ============================================================

-- Create database
CREATE DATABASE IF NOT EXISTS ems_O6 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ems_O6;

-- ============================================================
-- TABLE: students
-- Primary table for student information and profiling
-- ============================================================
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) UNIQUE COMMENT 'Format: STU-YYYY-XXXXX',
    
    -- Personal Information
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    suffix VARCHAR(10),
    sex ENUM('Male', 'Female') DEFAULT NULL,
    civil_status ENUM('Single', 'Married', 'Widowed', 'Separated', 'Divorced') DEFAULT 'Single',
    nationality VARCHAR(50) DEFAULT 'Filipino',
    religion VARCHAR(50),
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'Unknown') DEFAULT 'Unknown',
    
    -- Contact Information
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    place_of_birth VARCHAR(100),
    
    -- Address
    address_street VARCHAR(255),
    address_barangay VARCHAR(100),
    address_city VARCHAR(100),
    address_province VARCHAR(100),
    address_zip VARCHAR(10),
    
    -- Guardian Information
    guardian_name VARCHAR(100),
    guardian_relationship VARCHAR(50),
    guardian_contact VARCHAR(20),
    guardian_address VARCHAR(255),
    
    -- Emergency Contact
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    
    -- Profile & Status
    profile_photo VARCHAR(255),
    student_status ENUM('Active', 'Inactive', 'Graduated', 'Dropped', 'On Leave') DEFAULT 'Active',
    
    -- Academic Information
    admission_date DATE,
    year_level ENUM('1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year') DEFAULT '1st Year',
    semester ENUM('1st Semester', '2nd Semester', 'Summer') DEFAULT '1st Semester',
    section VARCHAR(20),
    program VARCHAR(100),
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_student_status (student_status),
    INDEX idx_year_level (year_level),
    INDEX idx_program (program),
    INDEX idx_admission_date (admission_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: users
-- System users with authentication
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL COMMENT 'bcrypt hashed',
    full_name VARCHAR(100),
    role ENUM('admin', 'staff', 'viewer') DEFAULT 'staff',
    is_active BOOLEAN DEFAULT TRUE,
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_role (role),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: programs
-- Academic programs (BSIT, BSCS, etc.)
-- ============================================================
CREATE TABLE IF NOT EXISTS programs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_code VARCHAR(20) NOT NULL UNIQUE,
    program_name VARCHAR(150) NOT NULL,
    department VARCHAR(100),
    description TEXT,
    years_duration INT DEFAULT 4,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_department (department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: subjects
-- Courses/subjects offered
-- ============================================================
CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(20) NOT NULL UNIQUE,
    subject_name VARCHAR(150) NOT NULL,
    description TEXT,
    units INT DEFAULT 3,
    lecture_hours INT DEFAULT 3,
    lab_hours INT DEFAULT 0,
    year_level ENUM('1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year') DEFAULT '1st Year',
    semester ENUM('1st Semester', '2nd Semester', 'Summer') DEFAULT '1st Semester',
    program_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE SET NULL,
    
    -- Indexes
    INDEX idx_year_semester (year_level, semester),
    INDEX idx_program (program_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: enrollments
-- Student subject enrollments and grades
-- ============================================================
CREATE TABLE IF NOT EXISTS enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    academic_year VARCHAR(20) NOT NULL COMMENT 'Format: YYYY-YYYY',
    semester ENUM('1st Semester', '2nd Semester', 'Summer') DEFAULT '1st Semester',
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade DECIMAL(5,2) DEFAULT NULL,
    grade_status ENUM('Pending', 'Passed', 'Failed', 'Incomplete', 'Dropped', 'Withdrawn') DEFAULT 'Pending',
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    
    -- Unique Constraint
    UNIQUE KEY unique_enrollment (student_id, subject_id, academic_year, semester),
    
    -- Indexes
    INDEX idx_academic_year (academic_year),
    INDEX idx_grade_status (grade_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: payment_types
-- Types of fees (Tuition, Lab, Misc, etc.)
-- ============================================================
CREATE TABLE IF NOT EXISTS payment_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE: payments
-- Student payments and transactions
-- ============================================================
CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    payment_type_id INT,
    academic_year VARCHAR(20) NOT NULL,
    semester ENUM('1st Semester', '2nd Semester', 'Summer') DEFAULT '1st Semester',
    description VARCHAR(255),
    amount_due DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    amount_paid DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    payment_date DATE,
    payment_method ENUM('Cash', 'Bank Transfer', 'Online Payment', 'Check', 'Installment', 'Scholarship', 'Other') DEFAULT 'Cash',
    reference_number VARCHAR(100),
    payment_status ENUM('Unpaid', 'Partial', 'Paid', 'Overdue', 'Refunded') DEFAULT 'Unpaid',
    due_date DATE,
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_type_id) REFERENCES payment_types(id) ON DELETE SET NULL,
    
    -- Indexes
    INDEX idx_academic_year (academic_year),
    INDEX idx_payment_status (payment_status),
    INDEX idx_payment_date (payment_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- End of Schema
-- ============================================================
