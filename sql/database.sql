-- ============================================
-- Student Information System (SIS) Database
-- Simplified version with Students and Programs only
-- Run this in phpMyAdmin or MySQL client
-- ============================================

-- First, let's create our database
CREATE DATABASE IF NOT EXISTS ems_O6;
USE ems_O6;

-- ============================================
-- Students Table
-- This stores all our student info with SIS profiling
-- ============================================
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    suffix VARCHAR(10),
    sex ENUM('Male', 'Female') DEFAULT NULL,
    civil_status ENUM('Single', 'Married', 'Widowed', 'Separated', 'Divorced') DEFAULT 'Single',
    nationality VARCHAR(50) DEFAULT 'Filipino',
    religion VARCHAR(50),
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'Unknown') DEFAULT 'Unknown',
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    place_of_birth VARCHAR(100),
    address_street VARCHAR(255),
    address_barangay VARCHAR(100),
    address_city VARCHAR(100),
    address_province VARCHAR(100),
    address_zip VARCHAR(10),
    guardian_name VARCHAR(100),
    guardian_relationship VARCHAR(50),
    guardian_contact VARCHAR(20),
    guardian_address VARCHAR(255),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    profile_photo VARCHAR(255),
    student_status ENUM('Active', 'Inactive', 'Graduated', 'Dropped', 'On Leave') DEFAULT 'Active',
    admission_date DATE,
    year_level ENUM('1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year') DEFAULT '1st Year',
    semester ENUM('1st Semester', '2nd Semester', 'Summer') DEFAULT '1st Semester',
    section VARCHAR(20),
    program VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- Users Table
-- System users with bcrypt encrypted passwords
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    role ENUM('admin', 'staff', 'viewer') DEFAULT 'staff',
    is_active BOOLEAN DEFAULT TRUE,
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- Programs Table
-- Academic programs (BSIT, BSCS, etc.)
-- ============================================
CREATE TABLE IF NOT EXISTS programs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_code VARCHAR(20) NOT NULL UNIQUE,
    program_name VARCHAR(150) NOT NULL,
    department VARCHAR(100),
    description TEXT,
    years_duration INT DEFAULT 4,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Subjects/Courses Table
-- List of available subjects/courses
-- ============================================
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
    FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE SET NULL
);

-- ============================================
-- Student Enrollments Table
-- Track which subjects students are enrolled in
-- ============================================
CREATE TABLE IF NOT EXISTS enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    academic_year VARCHAR(20) NOT NULL,
    semester ENUM('1st Semester', '2nd Semester', 'Summer') DEFAULT '1st Semester',
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade DECIMAL(5,2) DEFAULT NULL,
    grade_status ENUM('Pending', 'Passed', 'Failed', 'Incomplete', 'Dropped', 'Withdrawn') DEFAULT 'Pending',
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, subject_id, academic_year, semester)
);

-- ============================================
-- Payment Types Table
-- Types of fees (Tuition, Lab, Misc, etc.)
-- ============================================
CREATE TABLE IF NOT EXISTS payment_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Student Payments Table
-- Track all student payments and balances
-- ============================================
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
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_type_id) REFERENCES payment_types(id) ON DELETE SET NULL
);

-- ============================================
-- Sample Data
-- ============================================

-- Default Admin User
-- Password: admin123 (bcrypt hashed)
INSERT INTO users (username, email, password, full_name, role) VALUES
('admin', 'admin@ems.local', '$2y$10$oamDXJzNBYfrB3hWGeZZeu5gZgWQztufYMEslVARK.sRLmqzKwTWe', 'System Administrator', 'admin');

-- Sample Programs
INSERT INTO programs (program_code, program_name, department, years_duration) VALUES
('BSIT', 'Bachelor of Science in Information Technology', 'College of Computer Studies', 4),
('BSCS', 'Bachelor of Science in Computer Science', 'College of Computer Studies', 4),
('BSIS', 'Bachelor of Science in Information Systems', 'College of Computer Studies', 4),
('BSCE', 'Bachelor of Science in Computer Engineering', 'College of Engineering', 5),
('BSA', 'Bachelor of Science in Accountancy', 'College of Business', 4),
('BSBA', 'Bachelor of Science in Business Administration', 'College of Business', 4);

-- Sample Students (Complete Profiling Data)
INSERT INTO students (
    student_id, first_name, middle_name, last_name, suffix, sex, 
    civil_status, nationality, religion, blood_type,
    email, phone, date_of_birth, place_of_birth,
    address_street, address_barangay, address_city, address_province, address_zip,
    guardian_name, guardian_relationship, guardian_contact, guardian_address,
    emergency_contact_name, emergency_contact_phone,
    year_level, semester, section, program, student_status, admission_date
) VALUES
-- Student 1: Reginald Santos Cano
('STU-2025-00001', 'Reginald', 'Santos', 'Cano', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'O+',
'reginald.cano@email.com', '+63 9171234501', '2003-03-15', 'Manila, Philippines',
'123 Rizal Avenue', 'Brgy. Commonwealth', 'Quezon City', 'Metro Manila', '1121',
'Roberto Cano', 'Father', '+63 9181234501', '123 Rizal Avenue, Brgy. Commonwealth, Quezon City',
'Maria Santos Cano', '+63 9191234501',
'2nd Year', '1st Semester', 'BSIT-2A', 'Bachelor of Science in Information Technology', 'Active', '2024-06-15'),

-- Student 2: Kinley Cruz Lavina
('STU-2025-00002', 'Kinley', 'Cruz', 'Lavina', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'A+',
'kinley.lavina@email.com', '+63 9171234502', '2002-07-22', 'Cebu City, Philippines',
'456 Osmeña Boulevard', 'Brgy. Lahug', 'Cebu City', 'Cebu', '6000',
'Eduardo Lavina', 'Father', '+63 9181234502', '456 Osmeña Boulevard, Brgy. Lahug, Cebu City',
'Carmen Cruz Lavina', '+63 9191234502',
'2nd Year', '1st Semester', 'BSIT-2A', 'Bachelor of Science in Information Technology', 'Active', '2024-06-15'),

-- Student 3: Jeferson Reyes Cano
('STU-2025-00003', 'Jeferson', 'Reyes', 'Cano', 'Jr.', 'Male', 
'Single', 'Filipino', 'Iglesia ni Cristo', 'B+',
'jeferson.cano@email.com', '+63 9171234503', '2003-11-08', 'Davao City, Philippines',
'789 Bonifacio Street', 'Brgy. Poblacion', 'Davao City', 'Davao del Sur', '8000',
'Jeferson Cano Sr.', 'Father', '+63 9181234503', '789 Bonifacio Street, Brgy. Poblacion, Davao City',
'Rosa Reyes Cano', '+63 9191234503',
'1st Year', '1st Semester', 'BSCS-1A', 'Bachelor of Science in Computer Science', 'Active', '2025-06-10'),

