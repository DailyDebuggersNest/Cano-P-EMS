-- ============================================
-- Enrollment Management System (EMS) Database
-- Hey there! This file creates all the tables 
-- you need for the EMS. Run this in phpMyAdmin
-- or your favorite MySQL client.
-- ============================================

-- First, let's create our database
-- (Feel free to change the name if you want!)
CREATE DATABASE IF NOT EXISTS ems_database;
USE ems_database;

-- ============================================
-- Students Table
-- This stores all our student info
-- ============================================
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique ID for each student
    first_name VARCHAR(50) NOT NULL,          -- Student's first name
    last_name VARCHAR(50) NOT NULL,           -- Student's last name
    email VARCHAR(100) NOT NULL UNIQUE,       -- Email (must be unique!)
    phone VARCHAR(20),                        -- Phone number (optional)
    date_of_birth DATE,                       -- Birthday
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- When they were added
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Last update
);

-- ============================================
-- Courses Table
-- All the courses we offer
-- ============================================
CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique course ID
    course_code VARCHAR(20) NOT NULL UNIQUE,  -- Like "CS101" or "MATH200"
    course_name VARCHAR(100) NOT NULL,        -- Full course name
    description TEXT,                         -- What's the course about?
    credits INT DEFAULT 3,                    -- How many credits is it worth?
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- Enrollments Table
-- This connects students to courses
-- (It's a many-to-many relationship!)
-- One student can take many courses, and
-- one course can have many students.
-- ============================================
CREATE TABLE IF NOT EXISTS enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,                  -- Which student?
    course_id INT NOT NULL,                   -- Which course?
    enrollment_date DATE DEFAULT (CURRENT_DATE),  -- When did they enroll?
    grade VARCHAR(5),                         -- Their grade (optional)
    status ENUM('active', 'completed', 'dropped') DEFAULT 'active',  -- Current status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign keys link to our other tables
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    
    -- Make sure a student can't enroll in the same course twice
    UNIQUE KEY unique_enrollment (student_id, course_id)
);

-- ============================================
-- Sample Data - Let's add some test records!
-- ============================================

-- Adding some students
INSERT INTO students (first_name, last_name, email, phone, date_of_birth) VALUES
('Reginald', 'Cano', 'reginald.cano@email.com', '+63 9171234501', '2003-03-15'),
('Kinley', 'Laviña', 'kinley.lavina@email.com', '+63 9171234502', '2002-07-22'),
('Jeferson', 'Cano', 'jeferson.cano@email.com', '+63 9171234503', '2003-11-08'),
('Gester', 'Macaldo', 'gester.macaldo@email.com', '+63 9171234504', '2002-01-30'),
('Isaac', 'Gañolo', 'isaac.ganolo@email.com', '+63 9171234505', '2003-09-12'),
('Lynard', 'Demeterio', 'lynard.demeterio@email.com', '+63 9171234506', '2002-05-18'),
('Junrick', 'Dela Costa', 'junrick.delacosta@email.com', '+63 9171234507', '2003-12-25');

-- Adding some courses
INSERT INTO courses (course_code, course_name, description, credits) VALUES
('IT103', 'Computer Programming 1', 'Introduction to programming fundamentals using Python. Learn variables, loops, and functions.', 3),
('IT104', 'Computer Programming 2', 'Advanced programming concepts including OOP, file handling, and data structures.', 3),
('IT105', 'Data Structures and Algorithms', 'Study of arrays, linked lists, stacks, queues, trees, and algorithm analysis.', 3),
('IT106', 'Database Management Systems', 'Fundamentals of database design, SQL, normalization, and database administration.', 3),
('IT107', 'Web Development', 'Building modern websites using HTML, CSS, JavaScript, and PHP.', 3);

-- Enrolling some students in courses
INSERT INTO enrollments (student_id, course_id, enrollment_date, status) VALUES
(1, 1, '2025-01-15', 'active'),    -- Reginald enrolled in Computer Programming 1
(1, 4, '2025-01-15', 'active'),    -- Reginald also taking Database Management
(2, 1, '2025-01-16', 'active'),    -- Kinley in Computer Programming 1
(2, 5, '2025-01-16', 'active'),    -- Kinley in Web Development
(3, 2, '2025-01-17', 'active'),    -- Jeferson in Computer Programming 2
(3, 3, '2025-01-17', 'active'),    -- Jeferson in Data Structures
(4, 1, '2025-01-18', 'completed'), -- Gester completed Computer Programming 1
(4, 2, '2025-01-18', 'active'),    -- Gester now in Computer Programming 2
(5, 4, '2025-01-19', 'active'),    -- Isaac in Database Management
(5, 5, '2025-01-19', 'active'),    -- Isaac in Web Development
(6, 1, '2025-01-20', 'active'),    -- Lynard in Computer Programming 1
(6, 3, '2025-01-20', 'active'),    -- Lynard in Data Structures
(7, 2, '2025-01-21', 'active'),    -- Junrick in Computer Programming 2
(7, 4, '2025-01-21', 'active');    -- Junrick in Database Management

-- ============================================
-- All done! Your database is ready to go! 🎉
-- ============================================
