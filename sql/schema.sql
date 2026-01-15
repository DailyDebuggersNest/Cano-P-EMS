-- ============================================================
-- STUDENT INFORMATION SYSTEM (SIS) - DATABASE SCHEMA
-- ============================================================
-- Version: 2.3.0
-- Author: EMS Development Team
-- Database: MySQL 8.0+ / MariaDB 10.5+
-- Last Updated: 2026-01-15
-- 
-- This file contains the complete database structure.
-- For sample data, see: sis_sample_data.sql
--
-- TABLE STRUCTURE:
--   1. departments        - Academic departments
--   2. programs           - Academic programs (BSIT, BSCS, etc.)
--   3. academic_years     - Academic year periods
--   4. curriculum         - Course offerings per program
--   5. instructors        - Faculty members
--   6. students           - Student records
--   7. student_programs   - Student-program enrollment history
--   8. enrollments        - Subject enrollments per term
--   9. class_schedules    - Weekly class schedules
--  10. payment_types      - Fee categories
--  11. payments           - Payment transactions
--  12. users              - System authentication
-- ============================================================

-- Create database with proper character encoding
CREATE DATABASE IF NOT EXISTS ems_O6 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

USE ems_O6;

-- Disable foreign key checks for clean creation
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- TABLE: departments
-- Academic departments/colleges
-- ============================================================
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_code VARCHAR(20) NOT NULL UNIQUE,
    department_name VARCHAR(150) NOT NULL,
    college VARCHAR(150),
    dean_name VARCHAR(100),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    office_location VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_dept_active (is_active),
    INDEX idx_college (college)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Academic departments and colleges';