-- Student 4: Gester Garcia Macaldo
('STU-2025-00004', 'Gester', 'Garcia', 'Macaldo', NULL, 'Male', 
'Single', 'Filipino', 'Born Again Christian', 'AB+',
'gester.macaldo@email.com', '+63 9171234504', '2002-01-30', 'Iloilo City, Philippines',
'321 Mabini Street', 'Brgy. Jaro', 'Iloilo City', 'Iloilo', '5000',
'Antonio Macaldo', 'Father', '+63 9181234504', '321 Mabini Street, Brgy. Jaro, Iloilo City',
'Teresa Garcia Macaldo', '+63 9191234504',
'3rd Year', '1st Semester', 'BSIT-3A', 'Bachelor of Science in Information Technology', 'Active', '2023-06-12'),

-- Student 5: Isaac Lopez Ganolo
('STU-2025-00005', 'Isaac', 'Lopez', 'Ganolo', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'O-',
'isaac.ganolo@email.com', '+63 9171234505', '2003-09-12', 'Bacolod City, Philippines',
'654 Lacson Street', 'Brgy. Mandalagan', 'Bacolod City', 'Negros Occidental', '6100',
'Pedro Ganolo', 'Father', '+63 9181234505', '654 Lacson Street, Brgy. Mandalagan, Bacolod City',
'Linda Lopez Ganolo', '+63 9191234505',
'1st Year', '1st Semester', 'BSIT-1A', 'Bachelor of Science in Information Technology', 'Active', '2025-06-10'),

-- Student 6: Lynard Martinez Demeterio
('STU-2025-00006', 'Lynard', 'Martinez', 'Demeterio', NULL, 'Male', 
'Single', 'Filipino', 'Seventh Day Adventist', 'A-',
'lynard.demeterio@email.com', '+63 9171234506', '2002-05-18', 'Cagayan de Oro, Philippines',
'987 Corrales Avenue', 'Brgy. Divisoria', 'Cagayan de Oro', 'Misamis Oriental', '9000',
'Ricardo Demeterio', 'Father', '+63 9181234506', '987 Corrales Avenue, Brgy. Divisoria, Cagayan de Oro',
'Elena Martinez Demeterio', '+63 9191234506',
'2nd Year', '1st Semester', 'BSCS-2A', 'Bachelor of Science in Computer Science', 'Active', '2024-06-15'),

-- Student 7: Junrick Fernandez Dela Costa
('STU-2025-00007', 'Junrick', 'Fernandez', 'Dela Costa', 'III', 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'B-',
'junrick.delacosta@email.com', '+63 9171234507', '2003-12-25', 'Zamboanga City, Philippines',
'147 Veterans Avenue', 'Brgy. Santa Maria', 'Zamboanga City', 'Zamboanga del Sur', '7000',
'Junrick Dela Costa Jr.', 'Father', '+63 9181234507', '147 Veterans Avenue, Brgy. Santa Maria, Zamboanga City',
'Gloria Fernandez Dela Costa', '+63 9191234507',
'1st Year', '1st Semester', 'BSIT-1B', 'Bachelor of Science in Information Technology', 'Active', '2025-06-10'),

-- Student 8: Maria Clara Santos (Female student)
('STU-2025-00008', 'Maria Clara', 'Dela Cruz', 'Santos', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'A+',
'mariaclara.santos@email.com', '+63 9171234508', '2003-06-20', 'Makati City, Philippines',
'258 Ayala Avenue', 'Brgy. San Lorenzo', 'Makati City', 'Metro Manila', '1226',
'Jose Santos', 'Father', '+63 9181234508', '258 Ayala Avenue, Brgy. San Lorenzo, Makati City',
'Lucia Dela Cruz Santos', '+63 9191234508',
'2nd Year', '1st Semester', 'BSIT-2B', 'Bachelor of Science in Information Technology', 'Active', '2024-06-15'),

-- Student 9: Anna Therese Reyes (Female student)
('STU-2025-00009', 'Anna Therese', 'Villanueva', 'Reyes', NULL, 'Female', 
'Single', 'Filipino', 'Born Again Christian', 'O+',
'anna.reyes@email.com', '+63 9171234509', '2002-10-05', 'Pasig City, Philippines',
'369 Ortigas Avenue', 'Brgy. Ugong', 'Pasig City', 'Metro Manila', '1604',
'Fernando Reyes', 'Father', '+63 9181234509', '369 Ortigas Avenue, Brgy. Ugong, Pasig City',
'Cristina Villanueva Reyes', '+63 9191234509',
'3rd Year', '1st Semester', 'BSCS-3A', 'Bachelor of Science in Computer Science', 'Active', '2023-06-12'),

-- Student 10: John Michael Cruz
('STU-2025-00010', 'John Michael', 'Aquino', 'Cruz', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'AB-',
'johnmichael.cruz@email.com', '+63 9171234510', '2004-02-14', 'Taguig City, Philippines',
'741 McKinley Road', 'Brgy. Fort Bonifacio', 'Taguig City', 'Metro Manila', '1634',
'Michael Cruz', 'Father', '+63 9181234510', '741 McKinley Road, Brgy. Fort Bonifacio, Taguig City',
'Jennifer Aquino Cruz', '+63 9191234510',
'1st Year', '1st Semester', 'BSIT-1A', 'Bachelor of Science in Information Technology', 'Active', '2025-06-10'),

-- Student 11: Mark Anthony Garcia
('STU-2025-00011', 'Mark Anthony', 'Dela Cruz', 'Garcia', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'B+',
'mark.garcia@email.com', '+63 9171234511', '2004-05-10', 'Quezon City, Philippines',
'101 Maginhawa Street', 'Brgy. Teachers Village', 'Quezon City', 'Metro Manila', '1101',
'Ricardo Garcia', 'Father', '+63 9181234511', '101 Maginhawa Street, Brgy. Teachers Village, Quezon City',
'Elena Dela Cruz Garcia', '+63 9191234511',
'1st Year', '1st Semester', 'BSIT-1B', 'Bachelor of Science in Information Technology', 'Active', '2025-06-10'),

-- Student 12: Sofia Nicole Tan
('STU-2025-00012', 'Sofia Nicole', 'Lim', 'Tan', NULL, 'Female', 
'Single', 'Filipino', 'Buddhism', 'A+',
'sofia.tan@email.com', '+63 9171234512', '2003-08-25', 'Binondo, Manila',
'888 Ongpin Street', 'Brgy. Binondo', 'Manila', 'Metro Manila', '1006',
'Wei Tan', 'Father', '+63 9181234512', '888 Ongpin Street, Brgy. Binondo, Manila',
'Grace Lim Tan', '+63 9191234512',
'2nd Year', '1st Semester', 'BSCS-2A', 'Bachelor of Science in Computer Science', 'Active', '2024-06-15'),

