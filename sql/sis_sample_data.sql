-- ============================================================
-- STUDENT INFORMATION SYSTEM (SIS) - SAMPLE DATA
-- ============================================================
-- Version: 1.0.0
-- 
-- This file contains sample data for testing and development.
-- Run sis_schema.sql first to create the database structure.
-- ============================================================

USE ems_O6;

-- ============================================================
-- USERS - Default Admin Account
-- Password: admin123 (bcrypt hashed)
-- ============================================================
INSERT INTO users (username, email, password, full_name, role) VALUES
('admin', 'admin@ems.local', '$2y$10$oamDXJzNBYfrB3hWGeZZeu5gZgWQztufYMEslVARK.sRLmqzKwTWe', 'System Administrator', 'admin');

-- ============================================================
-- PROGRAMS - Academic Programs
-- ============================================================
INSERT INTO programs (program_code, program_name, department, description, years_duration) VALUES
('BSIT', 'Bachelor of Science in Information Technology', 'College of Computing Studies', 'Information Technology program focused on software development and IT infrastructure', 4),
('BSCS', 'Bachelor of Science in Computer Science', 'College of Computing Studies', 'Computer Science program with focus on algorithms and computational theory', 4),
('BSIS', 'Bachelor of Science in Information Systems', 'College of Computing Studies', 'Information Systems program bridging IT and business processes', 4),
('BSCE', 'Bachelor of Science in Computer Engineering', 'College of Engineering', 'Computer Engineering program combining hardware and software engineering', 5),
('BSA', 'Bachelor of Science in Accountancy', 'College of Business', 'Accountancy program preparing students for CPA licensure', 4),
('BSBA', 'Bachelor of Science in Business Administration', 'College of Business', 'Business Administration program with various specializations', 4);

-- ============================================================
-- SUBJECTS - BSIT Curriculum Subjects
-- ============================================================
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

-- ============================================================
-- PAYMENT TYPES - Fee Categories
-- ============================================================
INSERT INTO payment_types (type_name, description) VALUES
('Tuition Fee', 'Per unit fee for enrolled subjects'),
('Laboratory Fee', 'Computer and science laboratory usage fee'),
('Miscellaneous Fee', 'Includes library, ID, medical, guidance, and cultural fees'),
('NSTP Fee', 'National Service Training Program fee'),
('Athletic Fee', 'Sports facilities and intramural activities'),
('Student Development Fee', 'Student council and organization activities'),
('Energy Fee', 'Air conditioning and electricity consumption'),
('Insurance Fee', 'Student accident and health insurance'),
('Registration Fee', 'Enrollment processing and documentation'),
('Examination Permit', 'Midterm and final examination permit fee');

-- ============================================================
-- STUDENTS - Sample Student Records
-- ============================================================
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

-- Student 8: Maria Clara Santos
('STU-2025-00008', 'Maria Clara', 'Dela Cruz', 'Santos', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'A+',
'mariaclara.santos@email.com', '+63 9171234508', '2003-06-20', 'Makati City, Philippines',
'258 Ayala Avenue', 'Brgy. San Lorenzo', 'Makati City', 'Metro Manila', '1226',
'Jose Santos', 'Father', '+63 9181234508', '258 Ayala Avenue, Brgy. San Lorenzo, Makati City',
'Lucia Dela Cruz Santos', '+63 9191234508',
'2nd Year', '1st Semester', 'BSIT-2B', 'Bachelor of Science in Information Technology', 'Active', '2024-06-15'),

-- Student 9: Anna Therese Reyes
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

-- ============================================================
-- ENROLLMENTS - Complete Academic Records
-- Based on student year level and admission date
-- ============================================================

-- Clear existing enrollments for clean insert
-- DELETE FROM enrollments;