-- ============================================================
-- TABLE: programs
-- Academic degree programs
-- ============================================================
DROP TABLE IF EXISTS programs;
CREATE TABLE programs (
    program_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    program_code VARCHAR(20) NOT NULL UNIQUE,
    program_name VARCHAR(150) NOT NULL,
    department_id INT UNSIGNED,
    degree_type ENUM('Certificate', 'Associate', 'Bachelor', 'Master', 'Doctorate') DEFAULT 'Bachelor',
    description TEXT,
    total_units INT UNSIGNED DEFAULT 0 COMMENT 'Total units required for graduation',
    years_duration TINYINT UNSIGNED DEFAULT 4,
    is_active BOOLEAN DEFAULT TRUE,
    accreditation_status ENUM('None', 'Candidate', 'Level I', 'Level II', 'Level III', 'Level IV') DEFAULT 'None',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_program_department 
        FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    INDEX idx_program_active (is_active),
    INDEX idx_program_dept (department_id),
    INDEX idx_degree_type (degree_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Academic degree programs offered';

-- ============================================================
-- TABLE: academic_years
-- Academic year and term management
-- ============================================================
DROP TABLE IF EXISTS academic_years;
CREATE TABLE academic_years (
    academic_year_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    academic_year VARCHAR(20) NOT NULL COMMENT 'Format: YYYY-YYYY (e.g., 2025-2026)',
    semester ENUM('1st Semester', '2nd Semester', 'Summer') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    enrollment_start DATE,
    enrollment_end DATE,
    is_current BOOLEAN DEFAULT FALSE COMMENT 'Only one term should be current',
    status ENUM('Upcoming', 'Enrollment', 'Ongoing', 'Finals', 'Completed') DEFAULT 'Upcoming',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY uk_academic_term (academic_year, semester),
    INDEX idx_is_current (is_current),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Academic calendar and term management';

-- Note: MySQL/MariaDB triggers cannot update the same table they're triggered on.
-- Use the stored procedure sp_set_current_academic_year() instead to safely set the current term.

-- ============================================================
-- TABLE: curriculum
-- Course/subject offerings per program (replaces "subjects")
-- ============================================================
DROP TABLE IF EXISTS curriculum;
CREATE TABLE curriculum (
    curriculum_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL,
    course_name VARCHAR(150) NOT NULL,
    description TEXT,
    
    -- Unit breakdown
    units TINYINT UNSIGNED DEFAULT 3 COMMENT 'Total units (lec + lab)',
    lecture_units TINYINT UNSIGNED DEFAULT 3,
    lab_units TINYINT UNSIGNED DEFAULT 0,
    lecture_hours TINYINT UNSIGNED DEFAULT 3 COMMENT 'Hours per week',
    lab_hours TINYINT UNSIGNED DEFAULT 0 COMMENT 'Hours per week',
    
    -- Classification
    program_id INT UNSIGNED NOT NULL,
    year_level ENUM('1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year') NOT NULL,
    semester ENUM('1st Semester', '2nd Semester', 'Summer') NOT NULL,
    course_type ENUM('Core', 'Major', 'Minor', 'Elective', 'General Education', 'NSTP', 'PE') DEFAULT 'Core',
    
    -- Prerequisites (comma-separated course_codes or NULL)
    prerequisites VARCHAR(255) COMMENT 'Comma-separated prerequisite course codes',
    corequisites VARCHAR(255) COMMENT 'Courses that must be taken together',
    
    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    effective_year VARCHAR(20) COMMENT 'Curriculum year (e.g., 2024-2025)',
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_curriculum_program 
        FOREIGN KEY (program_id) REFERENCES programs(program_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    UNIQUE KEY uk_course_program (course_code, program_id, effective_year),
    INDEX idx_program_year_sem (program_id, year_level, semester),
    INDEX idx_course_type (course_type),
    INDEX idx_curriculum_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Curriculum courses and subject offerings per program';

-- ============================================================
-- TABLE: instructors
-- Faculty members and instructors
-- ============================================================
DROP TABLE IF EXISTS instructors;
CREATE TABLE instructors (
    instructor_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id VARCHAR(20) UNIQUE COMMENT 'Format: EMP-YYYY-XXXXX',
    
    -- Personal Information
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    suffix VARCHAR(10),
    title VARCHAR(30) COMMENT 'e.g., Prof., Dr., Engr.',
    
    -- Contact
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    office_location VARCHAR(100),
    
    -- Academic Info
    department_id INT UNSIGNED,
    position ENUM('Instructor', 'Assistant Professor', 'Associate Professor', 'Professor', 'Department Head', 'Dean', 'Part-time') DEFAULT 'Instructor',
    specialization VARCHAR(255),
    
    -- Status
    employment_status ENUM('Full-time', 'Part-time', 'Visiting', 'On Leave', 'Retired', 'Resigned') DEFAULT 'Full-time',
    is_active BOOLEAN DEFAULT TRUE,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_instructor_department 
        FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    INDEX idx_instructor_dept (department_id),
    INDEX idx_instructor_active (is_active),
    INDEX idx_instructor_name (last_name, first_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Faculty members and instructors';

-- ============================================================
-- TABLE: students
-- Student records and profiles
-- ============================================================
DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL UNIQUE COMMENT 'Format: STU-YYYY-XXXXX',
    
    -- Personal Information
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    suffix VARCHAR(10),
    sex ENUM('Male', 'Female') NOT NULL,
    civil_status ENUM('Single', 'Married', 'Widowed', 'Separated', 'Divorced') DEFAULT 'Single',
    nationality VARCHAR(50) DEFAULT 'Filipino',
    religion VARCHAR(50),
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'Unknown') DEFAULT 'Unknown',
    
    -- Contact Information
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE NOT NULL,
    place_of_birth VARCHAR(100),
    
    -- Address (Current)
    address_street VARCHAR(255),
    address_barangay VARCHAR(100),
    address_city VARCHAR(100),
    address_province VARCHAR(100),
    address_zip VARCHAR(10),
    
    -- Permanent Address
    permanent_address TEXT,
    
    -- Guardian/Parent Information
    guardian_name VARCHAR(100),
    guardian_relationship ENUM('Father', 'Mother', 'Guardian', 'Spouse', 'Sibling', 'Other') DEFAULT 'Guardian',
    guardian_contact VARCHAR(20),
    guardian_email VARCHAR(100),
    guardian_occupation VARCHAR(100),
    guardian_address VARCHAR(255),
    
    -- Emergency Contact
    emergency_contact_name VARCHAR(100) NOT NULL,
    emergency_contact_phone VARCHAR(20) NOT NULL,
    emergency_contact_relationship VARCHAR(50),
    
    -- Academic Information
    current_program_id INT UNSIGNED,
    admission_date DATE NOT NULL,
    admission_type ENUM('Freshman', 'Transferee', 'Second Degree', 'Cross-enrollee', 'Returnee') DEFAULT 'Freshman',
    year_level ENUM('1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year') DEFAULT '1st Year',
    current_semester ENUM('1st Semester', '2nd Semester', 'Summer') DEFAULT '1st Semester',
    section VARCHAR(20),
    
    -- Status
    student_status ENUM('Active', 'Inactive', 'Graduated', 'Dropped', 'On Leave', 'Dismissed', 'Transferred') DEFAULT 'Active',
    scholarship_status ENUM('None', 'Partial', 'Full', 'Government', 'Private') DEFAULT 'None',
    
    -- Documents & Profile
    profile_photo VARCHAR(255),
    lrn VARCHAR(20) COMMENT 'Learner Reference Number',
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_student_program 
        FOREIGN KEY (current_program_id) REFERENCES programs(program_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    INDEX idx_student_status (student_status),
    INDEX idx_student_program (current_program_id),
    INDEX idx_student_year (year_level),
    INDEX idx_student_name (last_name, first_name),
    INDEX idx_admission_date (admission_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Student master records';

-- ============================================================
-- TABLE: student_programs
-- Student program enrollment history (for transfers/shifts)
-- ============================================================
DROP TABLE IF EXISTS student_programs;
CREATE TABLE student_programs (
    student_program_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    student_id INT UNSIGNED NOT NULL,
    program_id INT UNSIGNED NOT NULL,
    academic_year_id INT UNSIGNED NOT NULL,
    
    action ENUM('Enrolled', 'Shifted', 'Transferred In', 'Transferred Out', 'Graduated', 'Dropped') NOT NULL,
    effective_date DATE NOT NULL,
    remarks TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_sp_student 
        FOREIGN KEY (student_id) REFERENCES students(student_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sp_program 
        FOREIGN KEY (program_id) REFERENCES programs(program_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_sp_academic_year 
        FOREIGN KEY (academic_year_id) REFERENCES academic_years(academic_year_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    
    INDEX idx_sp_student (student_id),
    INDEX idx_sp_program (program_id),
    INDEX idx_sp_effective (effective_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Student program enrollment and transfer history';

-- ============================================================
-- TABLE: enrollments
-- Student course enrollments per term
-- ============================================================
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (
    enrollment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    student_id INT UNSIGNED NOT NULL,
    curriculum_id INT UNSIGNED NOT NULL,
    academic_year_id INT UNSIGNED NOT NULL,
    
    -- Enrollment Details
    enrollment_date DATE NOT NULL,
    enrollment_status ENUM('Enrolled', 'Dropped', 'Withdrawn', 'Cancelled') DEFAULT 'Enrolled',
    
    -- Grading (Philippine Grade Scale: 1.00=Excellent to 3.00=Passing, 5.00=Failed)
    midterm_grade DECIMAL(3,2) DEFAULT NULL,
    final_grade DECIMAL(3,2) DEFAULT NULL,
    grade DECIMAL(3,2) DEFAULT NULL COMMENT 'Final computed grade (1.00-3.00=Pass, 5.00=Fail)',
    grade_status ENUM('Pending', 'Passed', 'Failed', 'Incomplete', 'Dropped', 'Withdrawn', 'No Grade') DEFAULT 'Pending',
    grade_remarks VARCHAR(100),
    
    -- Instructor assignment
    instructor_id INT UNSIGNED,
    
    -- Metadata
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_enrollment_student 
        FOREIGN KEY (student_id) REFERENCES students(student_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_enrollment_curriculum 
        FOREIGN KEY (curriculum_id) REFERENCES curriculum(curriculum_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_enrollment_academic_year 
        FOREIGN KEY (academic_year_id) REFERENCES academic_years(academic_year_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_enrollment_instructor 
        FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    UNIQUE KEY uk_enrollment (student_id, curriculum_id, academic_year_id),
    INDEX idx_enrollment_status (enrollment_status),
    INDEX idx_enrollment_grade (grade_status),
    INDEX idx_enrollment_instructor (instructor_id),
    INDEX idx_student_year (student_id, academic_year_id) COMMENT 'Composite index for student semester queries',
    
    -- Grade validation constraints (Philippine scale: 1.00-3.00 passing, 5.00 failed)
    CONSTRAINT chk_midterm_grade CHECK (midterm_grade IS NULL OR midterm_grade BETWEEN 1.00 AND 5.00),
    CONSTRAINT chk_final_grade CHECK (final_grade IS NULL OR final_grade BETWEEN 1.00 AND 5.00),
    CONSTRAINT chk_grade CHECK (grade IS NULL OR grade BETWEEN 1.00 AND 5.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Student course enrollments and grades';

-- ============================================================
-- TABLE: class_schedules
-- Weekly class schedule per enrollment
-- ============================================================
DROP TABLE IF EXISTS class_schedules;
CREATE TABLE class_schedules (
    schedule_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT UNSIGNED NOT NULL,
    
    -- Schedule Details
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    
    -- Location
    room VARCHAR(50),
    building VARCHAR(100),
    
    -- Instructor (can override enrollment instructor)
    instructor_id INT UNSIGNED,
    
    -- Class Info
    class_type ENUM('Lecture', 'Laboratory', 'Tutorial', 'Seminar', 'Online', 'Hybrid', 'Field', 'Practicum') DEFAULT 'Lecture',
    is_active BOOLEAN DEFAULT TRUE,
    notes TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Ensure end time is after start time
    CONSTRAINT chk_schedule_time CHECK (end_time > start_time),
    
    CONSTRAINT fk_schedule_enrollment 
        FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_schedule_instructor 
        FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    INDEX idx_schedule_day (day_of_week),
    INDEX idx_schedule_time (start_time, end_time),
    INDEX idx_schedule_room (building, room),
    INDEX idx_schedule_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Weekly class schedules per enrollment';

-- ============================================================
-- TABLE: payment_types
-- Fee categories and types
-- ============================================================
DROP TABLE IF EXISTS payment_types;
CREATE TABLE payment_types (
    payment_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type_code VARCHAR(20) NOT NULL UNIQUE,
    type_name VARCHAR(100) NOT NULL,
    description TEXT,
    category ENUM('Tuition', 'Laboratory', 'Miscellaneous', 'Other Fees') DEFAULT 'Other Fees',
    default_amount DECIMAL(12,2) DEFAULT 0.00,
    is_mandatory BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_payment_type_category (category),
    INDEX idx_payment_type_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Fee types and categories';

-- ============================================================
-- TABLE: users
-- System users for authentication
-- ============================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL COMMENT 'bcrypt hashed password',
    
    -- Profile
    full_name VARCHAR(100) NOT NULL,
    role ENUM('Super Admin', 'Admin', 'Registrar', 'Cashier', 'Faculty', 'Staff', 'Viewer') DEFAULT 'Staff',
    department_id INT UNSIGNED,
    
    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    
    -- Security
    last_login DATETIME,
    last_password_change DATETIME,
    failed_login_attempts TINYINT UNSIGNED DEFAULT 0,
    locked_until DATETIME,
    
    -- Tokens
    remember_token VARCHAR(255),
    reset_token VARCHAR(255),
    reset_token_expires DATETIME,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_user_department 
        FOREIGN KEY (department_id) REFERENCES departments(department_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    INDEX idx_user_role (role),
    INDEX idx_user_active (is_active),
    INDEX idx_user_department (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='System users and authentication';

-- ============================================================
-- TABLE: payments
-- Student payment transactions
-- ============================================================
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
    payment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    student_id INT UNSIGNED NOT NULL,
    payment_type_id INT UNSIGNED,
    academic_year_id INT UNSIGNED NOT NULL,
    
    -- Transaction Details
    description VARCHAR(255),
    amount_due DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    amount_paid DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    balance DECIMAL(12,2) GENERATED ALWAYS AS (amount_due - amount_paid) STORED,
    
    -- Payment Info
    payment_date DATE,
    due_date DATE,
    payment_method ENUM('Cash', 'Bank Transfer', 'Online Payment', 'Check', 'Installment', 'Scholarship', 'Credit Card', 'Other') DEFAULT 'Cash',
    reference_number VARCHAR(100),
    payment_status ENUM('Unpaid', 'Partial', 'Paid', 'Overdue', 'Refunded', 'Waived') DEFAULT 'Unpaid',
    
    -- Processing
    processed_by INT UNSIGNED COMMENT 'User who processed the payment',
    remarks TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_payment_student 
        FOREIGN KEY (student_id) REFERENCES students(student_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payment_type 
        FOREIGN KEY (payment_type_id) REFERENCES payment_types(payment_type_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_payment_academic_year 
        FOREIGN KEY (academic_year_id) REFERENCES academic_years(academic_year_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_payment_processed_by 
        FOREIGN KEY (processed_by) REFERENCES users(user_id) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    
    INDEX idx_payment_status (payment_status),
    INDEX idx_payment_date (payment_date),
    INDEX idx_payment_due (due_date),
    INDEX idx_payment_student (student_id),
    INDEX idx_payment_academic (academic_year_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Student payment transactions';

-- ============================================================
-- Re-enable foreign key checks
-- ============================================================
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- VIEWS: Useful data views for reporting
-- ============================================================

-- View: Current student enrollment summary
CREATE OR REPLACE VIEW vw_student_enrollment_summary AS
SELECT 
    s.student_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name, ' ', IFNULL(s.middle_name, '')) AS full_name,
    p.program_code,
    p.program_name,
    s.year_level,
    s.current_semester,
    s.section,
    s.student_status,
    COUNT(e.enrollment_id) AS enrolled_courses,
    SUM(c.units) AS total_units
FROM students s
LEFT JOIN programs p ON s.current_program_id = p.program_id
LEFT JOIN enrollments e ON s.student_id = e.student_id AND e.enrollment_status = 'Enrolled'
LEFT JOIN curriculum c ON e.curriculum_id = c.curriculum_id
GROUP BY s.student_id;

-- View: Student balance summary
CREATE OR REPLACE VIEW vw_student_balance AS
SELECT 
    s.student_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name) AS student_name,
    ay.academic_year,
    ay.semester,
    SUM(p.amount_due) AS total_due,
    SUM(p.amount_paid) AS total_paid,
    SUM(p.amount_due - p.amount_paid) AS total_balance
FROM students s
JOIN payments p ON s.student_id = p.student_id
JOIN academic_years ay ON p.academic_year_id = ay.academic_year_id
GROUP BY s.student_id, ay.academic_year_id;

-- View: Curriculum overview
CREATE OR REPLACE VIEW vw_curriculum_overview AS
SELECT 
    c.curriculum_id AS curriculum_id,
    c.course_code,
    c.course_name,
    c.units,
    c.year_level,
    c.semester,
    c.course_type,
    p.program_code,
    p.program_name,
    d.department_name
FROM curriculum c
JOIN programs p ON c.program_id = p.program_id
LEFT JOIN departments d ON p.department_id = d.department_id
WHERE c.is_active = TRUE
ORDER BY p.program_code, c.year_level, c.semester, c.course_code;

-- View: Class schedule overview
CREATE OR REPLACE VIEW vw_class_schedule AS
SELECT 
    cs.schedule_id AS schedule_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name) AS student_name,
    c.course_code,
    c.course_name,
    cs.day_of_week,
    cs.start_time,
    cs.end_time,
    cs.room,
    cs.building,
    CONCAT(i.title, ' ', i.first_name, ' ', i.last_name) AS instructor_name,
    cs.class_type
FROM class_schedules cs
JOIN enrollments e ON cs.enrollment_id = e.enrollment_id
JOIN students s ON e.student_id = s.student_id
JOIN curriculum c ON e.curriculum_id = c.curriculum_id
LEFT JOIN instructors i ON COALESCE(cs.instructor_id, e.instructor_id) = i.instructor_id
WHERE cs.is_active = TRUE
ORDER BY s.last_name, cs.day_of_week, cs.start_time;

-- View: Departments with program count
CREATE OR REPLACE VIEW vw_departments AS
SELECT 
    d.department_id,
    d.department_code,
    d.department_name,
    d.college,
    d.dean_name,
    COUNT(p.program_id) AS program_count
FROM departments d
LEFT JOIN programs p ON d.department_id = p.department_id
WHERE d.is_active = TRUE
GROUP BY d.department_id;

-- View: Active payment types
CREATE OR REPLACE VIEW vw_payment_types AS
SELECT 
    payment_type_id,
    type_code,
    type_name,
    description,
    category,
    default_amount,
    is_mandatory
FROM payment_types
WHERE is_active = TRUE;

-- View: Student program history
CREATE OR REPLACE VIEW vw_student_program_history AS
SELECT 
    sp.student_program_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name) AS student_name,
    p.program_code,
    p.program_name,
    ay.academic_year,
    ay.semester,
    sp.action,
    sp.effective_date,
    sp.remarks
FROM student_programs sp
JOIN students s ON sp.student_id = s.student_id
JOIN programs p ON sp.program_id = p.program_id
JOIN academic_years ay ON sp.academic_year_id = ay.academic_year_id;

-- ============================================================
-- TRIGGERS: Automatic data management
-- ============================================================

DELIMITER //

-- Trigger: Auto-update payment status before insert
-- Priority: Paid > Overdue > Partial > Unpaid
CREATE TRIGGER trg_payment_before_insert
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    IF NEW.amount_paid >= NEW.amount_due THEN
        SET NEW.payment_status = 'Paid';
    ELSEIF NEW.due_date IS NOT NULL AND NEW.due_date < CURDATE() AND NEW.amount_paid < NEW.amount_due THEN
        -- Check overdue BEFORE partial (past due date with any unpaid balance = overdue)
        SET NEW.payment_status = 'Overdue';
    ELSEIF NEW.amount_paid > 0 AND NEW.amount_paid < NEW.amount_due THEN
        SET NEW.payment_status = 'Partial';
    ELSE
        SET NEW.payment_status = 'Unpaid';
    END IF;
END//

-- Trigger: Auto-update payment status before update
-- Priority: Paid > Overdue > Partial > Unpaid
CREATE TRIGGER trg_payment_before_update
BEFORE UPDATE ON payments
FOR EACH ROW
BEGIN
    IF NEW.amount_paid >= NEW.amount_due THEN
        SET NEW.payment_status = 'Paid';
    ELSEIF NEW.due_date IS NOT NULL AND NEW.due_date < CURDATE() AND NEW.amount_paid < NEW.amount_due THEN
        -- Check overdue BEFORE partial (past due date with any unpaid balance = overdue)
        SET NEW.payment_status = 'Overdue';
    ELSEIF NEW.amount_paid > 0 AND NEW.amount_paid < NEW.amount_due THEN
        SET NEW.payment_status = 'Partial';
    ELSE
        SET NEW.payment_status = 'Unpaid';
    END IF;
END//

-- Trigger: Auto-update grade status based on grade
CREATE TRIGGER trg_enrollment_grade_update
BEFORE UPDATE ON enrollments
FOR EACH ROW
BEGIN
    IF NEW.grade IS NOT NULL AND OLD.grade IS NULL THEN
        IF NEW.grade <= 3.00 THEN
            SET NEW.grade_status = 'Passed';
        ELSEIF NEW.grade = 5.00 THEN
            SET NEW.grade_status = 'Failed';
        ELSEIF NEW.grade = 0.00 THEN
            SET NEW.grade_status = 'Incomplete';
        END IF;
    END IF;
END//

DELIMITER ;

-- ============================================================
-- STORED PROCEDURES: Common operations
-- ============================================================

DELIMITER //

-- Procedure: Get student complete profile
CREATE PROCEDURE sp_get_student_profile(IN p_student_id INT)
BEGIN
    SELECT 
        s.*,
        p.program_code,
        p.program_name,
        d.department_name
    FROM students s
    LEFT JOIN programs p ON s.current_program_id = p.program_id
    LEFT JOIN departments d ON p.department_id = d.department_id
    WHERE s.student_id = p_student_id;
END//

-- Procedure: Get student current enrollments
CREATE PROCEDURE sp_get_student_enrollments(IN p_student_id INT)
BEGIN
    SELECT 
        e.enrollment_id AS enrollment_id,
        c.course_code,
        c.course_name,
        c.units,
        c.course_type,
        ay.academic_year,
        ay.semester,
        e.grade,
        e.grade_status,
        CONCAT(i.title, ' ', i.first_name, ' ', i.last_name) AS instructor
    FROM enrollments e
    JOIN curriculum c ON e.curriculum_id = c.curriculum_id
    JOIN academic_years ay ON e.academic_year_id = ay.academic_year_id
    LEFT JOIN instructors i ON e.instructor_id = i.instructor_id
    WHERE e.student_id = p_student_id
    ORDER BY ay.academic_year DESC, ay.semester DESC, c.course_code;
END//

-- Procedure: Get student schedule
CREATE PROCEDURE sp_get_student_schedule(IN p_student_id INT)
BEGIN
    SELECT 
        c.course_code,
        c.course_name,
        cs.day_of_week,
        TIME_FORMAT(cs.start_time, '%h:%i %p') AS start_time,
        TIME_FORMAT(cs.end_time, '%h:%i %p') AS end_time,
        CONCAT(cs.room, ', ', cs.building) AS location,
        CONCAT(IFNULL(i.title, ''), ' ', i.first_name, ' ', i.last_name) AS instructor,
        cs.class_type
    FROM class_schedules cs
    JOIN enrollments e ON cs.enrollment_id = e.enrollment_id
    JOIN curriculum c ON e.curriculum_id = c.curriculum_id
    LEFT JOIN instructors i ON COALESCE(cs.instructor_id, e.instructor_id) = i.instructor_id
    WHERE e.student_id = p_student_id
      AND cs.is_active = TRUE
      AND e.enrollment_status = 'Enrolled'
    ORDER BY FIELD(cs.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
             cs.start_time;
END//

-- Procedure: Get student payment summary
CREATE PROCEDURE sp_get_student_payments(IN p_student_id INT)
BEGIN
    SELECT 
        ay.academic_year,
        ay.semester,
        pt.type_name,
        p.description,
        p.amount_due,
        p.amount_paid,
        p.balance,
        p.payment_status,
        p.payment_date,
        p.payment_method,
        p.reference_number
    FROM payments p
    JOIN academic_years ay ON p.academic_year_id = ay.academic_year_id
    LEFT JOIN payment_types pt ON p.payment_type_id = pt.payment_type_id
    WHERE p.student_id = p_student_id
    ORDER BY ay.academic_year DESC, ay.semester DESC, pt.type_name;
END//

-- ============================================================
-- PROCEDURE: Update Overdue Payment Statuses
-- Run this daily (via cron/scheduled task) or on-demand
-- to mark past-due payments as 'Overdue'
-- ============================================================
CREATE PROCEDURE sp_update_overdue_payments()
BEGIN
    DECLARE v_updated INT DEFAULT 0;
    
    -- Update payments that are past due date and not fully paid
    -- Excludes: Paid, Refunded, Waived
    UPDATE payments
    SET payment_status = 'Overdue',
        updated_at = CURRENT_TIMESTAMP
    WHERE due_date IS NOT NULL
      AND due_date < CURDATE()
      AND amount_paid < amount_due
      AND payment_status IN ('Unpaid', 'Partial');
    
    SET v_updated = ROW_COUNT();
    
    SELECT v_updated AS payments_marked_overdue,
           CURDATE() AS checked_date;
END//

-- ============================================================
-- PROCEDURE: Get Payment Summary Statistics
-- Returns payment stats for dashboard/reports
-- ============================================================
CREATE PROCEDURE sp_get_payment_stats(
    IN p_academic_year_id INT UNSIGNED
)
BEGIN
    SELECT 
        payment_status,
        COUNT(*) AS payment_count,
        SUM(amount_due) AS total_due,
        SUM(amount_paid) AS total_paid,
        SUM(amount_due - amount_paid) AS total_balance
    FROM payments
    WHERE (p_academic_year_id IS NULL OR academic_year_id = p_academic_year_id)
    GROUP BY payment_status
    ORDER BY FIELD(payment_status, 'Paid', 'Partial', 'Unpaid', 'Overdue', 'Refunded', 'Waived');
END//

-- ============================================================
-- PROCEDURE: Record Payment Transaction
-- Centralized payment recording with validation
-- ============================================================
CREATE PROCEDURE sp_record_payment(
    IN p_student_id INT UNSIGNED,
    IN p_payment_type_id INT UNSIGNED,
    IN p_academic_year_id INT UNSIGNED,
    IN p_amount_due DECIMAL(12,2),
    IN p_amount_paid DECIMAL(12,2),
    IN p_payment_date DATE,
    IN p_due_date DATE,
    IN p_payment_method VARCHAR(50),
    IN p_reference_number VARCHAR(100),
    IN p_processed_by INT UNSIGNED,
    IN p_description VARCHAR(255),
    IN p_remarks TEXT
)
BEGIN
    DECLARE v_payment_id INT UNSIGNED;
    
    -- Validate student exists
    IF NOT EXISTS (SELECT 1 FROM students WHERE student_id = p_student_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student not found';
    END IF;
    
    -- Validate academic year exists
    IF NOT EXISTS (SELECT 1 FROM academic_years WHERE academic_year_id = p_academic_year_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Academic year not found';
    END IF;
    
    -- Validate payment type if provided
    IF p_payment_type_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM payment_types WHERE payment_type_id = p_payment_type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment type not found';
    END IF;
    
    -- Insert payment record (trigger will handle status)
    INSERT INTO payments (
        student_id, payment_type_id, academic_year_id,
        description, amount_due, amount_paid,
        payment_date, due_date, payment_method,
        reference_number, processed_by, remarks
    ) VALUES (
        p_student_id, p_payment_type_id, p_academic_year_id,
        p_description, p_amount_due, p_amount_paid,
        p_payment_date, p_due_date, p_payment_method,
        p_reference_number, p_processed_by, p_remarks
    );
    
    SET v_payment_id = LAST_INSERT_ID();
    
    SELECT v_payment_id AS payment_id, 
           'Payment recorded successfully' AS message;
END//

-- Procedure: Get student program history
CREATE PROCEDURE sp_get_student_programs(IN p_student_id INT)
BEGIN
    SELECT 
        sp.student_program_id,
        p.program_code,
        p.program_name,
        d.department_name,
        ay.academic_year,
        ay.semester,
        sp.action,
        sp.effective_date,
        sp.remarks,
        sp.created_at
    FROM student_programs sp
    JOIN programs p ON sp.program_id = p.program_id
    JOIN academic_years ay ON sp.academic_year_id = ay.academic_year_id
    LEFT JOIN departments d ON p.department_id = d.department_id
    WHERE sp.student_id = p_student_id
    ORDER BY sp.effective_date DESC;
END//

-- Procedure: Get all users (for admin)
CREATE PROCEDURE sp_get_users()
BEGIN
    SELECT 
        u.user_id,
        u.username,
        u.email,
        u.full_name,
        u.role,
        d.department_name,
        u.is_active,
        u.is_verified,
        u.last_login,
        u.created_at
    FROM users u
    LEFT JOIN departments d ON u.department_id = d.department_id
    ORDER BY u.role, u.username;
END//

DELIMITER ;

-- ============================================================
-- ADDITIONAL VIEWS: Enhanced reporting
-- ============================================================

-- View: Instructor workload (classes per instructor)
CREATE OR REPLACE VIEW vw_instructor_workload AS
SELECT 
    i.instructor_id AS instructor_id,
    i.employee_id,
    CONCAT(IFNULL(i.title, ''), ' ', i.first_name, ' ', i.last_name) AS instructor_name,
    d.department_name,
    i.position,
    COUNT(DISTINCT e.enrollment_id) AS total_classes,
    COUNT(DISTINCT e.student_id) AS total_students,
    SUM(c.units) AS total_units_handled
FROM instructors i
LEFT JOIN departments d ON i.department_id = d.department_id
LEFT JOIN enrollments e ON i.instructor_id = e.instructor_id AND e.enrollment_status = 'Enrolled'
LEFT JOIN curriculum c ON e.curriculum_id = c.curriculum_id
WHERE i.is_active = TRUE
GROUP BY i.instructor_id
ORDER BY total_classes DESC;

-- View: Enrollment grades (quick grade lookup)
CREATE OR REPLACE VIEW vw_enrollment_grades AS
SELECT 
    e.enrollment_id AS enrollment_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name) AS student_name,
    p.program_code,
    c.course_code,
    c.course_name,
    c.units,
    ay.academic_year,
    ay.semester,
    e.midterm_grade,
    e.final_grade,
    e.grade,
    e.grade_status,
    CONCAT(IFNULL(i.title, ''), ' ', i.first_name, ' ', i.last_name) AS instructor_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN curriculum c ON e.curriculum_id = c.curriculum_id
JOIN academic_years ay ON e.academic_year_id = ay.academic_year_id
LEFT JOIN programs p ON s.current_program_id = p.program_id
LEFT JOIN instructors i ON e.instructor_id = i.instructor_id
ORDER BY ay.academic_year DESC, s.last_name, c.course_code;

-- View: Student full profile (all info + program + balance)
CREATE OR REPLACE VIEW vw_student_full_profile AS
SELECT 
    s.student_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name, ' ', IFNULL(s.middle_name, '')) AS full_name,
    s.first_name,
    s.middle_name,
    s.last_name,
    s.sex,
    s.email,
    s.phone,
    s.date_of_birth,
    TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) AS age,
    CONCAT(IFNULL(s.address_street, ''), ', ', IFNULL(s.address_barangay, ''), ', ', IFNULL(s.address_city, ''), ', ', IFNULL(s.address_province, '')) AS full_address,
    p.program_code,
    p.program_name,
    d.department_name,
    s.year_level,
    s.current_semester,
    s.student_status,
    s.admission_date,
    s.admission_type,
    s.scholarship_status,
    s.emergency_contact_name,
    s.emergency_contact_phone,
    (SELECT COUNT(*) FROM enrollments e WHERE e.student_id = s.student_id AND e.enrollment_status = 'Enrolled') AS enrolled_courses,
    (SELECT SUM(cu.units) FROM enrollments e JOIN curriculum cu ON e.curriculum_id = cu.curriculum_id WHERE e.student_id = s.student_id AND e.enrollment_status = 'Enrolled') AS total_units,
    (SELECT SUM(amount_due - amount_paid) FROM payments WHERE student_id = s.student_id) AS total_balance
FROM students s
LEFT JOIN programs p ON s.current_program_id = p.program_id
LEFT JOIN departments d ON p.department_id = d.department_id;

-- View: Active enrollments (current term only)
CREATE OR REPLACE VIEW vw_active_enrollments AS
SELECT 
    e.enrollment_id AS enrollment_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name) AS student_name,
    p.program_code,
    s.year_level,
    c.course_code,
    c.course_name,
    c.units,
    c.course_type,
    ay.academic_year,
    ay.semester,
    e.enrollment_date,
    CONCAT(IFNULL(i.title, ''), ' ', i.first_name, ' ', i.last_name) AS instructor_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN curriculum c ON e.curriculum_id = c.curriculum_id
JOIN academic_years ay ON e.academic_year_id = ay.academic_year_id
LEFT JOIN programs p ON s.current_program_id = p.program_id
LEFT JOIN instructors i ON e.instructor_id = i.instructor_id
WHERE e.enrollment_status = 'Enrolled'
  AND ay.is_current = TRUE
ORDER BY s.last_name, c.course_code;

-- ============================================================
-- ADDITIONAL PROCEDURES: Common operations
-- ============================================================

DELIMITER //

-- Procedure: Search students with filters
CREATE PROCEDURE sp_search_students(
    IN p_search VARCHAR(100),
    IN p_program_id INT,
    IN p_year_level VARCHAR(20),
    IN p_status VARCHAR(20),
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SET p_limit = IFNULL(p_limit, 50);
    SET p_offset = IFNULL(p_offset, 0);
    
    SELECT 
        s.student_id,
        s.student_number,
        CONCAT(s.last_name, ', ', s.first_name, ' ', IFNULL(s.middle_name, '')) AS full_name,
        s.email,
        p.program_code,
        p.program_name,
        s.year_level,
        s.student_status,
        s.created_at
    FROM students s
    LEFT JOIN programs p ON s.current_program_id = p.program_id
    WHERE (p_search IS NULL OR p_search = '' OR 
           s.student_id LIKE CONCAT('%', p_search, '%') OR
           s.first_name LIKE CONCAT('%', p_search, '%') OR
           s.last_name LIKE CONCAT('%', p_search, '%') OR
           s.email LIKE CONCAT('%', p_search, '%'))
      AND (p_program_id IS NULL OR s.current_program_id = p_program_id)
      AND (p_year_level IS NULL OR p_year_level = '' OR s.year_level = p_year_level)
      AND (p_status IS NULL OR p_status = '' OR s.student_status = p_status)
    ORDER BY s.last_name, s.first_name
    LIMIT p_limit OFFSET p_offset;
END//

-- Procedure: Get course roster (all students in a course)
CREATE PROCEDURE sp_get_course_roster(
    IN p_curriculum_id INT,
    IN p_academic_year_id INT
)
BEGIN
    SELECT 
        s.student_number,
        CONCAT(s.last_name, ', ', s.first_name) AS student_name,
        p.program_code,
        s.year_level,
        e.enrollment_date,
        e.grade,
        e.grade_status,
        CONCAT(IFNULL(i.title, ''), ' ', i.first_name, ' ', i.last_name) AS instructor_name
    FROM enrollments e
    JOIN students s ON e.student_id = s.student_id
    LEFT JOIN programs p ON s.current_program_id = p.program_id
    LEFT JOIN instructors i ON e.instructor_id = i.instructor_id
    WHERE e.curriculum_id = p_curriculum_id
      AND (p_academic_year_id IS NULL OR e.academic_year_id = p_academic_year_id)
      AND e.enrollment_status = 'Enrolled'
    ORDER BY s.last_name, s.first_name;
END//

-- Procedure: Get instructor schedule
CREATE PROCEDURE sp_get_instructor_schedule(IN p_instructor_id INT)
BEGIN
    SELECT 
        c.course_code,
        c.course_name,
        c.units,
        cs.day_of_week,
        TIME_FORMAT(cs.start_time, '%h:%i %p') AS start_time,
        TIME_FORMAT(cs.end_time, '%h:%i %p') AS end_time,
        CONCAT(cs.room, ', ', cs.building) AS location,
        cs.class_type,
        COUNT(DISTINCT e.student_id) AS student_count
    FROM class_schedules cs
    JOIN enrollments e ON cs.enrollment_id = e.enrollment_id
    JOIN curriculum c ON e.curriculum_id = c.curriculum_id
    WHERE (cs.instructor_id = p_instructor_id OR e.instructor_id = p_instructor_id)
      AND cs.is_active = TRUE
      AND e.enrollment_status = 'Enrolled'
    GROUP BY c.curriculum_id, cs.day_of_week, cs.start_time, cs.end_time, cs.room, cs.building, cs.class_type
    ORDER BY FIELD(cs.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
             cs.start_time;
END//

-- Procedure: Get academic statistics (dashboard)
CREATE PROCEDURE sp_get_academic_statistics()
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM students WHERE student_status = 'Active') AS active_students,
        (SELECT COUNT(*) FROM students WHERE student_status = 'Graduated') AS graduated_students,
        (SELECT COUNT(*) FROM instructors WHERE is_active = TRUE) AS active_instructors,
        (SELECT COUNT(*) FROM programs WHERE is_active = TRUE) AS active_programs,
        (SELECT COUNT(*) FROM departments WHERE is_active = TRUE) AS active_departments,
        (SELECT COUNT(*) FROM enrollments WHERE enrollment_status = 'Enrolled') AS current_enrollments,
        (SELECT COUNT(*) FROM curriculum WHERE is_active = TRUE) AS active_courses,
        (SELECT SUM(amount_due) FROM payments) AS total_fees_due,
        (SELECT SUM(amount_paid) FROM payments) AS total_fees_collected,
        (SELECT SUM(amount_due - amount_paid) FROM payments) AS total_outstanding_balance;
END//

-- ============================================================
-- DEBUG/MAINTENANCE PROCEDURES
-- ============================================================

-- Procedure: Check data integrity (find orphan records)
CREATE PROCEDURE sp_check_data_integrity()
BEGIN
    -- Check for orphan enrollments (no student)
    SELECT 'Orphan Enrollments (no student)' AS check_type, COUNT(*) AS count
    FROM enrollments e
    LEFT JOIN students s ON e.student_id = s.student_id
    WHERE s.student_id IS NULL
    
    UNION ALL
    
    -- Check for orphan enrollments (no curriculum)
    SELECT 'Orphan Enrollments (no curriculum)', COUNT(*)
    FROM enrollments e
    LEFT JOIN curriculum c ON e.curriculum_id = c.curriculum_id
    WHERE c.curriculum_id IS NULL
    
    UNION ALL
    
    -- Check for orphan schedules (no enrollment)
    SELECT 'Orphan Schedules (no enrollment)', COUNT(*)
    FROM class_schedules cs
    LEFT JOIN enrollments e ON cs.enrollment_id = e.enrollment_id
    WHERE e.enrollment_id IS NULL
    
    UNION ALL
    
    -- Check for orphan payments (no student)
    SELECT 'Orphan Payments (no student)', COUNT(*)
    FROM payments p
    LEFT JOIN students s ON p.student_id = s.student_id
    WHERE s.student_id IS NULL
    
    UNION ALL
    
    -- Check for students without program
    SELECT 'Students without program', COUNT(*)
    FROM students
    WHERE current_program_id IS NULL
    
    UNION ALL
    
    -- Check for enrollments without grades (past terms)
    SELECT 'Enrollments pending grades', COUNT(*)
    FROM enrollments e
    JOIN academic_years ay ON e.academic_year_id = ay.academic_year_id
    WHERE e.grade IS NULL 
      AND e.enrollment_status = 'Enrolled'
      AND ay.status = 'Completed'
    
    UNION ALL
    
    -- Check for duplicate enrollments
    SELECT 'Duplicate enrollments', COUNT(*) - COUNT(DISTINCT CONCAT(student_id, '-', curriculum_id, '-', academic_year_id))
    FROM enrollments;
END//

-- Procedure: Get database statistics (quick overview)
CREATE PROCEDURE sp_get_database_stats()
BEGIN
    SELECT 
        'departments' AS table_name, COUNT(*) AS row_count FROM departments
    UNION ALL SELECT 'programs', COUNT(*) FROM programs
    UNION ALL SELECT 'academic_years', COUNT(*) FROM academic_years
    UNION ALL SELECT 'curriculum', COUNT(*) FROM curriculum
    UNION ALL SELECT 'instructors', COUNT(*) FROM instructors
    UNION ALL SELECT 'students', COUNT(*) FROM students
    UNION ALL SELECT 'student_programs', COUNT(*) FROM student_programs
    UNION ALL SELECT 'enrollments', COUNT(*) FROM enrollments
    UNION ALL SELECT 'class_schedules', COUNT(*) FROM class_schedules
    UNION ALL SELECT 'payment_types', COUNT(*) FROM payment_types
    UNION ALL SELECT 'payments', COUNT(*) FROM payments
    UNION ALL SELECT 'users', COUNT(*) FROM users;
END//

-- Procedure: Validate prerequisites before enrollment
-- Handles single prerequisite (first one if comma-separated)
CREATE PROCEDURE sp_validate_prerequisites(
    IN p_student_id INT UNSIGNED,
    IN p_curriculum_id INT UNSIGNED,
    OUT p_can_enroll BOOLEAN,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_prereq_string VARCHAR(255);
    DECLARE v_first_prereq VARCHAR(20);
    DECLARE v_prereq_id INT UNSIGNED;
    DECLARE v_program_id INT UNSIGNED;
    DECLARE v_passed_count INT DEFAULT 0;
    DECLARE v_total_prereqs INT DEFAULT 0;
    DECLARE v_passed_prereqs INT DEFAULT 0;
    
    -- Get prerequisites and program_id for the course
    SELECT prerequisites, program_id INTO v_prereq_string, v_program_id
    FROM curriculum
    WHERE curriculum_id = p_curriculum_id;
    
    -- If no prerequisite, allow enrollment
    IF v_prereq_string IS NULL OR v_prereq_string = '' THEN
        SET p_can_enroll = TRUE;
        SET p_message = 'No prerequisite required';
    ELSE
        -- Get first prerequisite (handles comma-separated by taking first one)
        SET v_first_prereq = TRIM(SUBSTRING_INDEX(v_prereq_string, ',', 1));
        
        -- Count total prerequisites
        SET v_total_prereqs = LENGTH(v_prereq_string) - LENGTH(REPLACE(v_prereq_string, ',', '')) + 1;
        
        -- Check if student passed all prerequisites
        SELECT COUNT(*) INTO v_passed_prereqs
        FROM enrollments e
        JOIN curriculum c ON e.curriculum_id = c.curriculum_id
        WHERE e.student_id = p_student_id
          AND e.grade_status = 'Passed'
          AND c.program_id = v_program_id
          AND FIND_IN_SET(c.course_code, REPLACE(v_prereq_string, ' ', '')) > 0;
        
        IF v_passed_prereqs >= v_total_prereqs THEN
            SET p_can_enroll = TRUE;
            SET p_message = CONCAT('All prerequisites (', v_prereq_string, ') completed');
        ELSE
            SET p_can_enroll = FALSE;
            SET p_message = CONCAT('Prerequisite not met: Must pass ', v_prereq_string, ' first (', v_passed_prereqs, '/', v_total_prereqs, ' completed)');
        END IF;
    END IF;
END//

-- Procedure: Enroll student with prerequisite check
CREATE PROCEDURE sp_enroll_student_with_validation(
    IN p_student_id INT UNSIGNED,
    IN p_curriculum_id INT UNSIGNED,
    IN p_academic_year_id INT UNSIGNED,
    IN p_enrollment_date DATE,
    IN p_instructor_id INT UNSIGNED,
    OUT p_success BOOLEAN,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_can_enroll BOOLEAN;
    DECLARE v_prereq_message VARCHAR(255);
    DECLARE v_exists INT DEFAULT 0;
    
    -- Check if already enrolled
    SELECT COUNT(*) INTO v_exists
    FROM enrollments
    WHERE student_id = p_student_id
      AND curriculum_id = p_curriculum_id
      AND academic_year_id = p_academic_year_id;
    
    IF v_exists > 0 THEN
        SET p_success = FALSE;
        SET p_message = 'Student already enrolled in this course for this term';
    ELSE
        -- Validate prerequisites
        CALL sp_validate_prerequisites(p_student_id, p_curriculum_id, v_can_enroll, v_prereq_message);
        
        IF v_can_enroll THEN
            INSERT INTO enrollments (student_id, curriculum_id, academic_year_id, enrollment_date, instructor_id)
            VALUES (p_student_id, p_curriculum_id, p_academic_year_id, p_enrollment_date, p_instructor_id);
            
            SET p_success = TRUE;
            SET p_message = CONCAT('Enrollment successful. ', v_prereq_message);
        ELSE
            SET p_success = FALSE;
            SET p_message = v_prereq_message;
        END IF;
    END IF;
END//

DELIMITER ;

-- ============================================================
-- TABLE: grade_scale (Reference Table)
-- Philippine Grading System Documentation
-- ============================================================
DROP TABLE IF EXISTS grade_scale;
CREATE TABLE grade_scale (
    grade_scale_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    grade_value DECIMAL(3,2) NOT NULL UNIQUE,
    grade_equivalent VARCHAR(20) NOT NULL,
    description VARCHAR(100) NOT NULL,
    grade_point DECIMAL(3,2) NOT NULL COMMENT 'For GPA calculation',
    is_passing BOOLEAN NOT NULL DEFAULT TRUE,
    
    INDEX idx_grade_value (grade_value)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Philippine grade scale reference';

-- Insert grade scale values
INSERT INTO grade_scale (grade_value, grade_equivalent, description, grade_point, is_passing) VALUES
(1.00, '1.00', 'Excellent', 4.00, TRUE),
(1.25, '1.25', 'Very Good', 3.75, TRUE),
(1.50, '1.50', 'Very Good', 3.50, TRUE),
(1.75, '1.75', 'Good', 3.25, TRUE),
(2.00, '2.00', 'Good', 3.00, TRUE),
(2.25, '2.25', 'Satisfactory', 2.75, TRUE),
(2.50, '2.50', 'Satisfactory', 2.50, TRUE),
(2.75, '2.75', 'Fair', 2.25, TRUE),
(3.00, '3.00', 'Passing', 2.00, TRUE),
(5.00, '5.00', 'Failed', 0.00, FALSE);

-- ============================================================
-- TABLE: audit_log
-- Track important data changes
-- ============================================================
DROP TABLE IF EXISTS audit_log;
CREATE TABLE audit_log (
    audit_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(64) NOT NULL,
    record_id INT UNSIGNED NOT NULL,
    action ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_values JSON,
    new_values JSON,
    changed_by INT UNSIGNED COMMENT 'User ID who made the change',
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent VARCHAR(255),
    
    INDEX idx_audit_table (table_name),
    INDEX idx_audit_record (table_name, record_id),
    INDEX idx_audit_action (action),
    INDEX idx_audit_time (changed_at),
    INDEX idx_audit_user (changed_by)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Audit trail for data changes';

-- ============================================================
-- FUNCTION: Calculate Student GPA
-- ============================================================
DELIMITER //

CREATE FUNCTION fn_calculate_gpa(
    p_student_id INT UNSIGNED,
    p_academic_year_id INT UNSIGNED
) RETURNS DECIMAL(4,3)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_gpa DECIMAL(4,3);
    
    SELECT 
        ROUND(SUM(gs.grade_point * c.units) / NULLIF(SUM(c.units), 0), 3)
    INTO v_gpa
    FROM enrollments e
    JOIN curriculum c ON e.curriculum_id = c.curriculum_id
    JOIN grade_scale gs ON e.grade = gs.grade_value
    WHERE e.student_id = p_student_id
      AND (p_academic_year_id IS NULL OR e.academic_year_id = p_academic_year_id)
      AND e.grade IS NOT NULL
      AND e.grade_status IN ('Passed', 'Failed');
    
    RETURN COALESCE(v_gpa, 0.000);
END//

-- ============================================================
-- FUNCTION: Calculate Cumulative GPA (All Semesters)
-- ============================================================
CREATE FUNCTION fn_calculate_cumulative_gpa(
    p_student_id INT UNSIGNED
) RETURNS DECIMAL(4,3)
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN fn_calculate_gpa(p_student_id, NULL);
END//

-- ============================================================
-- PROCEDURE: Check Schedule Conflicts
-- ============================================================
CREATE PROCEDURE sp_check_schedule_conflict(
    IN p_student_id INT UNSIGNED,
    IN p_academic_year_id INT UNSIGNED,
    IN p_day_of_week VARCHAR(10),
    IN p_start_time TIME,
    IN p_end_time TIME,
    OUT p_has_conflict BOOLEAN,
    OUT p_conflict_details VARCHAR(500)
)
BEGIN
    DECLARE v_conflicts TEXT DEFAULT '';
    
    SELECT GROUP_CONCAT(
        CONCAT(cur.course_code, ' (', cs.start_time, '-', cs.end_time, ' in ', COALESCE(cs.room, 'TBA'), ')')
        SEPARATOR ', '
    ) INTO v_conflicts
    FROM class_schedules cs
    JOIN enrollments e ON cs.enrollment_id = e.enrollment_id
    JOIN curriculum cur ON e.curriculum_id = cur.curriculum_id
    WHERE e.student_id = p_student_id
      AND e.academic_year_id = p_academic_year_id
      AND e.enrollment_status = 'Enrolled'
      AND cs.day_of_week = p_day_of_week
      AND cs.is_active = TRUE
      AND (
          (p_start_time >= cs.start_time AND p_start_time < cs.end_time) OR
          (p_end_time > cs.start_time AND p_end_time <= cs.end_time) OR
          (p_start_time <= cs.start_time AND p_end_time >= cs.end_time)
      );
    
    IF v_conflicts IS NOT NULL AND v_conflicts != '' THEN
        SET p_has_conflict = TRUE;
        SET p_conflict_details = CONCAT('Conflicts with: ', v_conflicts);
    ELSE
        SET p_has_conflict = FALSE;
        SET p_conflict_details = 'No conflicts';
    END IF;
END//

-- ============================================================
-- PROCEDURE: Log Audit Entry
-- ============================================================
CREATE PROCEDURE sp_log_audit(
    IN p_table_name VARCHAR(64),
    IN p_record_id INT UNSIGNED,
    IN p_action VARCHAR(10),
    IN p_old_values JSON,
    IN p_new_values JSON,
    IN p_user_id INT UNSIGNED
)
BEGIN
    INSERT INTO audit_log (table_name, record_id, action, old_values, new_values, changed_by)
    VALUES (p_table_name, p_record_id, p_action, p_old_values, p_new_values, p_user_id);
END//

-- ============================================================
-- PROCEDURE: Set Current Academic Year (ensures only one is current)
-- ============================================================
CREATE PROCEDURE sp_set_current_academic_year(
    IN p_academic_year_id INT UNSIGNED
)
BEGIN
    -- First, set all academic years to not current
    UPDATE academic_years SET is_current = FALSE WHERE is_current = TRUE;
    
    -- Then set the specified academic year as current
    UPDATE academic_years SET is_current = TRUE WHERE academic_year_id = p_academic_year_id;
    
    SELECT CONCAT('Academic year ID ', p_academic_year_id, ' is now the current term.') AS result;
END//

-- ============================================================
-- VIEW: Student GPA Summary
-- ============================================================
DELIMITER ;

CREATE OR REPLACE VIEW vw_student_gpa AS
SELECT 
    s.student_id,
    s.student_number,
    CONCAT(s.last_name, ', ', s.first_name, ' ', COALESCE(s.middle_name, '')) AS student_name,
    p.program_code,
    s.year_level,
    fn_calculate_cumulative_gpa(s.student_id) AS cumulative_gpa,
    CASE 
        WHEN fn_calculate_cumulative_gpa(s.student_id) >= 3.50 THEN 'Dean''s Lister'
        WHEN fn_calculate_cumulative_gpa(s.student_id) >= 3.00 THEN 'Honor Student'
        WHEN fn_calculate_cumulative_gpa(s.student_id) >= 2.00 THEN 'Good Standing'
        WHEN fn_calculate_cumulative_gpa(s.student_id) > 0 THEN 'Needs Improvement'
        ELSE 'No Grades Yet'
    END AS academic_standing
FROM students s
LEFT JOIN programs p ON s.current_program_id = p.program_id
WHERE s.student_status = 'Active';

-- ============================================================
-- End of Schema v2.2.0 (100% Complete)
-- ============================================================