-- Student 13: Gabriel Luis Mendoza
('STU-2025-00013', 'Gabriel Luis', 'Santos', 'Mendoza', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'O+',
'gabriel.mendoza@email.com', '+63 9171234513', '2002-12-15', 'Makati City, Philippines',
'45 Jupiter Street', 'Brgy. Bel-Air', 'Makati City', 'Metro Manila', '1209',
'Luis Mendoza', 'Father', '+63 9181234513', '45 Jupiter Street, Brgy. Bel-Air, Makati City',
'Maria Santos Mendoza', '+63 9191234513',
'3rd Year', '1st Semester', 'BSIT-3A', 'Bachelor of Science in Information Technology', 'Active', '2023-06-12'),

-- Student 14: Chloe Marie Lim
('STU-2025-00014', 'Chloe Marie', 'Go', 'Lim', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'AB+',
'chloe.lim@email.com', '+63 9171234514', '2004-03-30', 'San Juan City, Philippines',
'22 Greenhills', 'Brgy. Greenhills', 'San Juan City', 'Metro Manila', '1502',
'Peter Lim', 'Father', '+63 9181234514', '22 Greenhills, Brgy. Greenhills, San Juan City',
'Catherine Go Lim', '+63 9191234514',
'1st Year', '1st Semester', 'BSIS-1A', 'Bachelor of Science in Information Systems', 'Active', '2025-06-10'),

-- Student 15: Rafael Jose Bautista
('STU-2025-00015', 'Rafael Jose', 'Reyes', 'Bautista', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'A-',
'rafael.bautista@email.com', '+63 9171234515', '2001-09-05', 'Cebu City, Philippines',
'50 Mango Avenue', 'Brgy. Kamputhaw', 'Cebu City', 'Cebu', '6000',
'Jose Bautista', 'Father', '+63 9181234515', '50 Mango Avenue, Brgy. Kamputhaw, Cebu City',
'Ana Reyes Bautista', '+63 9191234515',
'4th Year', '1st Semester', 'BSCE-4A', 'Bachelor of Science in Computer Engineering', 'Active', '2022-06-15'),

-- Student 16: Jasmine Rose Yap
('STU-2025-00016', 'Jasmine Rose', 'Sy', 'Yap', NULL, 'Female', 
'Single', 'Filipino', 'Born Again Christian', 'O-',
'jasmine.yap@email.com', '+63 9171234516', '2003-11-20', 'Davao City, Philippines',
'123 Durian Street', 'Brgy. Matina', 'Davao City', 'Davao del Sur', '8000',
'David Yap', 'Father', '+63 9181234516', '123 Durian Street, Brgy. Matina, Davao City',
'Sarah Sy Yap', '+63 9191234516',
'2nd Year', '1st Semester', 'BSA-2A', 'Bachelor of Science in Accountancy', 'Active', '2024-06-15'),

-- Student 17: Carlos Miguel Torres
('STU-2025-00017', 'Carlos Miguel', 'Fernandez', 'Torres', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'B-',
'carlos.torres@email.com', '+63 9171234517', '2002-04-18', 'Iloilo City, Philippines',
'78 Luna Street', 'Brgy. La Paz', 'Iloilo City', 'Iloilo', '5000',
'Miguel Torres', 'Father', '+63 9181234517', '78 Luna Street, Brgy. La Paz, Iloilo City',
'Isabel Fernandez Torres', '+63 9191234517',
'3rd Year', '1st Semester', 'BSBA-3A', 'Bachelor of Science in Business Administration', 'Active', '2023-06-12'),

-- Student 18: Bea Patricia Lopez
('STU-2025-00018', 'Bea Patricia', 'Gonzales', 'Lopez', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'A+',
'bea.lopez@email.com', '+63 9171234518', '2004-01-15', 'Bacolod City, Philippines',
'90 Lacson Street', 'Brgy. Bata', 'Bacolod City', 'Negros Occidental', '6100',
'Ramon Lopez', 'Father', '+63 9181234518', '90 Lacson Street, Brgy. Bata, Bacolod City',
'Patricia Gonzales Lopez', '+63 9191234518',
'1st Year', '1st Semester', 'BSIT-1C', 'Bachelor of Science in Information Technology', 'Active', '2025-06-10'),

-- Student 19: Angelo James Ramos
('STU-2025-00019', 'Angelo James', 'Castillo', 'Ramos', NULL, 'Male', 
'Single', 'Filipino', 'Iglesia ni Cristo', 'O+',
'angelo.ramos@email.com', '+63 9171234519', '2003-07-08', 'Cagayan de Oro, Philippines',
'34 Claro M. Recto Avenue', 'Brgy. Lapasan', 'Cagayan de Oro', 'Misamis Oriental', '9000',
'James Ramos', 'Father', '+63 9181234519', '34 Claro M. Recto Avenue, Brgy. Lapasan, Cagayan de Oro',
'Liza Castillo Ramos', '+63 9191234519',
'2nd Year', '1st Semester', 'BSCS-2B', 'Bachelor of Science in Computer Science', 'Active', '2024-06-15'),

-- Student 20: Hannah Grace Flores
('STU-2025-00020', 'Hannah Grace', 'Villanueva', 'Flores', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'AB-',
'hannah.flores@email.com', '+63 9171234520', '2003-10-12', 'Zamboanga City, Philippines',
'56 Gov. Camins Avenue', 'Brgy. Canelar', 'Zamboanga City', 'Zamboanga del Sur', '7000',
'Mark Flores', 'Father', '+63 9181234520', '56 Gov. Camins Avenue, Brgy. Canelar, Zamboanga City',
'Grace Villanueva Flores', '+63 9191234520',
'2nd Year', '1st Semester', 'BSIT-2C', 'Bachelor of Science in Information Technology', 'Active', '2024-06-15');