-- ============================================================
-- STUDENT 1: Reginald Santos Cano
-- 2nd Year BSIT | Admitted: 2024-06-15 | Currently: 2nd Year, 2nd Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
INSERT INTO enrollments (student_id, subject_id, academic_year, semester, enrollment_date, grade, grade_status) VALUES
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(1, 1, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- CC101 Introduction to Computing
(1, 2, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- CC102 Computer Programming 1
(1, 3, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),   -- GEC01 Understanding the Self
(1, 4, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- GEC02 Readings in Philippine History
(1, 5, '2024-2025', '1st Semester', '2024-08-12', 2.25, 'Passed'),   -- GEC03 Mathematics in the Modern World
(1, 6, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(1, 7, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(1, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),   -- CC103 Computer Programming 2
(1, 9, '2024-2025', '2nd Semester', '2025-01-06', 2.50, 'Passed'),   -- CC104 Discrete Mathematics
(1, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- GEC04 The Contemporary World
(1, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- GEC05 Purposive Communication
(1, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- NSTP2 National Service Training Program 2
(1, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(1, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(1, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(1, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(1, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(1, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(1, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- PE103 Individual and Dual Sports

-- ============================================================
-- STUDENT 2: Kinley Cruz Lavina  
-- 2nd Year BSIT | Admitted: 2024-06-15 | Currently: 2nd Year, 2nd Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(2, 1, '2024-2025', '1st Semester', '2024-08-12', 2.25, 'Passed'),   -- CC101 Introduction to Computing
(2, 2, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),   -- CC102 Computer Programming 1
(2, 3, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- GEC01 Understanding the Self
(2, 4, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),   -- GEC02 Readings in Philippine History
(2, 5, '2024-2025', '1st Semester', '2024-08-12', 2.50, 'Passed'),   -- GEC03 Mathematics in the Modern World
(2, 6, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- NSTP1 National Service Training Program 1
(2, 7, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(2, 8, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),   -- CC103 Computer Programming 2
(2, 9, '2024-2025', '2nd Semester', '2025-01-06', 2.75, 'Passed'),   -- CC104 Discrete Mathematics
(2, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- GEC04 The Contemporary World
(2, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- GEC05 Purposive Communication
(2, 12, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),  -- NSTP2 National Service Training Program 2
(2, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(2, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(2, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(2, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(2, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(2, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(2, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- PE103 Individual and Dual Sports

-- ============================================================
-- STUDENT 3: Jeferson Reyes Cano
-- 1st Year BSCS | Admitted: 2025-06-10 | Currently: 1st Year, 1st Semester
-- New student - first semester enrollment only
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(3, 1, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC101 Introduction to Computing
(3, 2, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC102 Computer Programming 1
(3, 3, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC01 Understanding the Self
(3, 4, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC02 Readings in Philippine History
(3, 5, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC03 Mathematics in the Modern World
(3, 6, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- NSTP1 National Service Training Program 1
(3, 7, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- PE101 Physical Fitness

-- ============================================================
-- STUDENT 4: Gester Garcia Macaldo
-- 3rd Year BSIT | Admitted: 2023-06-12 | Currently: 3rd Year, 1st Semester
-- Complete enrollment history: 1st Year to 3rd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(4, 1, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),   -- CC101 Introduction to Computing
(4, 2, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),   -- CC102 Computer Programming 1
(4, 3, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),   -- GEC01 Understanding the Self
(4, 4, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),   -- GEC02 Readings in Philippine History
(4, 5, '2023-2024', '1st Semester', '2023-08-14', 2.25, 'Passed'),   -- GEC03 Mathematics in the Modern World
(4, 6, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(4, 7, '2023-2024', '1st Semester', '2023-08-14', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(4, 8, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),   -- CC103 Computer Programming 2
(4, 9, '2023-2024', '2nd Semester', '2024-01-08', 2.25, 'Passed'),   -- CC104 Discrete Mathematics
(4, 10, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),  -- GEC04 The Contemporary World
(4, 11, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),  -- GEC05 Purposive Communication
(4, 12, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),  -- NSTP2 National Service Training Program 2
(4, 13, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(4, 14, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- IT201 Data Structures and Algorithms
(4, 15, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),  -- IT202 Object-Oriented Programming
(4, 16, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- IT203 Database Management Systems 1
(4, 17, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- IT204 Platform Technologies
(4, 18, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- GEC06 Art Appreciation
(4, 19, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),  -- PE103 Individual and Dual Sports
-- 2nd Year, 2nd Semester (S.Y. 2024-2025)
(4, 20, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- IT205 Information Management
(4, 21, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- IT206 Networking 1
(4, 22, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),  -- IT207 Systems Analysis and Design
(4, 23, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- IT208 Web Development
(4, 24, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- GEC07 Ethics
(4, 25, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE104 Team Sports
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(4, 26, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT301 Applications Development
(4, 27, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT302 Integrative Programming
(4, 28, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT303 System Administration
(4, 29, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT304 Information Assurance 1
(4, 30, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- CAP01 Capstone Project 1

-- ============================================================
-- STUDENT 5: Isaac Lopez Ganolo
-- 1st Year BSIT | Admitted: 2025-06-10 | Currently: 1st Year, 1st Semester
-- New student - first semester enrollment only
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(5, 1, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC101 Introduction to Computing
(5, 2, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC102 Computer Programming 1
(5, 3, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC01 Understanding the Self
(5, 4, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC02 Readings in Philippine History
(5, 5, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC03 Mathematics in the Modern World
(5, 6, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- NSTP1 National Service Training Program 1
(5, 7, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- PE101 Physical Fitness

-- ============================================================
-- STUDENT 6: Lynard Martinez Demeterio
-- 2nd Year BSCS | Admitted: 2024-06-15 | Currently: 2nd Year, 1st Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(6, 1, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- CC101 Introduction to Computing
(6, 2, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- CC102 Computer Programming 1
(6, 3, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- GEC01 Understanding the Self
(6, 4, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),   -- GEC02 Readings in Philippine History
(6, 5, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- GEC03 Mathematics in the Modern World
(6, 6, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- NSTP1 National Service Training Program 1
(6, 7, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(6, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),   -- CC103 Computer Programming 2
(6, 9, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),   -- CC104 Discrete Mathematics
(6, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- GEC04 The Contemporary World
(6, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- GEC05 Purposive Communication
(6, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- NSTP2 National Service Training Program 2
(6, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(6, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(6, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(6, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(6, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(6, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(6, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- PE103 Individual and Dual Sports

-- ============================================================
-- STUDENT 7: Junrick Fernandez Dela Costa
-- 1st Year BSIT | Admitted: 2025-06-10 | Currently: 1st Year, 1st Semester
-- New student - first semester enrollment only
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(7, 1, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC101 Introduction to Computing
(7, 2, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC102 Computer Programming 1
(7, 3, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC01 Understanding the Self
(7, 4, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC02 Readings in Philippine History
(7, 5, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC03 Mathematics in the Modern World
(7, 6, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- NSTP1 National Service Training Program 1
(7, 7, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- PE101 Physical Fitness

-- ============================================================
-- STUDENT 8: Maria Clara Santos
-- 2nd Year BSIT | Admitted: 2024-06-15 | Currently: 2nd Year, 1st Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(8, 1, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- CC101 Introduction to Computing
(8, 2, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- CC102 Computer Programming 1
(8, 3, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- GEC01 Understanding the Self
(8, 4, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- GEC02 Readings in Philippine History
(8, 5, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- GEC03 Mathematics in the Modern World
(8, 6, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(8, 7, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(8, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),   -- CC103 Computer Programming 2
(8, 9, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),   -- CC104 Discrete Mathematics
(8, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- GEC04 The Contemporary World
(8, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.00, 'Passed'),  -- GEC05 Purposive Communication
(8, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- NSTP2 National Service Training Program 2
(8, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(8, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(8, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(8, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(8, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(8, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(8, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- PE103 Individual and Dual Sports

-- ============================================================
-- STUDENT 9: Anna Therese Reyes
-- 3rd Year BSCS | Admitted: 2023-06-12 | Currently: 3rd Year, 1st Semester
-- Complete enrollment history: 1st Year to 3rd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(9, 1, '2023-2024', '1st Semester', '2023-08-14', 1.25, 'Passed'),   -- CC101 Introduction to Computing
(9, 2, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),   -- CC102 Computer Programming 1
(9, 3, '2023-2024', '1st Semester', '2023-08-14', 1.00, 'Passed'),   -- GEC01 Understanding the Self
(9, 4, '2023-2024', '1st Semester', '2023-08-14', 1.25, 'Passed'),   -- GEC02 Readings in Philippine History
(9, 5, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),   -- GEC03 Mathematics in the Modern World
(9, 6, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(9, 7, '2023-2024', '1st Semester', '2023-08-14', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(9, 8, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),   -- CC103 Computer Programming 2
(9, 9, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),   -- CC104 Discrete Mathematics
(9, 10, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),  -- GEC04 The Contemporary World
(9, 11, '2023-2024', '2nd Semester', '2024-01-08', 1.00, 'Passed'),  -- GEC05 Purposive Communication
(9, 12, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),  -- NSTP2 National Service Training Program 2
(9, 13, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(9, 14, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- IT201 Data Structures and Algorithms
(9, 15, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),  -- IT202 Object-Oriented Programming
(9, 16, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- IT203 Database Management Systems 1
(9, 17, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- IT204 Platform Technologies
(9, 18, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),  -- GEC06 Art Appreciation
(9, 19, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),  -- PE103 Individual and Dual Sports
-- 2nd Year, 2nd Semester (S.Y. 2024-2025)
(9, 20, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- IT205 Information Management
(9, 21, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- IT206 Networking 1
(9, 22, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- IT207 Systems Analysis and Design
(9, 23, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- IT208 Web Development
(9, 24, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- GEC07 Ethics
(9, 25, '2024-2025', '2nd Semester', '2025-01-06', 1.00, 'Passed'),  -- PE104 Team Sports
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(9, 26, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT301 Applications Development
(9, 27, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT302 Integrative Programming
(9, 28, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT303 System Administration
(9, 29, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT304 Information Assurance 1
(9, 30, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- CAP01 Capstone Project 1

-- ============================================================
-- STUDENT 10: John Michael Cruz
-- 1st Year BSIT | Admitted: 2025-06-10 | Currently: 1st Year, 1st Semester
-- New student - first semester enrollment only
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(10, 1, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC101 Introduction to Computing
(10, 2, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC102 Computer Programming 1
(10, 3, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC01 Understanding the Self
(10, 4, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC02 Readings in Philippine History
(10, 5, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC03 Mathematics in the Modern World
(10, 6, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- NSTP1 National Service Training Program 1
(10, 7, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- PE101 Physical Fitness

-- ============================================================
-- STUDENT 11: Mark Anthony Garcia
-- 1st Year BSIT | Admitted: 2025-06-10 | Currently: 1st Year, 1st Semester
-- New student - first semester enrollment only
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(11, 1, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC101 Introduction to Computing
(11, 2, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC102 Computer Programming 1
(11, 3, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC01 Understanding the Self
(11, 4, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC02 Readings in Philippine History
(11, 5, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC03 Mathematics in the Modern World
(11, 6, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- NSTP1 National Service Training Program 1
(11, 7, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- PE101 Physical Fitness

-- ============================================================
-- STUDENT 12: Sofia Nicole Tan
-- 2nd Year BSCS | Admitted: 2024-06-15 | Currently: 2nd Year, 1st Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(12, 1, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- CC101 Introduction to Computing
(12, 2, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- CC102 Computer Programming 1
(12, 3, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- GEC01 Understanding the Self
(12, 4, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- GEC02 Readings in Philippine History
(12, 5, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- GEC03 Mathematics in the Modern World
(12, 6, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(12, 7, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(12, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),   -- CC103 Computer Programming 2
(12, 9, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),   -- CC104 Discrete Mathematics
(12, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- GEC04 The Contemporary World
(12, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.00, 'Passed'),  -- GEC05 Purposive Communication
(12, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- NSTP2 National Service Training Program 2
(12, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(12, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(12, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(12, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(12, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(12, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(12, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- PE103 Individual and Dual Sports

-- ============================================================
-- STUDENT 13: Gabriel Luis Mendoza
-- 3rd Year BSIT | Admitted: 2023-06-12 | Currently: 3rd Year, 1st Semester
-- Complete enrollment history: 1st Year to 3rd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(13, 1, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),   -- CC101 Introduction to Computing
(13, 2, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),   -- CC102 Computer Programming 1
(13, 3, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),   -- GEC01 Understanding the Self
(13, 4, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),   -- GEC02 Readings in Philippine History
(13, 5, '2023-2024', '1st Semester', '2023-08-14', 2.25, 'Passed'),   -- GEC03 Mathematics in the Modern World
(13, 6, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(13, 7, '2023-2024', '1st Semester', '2023-08-14', 1.25, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(13, 8, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),   -- CC103 Computer Programming 2
(13, 9, '2023-2024', '2nd Semester', '2024-01-08', 2.00, 'Passed'),   -- CC104 Discrete Mathematics
(13, 10, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),  -- GEC04 The Contemporary World
(13, 11, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),  -- GEC05 Purposive Communication
(13, 12, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),  -- NSTP2 National Service Training Program 2
(13, 13, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(13, 14, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- IT201 Data Structures and Algorithms
(13, 15, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- IT202 Object-Oriented Programming
(13, 16, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),  -- IT203 Database Management Systems 1
(13, 17, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- IT204 Platform Technologies
(13, 18, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- GEC06 Art Appreciation
(13, 19, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),  -- PE103 Individual and Dual Sports
-- 2nd Year, 2nd Semester (S.Y. 2024-2025)
(13, 20, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- IT205 Information Management
(13, 21, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- IT206 Networking 1
(13, 22, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),  -- IT207 Systems Analysis and Design
(13, 23, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- IT208 Web Development
(13, 24, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- GEC07 Ethics
(13, 25, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE104 Team Sports
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(13, 26, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT301 Applications Development
(13, 27, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT302 Integrative Programming
(13, 28, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT303 System Administration
(13, 29, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT304 Information Assurance 1
(13, 30, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- CAP01 Capstone Project 1

-- ============================================================
-- STUDENT 14: Chloe Marie Lim
-- 1st Year BSIS | Admitted: 2025-06-10 | Currently: 1st Year, 1st Semester
-- New student - first semester enrollment only
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(14, 1, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC101 Introduction to Computing
(14, 2, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC102 Computer Programming 1
(14, 3, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC01 Understanding the Self
(14, 4, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC02 Readings in Philippine History
(14, 5, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC03 Mathematics in the Modern World
(14, 6, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- NSTP1 National Service Training Program 1
(14, 7, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- PE101 Physical Fitness

-- ============================================================
-- STUDENT 15: Rafael Jose Bautista
-- 4th Year BSCE | Admitted: 2022-06-15 | Currently: 4th Year, 1st Semester
-- Complete enrollment history: 1st Year to 4th Year (5-year program)
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2022-2023)
(15, 1, '2022-2023', '1st Semester', '2022-08-15', 1.50, 'Passed'),   -- CC101 Introduction to Computing
(15, 2, '2022-2023', '1st Semester', '2022-08-15', 1.75, 'Passed'),   -- CC102 Computer Programming 1
(15, 3, '2022-2023', '1st Semester', '2022-08-15', 1.50, 'Passed'),   -- GEC01 Understanding the Self
(15, 4, '2022-2023', '1st Semester', '2022-08-15', 1.25, 'Passed'),   -- GEC02 Readings in Philippine History
(15, 5, '2022-2023', '1st Semester', '2022-08-15', 2.00, 'Passed'),   -- GEC03 Mathematics in the Modern World
(15, 6, '2022-2023', '1st Semester', '2022-08-15', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(15, 7, '2022-2023', '1st Semester', '2022-08-15', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2022-2023)
(15, 8, '2022-2023', '2nd Semester', '2023-01-09', 1.75, 'Passed'),   -- CC103 Computer Programming 2
(15, 9, '2022-2023', '2nd Semester', '2023-01-09', 2.25, 'Passed'),   -- CC104 Discrete Mathematics
(15, 10, '2022-2023', '2nd Semester', '2023-01-09', 1.50, 'Passed'),  -- GEC04 The Contemporary World
(15, 11, '2022-2023', '2nd Semester', '2023-01-09', 1.25, 'Passed'),  -- GEC05 Purposive Communication
(15, 12, '2022-2023', '2nd Semester', '2023-01-09', 1.75, 'Passed'),  -- NSTP2 National Service Training Program 2
(15, 13, '2022-2023', '2nd Semester', '2023-01-09', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2023-2024)
(15, 14, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),  -- IT201 Data Structures and Algorithms
(15, 15, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),  -- IT202 Object-Oriented Programming
(15, 16, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),  -- IT203 Database Management Systems 1
(15, 17, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),  -- IT204 Platform Technologies
(15, 18, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),  -- GEC06 Art Appreciation
(15, 19, '2023-2024', '1st Semester', '2023-08-14', 1.25, 'Passed'),  -- PE103 Individual and Dual Sports
-- 2nd Year, 2nd Semester (S.Y. 2023-2024)
(15, 20, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),  -- IT205 Information Management
(15, 21, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),  -- IT206 Networking 1
(15, 22, '2023-2024', '2nd Semester', '2024-01-08', 2.00, 'Passed'),  -- IT207 Systems Analysis and Design
(15, 23, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),  -- IT208 Web Development
(15, 24, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),  -- GEC07 Ethics
(15, 25, '2023-2024', '2nd Semester', '2024-01-08', 1.25, 'Passed'),  -- PE104 Team Sports
-- 3rd Year, 1st Semester (S.Y. 2024-2025)
(15, 26, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- IT301 Applications Development
(15, 27, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- IT302 Integrative Programming
(15, 28, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- IT303 System Administration
(15, 29, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),  -- IT304 Information Assurance 1
(15, 30, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- CAP01 Capstone Project 1
-- 3rd Year, 2nd Semester (S.Y. 2024-2025)
(15, 31, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- IT305 Networking 2
(15, 32, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- IT306 Information Assurance 2
(15, 33, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- IT307 Social and Professional Issues
(15, 34, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- CAP02 Capstone Project 2
(15, 35, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- ITELEC1 IT Elective 1
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(15, 26, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- Advanced subjects (4th Year)
(15, 27, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),
(15, 28, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),
(15, 29, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),
(15, 30, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- Internship/OJT

-- ============================================================
-- STUDENT 16: Jasmine Rose Yap
-- 2nd Year BSA | Admitted: 2024-06-15 | Currently: 2nd Year, 1st Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(16, 1, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- CC101 Introduction to Computing
(16, 2, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- CC102 Computer Programming 1
(16, 3, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- GEC01 Understanding the Self
(16, 4, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- GEC02 Readings in Philippine History
(16, 5, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- GEC03 Mathematics in the Modern World
(16, 6, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- NSTP1 National Service Training Program 1
(16, 7, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(16, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),   -- CC103 Computer Programming 2
(16, 9, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),   -- CC104 Discrete Mathematics
(16, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.00, 'Passed'),  -- GEC04 The Contemporary World
(16, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- GEC05 Purposive Communication
(16, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- NSTP2 National Service Training Program 2
(16, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.00, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(16, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(16, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(16, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(16, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(16, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(16, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- PE103 Individual and Dual Sports

-- ============================================================
-- STUDENT 17: Carlos Miguel Torres
-- 3rd Year BSBA | Admitted: 2023-06-12 | Currently: 3rd Year, 1st Semester
-- Complete enrollment history: 1st Year to 3rd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(17, 1, '2023-2024', '1st Semester', '2023-08-14', 2.00, 'Passed'),   -- CC101 Introduction to Computing
(17, 2, '2023-2024', '1st Semester', '2023-08-14', 2.25, 'Passed'),   -- CC102 Computer Programming 1
(17, 3, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),   -- GEC01 Understanding the Self
(17, 4, '2023-2024', '1st Semester', '2023-08-14', 1.50, 'Passed'),   -- GEC02 Readings in Philippine History
(17, 5, '2023-2024', '1st Semester', '2023-08-14', 2.50, 'Passed'),   -- GEC03 Mathematics in the Modern World
(17, 6, '2023-2024', '1st Semester', '2023-08-14', 1.75, 'Passed'),   -- NSTP1 National Service Training Program 1
(17, 7, '2023-2024', '1st Semester', '2023-08-14', 1.25, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(17, 8, '2023-2024', '2nd Semester', '2024-01-08', 2.00, 'Passed'),   -- CC103 Computer Programming 2
(17, 9, '2023-2024', '2nd Semester', '2024-01-08', 2.25, 'Passed'),   -- CC104 Discrete Mathematics
(17, 10, '2023-2024', '2nd Semester', '2024-01-08', 1.75, 'Passed'),  -- GEC04 The Contemporary World
(17, 11, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),  -- GEC05 Purposive Communication
(17, 12, '2023-2024', '2nd Semester', '2024-01-08', 2.00, 'Passed'),  -- NSTP2 National Service Training Program 2
(17, 13, '2023-2024', '2nd Semester', '2024-01-08', 1.50, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(17, 14, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),  -- IT201 Data Structures and Algorithms
(17, 15, '2024-2025', '1st Semester', '2024-08-12', 2.25, 'Passed'),  -- IT202 Object-Oriented Programming
(17, 16, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- IT203 Database Management Systems 1
(17, 17, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),  -- IT204 Platform Technologies
(17, 18, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),  -- GEC06 Art Appreciation
(17, 19, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),  -- PE103 Individual and Dual Sports
-- 2nd Year, 2nd Semester (S.Y. 2024-2025)
(17, 20, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- IT205 Information Management
(17, 21, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),  -- IT206 Networking 1
(17, 22, '2024-2025', '2nd Semester', '2025-01-06', 2.25, 'Passed'),  -- IT207 Systems Analysis and Design
(17, 23, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- IT208 Web Development
(17, 24, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- GEC07 Ethics
(17, 25, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE104 Team Sports
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(17, 26, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT301 Applications Development
(17, 27, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT302 Integrative Programming
(17, 28, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT303 System Administration
(17, 29, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT304 Information Assurance 1
(17, 30, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- CAP01 Capstone Project 1

-- ============================================================
-- STUDENT 18: Bea Patricia Lopez
-- 1st Year BSIT | Admitted: 2025-06-10 | Currently: 1st Year, 1st Semester
-- New student - first semester enrollment only
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(18, 1, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC101 Introduction to Computing
(18, 2, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- CC102 Computer Programming 1
(18, 3, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC01 Understanding the Self
(18, 4, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC02 Readings in Philippine History
(18, 5, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- GEC03 Mathematics in the Modern World
(18, 6, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- NSTP1 National Service Training Program 1
(18, 7, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'),  -- PE101 Physical Fitness

-- ============================================================
-- STUDENT 19: Angelo James Ramos
-- 2nd Year BSCS | Admitted: 2024-06-15 | Currently: 2nd Year, 1st Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(19, 1, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- CC101 Introduction to Computing
(19, 2, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- CC102 Computer Programming 1
(19, 3, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),   -- GEC01 Understanding the Self
(19, 4, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- GEC02 Readings in Philippine History
(19, 5, '2024-2025', '1st Semester', '2024-08-12', 2.25, 'Passed'),   -- GEC03 Mathematics in the Modern World
(19, 6, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- NSTP1 National Service Training Program 1
(19, 7, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(19, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),   -- CC103 Computer Programming 2
(19, 9, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),   -- CC104 Discrete Mathematics
(19, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- GEC04 The Contemporary World
(19, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- GEC05 Purposive Communication
(19, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- NSTP2 National Service Training Program 2
(19, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(19, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(19, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(19, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(19, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(19, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(19, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- PE103 Individual and Dual Sports

-- ============================================================
-- STUDENT 20: Hannah Grace Flores
-- 2nd Year BSIT | Admitted: 2024-06-15 | Currently: 2nd Year, 1st Semester
-- Complete enrollment history: 1st Year to 2nd Year
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(20, 1, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- CC101 Introduction to Computing
(20, 2, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- CC102 Computer Programming 1
(20, 3, '2024-2025', '1st Semester', '2024-08-12', 1.25, 'Passed'),   -- GEC01 Understanding the Self
(20, 4, '2024-2025', '1st Semester', '2024-08-12', 1.50, 'Passed'),   -- GEC02 Readings in Philippine History
(20, 5, '2024-2025', '1st Semester', '2024-08-12', 2.00, 'Passed'),   -- GEC03 Mathematics in the Modern World
(20, 6, '2024-2025', '1st Semester', '2024-08-12', 1.75, 'Passed'),   -- NSTP1 National Service Training Program 1
(20, 7, '2024-2025', '1st Semester', '2024-08-12', 1.00, 'Passed'),   -- PE101 Physical Fitness
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(20, 8, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),   -- CC103 Computer Programming 2
(20, 9, '2024-2025', '2nd Semester', '2025-01-06', 2.00, 'Passed'),   -- CC104 Discrete Mathematics
(20, 10, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- GEC04 The Contemporary World
(20, 11, '2024-2025', '2nd Semester', '2025-01-06', 1.25, 'Passed'),  -- GEC05 Purposive Communication
(20, 12, '2024-2025', '2nd Semester', '2025-01-06', 1.75, 'Passed'),  -- NSTP2 National Service Training Program 2
(20, 13, '2024-2025', '2nd Semester', '2025-01-06', 1.50, 'Passed'),  -- PE102 Rhythmic Activities
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current Semester - In Progress
(20, 14, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT201 Data Structures and Algorithms
(20, 15, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT202 Object-Oriented Programming
(20, 16, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT203 Database Management Systems 1
(20, 17, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- IT204 Platform Technologies
(20, 18, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'), -- GEC06 Art Appreciation
(20, 19, '2025-2026', '1st Semester', '2025-08-11', NULL, 'Pending'); -- PE103 Individual and Dual Sports

-- ============================================================
-- PAYMENTS - Sample Payment Records with Complete History
-- Students 1-5 with payment history based on their year level
-- ============================================================

-- ============================================================
-- STUDENT 1: Reginald Cano
-- 2nd Year BSIT | Complete payment history: 1st Year to Current
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(1, 1, '2024-2025', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2024-08-10', 'Bank Transfer', 'BDO-2024-081001', 'Paid', '2024-08-15', 'Full payment for 1st sem'),
(1, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', 'Bank Transfer', 'BDO-2024-081002', 'Paid', '2024-08-15', NULL),
(1, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-10', 'Bank Transfer', 'BDO-2024-081003', 'Paid', '2024-08-15', NULL),
(1, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-10', 'Bank Transfer', 'BDO-2024-081004', 'Paid', '2024-08-15', NULL),
(1, 7, '2024-2025', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2024-08-10', 'Bank Transfer', 'BDO-2024-081005', 'Paid', '2024-08-15', NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(1, 1, '2024-2025', '2nd Semester', 'Tuition Fee (17 units x ₱1,500)', 25500.00, 25500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010501', 'Paid', '2025-01-10', 'Full payment via BDO online banking'),
(1, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010502', 'Paid', '2025-01-10', NULL),
(1, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010503', 'Paid', '2025-01-10', NULL),
(1, 7, '2024-2025', '2nd Semester', 'Energy Fee', 3500.00, 3500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010504', 'Paid', '2025-01-10', NULL),
(1, 8, '2024-2025', '2nd Semester', 'Student Insurance', 1500.00, 1500.00, '2025-01-05', 'Bank Transfer', 'BDO-2025-010505', 'Paid', '2025-01-10', NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Partial Payment
(1, 1, '2025-2026', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 15000.00, '2025-08-12', 'Bank Transfer', 'BDO-2025-081201', 'Partial', '2025-08-20', 'Initial payment - balance due'),
(1, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-12', 'Bank Transfer', 'BDO-2025-081202', 'Paid', '2025-08-20', NULL),
(1, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 0.00, NULL, NULL, NULL, 'Unpaid', '2025-08-20', NULL),
(1, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 0.00, NULL, NULL, NULL, 'Unpaid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 2: Kinley Lavina
-- 2nd Year BSCS | Complete payment history: 1st Year to Current
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(2, 1, '2024-2025', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2024-08-12', 'Installment', 'INST-2024-081201', 'Paid', '2024-08-15', 'Completed in 3 installments'),
(2, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-08', 'Cash', 'OR-2024-004521', 'Paid', '2024-08-15', NULL),
(2, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', 'Installment', 'INST-2024-081202', 'Paid', '2024-08-15', NULL),
(2, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-08', 'Cash', 'OR-2024-004522', 'Paid', '2024-08-15', NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(2, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2025-03-15', 'Installment', 'INST-2025-031501', 'Paid', '2025-01-10', 'Final installment completed'),
(2, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-08', 'Cash', 'OR-2025-005821', 'Paid', '2025-01-10', NULL),
(2, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-03-15', 'Installment', 'INST-2025-031502', 'Paid', '2025-01-10', NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(2, 1, '2025-2026', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-08-10', 'Online Payment', 'GCASH-2025-081001', 'Paid', '2025-08-20', 'GCash payment'),
(2, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-10', 'Online Payment', 'GCASH-2025-081002', 'Paid', '2025-08-20', NULL),
(2, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-10', 'Online Payment', 'GCASH-2025-081003', 'Paid', '2025-08-20', NULL),
(2, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-10', 'Online Payment', 'GCASH-2025-081004', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 3: Jeferson Cano
-- 4th Year BSIT | Complete payment history: 1st Year to Current (Scholar)
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2022-2023) - Fully Paid (Scholar)
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(3, 1, '2022-2023', '1st Semester', 'Tuition Fee (50% Scholar)', 15750.00, 15750.00, '2022-08-10', 'Scholarship', 'ACAD-SCHOLAR-2022-001', 'Paid', '2022-08-15', 'Academic scholarship - 50% discount'),
(3, 2, '2022-2023', '1st Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2022-08-10', 'Online Payment', 'GCASH-2022-081001', 'Paid', '2022-08-15', NULL),
(3, 3, '2022-2023', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2022-08-10', 'Online Payment', 'GCASH-2022-081002', 'Paid', '2022-08-15', NULL),
-- 1st Year, 2nd Semester (S.Y. 2022-2023) - Fully Paid
(3, 1, '2022-2023', '2nd Semester', 'Tuition Fee (50% Scholar)', 12750.00, 12750.00, '2023-01-08', 'Scholarship', 'ACAD-SCHOLAR-2023-001', 'Paid', '2023-01-10', NULL),
(3, 2, '2022-2023', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2023-01-08', 'Online Payment', 'GCASH-2023-010801', 'Paid', '2023-01-10', NULL),
(3, 3, '2022-2023', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2023-01-08', 'Online Payment', 'GCASH-2023-010802', 'Paid', '2023-01-10', NULL),
-- 2nd Year, 1st Semester (S.Y. 2023-2024) - Fully Paid
(3, 1, '2023-2024', '1st Semester', 'Tuition Fee (50% Scholar)', 13500.00, 13500.00, '2023-08-12', 'Scholarship', 'ACAD-SCHOLAR-2023-002', 'Paid', '2023-08-15', NULL),
(3, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-12', 'Online Payment', 'GCASH-2023-081201', 'Paid', '2023-08-15', NULL),
(3, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-12', 'Online Payment', 'GCASH-2023-081202', 'Paid', '2023-08-15', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2023-2024) - Fully Paid
(3, 1, '2023-2024', '2nd Semester', 'Tuition Fee (50% Scholar)', 13500.00, 13500.00, '2024-01-05', 'Scholarship', 'ACAD-SCHOLAR-2024-001', 'Paid', '2024-01-10', NULL),
(3, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-05', 'Online Payment', 'GCASH-2024-010501', 'Paid', '2024-01-10', NULL),
(3, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-05', 'Online Payment', 'GCASH-2024-010502', 'Paid', '2024-01-10', NULL),
-- 3rd Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(3, 1, '2024-2025', '1st Semester', 'Tuition Fee (50% Scholar)', 13500.00, 13500.00, '2024-08-08', 'Scholarship', 'ACAD-SCHOLAR-2024-002', 'Paid', '2024-08-15', NULL),
(3, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5500.00, 5500.00, '2024-08-08', 'Online Payment', 'GCASH-2024-080801', 'Paid', '2024-08-15', NULL),
(3, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9000.00, 9000.00, '2024-08-08', 'Online Payment', 'GCASH-2024-080802', 'Paid', '2024-08-15', NULL),
-- 3rd Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(3, 1, '2024-2025', '2nd Semester', 'Tuition Fee (50% Scholar)', 12750.00, 12750.00, '2025-01-04', 'Scholarship', 'ACAD-SCHOLAR-2025-001', 'Paid', '2025-01-10', 'Academic scholarship - 50% discount'),
(3, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 4500.00, 4500.00, '2025-01-04', 'Online Payment', 'GCASH-2025-010401', 'Paid', '2025-01-10', NULL),
(3, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-04', 'Online Payment', 'GCASH-2025-010402', 'Paid', '2025-01-10', NULL),
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(3, 1, '2025-2026', '1st Semester', 'Tuition Fee (50% Scholar)', 12000.00, 12000.00, '2025-08-11', 'Scholarship', 'ACAD-SCHOLAR-2025-002', 'Paid', '2025-08-20', NULL),
(3, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5500.00, 5500.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081101', 'Paid', '2025-08-20', NULL),
(3, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9000.00, 9000.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081102', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 4: Gester Macaldo
-- 3rd Year BSCS | Complete payment history: 1st Year to Current
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(4, 1, '2023-2024', '1st Semester', 'Tuition Fee (21 units x ₱1,800)', 37800.00, 37800.00, '2023-08-14', 'Bank Transfer', 'BPI-2023-081401', 'Paid', '2023-08-20', 'Full payment'),
(4, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2023-08-14', 'Bank Transfer', 'BPI-2023-081402', 'Paid', '2023-08-20', NULL),
(4, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2023-08-14', 'Bank Transfer', 'BPI-2023-081403', 'Paid', '2023-08-20', NULL),
(4, 4, '2023-2024', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2023-08-14', 'Bank Transfer', 'BPI-2023-081404', 'Paid', '2023-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024) - Fully Paid
(4, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-01-08', 'Bank Transfer', 'BPI-2024-010801', 'Paid', '2024-01-15', NULL),
(4, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-01-08', 'Bank Transfer', 'BPI-2024-010802', 'Paid', '2024-01-15', NULL),
(4, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-01-08', 'Bank Transfer', 'BPI-2024-010803', 'Paid', '2024-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(4, 1, '2024-2025', '1st Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-08-12', 'Bank Transfer', 'BPI-2024-081201', 'Paid', '2024-08-20', NULL),
(4, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-08-12', 'Bank Transfer', 'BPI-2024-081202', 'Paid', '2024-08-20', NULL),
(4, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-08-12', 'Bank Transfer', 'BPI-2024-081203', 'Paid', '2024-08-20', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(4, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010601', 'Paid', '2025-01-10', NULL),
(4, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010602', 'Paid', '2025-01-10', NULL),
(4, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-06', 'Bank Transfer', 'BPI-2025-010603', 'Paid', '2025-01-10', NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(4, 1, '2025-2026', '1st Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-08-11', 'Bank Transfer', 'BPI-2025-081101', 'Paid', '2025-08-20', NULL),
(4, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-08-11', 'Bank Transfer', 'BPI-2025-081102', 'Paid', '2025-08-20', NULL),
(4, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-08-11', 'Bank Transfer', 'BPI-2025-081103', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 5: Isaac Ganolo
-- 1st Year BSIT | Only current semester (new student)
-- ============================================================
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(5, 1, '2025-2026', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2025-08-10', 'Bank Transfer', 'BPI-2025-081001', 'Paid', '2025-08-20', 'Full payment by parents'),
(5, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-10', 'Bank Transfer', 'BPI-2025-081002', 'Paid', '2025-08-20', NULL),
(5, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-10', 'Bank Transfer', 'BPI-2025-081003', 'Paid', '2025-08-20', NULL),
(5, 4, '2025-2026', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-08-10', 'Bank Transfer', 'BPI-2025-081004', 'Paid', '2025-08-20', NULL),
(5, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-10', 'Bank Transfer', 'BPI-2025-081005', 'Paid', '2025-08-20', NULL),
(5, 8, '2025-2026', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2025-08-10', 'Bank Transfer', 'BPI-2025-081006', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 6: Patricia Anne Santos
-- 2nd Year BSIS | Complete payment history: 1st Year to Current
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(6, 1, '2024-2025', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2024-08-11', 'Online Payment', 'MAYA-2024-081101', 'Paid', '2024-08-15', 'Maya payment'),
(6, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-11', 'Online Payment', 'MAYA-2024-081102', 'Paid', '2024-08-15', NULL),
(6, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-11', 'Online Payment', 'MAYA-2024-081103', 'Paid', '2024-08-15', NULL),
(6, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-11', 'Online Payment', 'MAYA-2024-081104', 'Paid', '2024-08-15', NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(6, 1, '2024-2025', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010701', 'Paid', '2025-01-10', NULL),
(6, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010702', 'Paid', '2025-01-10', NULL),
(6, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010703', 'Paid', '2025-01-10', NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(6, 1, '2025-2026', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-08-12', 'Online Payment', 'MAYA-2025-081201', 'Paid', '2025-08-20', NULL),
(6, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-12', 'Online Payment', 'MAYA-2025-081202', 'Paid', '2025-08-20', NULL),
(6, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-12', 'Online Payment', 'MAYA-2025-081203', 'Paid', '2025-08-20', NULL),
(6, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-12', 'Online Payment', 'MAYA-2025-081204', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 7: Miguel Angelo Cruz
-- 1st Year BSCE | Only current semester (new student)
-- ============================================================
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(7, 1, '2025-2026', '1st Semester', 'Tuition Fee (21 units x ₱1,800)', 37800.00, 20000.00, '2025-08-11', 'Installment', 'INST-2025-081101', 'Partial', '2025-08-20', 'First installment - balance due Oct 2025'),
(7, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-08-11', 'Cash', 'OR-2025-007201', 'Paid', '2025-08-20', NULL),
(7, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9500.00, 5000.00, '2025-08-11', 'Installment', 'INST-2025-081102', 'Partial', '2025-08-20', NULL),
(7, 4, '2025-2026', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', 'Cash', 'OR-2025-007202', 'Paid', '2025-08-20', NULL),
(7, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 0.00, NULL, NULL, NULL, 'Unpaid', '2025-08-20', 'Due upon next installment');

-- ============================================================
-- STUDENT 8: Maria Clara Reyes
-- 2nd Year BSIT | Complete payment history: 1st Year to Current
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(8, 1, '2024-2025', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2024-08-10', 'Bank Transfer', 'UB-2024-081001', 'Paid', '2024-08-15', 'UnionBank transfer'),
(8, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', 'Bank Transfer', 'UB-2024-081002', 'Paid', '2024-08-15', NULL),
(8, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-10', 'Bank Transfer', 'UB-2024-081003', 'Paid', '2024-08-15', NULL),
(8, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-10', 'Bank Transfer', 'UB-2024-081004', 'Paid', '2024-08-15', NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(8, 1, '2024-2025', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-01-06', 'Bank Transfer', 'UB-2025-010601', 'Paid', '2025-01-10', NULL),
(8, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', 'Bank Transfer', 'UB-2025-010602', 'Paid', '2025-01-10', NULL),
(8, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', 'Bank Transfer', 'UB-2025-010603', 'Paid', '2025-01-10', NULL),
(8, 7, '2024-2025', '2nd Semester', 'Energy Fee', 3500.00, 3500.00, '2025-01-06', 'Bank Transfer', 'UB-2025-010604', 'Paid', '2025-01-10', NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(8, 1, '2025-2026', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-08-10', 'Bank Transfer', 'UB-2025-081001', 'Paid', '2025-08-20', NULL),
(8, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-10', 'Bank Transfer', 'UB-2025-081002', 'Paid', '2025-08-20', NULL),
(8, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-10', 'Bank Transfer', 'UB-2025-081003', 'Paid', '2025-08-20', NULL),
(8, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-10', 'Bank Transfer', 'UB-2025-081004', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 9: John Patrick Villanueva
-- 3rd Year BSCS | Complete payment history: 1st Year to Current
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(9, 1, '2023-2024', '1st Semester', 'Tuition Fee (21 units x ₱1,800)', 37800.00, 37800.00, '2023-08-12', 'Cash', 'OR-2023-009101', 'Paid', '2023-08-20', 'Full cash payment'),
(9, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2023-08-12', 'Cash', 'OR-2023-009102', 'Paid', '2023-08-20', NULL),
(9, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2023-08-12', 'Cash', 'OR-2023-009103', 'Paid', '2023-08-20', NULL),
(9, 4, '2023-2024', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2023-08-12', 'Cash', 'OR-2023-009104', 'Paid', '2023-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024) - Fully Paid
(9, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-01-08', 'Cash', 'OR-2024-009201', 'Paid', '2024-01-15', NULL),
(9, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-01-08', 'Cash', 'OR-2024-009202', 'Paid', '2024-01-15', NULL),
(9, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-01-08', 'Cash', 'OR-2024-009203', 'Paid', '2024-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(9, 1, '2024-2025', '1st Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-08-14', 'Online Payment', 'GCASH-2024-081401', 'Paid', '2024-08-20', NULL),
(9, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-08-14', 'Online Payment', 'GCASH-2024-081402', 'Paid', '2024-08-20', NULL),
(9, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-08-14', 'Online Payment', 'GCASH-2024-081403', 'Paid', '2024-08-20', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(9, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-01-06', 'Online Payment', 'GCASH-2025-010601', 'Paid', '2025-01-10', NULL),
(9, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-06', 'Online Payment', 'GCASH-2025-010602', 'Paid', '2025-01-10', NULL),
(9, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-06', 'Online Payment', 'GCASH-2025-010603', 'Paid', '2025-01-10', NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(9, 1, '2025-2026', '1st Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081101', 'Paid', '2025-08-20', NULL),
(9, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081102', 'Paid', '2025-08-20', NULL),
(9, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081103', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 10: Angela Rose Dimaculangan
-- 1st Year BSA | Only current semester (new student)
-- ============================================================
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(10, 1, '2025-2026', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2025-08-09', 'Bank Transfer', 'MET-2025-080901', 'Paid', '2025-08-20', 'Metrobank transfer'),
(10, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-09', 'Bank Transfer', 'MET-2025-080902', 'Paid', '2025-08-20', NULL),
(10, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-09', 'Bank Transfer', 'MET-2025-080903', 'Paid', '2025-08-20', NULL),
(10, 4, '2025-2026', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-08-09', 'Bank Transfer', 'MET-2025-080904', 'Paid', '2025-08-20', NULL),
(10, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-09', 'Bank Transfer', 'MET-2025-080905', 'Paid', '2025-08-20', NULL),
(10, 8, '2025-2026', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2025-08-09', 'Bank Transfer', 'MET-2025-080906', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 11: Kevin James Hernandez
-- 4th Year BSIT | Complete payment history: 1st Year to Current
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2022-2023) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(11, 1, '2022-2023', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2022-08-15', 'Cash', 'OR-2022-011101', 'Paid', '2022-08-20', NULL),
(11, 2, '2022-2023', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2022-08-15', 'Cash', 'OR-2022-011102', 'Paid', '2022-08-20', NULL),
(11, 3, '2022-2023', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2022-08-15', 'Cash', 'OR-2022-011103', 'Paid', '2022-08-20', NULL),
(11, 4, '2022-2023', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2022-08-15', 'Cash', 'OR-2022-011104', 'Paid', '2022-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2022-2023) - Fully Paid
(11, 1, '2022-2023', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2023-01-10', 'Cash', 'OR-2023-011201', 'Paid', '2023-01-15', NULL),
(11, 2, '2022-2023', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-01-10', 'Cash', 'OR-2023-011202', 'Paid', '2023-01-15', NULL),
(11, 3, '2022-2023', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2023-01-10', 'Cash', 'OR-2023-011203', 'Paid', '2023-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2023-2024) - Fully Paid
(11, 1, '2023-2024', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2023-08-12', 'Bank Transfer', 'BDO-2023-081201', 'Paid', '2023-08-20', NULL),
(11, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-12', 'Bank Transfer', 'BDO-2023-081202', 'Paid', '2023-08-20', NULL),
(11, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-12', 'Bank Transfer', 'BDO-2023-081203', 'Paid', '2023-08-20', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2023-2024) - Fully Paid
(11, 1, '2023-2024', '2nd Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010801', 'Paid', '2024-01-15', NULL),
(11, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010802', 'Paid', '2024-01-15', NULL),
(11, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-08', 'Bank Transfer', 'BDO-2024-010803', 'Paid', '2024-01-15', NULL),
-- 3rd Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(11, 1, '2024-2025', '1st Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2024-08-11', 'Bank Transfer', 'BDO-2024-081101', 'Paid', '2024-08-20', NULL),
(11, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-11', 'Bank Transfer', 'BDO-2024-081102', 'Paid', '2024-08-20', NULL),
(11, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-11', 'Bank Transfer', 'BDO-2024-081103', 'Paid', '2024-08-20', NULL),
-- 3rd Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(11, 1, '2024-2025', '2nd Semester', 'Tuition Fee (12 units x ₱1,500)', 18000.00, 18000.00, '2025-01-07', 'Bank Transfer', 'BDO-2025-010701', 'Paid', '2025-01-10', NULL),
(11, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-07', 'Bank Transfer', 'BDO-2025-010702', 'Paid', '2025-01-10', NULL),
(11, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-07', 'Bank Transfer', 'BDO-2025-010703', 'Paid', '2025-01-10', NULL),
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(11, 1, '2025-2026', '1st Semester', 'Tuition Fee (12 units x ₱1,500)', 18000.00, 18000.00, '2025-08-10', 'Bank Transfer', 'BDO-2025-081001', 'Paid', '2025-08-20', NULL),
(11, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-10', 'Bank Transfer', 'BDO-2025-081002', 'Paid', '2025-08-20', NULL),
(11, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-10', 'Bank Transfer', 'BDO-2025-081003', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 12: Samantha Louise Tan
-- 3rd Year BSCS (Scholar) | Full scholarship covers tuition
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024) - Scholarship
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(12, 1, '2023-2024', '1st Semester', 'Tuition Fee (21 units x ₱1,800)', 37800.00, 37800.00, '2023-08-10', 'Scholarship', 'DOST-2023-081001', 'Paid', '2023-08-20', 'DOST-SEI Scholarship'),
(12, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2023-08-10', 'Cash', 'OR-2023-012101', 'Paid', '2023-08-20', NULL),
(12, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2023-08-10', 'Cash', 'OR-2023-012102', 'Paid', '2023-08-20', NULL),
(12, 4, '2023-2024', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2023-08-10', 'Cash', 'OR-2023-012103', 'Paid', '2023-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024) - Scholarship
(12, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-01-06', 'Scholarship', 'DOST-2024-010601', 'Paid', '2024-01-15', 'DOST-SEI Scholarship'),
(12, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-01-06', 'Cash', 'OR-2024-012201', 'Paid', '2024-01-15', NULL),
(12, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-01-06', 'Cash', 'OR-2024-012202', 'Paid', '2024-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025) - Scholarship
(12, 1, '2024-2025', '1st Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-08-09', 'Scholarship', 'DOST-2024-080901', 'Paid', '2024-08-20', 'DOST-SEI Scholarship'),
(12, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-08-09', 'Online Payment', 'GCASH-2024-080901', 'Paid', '2024-08-20', NULL),
(12, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-08-09', 'Online Payment', 'GCASH-2024-080902', 'Paid', '2024-08-20', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2024-2025) - Scholarship
(12, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-01-05', 'Scholarship', 'DOST-2025-010501', 'Paid', '2025-01-10', 'DOST-SEI Scholarship'),
(12, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-05', 'Online Payment', 'GCASH-2025-010501', 'Paid', '2025-01-10', NULL),
(12, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-05', 'Online Payment', 'GCASH-2025-010502', 'Paid', '2025-01-10', NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current - Scholarship
(12, 1, '2025-2026', '1st Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-08-08', 'Scholarship', 'DOST-2025-080801', 'Paid', '2025-08-20', 'DOST-SEI Scholarship'),
(12, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-08-08', 'Online Payment', 'GCASH-2025-080801', 'Paid', '2025-08-20', NULL),
(12, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-08-08', 'Online Payment', 'GCASH-2025-080802', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 13: Robert Carl Mendoza
-- 2nd Year BSIT | Complete payment history
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(13, 1, '2024-2025', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2024-08-14', 'Online Payment', 'GCASH-2024-081401', 'Paid', '2024-08-20', NULL),
(13, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-14', 'Online Payment', 'GCASH-2024-081402', 'Paid', '2024-08-20', NULL),
(13, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-14', 'Online Payment', 'GCASH-2024-081403', 'Paid', '2024-08-20', NULL),
(13, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-14', 'Online Payment', 'GCASH-2024-081404', 'Paid', '2024-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(13, 1, '2024-2025', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-01-09', 'Online Payment', 'GCASH-2025-010901', 'Paid', '2025-01-15', NULL),
(13, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-09', 'Online Payment', 'GCASH-2025-010902', 'Paid', '2025-01-15', NULL),
(13, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-09', 'Online Payment', 'GCASH-2025-010903', 'Paid', '2025-01-15', NULL),
(13, 7, '2024-2025', '2nd Semester', 'Energy Fee', 3500.00, 3500.00, '2025-01-09', 'Online Payment', 'GCASH-2025-010904', 'Paid', '2025-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(13, 1, '2025-2026', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-08-13', 'Online Payment', 'GCASH-2025-081301', 'Paid', '2025-08-20', NULL),
(13, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-13', 'Online Payment', 'GCASH-2025-081302', 'Paid', '2025-08-20', NULL),
(13, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-13', 'Online Payment', 'GCASH-2025-081303', 'Paid', '2025-08-20', NULL),
(13, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-13', 'Online Payment', 'GCASH-2025-081304', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 14: Christine Joy Aquino
-- 1st Year BSIS | Only current semester (new student)
-- ============================================================
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(14, 1, '2025-2026', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2025-08-08', 'Cash', 'OR-2025-014101', 'Paid', '2025-08-20', 'Full cash payment'),
(14, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-08', 'Cash', 'OR-2025-014102', 'Paid', '2025-08-20', NULL),
(14, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-08', 'Cash', 'OR-2025-014103', 'Paid', '2025-08-20', NULL),
(14, 4, '2025-2026', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-08-08', 'Cash', 'OR-2025-014104', 'Paid', '2025-08-20', NULL),
(14, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-08', 'Cash', 'OR-2025-014105', 'Paid', '2025-08-20', NULL),
(14, 8, '2025-2026', '1st Semester', 'Student Insurance', 1500.00, 1500.00, '2025-08-08', 'Cash', 'OR-2025-014106', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 15: Mark Anthony Dela Cruz
-- 3rd Year BSCS | Complete payment history with balance
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(15, 1, '2023-2024', '1st Semester', 'Tuition Fee (21 units x ₱1,800)', 37800.00, 37800.00, '2023-08-14', 'Installment', 'INST-2023-081401', 'Paid', '2023-08-20', 'Completed in 3 payments'),
(15, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2023-08-14', 'Cash', 'OR-2023-015101', 'Paid', '2023-08-20', NULL),
(15, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2023-08-14', 'Cash', 'OR-2023-015102', 'Paid', '2023-08-20', NULL),
(15, 4, '2023-2024', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2023-08-14', 'Cash', 'OR-2023-015103', 'Paid', '2023-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024) - Fully Paid
(15, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-01-10', 'Installment', 'INST-2024-011001', 'Paid', '2024-01-15', NULL),
(15, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-01-10', 'Cash', 'OR-2024-015201', 'Paid', '2024-01-15', NULL),
(15, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-01-10', 'Cash', 'OR-2024-015202', 'Paid', '2024-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(15, 1, '2024-2025', '1st Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2024-08-13', 'Installment', 'INST-2024-081301', 'Paid', '2024-08-20', NULL),
(15, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-08-13', 'Online Payment', 'GCASH-2024-081301', 'Paid', '2024-08-20', NULL),
(15, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-08-13', 'Online Payment', 'GCASH-2024-081302', 'Paid', '2024-08-20', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(15, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2025-01-08', 'Installment', 'INST-2025-010801', 'Paid', '2025-01-15', NULL),
(15, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-08', 'Online Payment', 'GCASH-2025-010801', 'Paid', '2025-01-15', NULL),
(15, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-08', 'Online Payment', 'GCASH-2025-010802', 'Paid', '2025-01-15', NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current - Has Balance
(15, 1, '2025-2026', '1st Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 15000.00, '2025-08-12', 'Installment', 'INST-2025-081201', 'Partial', '2025-08-20', 'First installment - balance ₱12,000 due Nov 2025'),
(15, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-08-12', 'Online Payment', 'GCASH-2025-081201', 'Paid', '2025-08-20', NULL),
(15, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-08-12', 'Online Payment', 'GCASH-2025-081202', 'Paid', '2025-08-20', NULL),
(15, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 0.00, NULL, NULL, NULL, 'Unpaid', '2025-08-20', 'Due upon next installment');

-- ============================================================
-- STUDENT 16: Princess Mae Garcia
-- 2nd Year BSIT | Complete payment history
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(16, 1, '2024-2025', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2024-08-09', 'Bank Transfer', 'PNB-2024-080901', 'Paid', '2024-08-15', 'PNB transfer'),
(16, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-09', 'Bank Transfer', 'PNB-2024-080902', 'Paid', '2024-08-15', NULL),
(16, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-09', 'Bank Transfer', 'PNB-2024-080903', 'Paid', '2024-08-15', NULL),
(16, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-09', 'Bank Transfer', 'PNB-2024-080904', 'Paid', '2024-08-15', NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(16, 1, '2024-2025', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-01-06', 'Bank Transfer', 'PNB-2025-010601', 'Paid', '2025-01-10', NULL),
(16, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', 'Bank Transfer', 'PNB-2025-010602', 'Paid', '2025-01-10', NULL),
(16, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', 'Bank Transfer', 'PNB-2025-010603', 'Paid', '2025-01-10', NULL),
(16, 7, '2024-2025', '2nd Semester', 'Energy Fee', 3500.00, 3500.00, '2025-01-06', 'Bank Transfer', 'PNB-2025-010604', 'Paid', '2025-01-10', NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(16, 1, '2025-2026', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2025-08-09', 'Bank Transfer', 'PNB-2025-080901', 'Paid', '2025-08-20', NULL),
(16, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-09', 'Bank Transfer', 'PNB-2025-080902', 'Paid', '2025-08-20', NULL),
(16, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-09', 'Bank Transfer', 'PNB-2025-080903', 'Paid', '2025-08-20', NULL),
(16, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-09', 'Bank Transfer', 'PNB-2025-080904', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 17: Joshua Emmanuel Ramos
-- 4th Year BSCS (Dean's Lister) | Complete payment history
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2022-2023) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(17, 1, '2022-2023', '1st Semester', 'Tuition Fee (21 units x ₱1,800)', 37800.00, 37800.00, '2022-08-10', 'Bank Transfer', 'BPI-2022-081001', 'Paid', '2022-08-20', NULL),
(17, 2, '2022-2023', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2022-08-10', 'Bank Transfer', 'BPI-2022-081002', 'Paid', '2022-08-20', NULL),
(17, 3, '2022-2023', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2022-08-10', 'Bank Transfer', 'BPI-2022-081003', 'Paid', '2022-08-20', NULL),
(17, 4, '2022-2023', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2022-08-10', 'Bank Transfer', 'BPI-2022-081004', 'Paid', '2022-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2022-2023) - Fully Paid
(17, 1, '2022-2023', '2nd Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2023-01-09', 'Bank Transfer', 'BPI-2023-010901', 'Paid', '2023-01-15', NULL),
(17, 2, '2022-2023', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2023-01-09', 'Bank Transfer', 'BPI-2023-010902', 'Paid', '2023-01-15', NULL),
(17, 3, '2022-2023', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2023-01-09', 'Bank Transfer', 'BPI-2023-010903', 'Paid', '2023-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2023-2024) - Fully Paid
(17, 1, '2023-2024', '1st Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2023-08-11', 'Bank Transfer', 'BPI-2023-081101', 'Paid', '2023-08-20', NULL),
(17, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2023-08-11', 'Bank Transfer', 'BPI-2023-081102', 'Paid', '2023-08-20', NULL),
(17, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2023-08-11', 'Bank Transfer', 'BPI-2023-081103', 'Paid', '2023-08-20', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2023-2024) - Fully Paid
(17, 1, '2023-2024', '2nd Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2024-01-08', 'Bank Transfer', 'BPI-2024-010801', 'Paid', '2024-01-15', NULL),
(17, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-01-08', 'Bank Transfer', 'BPI-2024-010802', 'Paid', '2024-01-15', NULL),
(17, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-01-08', 'Bank Transfer', 'BPI-2024-010803', 'Paid', '2024-01-15', NULL),
-- 3rd Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(17, 1, '2024-2025', '1st Semester', 'Tuition Fee (15 units x ₱1,800)', 27000.00, 27000.00, '2024-08-10', 'Bank Transfer', 'BPI-2024-081001', 'Paid', '2024-08-20', NULL),
(17, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-08-10', 'Bank Transfer', 'BPI-2024-081002', 'Paid', '2024-08-20', NULL),
(17, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-08-10', 'Bank Transfer', 'BPI-2024-081003', 'Paid', '2024-08-20', NULL),
-- 3rd Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(17, 1, '2024-2025', '2nd Semester', 'Tuition Fee (12 units x ₱1,800)', 21600.00, 21600.00, '2025-01-07', 'Bank Transfer', 'BPI-2025-010701', 'Paid', '2025-01-10', NULL),
(17, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-07', 'Bank Transfer', 'BPI-2025-010702', 'Paid', '2025-01-10', NULL),
(17, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-07', 'Bank Transfer', 'BPI-2025-010703', 'Paid', '2025-01-10', NULL),
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(17, 1, '2025-2026', '1st Semester', 'Tuition Fee (12 units x ₱1,800)', 21600.00, 21600.00, '2025-08-09', 'Bank Transfer', 'BPI-2025-080901', 'Paid', '2025-08-20', NULL),
(17, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-08-09', 'Bank Transfer', 'BPI-2025-080902', 'Paid', '2025-08-20', NULL),
(17, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-08-09', 'Bank Transfer', 'BPI-2025-080903', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 18: Nicole Ann Fernandez
-- 1st Year BSIT | Only current semester (new student)
-- ============================================================
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(18, 1, '2025-2026', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081101', 'Paid', '2025-08-20', NULL),
(18, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081102', 'Paid', '2025-08-20', NULL),
(18, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081103', 'Paid', '2025-08-20', NULL),
(18, 4, '2025-2026', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081104', 'Paid', '2025-08-20', NULL),
(18, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-11', 'Online Payment', 'GCASH-2025-081105', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 19: Carlo Miguel Santos
-- 3rd Year BSIS | Complete payment history
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2023-2024) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(19, 1, '2023-2024', '1st Semester', 'Tuition Fee (21 units x ₱1,500)', 31500.00, 31500.00, '2023-08-11', 'Cash', 'OR-2023-019101', 'Paid', '2023-08-20', NULL),
(19, 2, '2023-2024', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-11', 'Cash', 'OR-2023-019102', 'Paid', '2023-08-20', NULL),
(19, 3, '2023-2024', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-11', 'Cash', 'OR-2023-019103', 'Paid', '2023-08-20', NULL),
(19, 4, '2023-2024', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2023-08-11', 'Cash', 'OR-2023-019104', 'Paid', '2023-08-20', NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024) - Fully Paid
(19, 1, '2023-2024', '2nd Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2024-01-09', 'Cash', 'OR-2024-019201', 'Paid', '2024-01-15', NULL),
(19, 2, '2023-2024', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-09', 'Cash', 'OR-2024-019202', 'Paid', '2024-01-15', NULL),
(19, 3, '2023-2024', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-09', 'Cash', 'OR-2024-019203', 'Paid', '2024-01-15', NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(19, 1, '2024-2025', '1st Semester', 'Tuition Fee (18 units x ₱1,500)', 27000.00, 27000.00, '2024-08-12', 'Online Payment', 'MAYA-2024-081201', 'Paid', '2024-08-20', NULL),
(19, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', 'Online Payment', 'MAYA-2024-081202', 'Paid', '2024-08-20', NULL),
(19, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', 'Online Payment', 'MAYA-2024-081203', 'Paid', '2024-08-20', NULL),
-- 2nd Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(19, 1, '2024-2025', '2nd Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010701', 'Paid', '2025-01-10', NULL),
(19, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010702', 'Paid', '2025-01-10', NULL),
(19, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-07', 'Online Payment', 'MAYA-2025-010703', 'Paid', '2025-01-10', NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current - Fully Paid
(19, 1, '2025-2026', '1st Semester', 'Tuition Fee (15 units x ₱1,500)', 22500.00, 22500.00, '2025-08-10', 'Online Payment', 'MAYA-2025-081001', 'Paid', '2025-08-20', NULL),
(19, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-10', 'Online Payment', 'MAYA-2025-081002', 'Paid', '2025-08-20', NULL),
(19, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-10', 'Online Payment', 'MAYA-2025-081003', 'Paid', '2025-08-20', NULL),
(19, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 3500.00, '2025-08-10', 'Online Payment', 'MAYA-2025-081004', 'Paid', '2025-08-20', NULL);

-- ============================================================
-- STUDENT 20: Anna Marie Lim
-- 2nd Year BSCS | Complete payment history with balance
-- ============================================================
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
INSERT INTO payments (student_id, payment_type_id, academic_year, semester, description, amount_due, amount_paid, payment_date, payment_method, reference_number, payment_status, due_date, remarks) VALUES
(20, 1, '2024-2025', '1st Semester', 'Tuition Fee (21 units x ₱1,800)', 37800.00, 37800.00, '2024-08-10', 'Bank Transfer', 'SEC-2024-081001', 'Paid', '2024-08-15', 'Security Bank transfer'),
(20, 2, '2024-2025', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2024-08-10', 'Bank Transfer', 'SEC-2024-081002', 'Paid', '2024-08-15', NULL),
(20, 3, '2024-2025', '1st Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2024-08-10', 'Bank Transfer', 'SEC-2024-081003', 'Paid', '2024-08-15', NULL),
(20, 4, '2024-2025', '1st Semester', 'NSTP Fee', 1000.00, 1000.00, '2024-08-10', 'Bank Transfer', 'SEC-2024-081004', 'Paid', '2024-08-15', NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(20, 1, '2024-2025', '2nd Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 32400.00, '2025-01-08', 'Bank Transfer', 'SEC-2025-010801', 'Paid', '2025-01-10', NULL),
(20, 2, '2024-2025', '2nd Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-01-08', 'Bank Transfer', 'SEC-2025-010802', 'Paid', '2025-01-10', NULL),
(20, 3, '2024-2025', '2nd Semester', 'Miscellaneous Fee', 9500.00, 9500.00, '2025-01-08', 'Bank Transfer', 'SEC-2025-010803', 'Paid', '2025-01-10', NULL),
(20, 7, '2024-2025', '2nd Semester', 'Energy Fee', 3500.00, 3500.00, '2025-01-08', 'Bank Transfer', 'SEC-2025-010804', 'Paid', '2025-01-10', NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Has Balance
(20, 1, '2025-2026', '1st Semester', 'Tuition Fee (18 units x ₱1,800)', 32400.00, 20000.00, '2025-08-11', 'Installment', 'INST-2025-081101', 'Partial', '2025-08-20', 'First installment - balance ₱12,400 due Oct 2025'),
(20, 2, '2025-2026', '1st Semester', 'Computer Laboratory Fee', 6000.00, 6000.00, '2025-08-11', 'Bank Transfer', 'SEC-2025-081101', 'Paid', '2025-08-20', NULL),
(20, 3, '2025-2026', '1st Semester', 'Miscellaneous Fee', 9500.00, 5000.00, '2025-08-11', 'Installment', 'INST-2025-081102', 'Partial', '2025-08-20', 'Balance ₱4,500'),
(20, 7, '2025-2026', '1st Semester', 'Energy Fee', 3500.00, 0.00, NULL, NULL, NULL, 'Unpaid', '2025-08-20', 'Due upon next installment'),
(20, 8, '2025-2026', '1st Semester', 'Student Insurance', 1500.00, 0.00, NULL, NULL, NULL, 'Unpaid', '2025-08-20', NULL);

-- ============================================================
-- End of Sample Data
-- ============================================================