-- Sample Subjects for BSIT Program
INSERT INTO subjects (subject_code, subject_name, description, units, lecture_hours, lab_hours, year_level, semester, program_id) VALUES
-- 1st Year, 1st Semester
('CC101', 'Introduction to Computing', 'Fundamentals of computer systems and information technology', 3, 3, 0, '1st Year', '1st Semester', 1),
('CC102', 'Computer Programming 1', 'Introduction to programming concepts using Python', 3, 2, 3, '1st Year', '1st Semester', 1),
('GEC01', 'Understanding the Self', 'General Education - Understanding personal identity and development', 3, 3, 0, '1st Year', '1st Semester', 1),
('GEC02', 'Readings in Philippine History', 'General Education - Philippine historical perspectives', 3, 3, 0, '1st Year', '1st Semester', 1),
('GEC03', 'Mathematics in the Modern World', 'General Education - Mathematical concepts and applications', 3, 3, 0, '1st Year', '1st Semester', 1),
('NSTP1', 'National Service Training Program 1', 'Civic welfare training service', 3, 3, 0, '1st Year', '1st Semester', 1),
('PE101', 'Physical Fitness and Self-Testing Activities', 'Physical education fundamentals', 2, 2, 0, '1st Year', '1st Semester', 1),
-- 1st Year, 2nd Semester
('CC103', 'Computer Programming 2', 'Advanced programming concepts and OOP with Java', 3, 2, 3, '1st Year', '2nd Semester', 1),
('CC104', 'Discrete Mathematics', 'Mathematical structures for computer science', 3, 3, 0, '1st Year', '2nd Semester', 1),
('GEC04', 'The Contemporary World', 'General Education - Global perspectives and issues', 3, 3, 0, '1st Year', '2nd Semester', 1),
('GEC05', 'Purposive Communication', 'General Education - Communication skills development', 3, 3, 0, '1st Year', '2nd Semester', 1),
('NSTP2', 'National Service Training Program 2', 'Civic welfare training service continuation', 3, 3, 0, '1st Year', '2nd Semester', 1),
('PE102', 'Rhythmic Activities', 'Physical education with dance and rhythm', 2, 2, 0, '1st Year', '2nd Semester', 1),
-- 2nd Year, 1st Semester
('IT201', 'Data Structures and Algorithms', 'Fundamental data structures and algorithm design', 3, 2, 3, '2nd Year', '1st Semester', 1),
('IT202', 'Object-Oriented Programming', 'OOP principles using Java/C#', 3, 2, 3, '2nd Year', '1st Semester', 1),
('IT203', 'Database Management Systems 1', 'Relational databases and SQL fundamentals', 3, 2, 3, '2nd Year', '1st Semester', 1),
('IT204', 'Platform Technologies', 'Operating systems and platform concepts', 3, 2, 3, '2nd Year', '1st Semester', 1),
('GEC06', 'Art Appreciation', 'General Education - Understanding art and aesthetics', 3, 3, 0, '2nd Year', '1st Semester', 1),
('PE103', 'Individual and Dual Sports', 'Physical education with sports activities', 2, 2, 0, '2nd Year', '1st Semester', 1),
-- 2nd Year, 2nd Semester
('IT205', 'Information Management', 'Managing information systems and resources', 3, 3, 0, '2nd Year', '2nd Semester', 1),
('IT206', 'Networking 1', 'Computer networking concepts and protocols', 3, 2, 3, '2nd Year', '2nd Semester', 1),
('IT207', 'Systems Analysis and Design', 'Software development lifecycle and methodologies', 3, 3, 0, '2nd Year', '2nd Semester', 1),
('IT208', 'Web Development', 'HTML, CSS, JavaScript and PHP fundamentals', 3, 2, 3, '2nd Year', '2nd Semester', 1),
('GEC07', 'Ethics', 'General Education - Ethical principles and reasoning', 3, 3, 0, '2nd Year', '2nd Semester', 1),
('PE104', 'Team Sports', 'Physical education with team-based activities', 2, 2, 0, '2nd Year', '2nd Semester', 1),
-- 3rd Year, 1st Semester
('IT301', 'Applications Development and Emerging Technologies', 'Modern application development practices', 3, 2, 3, '3rd Year', '1st Semester', 1),
('IT302', 'Integrative Programming and Technologies', 'API development and system integration', 3, 2, 3, '3rd Year', '1st Semester', 1),
('IT303', 'System Administration and Maintenance', 'Server management and system maintenance', 3, 2, 3, '3rd Year', '1st Semester', 1),
('IT304', 'Information Assurance and Security 1', 'Cybersecurity fundamentals and practices', 3, 3, 0, '3rd Year', '1st Semester', 1),
('CAP01', 'Capstone Project 1', 'Initial phase of capstone research and development', 3, 1, 6, '3rd Year', '1st Semester', 1),
-- 3rd Year, 2nd Semester
('IT305', 'Networking 2', 'Advanced networking and network administration', 3, 2, 3, '3rd Year', '2nd Semester', 1),
('IT306', 'Information Assurance and Security 2', 'Advanced security concepts and ethical hacking', 3, 2, 3, '3rd Year', '2nd Semester', 1),
('IT307', 'Social and Professional Issues in IT', 'Legal and professional aspects of IT', 3, 3, 0, '3rd Year', '2nd Semester', 1),
('CAP02', 'Capstone Project 2', 'Continuation and completion of capstone project', 3, 1, 6, '3rd Year', '2nd Semester', 1),
('ITELEC1', 'IT Elective 1', 'Specialized IT elective course', 3, 2, 3, '3rd Year', '2nd Semester', 1);

-- Sample Payment Types
INSERT INTO payment_types (type_name, description) VALUES
('Tuition Fee', 'Per unit fee for enrolled subjects (₱1,500/unit)'),
('Laboratory Fee', 'Computer and science laboratory usage fee'),
('Miscellaneous Fee', 'Includes library, ID, medical, guidance, and cultural fees'),
('NSTP Fee', 'National Service Training Program fee'),
('Athletic Fee', 'Sports facilities and intramural activities'),
('Student Development Fee', 'Student council and organization activities'),
('Energy Fee', 'Air conditioning and electricity consumption'),
('Insurance Fee', 'Student accident and health insurance'),
('Registration Fee', 'Enrollment processing and documentation'),
('Examination Permit', 'Midterm and final examination permit fee');

-- Sample Enrollments (for existing students)
-- Academic Year: 2024-2025, 2nd Semester COMPLETED (May 2025 - Finals finished)
INSERT INTO enrollments (student_id, subject_id, academic_year, semester, enrollment_date, grade, grade_status) VALUES
-- ===========================================
-- REGINALD CANO (Student ID: 1) - 2nd Year BSIT
-- ===========================================
-- 1st Year, 1st Semester (2023-2024) - COMPLETED
(1, 1, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),
(1, 2, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),
(1, 3, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),
(1, 4, '2023-2024', '1st Semester', '2023-08-14', 1.25, 'Passed'),
(1, 5, '2023-2024', '1st Semester', '2023-08-14', 2.25, 'Passed'),
(1, 6, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),
(1, 7, '2023-2024', '1st Semester', '2023-08-14', 1.00, 'Passed'),
-- 1st Year, 2nd Semester (2023-2024) - COMPLETED
(1, 8, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),
(1, 9, '2023-2024', '2nd Semester', '2024-01-08', 2.50, 'Passed'),
(1, 10, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),
(1, 11, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),
(1, 12, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),
(1, 13, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),
-- 2nd Year, 1st Semester (2024-2025) - COMPLETED
(1, 14, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
(1, 15, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),
(1, 16, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),
(1, 17, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),
(1, 18, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
(1, 19, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),
-- 2nd Year, 2nd Semester (2024-2025) - COMPLETED (Just finished Dec 2025)
(1, 20, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(1, 21, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(1, 22, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(1, 23, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),
(1, 24, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(1, 25, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),

-- ===========================================
-- KINLEY LAVINA (Student ID: 2) - 2nd Year BSIT
-- ===========================================
-- 1st Year, 1st Semester (2023-2024) - COMPLETED
(2, 1, '2023-2024', '1st Semester', '2023-08-14', 2.25, 'Passed'),
(2, 2, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),
(2, 3, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),
(2, 4, '2023-2024', '1st Semester', '2023-08-14', 2.50, 'Passed'),
(2, 5, '2023-2024', '1st Semester', '2023-08-14', 2.75, 'Passed'),
(2, 6, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),
(2, 7, '2023-2024', '1st Semester', '2023-08-14', 1.25, 'Passed'),
-- 1st Year, 2nd Semester (2023-2024) - COMPLETED
(2, 8, '2023-2024', '2nd Semester', '2024-01-08', 2.00, 'Passed'),
(2, 9, '2023-2024', '2nd Semester', '2024-01-08', 2.25, 'Passed'),
(2, 10, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),
(2, 11, '2023-2024', '2nd Semester', '2024-01-08', 2.00, 'Passed'),
(2, 12, '2023-2024', '2nd Semester', '2024-01-08', 2.25, 'Passed'),
(2, 13, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),
-- 2nd Year, 1st Semester (2024-2025) - COMPLETED
(2, 14, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),
(2, 15, '2024-2025', '1st Semester', '2024-08-12', 2.25, 'Passed'),
(2, 16, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),
(2, 17, '2024-2025', '1st Semester', '2024-08-12', 2.50, 'Passed'),
(2, 18, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),
(2, 19, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
-- 2nd Year, 2nd Semester (2024-2025) - COMPLETED
(2, 20, '2024-2025', '2nd Semester', '2025-01-06', 2.25, 'Passed'),
(2, 21, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(2, 22, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(2, 23, '2024-2025', '2nd Semester', '2025-01-06', 2.25, 'Passed'),
(2, 24, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),

-- ===========================================
-- JEFERSON CANO (Student ID: 3) - 1st Year BSCS
-- ===========================================
-- 1st Year, 1st Semester (2024-2025) - COMPLETED
(3, 1, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),
(3, 2, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
(3, 3, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),
(3, 4, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),
(3, 5, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
(3, 6, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),
-- 1st Year, 2nd Semester (2024-2025) - COMPLETED
(3, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(3, 9, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(3, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),
(3, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(3, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),

-- ===========================================
-- GESTER MACALDO (Student ID: 4) - 3rd Year BSIT
-- ===========================================
-- 2nd Year, 1st Semester (2023-2024) - COMPLETED
(4, 14, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),
(4, 15, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),
(4, 16, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),
(4, 17, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),
(4, 18, '2023-2024', '1st Semester', '2023-08-14', 2.25, 'Passed'),
(4, 19, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),
-- 2nd Year, 2nd Semester (2023-2024) - COMPLETED
(4, 20, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),
(4, 21, '2023-2024', '2nd Semester', '2024-01-08', 2.00, 'Passed'),
(4, 22, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),
(4, 23, '2023-2024', '2nd Semester', '2024-01-08', 2.25, 'Passed'),
(4, 24, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),
(4, 25, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),
-- 3rd Year, 1st Semester (2024-2025) - COMPLETED
(4, 26, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),
(4, 27, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),
(4, 28, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
(4, 29, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),
(4, 30, '2024-2025', '1st Semester', '2024-08-12', 2.25, 'Passed'),
-- 3rd Year, 2nd Semester (2024-2025) - COMPLETED
(4, 31, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(4, 32, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(4, 33, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(4, 34, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(4, 35, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),

-- ===========================================
-- ISAAC GANOLO (Student ID: 5) - 1st Year BSIT (Freshman)
-- ===========================================
-- 1st Year, 1st Semester (2024-2025) - COMPLETED
(5, 1, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),
(5, 2, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),
(5, 3, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
(5, 4, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),
(5, 5, '2024-2025', '1st Semester', '2024-08-12', 2.25, 'Passed'),
(5, 6, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),
(5, 7, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),
-- 1st Year, 2nd Semester (2024-2025) - COMPLETED
(5, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(5, 9, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(5, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),
(5, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(5, 12, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(5, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),

-- ===========================================
-- LYNARD DEMETERIO (Student ID: 6) - 2nd Year BSCS
-- ===========================================
-- 2nd Year, 2nd Semester (2024-2025) - COMPLETED
(6, 20, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(6, 21, '2024-2025', '2nd Semester', '2025-01-06', 2.25, 'Passed'),
(6, 22, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(6, 23, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(6, 24, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),

-- ===========================================
-- JUNRICK DELA COSTA (Student ID: 7) - 1st Year BSIT
-- ===========================================
-- 1st Year, 2nd Semester (2024-2025) - COMPLETED
(7, 8, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(7, 9, '2024-2025', '2nd Semester', '2025-01-06', 2.25, 'Passed'),
(7, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(7, 11, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(7, 12, '2024-2025', '2nd Semester', '2025-01-06', 2.50, 'Passed'),
(7, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),

-- ===========================================
-- MARIA CLARA SANTOS (Student ID: 8) - 2nd Year BSIT
-- ===========================================
-- 2nd Year, 2nd Semester (2024-2025) - COMPLETED
(8, 20, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(8, 21, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(8, 22, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),
(8, 23, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(8, 24, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(8, 25, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),

-- ===========================================
-- ANNA THERESE REYES (Student ID: 9) - 3rd Year BSCS
-- ===========================================
-- 3rd Year, 2nd Semester (2024-2025) - COMPLETED
(9, 31, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),
(9, 32, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(9, 33, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(9, 34, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),
(9, 35, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),

-- ===========================================
-- JOHN MICHAEL CRUZ (Student ID: 10) - 1st Year BSIT
-- ===========================================
-- 1st Year, 2nd Semester (2024-2025) - COMPLETED
(10, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(10, 9, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),
(10, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),
(10, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),
(10, 12, '2024-2025', '2nd Semester', '2025-01-06', 2.25, 'Passed'),
(10, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed');

-- Sample Payments (Realistic Philippine Private University Fees)
-- All payments are for the completed 2nd Semester 2024-2025 (Just finished December 2025)
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
-- ===========================================
-- REGINALD CANO (Student ID: 1) - 2nd Year, 2nd Sem - FULLY PAID
-- ===========================================
(1, 1, '2024-2025', '2nd Semester', 'Tuition Fee (17 units x ₱1,500)', 25500.00, 25500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010501', 'Paid', '2025-01-10', 'Full payment via BDO online banking'),
(1, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010501', 'Paid', '2025-01-10', NULL),
(1, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010501', 'Paid', '2025-01-10', NULL),
(1, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010501', 'Paid', '2025-01-10', NULL),
(1, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010501', 'Paid', '2025-01-10', NULL),
(1, 10, '2024-2025', '2nd Semester', 'Examination Permit Fee', 1500.00, 1500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010501', 'Paid', '2025-01-10', NULL),

-- ===========================================
-- KINLEY LAVINA (Student ID: 2) - 2nd Year, 2nd Sem - FULLY PAID (Installment completed)
-- ===========================================
(2, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2025-03-15', 'Installment', 'INST-2025-031501', 'Paid', '2025-01-10', 'Final installment payment completed'),
(2, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-08', 'Cash', 'OR-2025-005821', 'Paid', '2025-01-10', 'Paid at cashier'),
(2, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-03-15', 'Installment', 'INST-2025-031502', 'Paid', '2025-01-10', 'Completed with final installment'),
(2, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-03-15', 'Installment', 'INST-2025-031503', 'Paid', '2025-03-20', NULL),
(2, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-08', 'Cash', 'OR-2025-005822', 'Paid', '2025-01-10', NULL),
(2, 10, '2024-2025', '2nd Semester', 'Examination Permit Fee', 2000.00, 2000.00, '2025-03-01', 'Cash', 'OR-2025-008891', 'Paid', '2025-03-05', 'Paid before midterms'),

-- ===========================================
-- JEFERSON CANO (Student ID: 3) - 1st Year, 2nd Sem - FULLY PAID (Scholar)
-- ===========================================
(3, 1, '2024-2025', '2nd Semester', 'Tuition Fee (17 units x ₱1,500) - 50% Scholar', 12750.00, 12750.00, '2025-01-04', 'Scholarship', 'ACAD-SCHOLAR-2025-003', 'Paid', '2025-01-10', 'Academic scholarship - 50% tuition discount'),
(3, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2025-01-04', 'GCash', 'GCASH-2025-010401', 'Paid', '2025-01-10', 'Paid via GCash'),
(3, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-04', 'GCash', 'GCASH-2025-010402', 'Paid', '2025-01-10', NULL),
(3, 4, '2024-2025', '2nd Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-01-04', 'GCash', 'GCASH-2025-010403', 'Paid', '2025-01-10', NULL),
(3, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-01-04', 'GCash', 'GCASH-2025-010404', 'Paid', '2025-01-10', NULL),
(3, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-04', 'GCash', 'GCASH-2025-010405', 'Paid', '2025-01-10', NULL),

-- ===========================================
-- GESTER MACALDO (Student ID: 4) - 3rd Year, 2nd Sem - FULLY PAID
-- ===========================================
(4, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,800 - 3rd Year rate)', 27000.00, 27000.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', 'Paid via BPI mobile app'),
(4, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', NULL),
(4, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', NULL),
(4, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 4000.00, 4000.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', NULL),
(4, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', NULL),
(4, 10, '2024-2025', '2nd Semester', 'Examination Permit Fee', 2000.00, 2000.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', NULL),
(4, 6, '2024-2025', '2nd Semester', 'Student Development Fee', 2500.00, 2500.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', NULL),

-- ===========================================
-- ISAAC GANOLO (Student ID: 5) - 1st Year, 2nd Sem - FULLY PAID (Parents paid)
-- ===========================================
(5, 1, '2024-2025', '2nd Semester', 'Tuition Fee (20 units x ₱1,500)', 30000.00, 30000.00, '2025-01-03', 'Bank Transfer', 'BPI-2025-010301', 'Paid', '2025-01-10', 'Full payment by parents'),
(5, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2025-01-03', 'Bank Transfer', 'BPI-2025-010301', 'Paid', '2025-01-10', NULL),
(5, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-03', 'Bank Transfer', 'BPI-2025-010301', 'Paid', '2025-01-10', NULL),
(5, 4, '2024-2025', '2nd Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-01-03', 'Bank Transfer', 'BPI-2025-010301', 'Paid', '2025-01-10', NULL),
(5, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-01-03', 'Bank Transfer', 'BPI-2025-010301', 'Paid', '2025-01-10', NULL),
(5, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-03', 'Bank Transfer', 'BPI-2025-010301', 'Paid', '2025-01-10', NULL),
(5, 9, '2024-2025', '2nd Semester', 'Registration Fee', 500.00, 500.00, '2025-01-03', 'Bank Transfer', 'BPI-2025-010301', 'Paid', '2025-01-10', NULL),

-- ===========================================
-- LYNARD DEMETERIO (Student ID: 6) - 2nd Year, 2nd Sem - FULLY PAID
-- ===========================================
(6, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010701', 'Paid', '2025-01-10', 'Paid via Maya'),
(6, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010702', 'Paid', '2025-01-10', NULL),
(6, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010703', 'Paid', '2025-01-10', NULL),
(6, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010704', 'Paid', '2025-01-10', NULL),
(6, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010705', 'Paid', '2025-01-10', NULL),

-- ===========================================
-- JUNRICK DELA COSTA (Student ID: 7) - 1st Year, 2nd Sem - FULLY PAID
-- ===========================================
(7, 1, '2024-2025', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-01-05', 'Cash', 'OR-2025-003312', 'Paid', '2025-01-10', 'Paid at cashier window'),
(7, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2025-01-05', 'Cash', 'OR-2025-003313', 'Paid', '2025-01-10', NULL),
(7, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', 'Cash', 'OR-2025-003314', 'Paid', '2025-01-10', NULL),
(7, 4, '2024-2025', '2nd Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-01-05', 'Cash', 'OR-2025-003315', 'Paid', '2025-01-10', NULL),
(7, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-01-05', 'Cash', 'OR-2025-003316', 'Paid', '2025-01-10', NULL),
(7, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-05', 'Cash', 'OR-2025-003317', 'Paid', '2025-01-10', NULL),

-- ===========================================
-- MARIA CLARA SANTOS (Student ID: 8) - 2nd Year, 2nd Sem - FULLY PAID
-- ===========================================
(8, 1, '2024-2025', '2nd Semester', 'Tuition Fee (17 units x ₱1,500)', 25500.00, 25500.00, '2025-01-06', 'Online Payment', 'MAYA-2025-010601', 'Paid', '2025-01-10', 'Paid via Maya'),
(8, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', 'Online Payment', 'MAYA-2025-010602', 'Paid', '2025-01-10', NULL),
(8, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', 'Online Payment', 'MAYA-2025-010603', 'Paid', '2025-01-10', NULL),
(8, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-01-06', 'Online Payment', 'MAYA-2025-010604', 'Paid', '2025-01-10', NULL),
(8, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-06', 'Online Payment', 'MAYA-2025-010605', 'Paid', '2025-01-10', NULL),
(8, 10, '2024-2025', '2nd Semester', 'Examination Permit Fee', 1500.00, 1500.00, '2025-03-01', 'Online Payment', 'MAYA-2025-030101', 'Paid', '2025-03-05', NULL),

-- ===========================================
-- ANNA THERESE REYES (Student ID: 9) - 3rd Year, 2nd Sem - FULLY PAID
-- ===========================================
(9, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-01-04', 'Bank Transfer', 'UNION-2025-010401', 'Paid', '2025-01-10', 'UnionBank transfer'),
(9, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-04', 'Bank Transfer', 'UNION-2025-010401', 'Paid', '2025-01-10', NULL),
(9, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-04', 'Bank Transfer', 'UNION-2025-010401', 'Paid', '2025-01-10', NULL),
(9, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 4000.00, 4000.00, '2025-01-04', 'Bank Transfer', 'UNION-2025-010401', 'Paid', '2025-01-10', NULL),
(9, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-04', 'Bank Transfer', 'UNION-2025-010401', 'Paid', '2025-01-10', NULL),
(9, 10, '2024-2025', '2nd Semester', 'Examination Permit Fee', 2000.00, 2000.00, '2025-01-04', 'Bank Transfer', 'UNION-2025-010401', 'Paid', '2025-01-10', NULL),

-- ===========================================
-- JOHN MICHAEL CRUZ (Student ID: 10) - 1st Year, 2nd Sem - FULLY PAID
-- ===========================================
(10, 1, '2024-2025', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-01-02', 'GCash', 'GCASH-2025-010201', 'Paid', '2025-01-10', 'GCash payment'),
(10, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2025-01-02', 'GCash', 'GCASH-2025-010202', 'Paid', '2025-01-10', NULL),
(10, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-02', 'GCash', 'GCASH-2025-010203', 'Paid', '2025-01-10', NULL),
(10, 4, '2024-2025', '2nd Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-01-02', 'GCash', 'GCASH-2025-010204', 'Paid', '2025-01-10', NULL),
(10, 7, '2024-2025', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2025-01-02', 'GCash', 'GCASH-2025-010205', 'Paid', '2025-01-10', NULL),
(10, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-02', 'GCash', 'GCASH-2025-010206', 'Paid', '2025-01-10', NULL),

-- =====================================================================
-- PAYMENT HISTORY FOR PREVIOUS SEMESTERS
-- Students who have been enrolled for multiple semesters
-- =====================================================================

-- ===========================================
-- REGINALD CANO (Student ID: 1) - PAYMENT HISTORY
-- Started: 1st Year, 1st Sem 2023-2024
-- ===========================================
-- 1st Year, 1st Semester (2023-2024)
(1, 1, '2023-2024', '1st Semester', 'Tuition Fee (20 units x ₱1,500)', 30000.00, 30000.00, '2023-08-10', 'Bank Transfer', 'BDO-2023-081001', 'Paid', '2023-08-15', 'Full payment - 1st Year 1st Sem'),
(1, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2023-08-10', 'Bank Transfer', 'BDO-2023-081001', 'Paid', '2023-08-15', NULL),
(1, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-10', 'Bank Transfer', 'BDO-2023-081001', 'Paid', '2023-08-15', NULL),
(1, 4, '2023-2024', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2023-08-10', 'Bank Transfer', 'BDO-2023-081001', 'Paid', '2023-08-15', NULL),
(1, 7, '2023-2024', '1st Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2023-08-10', 'Bank Transfer', 'BDO-2023-081001', 'Paid', '2023-08-15', NULL),
(1, 8, '2023-2024', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2023-08-10', 'Bank Transfer', 'BDO-2023-081001', 'Paid', '2023-08-15', NULL),
(1, 9, '2023-2024', '1st Semester', 'Registration Fee', 500.00, 500.00, '2023-08-10', 'Bank Transfer', 'BDO-2023-081001', 'Paid', '2023-08-15', 'New student registration'),

-- 1st Year, 2nd Semester (2023-2024)
(1, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010801', 'Paid', '2024-01-12', NULL),
(1, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010801', 'Paid', '2024-01-12', NULL),
(1, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010801', 'Paid', '2024-01-12', NULL),
(1, 4, '2023-2024', '2nd Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010801', 'Paid', '2024-01-12', NULL),
(1, 7, '2023-2024', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010801', 'Paid', '2024-01-12', NULL),
(1, 8, '2023-2024', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010801', 'Paid', '2024-01-12', NULL),

-- 2nd Year, 1st Semester (2024-2025)
(1, 1, '2024-2025', '1st Semester', 'Tuition Fee (17 units x ₱1,500)', 25500.00, 25500.00, '2024-08-08', 'Bank Transfer', 'BDO-2024-080801', 'Paid', '2024-08-12', NULL),
(1, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-08', 'Bank Transfer', 'BDO-2024-080801', 'Paid', '2024-08-12', NULL),
(1, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-08', 'Bank Transfer', 'BDO-2024-080801', 'Paid', '2024-08-12', NULL),
(1, 7, '2024-2025', '1st Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2024-08-08', 'Bank Transfer', 'BDO-2024-080801', 'Paid', '2024-08-12', NULL),
(1, 8, '2024-2025', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2024-08-08', 'Bank Transfer', 'BDO-2024-080801', 'Paid', '2024-08-12', NULL),

-- ===========================================
-- KINLEY LAVINA (Student ID: 2) - PAYMENT HISTORY
-- Started: 1st Year, 1st Sem 2023-2024
-- ===========================================
-- 1st Year, 1st Semester (2023-2024)
(2, 1, '2023-2024', '1st Semester', 'Tuition Fee (20 units x ₱1,500)', 30000.00, 30000.00, '2023-08-12', 'Installment', 'INST-2023-081201', 'Paid', '2023-08-15', 'Completed via installment'),
(2, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2023-08-12', 'Cash', 'OR-2023-001122', 'Paid', '2023-08-15', NULL),
(2, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2023-10-15', 'Installment', 'INST-2023-101501', 'Paid', '2023-08-15', NULL),
(2, 4, '2023-2024', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2023-08-12', 'Cash', 'OR-2023-001123', 'Paid', '2023-08-15', NULL),
(2, 7, '2023-2024', '1st Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2023-10-15', 'Installment', 'INST-2023-101502', 'Paid', '2023-10-20', NULL),
(2, 8, '2023-2024', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2023-08-12', 'Cash', 'OR-2023-001124', 'Paid', '2023-08-15', NULL),

-- 1st Year, 2nd Semester (2023-2024)
(2, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2024-03-10', 'Installment', 'INST-2024-031001', 'Paid', '2024-01-12', 'Final installment'),
(2, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2024-01-10', 'Cash', 'OR-2024-000512', 'Paid', '2024-01-12', NULL),
(2, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-03-10', 'Installment', 'INST-2024-031002', 'Paid', '2024-01-12', NULL),
(2, 7, '2023-2024', '2nd Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2024-03-10', 'Installment', 'INST-2024-031003', 'Paid', '2024-03-15', NULL),
(2, 8, '2023-2024', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2024-01-10', 'Cash', 'OR-2024-000513', 'Paid', '2024-01-12', NULL),

-- 2nd Year, 1st Semester (2024-2025)
(2, 1, '2024-2025', '1st Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2024-10-15', 'Installment', 'INST-2024-101501', 'Paid', '2024-08-12', 'Completed installment'),
(2, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', 'Cash', 'OR-2024-005512', 'Paid', '2024-08-12', NULL),
(2, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-10-15', 'Installment', 'INST-2024-101502', 'Paid', '2024-08-12', NULL),
(2, 7, '2024-2025', '1st Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2024-10-15', 'Installment', 'INST-2024-101503', 'Paid', '2024-10-20', NULL),
(2, 8, '2024-2025', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2024-08-10', 'Cash', 'OR-2024-005513', 'Paid', '2024-08-12', NULL),

-- ===========================================
-- JEFERSON CANO (Student ID: 3) - PAYMENT HISTORY
-- Started: 1st Year, 1st Sem 2024-2025 (Scholar)
-- ===========================================
-- 1st Year, 1st Semester (2024-2025)
(3, 1, '2024-2025', '1st Semester', 'Tuition Fee (18 units x ₱1,500) - 50% Scholar', 13500.00, 13500.00, '2024-08-05', 'Scholarship', 'ACAD-SCHOLAR-2024-003', 'Paid', '2024-08-10', 'Academic scholarship'),
(3, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2024-08-05', 'GCash', 'GCASH-2024-080501', 'Paid', '2024-08-10', NULL),
(3, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-05', 'GCash', 'GCASH-2024-080502', 'Paid', '2024-08-10', NULL),
(3, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-05', 'GCash', 'GCASH-2024-080503', 'Paid', '2024-08-10', NULL),
(3, 7, '2024-2025', '1st Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2024-08-05', 'GCash', 'GCASH-2024-080504', 'Paid', '2024-08-10', NULL),
(3, 8, '2024-2025', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2024-08-05', 'GCash', 'GCASH-2024-080505', 'Paid', '2024-08-10', NULL),
(3, 9, '2024-2025', '1st Semester', 'Registration Fee', 500.00, 500.00, '2024-08-05', 'GCash', 'GCASH-2024-080506', 'Paid', '2024-08-10', 'New student'),

-- ===========================================
-- GESTER MACALDO (Student ID: 4) - PAYMENT HISTORY
-- Started: 2nd Year, 1st Sem 2023-2024 (Transferee)
-- ===========================================
-- 2nd Year, 1st Semester (2023-2024)
(4, 1, '2023-2024', '1st Semester', 'Tuition Fee (17 units x ₱1,800)', 30600.00, 30600.00, '2023-08-08', 'Bank Transfer', 'BPI-2023-080801', 'Paid', '2023-08-12', 'Transferee - 2nd Year'),
(4, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2023-08-08', 'Bank Transfer', 'BPI-2023-080801', 'Paid', '2023-08-12', NULL),
(4, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2023-08-08', 'Bank Transfer', 'BPI-2023-080801', 'Paid', '2023-08-12', NULL),
(4, 7, '2023-2024', '1st Semester', 'Energy Fee (Aircon)', 4000.00, 4000.00, '2023-08-08', 'Bank Transfer', 'BPI-2023-080801', 'Paid', '2023-08-12', NULL),
(4, 8, '2023-2024', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2023-08-08', 'Bank Transfer', 'BPI-2023-080801', 'Paid', '2023-08-12', NULL),

-- 2nd Year, 2nd Semester (2023-2024)
(4, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-01-05', 'Bank Transfer', 'BPI-2024-010501', 'Paid', '2024-01-10', NULL),
(4, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-01-05', 'Bank Transfer', 'BPI-2024-010501', 'Paid', '2024-01-10', NULL),
(4, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-01-05', 'Bank Transfer', 'BPI-2024-010501', 'Paid', '2024-01-10', NULL),
(4, 7, '2023-2024', '2nd Semester', 'Energy Fee (Aircon)', 4000.00, 4000.00, '2024-01-05', 'Bank Transfer', 'BPI-2024-010501', 'Paid', '2024-01-10', NULL),
(4, 8, '2023-2024', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2024-01-05', 'Bank Transfer', 'BPI-2024-010501', 'Paid', '2024-01-10', NULL),

-- 3rd Year, 1st Semester (2024-2025)
(4, 1, '2024-2025', '1st Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2024-08-06', 'Bank Transfer', 'BPI-2024-080601', 'Paid', '2024-08-10', NULL),
(4, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-08-06', 'Bank Transfer', 'BPI-2024-080601', 'Paid', '2024-08-10', NULL),
(4, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-08-06', 'Bank Transfer', 'BPI-2024-080601', 'Paid', '2024-08-10', NULL),
(4, 7, '2024-2025', '1st Semester', 'Energy Fee (Aircon)', 4000.00, 4000.00, '2024-08-06', 'Bank Transfer', 'BPI-2024-080601', 'Paid', '2024-08-10', NULL),
(4, 8, '2024-2025', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2024-08-06', 'Bank Transfer', 'BPI-2024-080601', 'Paid', '2024-08-10', NULL),

-- ===========================================
-- ISAAC GANOLO (Student ID: 5) - PAYMENT HISTORY
-- Started: 1st Year, 1st Sem 2024-2025 (Freshman)
-- ===========================================
-- 1st Year, 1st Semester (2024-2025)
(5, 1, '2024-2025', '1st Semester', 'Tuition Fee (20 units x ₱1,500)', 30000.00, 30000.00, '2024-08-03', 'Bank Transfer', 'BPI-2024-080301', 'Paid', '2024-08-10', 'Full payment by parents'),
(5, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2024-08-03', 'Bank Transfer', 'BPI-2024-080301', 'Paid', '2024-08-10', NULL),
(5, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-03', 'Bank Transfer', 'BPI-2024-080301', 'Paid', '2024-08-10', NULL),
(5, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-03', 'Bank Transfer', 'BPI-2024-080301', 'Paid', '2024-08-10', NULL),
(5, 7, '2024-2025', '1st Semester', 'Energy Fee (Aircon)', 3500.00, 3500.00, '2024-08-03', 'Bank Transfer', 'BPI-2024-080301', 'Paid', '2024-08-10', NULL),
(5, 8, '2024-2025', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2024-08-03', 'Bank Transfer', 'BPI-2024-080301', 'Paid', '2024-08-10', NULL),
(5, 9, '2024-2025', '1st Semester', 'Registration Fee', 500.00, 500.00, '2024-08-03', 'Bank Transfer', 'BPI-2024-080301', 'Paid', '2024-08-10', 'New student');

-- ============================================
-- All done! Your database is ready to go!
-- ============================================
