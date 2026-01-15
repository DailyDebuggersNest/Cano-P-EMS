-- ============================================================
-- STUDENT INFORMATION SYSTEM (SIS) - SAMPLE DATA
-- ============================================================
-- Version: 2.0.0
-- Compatible with: sis_schema.sql v2.0.0
-- 
-- This file contains sample data for testing and development.
-- Run sis_schema.sql first to create the database structure.
--
-- DATA ORDER (respecting foreign key dependencies):
--   1. departments
--   2. programs
--   3. academic_years
--   4. curriculum
--   5. instructors
--   6. payment_types
--   7. users
--   8. students
--   9. student_programs
--  10. enrollments
--  11. class_schedules
--  12. payments
-- ============================================================

USE ems_O6;

-- Disable foreign key checks for clean insertion
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- DEPARTMENTS
-- ============================================================
INSERT INTO departments (department_id, department_code, department_name, college, dean_name, contact_email, contact_phone, office_location, is_active) VALUES
(1, 'CCS', 'College of Computing Studies', 'College of Computing Studies', 'Dr. Juan Dela Cruz', 'ccs@university.edu.ph', '+63 2 8123 4567', 'IT Building, 3rd Floor', TRUE),
(2, 'COE', 'College of Engineering', 'College of Engineering', 'Dr. Maria Santos', 'coe@university.edu.ph', '+63 2 8123 4568', 'Engineering Building, 2nd Floor', TRUE),
(3, 'COB', 'College of Business', 'College of Business', 'Dr. Pedro Reyes', 'cob@university.edu.ph', '+63 2 8123 4569', 'Business Building, 1st Floor', TRUE),
(4, 'CAS', 'College of Arts and Sciences', 'College of Arts and Sciences', 'Dr. Elena Garcia', 'cas@university.edu.ph', '+63 2 8123 4570', 'Liberal Arts Building, 2nd Floor', TRUE);

-- ============================================================
-- PROGRAMS
-- ============================================================
INSERT INTO programs (program_id, program_code, program_name, department_id, degree_type, description, total_units, years_duration, is_active, accreditation_status) VALUES
(1, 'BSIT', 'Bachelor of Science in Information Technology', 1, 'Bachelor', 'Information Technology program focused on software development and IT infrastructure', 160, 4, TRUE, 'Level II'),
(2, 'BSCS', 'Bachelor of Science in Computer Science', 1, 'Bachelor', 'Computer Science program with focus on algorithms and computational theory', 165, 4, TRUE, 'Level III'),
(3, 'BSIS', 'Bachelor of Science in Information Systems', 1, 'Bachelor', 'Information Systems program bridging IT and business processes', 155, 4, TRUE, 'Level I'),
(4, 'BSCE', 'Bachelor of Science in Computer Engineering', 2, 'Bachelor', 'Computer Engineering program combining hardware and software engineering', 180, 5, TRUE, 'Level II'),
(5, 'BSA', 'Bachelor of Science in Accountancy', 3, 'Bachelor', 'Accountancy program preparing students for CPA licensure', 170, 4, TRUE, 'Level III'),
(6, 'BSBA', 'Bachelor of Science in Business Administration', 3, 'Bachelor', 'Business Administration program with various specializations', 150, 4, TRUE, 'Level II');

-- ============================================================
-- ACADEMIC YEARS
-- ============================================================
INSERT INTO academic_years (academic_year_id, academic_year, semester, start_date, end_date, enrollment_start, enrollment_end, is_current, status) VALUES
-- 2021-2022 (Ryan's 1st year)
(9, '2021-2022', '1st Semester', '2021-08-09', '2021-12-10', '2021-08-01', '2021-08-08', FALSE, 'Completed'),
(10, '2021-2022', '2nd Semester', '2022-01-10', '2022-05-13', '2022-01-03', '2022-01-09', FALSE, 'Completed'),
-- 2022-2023 (Ryan's 2nd year)
(11, '2022-2023', '1st Semester', '2022-08-08', '2022-12-09', '2022-08-01', '2022-08-07', FALSE, 'Completed'),
(12, '2022-2023', '2nd Semester', '2023-01-09', '2023-05-12', '2023-01-02', '2023-01-08', FALSE, 'Completed'),
-- 2023-2024
(1, '2023-2024', '1st Semester', '2023-08-14', '2023-12-15', '2023-08-01', '2023-08-13', FALSE, 'Completed'),
(2, '2023-2024', '2nd Semester', '2024-01-08', '2024-05-15', '2024-01-02', '2024-01-07', FALSE, 'Completed'),
(3, '2023-2024', 'Summer', '2024-06-01', '2024-07-15', '2024-05-20', '2024-05-31', FALSE, 'Completed'),
-- 2024-2025
(4, '2024-2025', '1st Semester', '2024-08-12', '2024-12-13', '2024-08-01', '2024-08-11', FALSE, 'Completed'),
(5, '2024-2025', '2nd Semester', '2025-01-06', '2025-05-16', '2025-01-02', '2025-01-05', FALSE, 'Completed'),
(6, '2024-2025', 'Summer', '2025-06-02', '2025-07-18', '2025-05-20', '2025-06-01', FALSE, 'Completed'),
-- 2025-2026 (Current)
(7, '2025-2026', '1st Semester', '2025-08-11', '2025-12-12', '2025-08-01', '2025-08-10', TRUE, 'Ongoing'),
(8, '2025-2026', '2nd Semester', '2026-01-05', '2026-05-15', '2026-01-02', '2026-01-04', FALSE, 'Upcoming');

-- ============================================================
-- INSTRUCTORS
-- ============================================================
INSERT INTO instructors (instructor_id, employee_id, first_name, middle_name, last_name, suffix, title, email, phone, office_location, department_id, position, specialization, employment_status, is_active) VALUES
(1, 'EMP-2020-00001', 'Juan', 'Carlos', 'Dela Cruz', NULL, 'Prof.', 'juan.delacruz@university.edu.ph', '+63 917 123 4501', 'IT-301', 1, 'Associate Professor', 'Data Structures, Algorithms', 'Full-time', TRUE),
(2, 'EMP-2019-00002', 'Maria', 'Elena', 'Santos', NULL, 'Prof.', 'maria.santos@university.edu.ph', '+63 917 123 4502', 'IT-302', 1, 'Professor', 'Object-Oriented Programming, Java', 'Full-time', TRUE),
(3, 'EMP-2021-00003', 'Pedro', 'Jose', 'Reyes', NULL, 'Prof.', 'pedro.reyes@university.edu.ph', '+63 917 123 4503', 'IT-303', 1, 'Assistant Professor', 'Database Systems, SQL', 'Full-time', TRUE),
(4, 'EMP-2018-00004', 'Ana', 'Marie', 'Garcia', NULL, 'Prof.', 'ana.garcia@university.edu.ph', '+63 917 123 4504', 'IT-304', 1, 'Associate Professor', 'Operating Systems, Platform Technologies', 'Full-time', TRUE),
(5, 'EMP-2022-00005', 'Carlos', 'Miguel', 'Mendoza', NULL, 'Prof.', 'carlos.mendoza@university.edu.ph', '+63 917 123 4505', 'IT-101', 1, 'Instructor', 'Introduction to Computing', 'Full-time', TRUE),
(6, 'EMP-2020-00006', 'Angela', 'Rose', 'Cruz', NULL, 'Prof.', 'angela.cruz@university.edu.ph', '+63 917 123 4506', 'LA-201', 4, 'Assistant Professor', 'Art History, Aesthetics', 'Full-time', TRUE),
(7, 'EMP-2017-00007', 'Roberto', 'Luis', 'Tan', NULL, 'Coach', 'roberto.tan@university.edu.ph', '+63 917 123 4507', 'GYM-101', 4, 'Instructor', 'Physical Education, Sports', 'Full-time', TRUE),
(8, 'EMP-2019-00008', 'Elena', 'Patricia', 'Cruz', 'PhD', 'Dr.', 'elena.cruz@university.edu.ph', '+63 917 123 4508', 'GE-201', 4, 'Professor', 'Psychology, Philosophy', 'Full-time', TRUE),
(9, 'EMP-2018-00009', 'Jose', 'Antonio', 'Rizal Jr.', NULL, 'Dr.', 'jose.rizal@university.edu.ph', '+63 917 123 4509', 'GE-202', 4, 'Professor', 'Philippine History, Social Sciences', 'Full-time', TRUE),
(10, 'EMP-2021-00010', 'Albert', 'Newton', 'Reyes', NULL, 'Prof.', 'albert.reyes@university.edu.ph', '+63 917 123 4510', 'SCI-301', 4, 'Associate Professor', 'Mathematics, Statistics', 'Full-time', TRUE);

-- ============================================================
-- CURRICULUM (formerly subjects)
-- ============================================================
INSERT INTO curriculum (curriculum_id, course_code, course_name, description, units, lecture_units, lab_units, lecture_hours, lab_hours, program_id, year_level, semester, course_type, prerequisites, is_active, effective_year) VALUES
-- BSIT 1st Year, 1st Semester
(1, 'CC101', 'Introduction to Computing', 'Fundamentals of computer systems and information technology', 3, 3, 0, 3, 0, 1, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(2, 'CC102', 'Computer Programming 1', 'Introduction to programming concepts using Python', 3, 2, 1, 2, 3, 1, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(3, 'GEC01', 'Understanding the Self', 'General Education - Understanding personal identity and development', 3, 3, 0, 3, 0, 1, '1st Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(4, 'GEC02', 'Readings in Philippine History', 'General Education - Philippine historical perspectives', 3, 3, 0, 3, 0, 1, '1st Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(5, 'GEC03', 'Mathematics in the Modern World', 'General Education - Mathematical concepts and applications', 3, 3, 0, 3, 0, 1, '1st Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(6, 'NSTP1', 'National Service Training Program 1', 'Civic welfare training service', 3, 3, 0, 3, 0, 1, '1st Year', '1st Semester', 'NSTP', NULL, TRUE, '2024-2025'),
(7, 'PE101', 'Physical Fitness and Self-Testing Activities', 'Physical education fundamentals', 2, 2, 0, 2, 0, 1, '1st Year', '1st Semester', 'PE', NULL, TRUE, '2024-2025'),

-- BSIT 1st Year, 2nd Semester
(8, 'CC103', 'Computer Programming 2', 'Advanced programming concepts and OOP with Java', 3, 2, 1, 2, 3, 1, '1st Year', '2nd Semester', 'Core', 'CC102', TRUE, '2024-2025'),
(9, 'CC104', 'Discrete Mathematics', 'Mathematical structures for computer science', 3, 3, 0, 3, 0, 1, '1st Year', '2nd Semester', 'Core', 'GEC03', TRUE, '2024-2025'),
(10, 'GEC04', 'The Contemporary World', 'General Education - Global perspectives and issues', 3, 3, 0, 3, 0, 1, '1st Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),
(11, 'GEC05', 'Purposive Communication', 'General Education - Communication skills development', 3, 3, 0, 3, 0, 1, '1st Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),
(12, 'NSTP2', 'National Service Training Program 2', 'Civic welfare training service continuation', 3, 3, 0, 3, 0, 1, '1st Year', '2nd Semester', 'NSTP', 'NSTP1', TRUE, '2024-2025'),
(13, 'PE102', 'Rhythmic Activities', 'Physical education with dance and rhythm', 2, 2, 0, 2, 0, 1, '1st Year', '2nd Semester', 'PE', 'PE101', TRUE, '2024-2025'),

-- BSIT 2nd Year, 1st Semester
(14, 'IT201', 'Data Structures and Algorithms', 'Fundamental data structures and algorithm design', 3, 2, 1, 2, 3, 1, '2nd Year', '1st Semester', 'Major', 'CC103', TRUE, '2024-2025'),
(15, 'IT202', 'Object-Oriented Programming', 'OOP principles using Java/C#', 3, 2, 1, 2, 3, 1, '2nd Year', '1st Semester', 'Major', 'CC103', TRUE, '2024-2025'),
(16, 'IT203', 'Database Management Systems 1', 'Relational databases and SQL fundamentals', 3, 2, 1, 2, 3, 1, '2nd Year', '1st Semester', 'Major', 'CC102', TRUE, '2024-2025'),
(17, 'IT204', 'Platform Technologies', 'Operating systems and platform concepts', 3, 2, 1, 2, 3, 1, '2nd Year', '1st Semester', 'Major', 'CC101', TRUE, '2024-2025'),
(18, 'GEC06', 'Art Appreciation', 'General Education - Understanding art and aesthetics', 3, 3, 0, 3, 0, 1, '2nd Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(19, 'PE103', 'Individual and Dual Sports', 'Physical education with sports activities', 2, 2, 0, 2, 0, 1, '2nd Year', '1st Semester', 'PE', 'PE102', TRUE, '2024-2025'),

-- BSIT 2nd Year, 2nd Semester
(20, 'IT205', 'Database Management Systems 2', 'Advanced database concepts, stored procedures, triggers', 3, 2, 1, 2, 3, 1, '2nd Year', '2nd Semester', 'Major', 'IT203', TRUE, '2024-2025'),
(21, 'IT206', 'Networking 1', 'Computer networking fundamentals and protocols', 3, 2, 1, 2, 3, 1, '2nd Year', '2nd Semester', 'Major', 'IT204', TRUE, '2024-2025'),
(22, 'IT207', 'Systems Analysis and Design', 'Software development lifecycle and system design methodologies', 3, 3, 0, 3, 0, 1, '2nd Year', '2nd Semester', 'Major', 'IT203', TRUE, '2024-2025'),
(23, 'IT208', 'Web Development 1', 'HTML, CSS, JavaScript and responsive web design', 3, 2, 1, 2, 3, 1, '2nd Year', '2nd Semester', 'Major', 'CC103', TRUE, '2024-2025'),
(24, 'GEC07', 'Science, Technology and Society', 'General Education - Impact of science and technology on society', 3, 3, 0, 3, 0, 1, '2nd Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),
(25, 'PE104', 'Team Sports', 'Physical education with team-based sports activities', 2, 2, 0, 2, 0, 1, '2nd Year', '2nd Semester', 'PE', 'PE103', TRUE, '2024-2025'),

-- BSIT 3rd Year, 1st Semester
(26, 'IT301', 'Web Development 2', 'Server-side programming with PHP/Node.js and frameworks', 3, 2, 1, 2, 3, 1, '3rd Year', '1st Semester', 'Major', 'IT208', TRUE, '2024-2025'),
(27, 'IT302', 'Information Assurance and Security', 'Cybersecurity principles, encryption, and network security', 3, 2, 1, 2, 3, 1, '3rd Year', '1st Semester', 'Major', 'IT206', TRUE, '2024-2025'),
(28, 'IT303', 'Networking 2', 'Advanced networking, routing, switching and network administration', 3, 2, 1, 2, 3, 1, '3rd Year', '1st Semester', 'Major', 'IT206', TRUE, '2024-2025'),
(29, 'IT304', 'Software Engineering', 'Software development methodologies, Agile, and project management', 3, 3, 0, 3, 0, 1, '3rd Year', '1st Semester', 'Major', 'IT207', TRUE, '2024-2025'),
(30, 'GEC08', 'Ethics', 'General Education - Moral philosophy and professional ethics', 3, 3, 0, 3, 0, 1, '3rd Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(31, 'IT305', 'IT Elective 1', 'Specialization elective - Mobile App Development', 3, 2, 1, 2, 3, 1, '3rd Year', '1st Semester', 'Elective', 'IT202', TRUE, '2024-2025'),

-- BSIT 3rd Year, 2nd Semester
(32, 'IT306', 'Capstone Project 1', 'Research and proposal for capstone project', 3, 3, 0, 3, 0, 1, '3rd Year', '2nd Semester', 'Major', 'IT304', TRUE, '2024-2025'),
(33, 'IT307', 'System Integration and Architecture', 'Enterprise systems integration and IT architecture', 3, 2, 1, 2, 3, 1, '3rd Year', '2nd Semester', 'Major', 'IT207', TRUE, '2024-2025'),
(34, 'IT308', 'Human Computer Interaction', 'UI/UX design principles and usability testing', 3, 2, 1, 2, 3, 1, '3rd Year', '2nd Semester', 'Major', 'IT208', TRUE, '2024-2025'),
(35, 'IT309', 'IT Elective 2', 'Specialization elective - Cloud Computing', 3, 2, 1, 2, 3, 1, '3rd Year', '2nd Semester', 'Elective', 'IT303', TRUE, '2024-2025'),
(36, 'GEC09', 'The Life and Works of Rizal', 'General Education - Study of Jose Rizal and Philippine nationalism', 3, 3, 0, 3, 0, 1, '3rd Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),

-- BSIT 4th Year, 1st Semester
(37, 'IT401', 'Capstone Project 2', 'Development and implementation of capstone project', 3, 0, 3, 0, 9, 1, '4th Year', '1st Semester', 'Major', 'IT306', TRUE, '2024-2025'),
(38, 'IT402', 'Systems Administration and Maintenance', 'Server administration, virtualization, and IT service management', 3, 2, 1, 2, 3, 1, '4th Year', '1st Semester', 'Major', 'IT303', TRUE, '2024-2025'),
(39, 'IT403', 'IT Elective 3', 'Specialization elective - Data Science and Analytics', 3, 2, 1, 2, 3, 1, '4th Year', '1st Semester', 'Elective', 'IT205', TRUE, '2024-2025'),
(40, 'IT404', 'Social and Professional Issues in IT', 'Legal, ethical, and social issues in information technology', 3, 3, 0, 3, 0, 1, '4th Year', '1st Semester', 'Major', NULL, TRUE, '2024-2025'),
(41, 'IT405', 'IT Elective 4', 'Specialization elective - Internet of Things', 3, 2, 1, 2, 3, 1, '4th Year', '1st Semester', 'Elective', 'IT302', TRUE, '2024-2025'),

-- BSIT 4th Year, 2nd Semester
(42, 'IT406', 'Practicum/Internship', 'Industry immersion and on-the-job training (500 hours)', 6, 0, 6, 0, 20, 1, '4th Year', '2nd Semester', 'Major', 'IT401', TRUE, '2024-2025'),
(43, 'IT407', 'IT Elective 5', 'Specialization elective - Artificial Intelligence', 3, 2, 1, 2, 3, 1, '4th Year', '2nd Semester', 'Elective', 'IT201', TRUE, '2024-2025'),

-- ============================================================
-- BSCS CURRICULUM (Computer Science - More theoretical/algorithmic focus)
-- ============================================================

-- BSCS 1st Year, 1st Semester
(44, 'CS101', 'Introduction to Computer Science', 'Fundamentals of computing and computational thinking', 3, 3, 0, 3, 0, 2, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(45, 'CS102', 'Programming Fundamentals', 'Introduction to programming using Python', 3, 2, 1, 2, 3, 2, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(46, 'GEC01', 'Understanding the Self', 'General Education - Understanding personal identity and development', 3, 3, 0, 3, 0, 2, '1st Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(47, 'GEC02', 'Readings in Philippine History', 'General Education - Philippine historical perspectives', 3, 3, 0, 3, 0, 2, '1st Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(48, 'MATH101', 'Calculus 1', 'Differential calculus and its applications', 3, 3, 0, 3, 0, 2, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(49, 'NSTP1', 'National Service Training Program 1', 'Civic welfare training service', 3, 3, 0, 3, 0, 2, '1st Year', '1st Semester', 'NSTP', NULL, TRUE, '2024-2025'),
(50, 'PE101', 'Physical Fitness', 'Physical education fundamentals', 2, 2, 0, 2, 0, 2, '1st Year', '1st Semester', 'PE', NULL, TRUE, '2024-2025'),

-- BSCS 1st Year, 2nd Semester
(51, 'CS103', 'Intermediate Programming', 'Advanced programming concepts and OOP with Java', 3, 2, 1, 2, 3, 2, '1st Year', '2nd Semester', 'Core', 'CS102', TRUE, '2024-2025'),
(52, 'CS104', 'Discrete Mathematics', 'Mathematical structures for computer science', 3, 3, 0, 3, 0, 2, '1st Year', '2nd Semester', 'Core', NULL, TRUE, '2024-2025'),
(53, 'MATH102', 'Calculus 2', 'Integral calculus and its applications', 3, 3, 0, 3, 0, 2, '1st Year', '2nd Semester', 'Core', 'MATH101', TRUE, '2024-2025'),
(54, 'GEC04', 'The Contemporary World', 'General Education - Global perspectives', 3, 3, 0, 3, 0, 2, '1st Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),
(55, 'NSTP2', 'National Service Training Program 2', 'Civic welfare training service continuation', 3, 3, 0, 3, 0, 2, '1st Year', '2nd Semester', 'NSTP', 'NSTP1', TRUE, '2024-2025'),
(56, 'PE102', 'Rhythmic Activities', 'Physical education with dance and rhythm', 2, 2, 0, 2, 0, 2, '1st Year', '2nd Semester', 'PE', 'PE101', TRUE, '2024-2025'),

-- BSCS 2nd Year, 1st Semester
(57, 'CS201', 'Data Structures', 'Advanced data structures and complexity analysis', 3, 2, 1, 2, 3, 2, '2nd Year', '1st Semester', 'Major', 'CS103', TRUE, '2024-2025'),
(58, 'CS202', 'Computer Organization and Architecture', 'Digital logic, CPU design and memory systems', 3, 2, 1, 2, 3, 2, '2nd Year', '1st Semester', 'Major', 'CS101', TRUE, '2024-2025'),
(59, 'CS203', 'Object-Oriented Programming', 'OOP design patterns and principles', 3, 2, 1, 2, 3, 2, '2nd Year', '1st Semester', 'Major', 'CS103', TRUE, '2024-2025'),
(60, 'MATH201', 'Linear Algebra', 'Vectors, matrices, and linear transformations', 3, 3, 0, 3, 0, 2, '2nd Year', '1st Semester', 'Core', 'MATH102', TRUE, '2024-2025'),
(61, 'GEC06', 'Art Appreciation', 'General Education - Understanding art and aesthetics', 3, 3, 0, 3, 0, 2, '2nd Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(62, 'PE103', 'Individual and Dual Sports', 'Physical education with sports activities', 2, 2, 0, 2, 0, 2, '2nd Year', '1st Semester', 'PE', 'PE102', TRUE, '2024-2025'),

-- BSCS 2nd Year, 2nd Semester
(63, 'CS204', 'Algorithms and Complexity', 'Algorithm design, analysis, and NP-completeness', 3, 3, 0, 3, 0, 2, '2nd Year', '2nd Semester', 'Major', 'CS201', TRUE, '2024-2025'),
(64, 'CS205', 'Operating Systems', 'Process management, memory, and file systems', 3, 2, 1, 2, 3, 2, '2nd Year', '2nd Semester', 'Major', 'CS202', TRUE, '2024-2025'),
(65, 'CS206', 'Database Systems', 'Relational database theory and SQL', 3, 2, 1, 2, 3, 2, '2nd Year', '2nd Semester', 'Major', 'CS201', TRUE, '2024-2025'),
(66, 'MATH202', 'Probability and Statistics', 'Probability theory and statistical inference', 3, 3, 0, 3, 0, 2, '2nd Year', '2nd Semester', 'Core', 'MATH101', TRUE, '2024-2025'),
(67, 'GEC07', 'Science, Technology and Society', 'Impact of science and technology on society', 3, 3, 0, 3, 0, 2, '2nd Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),
(68, 'PE104', 'Team Sports', 'Physical education with team-based sports activities', 2, 2, 0, 2, 0, 2, '2nd Year', '2nd Semester', 'PE', 'PE103', TRUE, '2024-2025'),

-- BSCS 3rd Year, 1st Semester
(69, 'CS301', 'Automata Theory and Formal Languages', 'Finite automata, regular expressions, context-free grammars', 3, 3, 0, 3, 0, 2, '3rd Year', '1st Semester', 'Major', 'CS204', TRUE, '2024-2025'),
(70, 'CS302', 'Programming Languages', 'Language paradigms, syntax, and semantics', 3, 2, 1, 2, 3, 2, '3rd Year', '1st Semester', 'Major', 'CS203', TRUE, '2024-2025'),
(71, 'CS303', 'Software Engineering', 'Software development methodologies and project management', 3, 2, 1, 2, 3, 2, '3rd Year', '1st Semester', 'Major', 'CS203', TRUE, '2024-2025'),
(72, 'CS304', 'Computer Networks', 'Network protocols, architecture, and security', 3, 2, 1, 2, 3, 2, '3rd Year', '1st Semester', 'Major', 'CS205', TRUE, '2024-2025'),
(73, 'GEC08', 'Ethics', 'Moral philosophy and professional ethics', 3, 3, 0, 3, 0, 2, '3rd Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(74, 'CS305', 'CS Elective 1', 'Specialization - Machine Learning Fundamentals', 3, 2, 1, 2, 3, 2, '3rd Year', '1st Semester', 'Elective', 'MATH202', TRUE, '2024-2025'),

-- BSCS 3rd Year, 2nd Semester
(75, 'CS306', 'Thesis 1', 'Research proposal and methodology', 3, 3, 0, 3, 0, 2, '3rd Year', '2nd Semester', 'Major', 'CS303', TRUE, '2024-2025'),
(76, 'CS307', 'Artificial Intelligence', 'AI fundamentals, search algorithms, knowledge representation', 3, 2, 1, 2, 3, 2, '3rd Year', '2nd Semester', 'Major', 'CS204', TRUE, '2024-2025'),
(77, 'CS308', 'Information Security', 'Cryptography, security protocols, and ethical hacking', 3, 2, 1, 2, 3, 2, '3rd Year', '2nd Semester', 'Major', 'CS304', TRUE, '2024-2025'),
(78, 'CS309', 'CS Elective 2', 'Specialization - Deep Learning', 3, 2, 1, 2, 3, 2, '3rd Year', '2nd Semester', 'Elective', 'CS305', TRUE, '2024-2025'),
(79, 'GEC09', 'The Life and Works of Rizal', 'Study of Jose Rizal and Philippine nationalism', 3, 3, 0, 3, 0, 2, '3rd Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),

-- BSCS 4th Year, 1st Semester
(80, 'CS401', 'Thesis 2', 'Implementation and documentation of research project', 3, 0, 3, 0, 9, 2, '4th Year', '1st Semester', 'Major', 'CS306', TRUE, '2024-2025'),
(81, 'CS402', 'Parallel and Distributed Computing', 'Parallel algorithms and distributed systems', 3, 2, 1, 2, 3, 2, '4th Year', '1st Semester', 'Major', 'CS205', TRUE, '2024-2025'),
(82, 'CS403', 'CS Elective 3', 'Specialization - Computer Vision', 3, 2, 1, 2, 3, 2, '4th Year', '1st Semester', 'Elective', 'CS307', TRUE, '2024-2025'),
(83, 'CS404', 'Social and Professional Issues', 'Legal, ethical, and social issues in computing', 3, 3, 0, 3, 0, 2, '4th Year', '1st Semester', 'Major', NULL, TRUE, '2024-2025'),
(84, 'CS405', 'CS Elective 4', 'Specialization - Natural Language Processing', 3, 2, 1, 2, 3, 2, '4th Year', '1st Semester', 'Elective', 'CS307', TRUE, '2024-2025'),

-- BSCS 4th Year, 2nd Semester
(85, 'CS406', 'Practicum/Internship', 'Industry immersion and on-the-job training (500 hours)', 6, 0, 6, 0, 20, 2, '4th Year', '2nd Semester', 'Major', 'CS401', TRUE, '2024-2025'),
(86, 'CS407', 'CS Elective 5', 'Specialization - Quantum Computing Introduction', 3, 2, 1, 2, 3, 2, '4th Year', '2nd Semester', 'Elective', 'CS402', TRUE, '2024-2025'),

-- ============================================================
-- BSIS CURRICULUM (Information Systems - Business-IT focus)
-- ============================================================

-- BSIS 1st Year, 1st Semester
(87, 'IS101', 'Introduction to Information Systems', 'Fundamentals of IS in organizations', 3, 3, 0, 3, 0, 3, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(88, 'IS102', 'Computer Programming 1', 'Introduction to programming using Python', 3, 2, 1, 2, 3, 3, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(89, 'GEC01', 'Understanding the Self', 'General Education - Personal identity and development', 3, 3, 0, 3, 0, 3, '1st Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(90, 'GEC02', 'Readings in Philippine History', 'General Education - Philippine historical perspectives', 3, 3, 0, 3, 0, 3, '1st Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(91, 'ACC101', 'Fundamentals of Accounting', 'Basic accounting principles and financial statements', 3, 3, 0, 3, 0, 3, '1st Year', '1st Semester', 'Core', NULL, TRUE, '2024-2025'),
(92, 'NSTP1', 'National Service Training Program 1', 'Civic welfare training service', 3, 3, 0, 3, 0, 3, '1st Year', '1st Semester', 'NSTP', NULL, TRUE, '2024-2025'),
(93, 'PE101', 'Physical Fitness', 'Physical education fundamentals', 2, 2, 0, 2, 0, 3, '1st Year', '1st Semester', 'PE', NULL, TRUE, '2024-2025'),

-- BSIS 1st Year, 2nd Semester
(94, 'IS103', 'Computer Programming 2', 'Advanced programming and OOP concepts', 3, 2, 1, 2, 3, 3, '1st Year', '2nd Semester', 'Core', 'IS102', TRUE, '2024-2025'),
(95, 'IS104', 'Discrete Mathematics', 'Mathematical foundations for IS', 3, 3, 0, 3, 0, 3, '1st Year', '2nd Semester', 'Core', NULL, TRUE, '2024-2025'),
(96, 'BUS101', 'Principles of Management', 'Management theories and organizational behavior', 3, 3, 0, 3, 0, 3, '1st Year', '2nd Semester', 'Core', NULL, TRUE, '2024-2025'),
(97, 'GEC05', 'Purposive Communication', 'Communication skills development', 3, 3, 0, 3, 0, 3, '1st Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),
(98, 'NSTP2', 'National Service Training Program 2', 'Civic welfare training service continuation', 3, 3, 0, 3, 0, 3, '1st Year', '2nd Semester', 'NSTP', 'NSTP1', TRUE, '2024-2025'),
(99, 'PE102', 'Rhythmic Activities', 'Physical education with dance and rhythm', 2, 2, 0, 2, 0, 3, '1st Year', '2nd Semester', 'PE', 'PE101', TRUE, '2024-2025'),

-- BSIS 2nd Year, 1st Semester
(100, 'IS201', 'Data Structures and Algorithms', 'Fundamental data structures for IS applications', 3, 2, 1, 2, 3, 3, '2nd Year', '1st Semester', 'Major', 'IS103', TRUE, '2024-2025'),
(101, 'IS202', 'Database Management Systems', 'Relational databases and SQL for business', 3, 2, 1, 2, 3, 3, '2nd Year', '1st Semester', 'Major', 'IS103', TRUE, '2024-2025'),
(102, 'IS203', 'Systems Analysis and Design', 'Business systems analysis methodologies', 3, 3, 0, 3, 0, 3, '2nd Year', '1st Semester', 'Major', 'IS101', TRUE, '2024-2025'),
(103, 'BUS201', 'Business Process Management', 'Process modeling and optimization', 3, 3, 0, 3, 0, 3, '2nd Year', '1st Semester', 'Major', 'BUS101', TRUE, '2024-2025'),
(104, 'GEC06', 'Art Appreciation', 'Understanding art and aesthetics', 3, 3, 0, 3, 0, 3, '2nd Year', '1st Semester', 'General Education', NULL, TRUE, '2024-2025'),
(105, 'PE103', 'Individual and Dual Sports', 'Physical education with sports activities', 2, 2, 0, 2, 0, 3, '2nd Year', '1st Semester', 'PE', 'PE102', TRUE, '2024-2025'),

-- BSIS 2nd Year, 2nd Semester
(106, 'IS204', 'Web Systems Development', 'Web application development for business', 3, 2, 1, 2, 3, 3, '2nd Year', '2nd Semester', 'Major', 'IS201', TRUE, '2024-2025'),
(107, 'IS205', 'Networking and Data Communications', 'Network fundamentals for IS professionals', 3, 2, 1, 2, 3, 3, '2nd Year', '2nd Semester', 'Major', 'IS101', TRUE, '2024-2025'),
(108, 'IS206', 'Human Computer Interaction', 'User interface design and usability', 3, 2, 1, 2, 3, 3, '2nd Year', '2nd Semester', 'Major', 'IS203', TRUE, '2024-2025'),
(109, 'BUS202', 'Financial Management', 'Corporate finance and investment decisions', 3, 3, 0, 3, 0, 3, '2nd Year', '2nd Semester', 'Core', 'ACC101', TRUE, '2024-2025'),
(110, 'GEC07', 'Science, Technology and Society', 'Impact of technology on society', 3, 3, 0, 3, 0, 3, '2nd Year', '2nd Semester', 'General Education', NULL, TRUE, '2024-2025'),
(111, 'PE104', 'Team Sports', 'Physical education with team sports', 2, 2, 0, 2, 0, 3, '2nd Year', '2nd Semester', 'PE', 'PE103', TRUE, '2024-2025');

-- ============================================================
-- PAYMENT TYPES
-- ============================================================
INSERT INTO payment_types (payment_type_id, type_code, type_name, description, category, default_amount, is_mandatory, is_active) VALUES
(1, 'TF', 'Tuition Fee', 'Per unit fee for enrolled subjects', 'Tuition', 1500.00, TRUE, TRUE),
(2, 'LF', 'Laboratory Fee', 'Computer and science laboratory usage fee', 'Laboratory', 5000.00, TRUE, TRUE),
(3, 'MF', 'Miscellaneous Fee', 'Includes library, ID, medical, guidance, and cultural fees', 'Miscellaneous', 8500.00, TRUE, TRUE),
(4, 'NSTP', 'NSTP Fee', 'National Service Training Program fee', 'Other Fees', 1000.00, TRUE, TRUE),
(5, 'ATH', 'Athletic Fee', 'Sports facilities and intramural activities', 'Other Fees', 500.00, FALSE, TRUE),
(6, 'SDF', 'Student Development Fee', 'Student council and organization activities', 'Other Fees', 300.00, FALSE, TRUE),
(7, 'EF', 'Energy Fee', 'Air conditioning and electricity consumption', 'Other Fees', 3500.00, TRUE, TRUE),
(8, 'INS', 'Insurance Fee', 'Student accident and health insurance', 'Other Fees', 1500.00, TRUE, TRUE),
(9, 'REG', 'Registration Fee', 'Enrollment processing and documentation', 'Other Fees', 500.00, TRUE, TRUE),
(10, 'EXAM', 'Examination Permit', 'Midterm and final examination permit fee', 'Other Fees', 200.00, TRUE, TRUE);

-- ============================================================
-- USERS
-- ============================================================
INSERT INTO users (user_id, username, email, password, full_name, role, department_id, is_active, is_verified) VALUES
(1, 'admin', 'admin@ems.local', '$2y$10$oamDXJzNBYfrB3hWGeZZeu5gZgWQztufYMEslVARK.sRLmqzKwTWe', 'System Administrator', 'Super Admin', NULL, TRUE, TRUE),
(2, 'registrar', 'registrar@ems.local', '$2y$10$oamDXJzNBYfrB3hWGeZZeu5gZgWQztufYMEslVARK.sRLmqzKwTWe', 'Maria Registrar', 'Registrar', NULL, TRUE, TRUE),
(3, 'cashier', 'cashier@ems.local', '$2y$10$oamDXJzNBYfrB3hWGeZZeu5gZgWQztufYMEslVARK.sRLmqzKwTWe', 'Juan Cashier', 'Cashier', NULL, TRUE, TRUE);

-- ============================================================
-- STUDENTS (6 students for comprehensive testing)
-- ============================================================
INSERT INTO students (
    student_id, student_number, first_name, middle_name, last_name, suffix, sex, 
    civil_status, nationality, religion, blood_type,
    email, phone, date_of_birth, place_of_birth,
    address_street, address_barangay, address_city, address_province, address_zip,
    permanent_address,
    guardian_name, guardian_relationship, guardian_contact, guardian_email, guardian_occupation, guardian_address,
    emergency_contact_name, emergency_contact_phone, emergency_contact_relationship,
    current_program_id, admission_date, admission_type, year_level, current_semester, section,
    student_status, scholarship_status, lrn
) VALUES
-- Student 1: Reginald Cano_06 - BSIT 2nd Year (Original)
(1, 'STU-2024-00001', 'Reginald', 'Santos', 'Cano_06', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'O+',
'reginald.cano@email.com', '+63 917 123 4501', '2003-03-15', 'Manila, Philippines',
'123 Rizal Avenue', 'Brgy. Commonwealth', 'Quezon City', 'Metro Manila', '1121',
'123 Rizal Avenue, Brgy. Commonwealth, Quezon City, Metro Manila 1121',
'Roberto Cano', 'Father', '+63 918 123 4501', 'roberto.cano@email.com', 'Engineer', '123 Rizal Avenue, Brgy. Commonwealth, Quezon City',
'Maria Santos Cano', '+63 919 123 4501', 'Mother',
1, '2024-06-15', 'Freshman', '2nd Year', '1st Semester', 'BSIT-2A',
'Active', 'None', '123456789012'),

-- Student 2: Maria Elena Santos_06 - BSIT 1st Year (New Freshman)
(2, 'STU-2025-00001', 'Maria Elena', 'Cruz', 'Santos_06', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'A+',
'maria.santos@email.com', '+63 917 234 5601', '2006-07-22', 'Cebu City, Philippines',
'456 Mabini Street', 'Brgy. Loyola Heights', 'Quezon City', 'Metro Manila', '1108',
'456 Mabini Street, Brgy. Loyola Heights, Quezon City, Metro Manila 1108',
'Elena Cruz Santos', 'Mother', '+63 918 234 5601', 'elena.santos@email.com', 'Teacher', '456 Mabini Street, Brgy. Loyola Heights, Quezon City',
'Pedro Santos', '+63 919 234 5601', 'Father',
1, '2025-06-20', 'Freshman', '1st Year', '1st Semester', 'BSIT-1A',
'Active', 'Government', '234567890123'),

-- Student 3: Juan Carlos Reyes_06 - BSIT 2nd Year (Same batch as Reginald, Section B)
(3, 'STU-2024-00002', 'Juan Carlos', 'Miguel', 'Reyes_06', 'Jr.', 'Male', 
'Single', 'Filipino', 'Iglesia ni Cristo', 'B+',
'juan.reyes@email.com', '+63 917 345 6701', '2004-01-10', 'Makati City, Philippines',
'789 Bonifacio Avenue', 'Brgy. San Antonio', 'Makati City', 'Metro Manila', '1203',
'789 Bonifacio Avenue, Brgy. San Antonio, Makati City, Metro Manila 1203',
'Carlos Reyes Sr.', 'Father', '+63 918 345 6701', 'carlos.reyes@email.com', 'Businessman', '789 Bonifacio Avenue, Brgy. San Antonio, Makati City',
'Rosa Miguel Reyes', '+63 919 345 6701', 'Mother',
1, '2024-06-18', 'Freshman', '2nd Year', '1st Semester', 'BSIT-2B',
'Active', 'Partial', '345678901234'),

-- Student 4: Angela Rose Cruz_06 - BSCS 1st Year (Different Program)
(4, 'STU-2025-00002', 'Angela Rose', 'Marie', 'Cruz_06', NULL, 'Female', 
'Single', 'Filipino', 'Born Again Christian', 'O-',
'angela.cruz@email.com', '+63 917 456 7801', '2006-11-05', 'Davao City, Philippines',
'321 Katipunan Avenue', 'Brgy. UP Campus', 'Quezon City', 'Metro Manila', '1101',
'321 Katipunan Avenue, Brgy. UP Campus, Quezon City, Metro Manila 1101',
'Marie Cruz', 'Mother', '+63 918 456 7801', 'marie.cruz@email.com', 'Nurse', '321 Katipunan Avenue, Brgy. UP Campus, Quezon City',
'Antonio Cruz', '+63 919 456 7801', 'Father',
2, '2025-06-22', 'Freshman', '1st Year', '1st Semester', 'BSCS-1A',
'Active', 'Full', '456789012345'),

-- Student 5: Carlos Miguel Mendoza_06 - BSIT 1st Year, 2nd Semester (Irregular)
(5, 'STU-2024-00003', 'Carlos Miguel', 'Jose', 'Mendoza_06', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'AB+',
'carlos.mendoza@email.com', '+63 917 567 8901', '2005-04-18', 'Baguio City, Philippines',
'555 Session Road', 'Brgy. Burnham Park', 'Baguio City', 'Benguet', '2600',
'555 Session Road, Brgy. Burnham Park, Baguio City, Benguet 2600',
'Jose Mendoza', 'Father', '+63 918 567 8901', 'jose.mendoza@email.com', 'OFW - Seaman', '555 Session Road, Brgy. Burnham Park, Baguio City',
'Carmen Jose Mendoza', '+63 919 567 8901', 'Mother',
1, '2024-06-25', 'Transferee', '1st Year', '2nd Semester', 'BSIT-1B',
'Active', 'None', '567890123456'),

-- Student 6: Sofia Isabel Garcia_06 - BSIT 2nd Year (On Leave)
(6, 'STU-2024-00004', 'Sofia Isabel', 'Patricia', 'Garcia_06', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'A-',
'sofia.garcia@email.com', '+63 917 678 9012', '2004-09-30', 'Iloilo City, Philippines',
'888 General Luna Street', 'Brgy. Jaro', 'Iloilo City', 'Iloilo', '5000',
'888 General Luna Street, Brgy. Jaro, Iloilo City, Iloilo 5000',
'Patricia Garcia', 'Mother', '+63 918 678 9012', 'patricia.garcia@email.com', 'Lawyer', '888 General Luna Street, Brgy. Jaro, Iloilo City',
'Ramon Garcia', '+63 919 678 9012', 'Father',
1, '2024-06-20', 'Freshman', '2nd Year', '1st Semester', 'BSIT-2A',
'On Leave', 'None', '678901234567'),

-- Student 7: Miguel Antonio Dela Cruz_06 - BSCS 2nd Year (Dean's Lister)
(7, 'STU-2024-00005', 'Miguel Antonio', 'Jose', 'Dela Cruz_06', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'B+',
'miguel.delacruz@email.com', '+63 917 789 0123', '2004-02-14', 'Pasig City, Philippines',
'222 Ortigas Avenue', 'Brgy. San Antonio', 'Pasig City', 'Metro Manila', '1605',
'222 Ortigas Avenue, Brgy. San Antonio, Pasig City, Metro Manila 1605',
'Jose Dela Cruz', 'Father', '+63 918 789 0123', 'jose.delacruz@email.com', 'Accountant', '222 Ortigas Avenue, Brgy. San Antonio, Pasig City',
'Carmen Dela Cruz', '+63 919 789 0123', 'Mother',
2, '2024-06-18', 'Freshman', '2nd Year', '1st Semester', 'BSCS-2A',
'Active', 'Partial', '789012345678'),

-- Student 8: Princess Joy Villanueva_06 - BSIS 1st Year (New Freshman)
(8, 'STU-2025-00003', 'Princess Joy', 'Anne', 'Villanueva_06', NULL, 'Female', 
'Single', 'Filipino', 'Born Again Christian', 'O+',
'princess.villanueva@email.com', '+63 917 890 1234', '2006-12-25', 'Taguig City, Philippines',
'333 McKinley Road', 'Brgy. Bonifacio Global City', 'Taguig City', 'Metro Manila', '1634',
'333 McKinley Road, Brgy. Bonifacio Global City, Taguig City, Metro Manila 1634',
'Anne Villanueva', 'Mother', '+63 918 890 1234', 'anne.villanueva@email.com', 'HR Manager', '333 McKinley Road, Brgy. BGC, Taguig City',
'Ricardo Villanueva', '+63 919 890 1234', 'Father',
3, '2025-06-21', 'Freshman', '1st Year', '1st Semester', 'BSIS-1A',
'Active', 'None', '890123456789'),

-- Student 9: John Patrick Aquino_06 - BSIT 1st Year (Dropped)
(9, 'STU-2024-00006', 'John Patrick', 'Luis', 'Aquino_06', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'AB-',
'john.aquino@email.com', '+63 917 901 2345', '2005-06-12', 'Caloocan City, Philippines',
'444 EDSA', 'Brgy. Grace Park', 'Caloocan City', 'Metro Manila', '1400',
'444 EDSA, Brgy. Grace Park, Caloocan City, Metro Manila 1400',
'Luis Aquino', 'Father', '+63 918 901 2345', 'luis.aquino@email.com', 'Driver', '444 EDSA, Brgy. Grace Park, Caloocan City',
'Maria Aquino', '+63 919 901 2345', 'Mother',
1, '2024-06-22', 'Freshman', '1st Year', '1st Semester', 'BSIT-1A',
'Dropped', 'None', '901234567890'),

-- Student 10: Samantha Rose Lim_06 - BSBA 1st Year (Business Admin)
(10, 'STU-2025-00004', 'Samantha Rose', 'Chen', 'Lim_06', NULL, 'Female', 
'Single', 'Filipino-Chinese', 'Buddhist', 'A+',
'samantha.lim@email.com', '+63 917 012 3456', '2006-08-08', 'Binondo, Manila, Philippines',
'555 Ongpin Street', 'Brgy. Binondo', 'Manila', 'Metro Manila', '1006',
'555 Ongpin Street, Brgy. Binondo, Manila, Metro Manila 1006',
'Chen Lim', 'Father', '+63 918 012 3456', 'chen.lim@email.com', 'Business Owner', '555 Ongpin Street, Brgy. Binondo, Manila',
'Lily Tan Lim', '+63 919 012 3456', 'Mother',
6, '2025-06-23', 'Freshman', '1st Year', '1st Semester', 'BSBA-1A',
'Active', 'Private', '012345678901'),

-- Student 11: Roberto James Santos_06 Jr. - BSIT 2nd Year (Irregular - Failed subjects)
(11, 'STU-2023-00001', 'Roberto James', 'Miguel', 'Santos_06', 'Jr.', 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'O-',
'roberto.santos@email.com', '+63 917 123 4567', '2003-10-20', 'Paranaque City, Philippines',
'666 Sucat Road', 'Brgy. San Dionisio', 'Paranaque City', 'Metro Manila', '1700',
'666 Sucat Road, Brgy. San Dionisio, Paranaque City, Metro Manila 1700',
'Miguel Santos Sr.', 'Father', '+63 918 123 4567', 'miguel.santos@email.com', 'Police Officer', '666 Sucat Road, Brgy. San Dionisio, Paranaque City',
'Teresa Santos', '+63 919 123 4567', 'Mother',
1, '2023-06-15', 'Freshman', '2nd Year', '1st Semester', 'BSIT-2A',
'Active', 'None', '112233445566'),

-- Student 12: Patricia Anne Gonzales_06 - BSIT 1st Year (Regular student)
(12, 'STU-2025-00005', 'Patricia Anne', 'Marie', 'Gonzales_06', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'B+',
'patricia.gonzales@email.com', '+63 917 234 5678', '2006-05-18', 'Las Pinas City, Philippines',
'777 Alabang-Zapote Road', 'Brgy. Almanza Uno', 'Las Pinas City', 'Metro Manila', '1750',
'777 Alabang-Zapote Road, Brgy. Almanza Uno, Las Pinas City, Metro Manila 1750',
'Marie Gonzales', 'Mother', '+63 918 234 5678', 'marie.gonzales@email.com', 'Dentist', '777 Alabang-Zapote Road, Brgy. Almanza Uno, Las Pinas',
'Pedro Gonzales', '+63 919 234 5678', 'Father',
1, '2025-06-20', 'Freshman', '1st Year', '1st Semester', 'BSIT-1A',
'Active', 'None', '223344556677'),

-- Student 13: Mark Anthony Rivera_06 - BSCS 1st Year (Athlete Scholar)
(13, 'STU-2025-00006', 'Mark Anthony', 'Jose', 'Rivera_06', NULL, 'Male', 
'Single', 'Filipino', 'Born Again Christian', 'O+',
'mark.rivera@email.com', '+63 917 345 6789', '2006-09-12', 'Muntinlupa City, Philippines',
'888 National Road', 'Brgy. Poblacion', 'Muntinlupa City', 'Metro Manila', '1776',
'888 National Road, Brgy. Poblacion, Muntinlupa City, Metro Manila 1776',
'Jose Rivera', 'Father', '+63 918 345 6789', 'jose.rivera@email.com', 'Basketball Coach', '888 National Road, Brgy. Poblacion, Muntinlupa City',
'Ana Rivera', '+63 919 345 6789', 'Mother',
2, '2025-06-22', 'Freshman', '1st Year', '1st Semester', 'BSCS-1A',
'Active', 'Full', '334455667788'),

-- Student 14: Christine Joy Bautista_06 - BSIS 2nd Year (Regular)
(14, 'STU-2024-00007', 'Christine Joy', 'Anne', 'Bautista_06', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'A+',
'christine.bautista@email.com', '+63 917 456 7890', '2004-12-03', 'Marikina City, Philippines',
'999 Shoe Avenue', 'Brgy. Industrial Valley', 'Marikina City', 'Metro Manila', '1800',
'999 Shoe Avenue, Brgy. Industrial Valley, Marikina City, Metro Manila 1800',
'Anne Bautista', 'Mother', '+63 918 456 7890', 'anne.bautista@email.com', 'Shoe Designer', '999 Shoe Avenue, Brgy. Industrial Valley, Marikina City',
'Ramon Bautista', '+63 919 456 7890', 'Father',
3, '2024-06-18', 'Freshman', '2nd Year', '1st Semester', 'BSIS-2A',
'Active', 'None', '445566778899'),

-- Student 15: Joshua David Fernandez_06 - BSCE 1st Year (Engineering Student)
(15, 'STU-2025-00007', 'Joshua David', 'Paul', 'Fernandez_06', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'AB+',
'joshua.fernandez@email.com', '+63 917 567 8901', '2006-03-25', 'San Juan City, Philippines',
'111 N. Domingo Street', 'Brgy. Greenhills', 'San Juan City', 'Metro Manila', '1500',
'111 N. Domingo Street, Brgy. Greenhills, San Juan City, Metro Manila 1500',
'Paul Fernandez', 'Father', '+63 918 567 8901', 'paul.fernandez@email.com', 'Civil Engineer', '111 N. Domingo Street, Brgy. Greenhills, San Juan City',
'Maria Fernandez', '+63 919 567 8901', 'Mother',
4, '2025-06-24', 'Freshman', '1st Year', '1st Semester', 'BSCE-1A',
'Active', 'None', '556677889900'),

-- Student 16: Anna Marie Pascual_06 - BSA 1st Year (Accountancy Student)
(16, 'STU-2025-00008', 'Anna Marie', 'Grace', 'Pascual_06', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'B-',
'anna.pascual@email.com', '+63 917 678 9012', '2006-07-14', 'Mandaluyong City, Philippines',
'222 Shaw Boulevard', 'Brgy. Wack-Wack', 'Mandaluyong City', 'Metro Manila', '1555',
'222 Shaw Boulevard, Brgy. Wack-Wack, Mandaluyong City, Metro Manila 1555',
'Grace Pascual', 'Mother', '+63 918 678 9012', 'grace.pascual@email.com', 'CPA', '222 Shaw Boulevard, Brgy. Wack-Wack, Mandaluyong City',
'Antonio Pascual', '+63 919 678 9012', 'Father',
5, '2025-06-25', 'Freshman', '1st Year', '1st Semester', 'BSA-1A',
'Active', 'Government', '667788990011'),

-- Student 17: Kevin John Tolentino_06 - BSIT 2nd Year (Working Student)
(17, 'STU-2024-00008', 'Kevin John', 'Carlo', 'Tolentino_06', NULL, 'Male', 
'Single', 'Filipino', 'Iglesia ni Cristo', 'O+',
'kevin.tolentino@email.com', '+63 917 789 0123', '2004-04-08', 'Valenzuela City, Philippines',
'333 McArthur Highway', 'Brgy. Karuhatan', 'Valenzuela City', 'Metro Manila', '1440',
'333 McArthur Highway, Brgy. Karuhatan, Valenzuela City, Metro Manila 1440',
'Carlo Tolentino', 'Father', '+63 918 789 0123', 'carlo.tolentino@email.com', 'Factory Worker', '333 McArthur Highway, Brgy. Karuhatan, Valenzuela City',
'Linda Tolentino', '+63 919 789 0123', 'Mother',
1, '2024-06-19', 'Freshman', '2nd Year', '1st Semester', 'BSIT-2B',
'Active', 'None', '778899001122'),

-- Student 18: Rachel Marie Domingo_06 - BSIT 1st Year (Transferee from province)
(18, 'STU-2025-00009', 'Rachel Marie', 'Faith', 'Domingo_06', NULL, 'Female', 
'Single', 'Filipino', 'Methodist', 'A+',
'rachel.domingo@email.com', '+63 917 890 1234', '2005-11-22', 'Batangas City, Philippines',
'444 P. Burgos Street', 'Brgy. Poblacion', 'Batangas City', 'Batangas', '4200',
'444 P. Burgos Street, Brgy. Poblacion, Batangas City, Batangas 4200',
'Faith Domingo', 'Mother', '+63 918 890 1234', 'faith.domingo@email.com', 'Teacher', '444 P. Burgos Street, Brgy. Poblacion, Batangas City',
'Jose Domingo', '+63 919 890 1234', 'Father',
1, '2025-06-26', 'Transferee', '1st Year', '1st Semester', 'BSIT-1B',
'Active', 'None', '889900112233'),

-- Student 19: Gabriel Luis Ramos_06 - BSCS 2nd Year (Dean's Lister)
(19, 'STU-2024-00009', 'Gabriel Luis', 'Martin', 'Ramos_06', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'B+',
'gabriel.ramos@email.com', '+63 917 901 2345', '2004-08-17', 'Pasay City, Philippines',
'555 Taft Avenue', 'Brgy. Malibay', 'Pasay City', 'Metro Manila', '1300',
'555 Taft Avenue, Brgy. Malibay, Pasay City, Metro Manila 1300',
'Martin Ramos', 'Father', '+63 918 901 2345', 'martin.ramos@email.com', 'Pilot', '555 Taft Avenue, Brgy. Malibay, Pasay City',
'Elena Ramos', '+63 919 901 2345', 'Mother',
2, '2024-06-17', 'Freshman', '2nd Year', '1st Semester', 'BSCS-2A',
'Active', 'Partial', '990011223344'),

-- Student 20: Jasmine Claire Soriano_06 - BSBA 1st Year (Business Admin)
(20, 'STU-2025-00010', 'Jasmine Claire', 'Rose', 'Soriano_06', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'O-',
'jasmine.soriano@email.com', '+63 917 012 3456', '2006-02-28', 'Malabon City, Philippines',
'666 Gov. Pascual Avenue', 'Brgy. Potrero', 'Malabon City', 'Metro Manila', '1470',
'666 Gov. Pascual Avenue, Brgy. Potrero, Malabon City, Metro Manila 1470',
'Rose Soriano', 'Mother', '+63 918 012 3456', 'rose.soriano@email.com', 'Boutique Owner', '666 Gov. Pascual Avenue, Brgy. Potrero, Malabon City',
'Eduardo Soriano', '+63 919 012 3456', 'Father',
6, '2025-06-27', 'Freshman', '1st Year', '1st Semester', 'BSBA-1B',
'Active', 'None', '001122334455'),

-- Student 21: Ryan Christopher Mercado_06 - BSIT 1st Year (Graduated - for testing)
(21, 'STU-2021-00001', 'Ryan Christopher', 'James', 'Mercado_06', NULL, 'Male', 
'Married', 'Filipino', 'Roman Catholic', 'AB-',
'ryan.mercado@email.com', '+63 917 111 2222', '2001-06-15', 'Navotas City, Philippines',
'777 C. Arellano Street', 'Brgy. Tangos', 'Navotas City', 'Metro Manila', '1485',
'777 C. Arellano Street, Brgy. Tangos, Navotas City, Metro Manila 1485',
'James Mercado', 'Father', '+63 918 111 2222', 'james.mercado@email.com', 'Fisherman', '777 C. Arellano Street, Brgy. Tangos, Navotas City',
'Carmen Mercado', '+63 919 111 2222', 'Mother',
1, '2021-06-14', 'Freshman', '4th Year', '2nd Semester', 'BSIT-4A',
'Graduated', 'None', '111222333444'),

-- Student 22: Jerome Paul Villanueva_06 - BSIT 3rd Year (Dean's Lister)
(22, 'STU-2023-00003', 'Jerome Paul', 'Andrew', 'Villanueva_06', NULL, 'Male', 
'Single', 'Filipino', 'Roman Catholic', 'A+',
'jerome.villanueva@email.com', '+63 917 222 3333', '2003-02-14', 'Pasig City, Philippines',
'123 Ortigas Avenue', 'Brgy. San Antonio', 'Pasig City', 'Metro Manila', '1605',
'123 Ortigas Avenue, Brgy. San Antonio, Pasig City, Metro Manila 1605',
'Andrew Villanueva', 'Father', '+63 918 222 3333', 'andrew.villanueva@email.com', 'IT Manager', '123 Ortigas Avenue, Brgy. San Antonio, Pasig City',
'Rosario Villanueva', '+63 919 222 3333', 'Mother',
1, '2023-06-15', 'Freshman', '3rd Year', '1st Semester', 'BSIT-3A',
'Active', 'Partial', '222333444555'),

-- Student 23: Michelle Anne Lim_06 - BSCS 3rd Year (Regular)
(23, 'STU-2023-00004', 'Michelle Anne', 'Grace', 'Lim_06', NULL, 'Female', 
'Single', 'Filipino', 'Born Again Christian', 'O+',
'michelle.lim@email.com', '+63 917 333 4444', '2003-08-22', 'Taguig City, Philippines',
'456 BGC Avenue', 'Brgy. Fort Bonifacio', 'Taguig City', 'Metro Manila', '1630',
'456 BGC Avenue, Brgy. Fort Bonifacio, Taguig City, Metro Manila 1630',
'Grace Lim', 'Mother', '+63 918 333 4444', 'grace.lim@email.com', 'Bank Manager', '456 BGC Avenue, Brgy. Fort Bonifacio, Taguig City',
'William Lim', '+63 919 333 4444', 'Father',
2, '2023-06-18', 'Freshman', '3rd Year', '1st Semester', 'BSCS-3A',
'Active', 'None', '333444555666'),

-- Student 24: Daniel Joseph Cruz_06 - BSIT 4th Year (Graduating)
(24, 'STU-2022-00001', 'Daniel Joseph', 'Michael', 'Cruz_06', NULL, 'Male', 
'Single', 'Filipino', 'Iglesia ni Cristo', 'B+',
'daniel.cruz@email.com', '+63 917 444 5555', '2002-05-10', 'Manila City, Philippines',
'789 Taft Avenue', 'Brgy. Malate', 'Manila City', 'Metro Manila', '1004',
'789 Taft Avenue, Brgy. Malate, Manila City, Metro Manila 1004',
'Michael Cruz', 'Father', '+63 918 444 5555', 'michael.cruz@email.com', 'Lawyer', '789 Taft Avenue, Brgy. Malate, Manila City',
'Elizabeth Cruz', '+63 919 444 5555', 'Mother',
1, '2022-06-13', 'Freshman', '4th Year', '1st Semester', 'BSIT-4A',
'Active', 'Full', '444555666777'),

-- Student 25: Angela Faith Santos_06 - BSCS 4th Year (Graduating, Dean's Lister)
(25, 'STU-2022-00002', 'Angela Faith', 'Marie', 'Santos_06', NULL, 'Female', 
'Single', 'Filipino', 'Roman Catholic', 'AB+',
'angela.faith@email.com', '+63 917 555 6666', '2002-11-28', 'Makati City, Philippines',
'321 Ayala Avenue', 'Brgy. Bel-Air', 'Makati City', 'Metro Manila', '1209',
'321 Ayala Avenue, Brgy. Bel-Air, Makati City, Metro Manila 1209',
'Marie Santos', 'Mother', '+63 918 555 6666', 'marie.santos2@email.com', 'Company Executive', '321 Ayala Avenue, Brgy. Bel-Air, Makati City',
'Roberto Santos', '+63 919 555 6666', 'Father',
2, '2022-06-15', 'Freshman', '4th Year', '1st Semester', 'BSCS-4A',
'Active', 'Government', '555666777888');

-- ============================================================
-- STUDENT PROGRAMS (Enrollment History)
-- ============================================================
INSERT INTO student_programs (student_program_id, student_id, program_id, academic_year_id, action, effective_date, remarks) VALUES
(1, 1, 1, 4, 'Enrolled', '2024-08-12', 'Initial enrollment as Freshman in BSIT'),
(2, 2, 1, 7, 'Enrolled', '2025-08-11', 'Initial enrollment as Freshman in BSIT'),
(3, 3, 1, 4, 'Enrolled', '2024-08-12', 'Initial enrollment as Freshman in BSIT'),
(4, 4, 2, 7, 'Enrolled', '2025-08-11', 'Initial enrollment as Freshman in BSCS'),
(5, 5, 1, 4, 'Enrolled', '2024-08-12', 'Transferred from another university'),
(6, 6, 1, 4, 'Enrolled', '2024-08-12', 'Initial enrollment as Freshman in BSIT'),
(7, 7, 2, 4, 'Enrolled', '2024-08-12', 'Initial enrollment as Freshman in BSCS'),
(8, 8, 3, 7, 'Enrolled', '2025-08-11', 'Initial enrollment as Freshman in BSIS'),
(9, 9, 1, 4, 'Enrolled', '2024-08-12', 'Initial enrollment as Freshman in BSIT'),
(10, 9, 1, 4, 'Dropped', '2024-10-15', 'Dropped due to personal reasons'),
(11, 10, 6, 7, 'Enrolled', '2025-08-11', 'Initial enrollment as Freshman in BSBA'),
(12, 11, 1, 1, 'Enrolled', '2023-08-14', 'Initial enrollment as Freshman in BSIT'),
-- New students 12-21
(13, 12, 1, 9, 'Enrolled', '2025-08-11', 'Initial enrollment as Freshman in BSIT'),
(14, 13, 2, 9, 'Enrolled', '2025-08-11', 'Athlete Scholar - Basketball team'),
(15, 14, 3, 7, 'Enrolled', '2024-08-12', 'Initial enrollment as Freshman in BSIS'),
(16, 15, 4, 9, 'Enrolled', '2025-08-11', 'Initial enrollment as Freshman in BSCE'),
(17, 16, 5, 9, 'Enrolled', '2025-08-11', 'Government Scholar'),
(18, 17, 1, 7, 'Enrolled', '2024-08-12', 'Working student - Night shift'),
(19, 18, 1, 9, 'Enrolled', '2025-08-11', 'Transferee from Batangas State University'),
(20, 19, 2, 7, 'Enrolled', '2024-08-12', 'Deans Lister - Consistent'),
(21, 20, 6, 9, 'Enrolled', '2025-08-11', 'Initial enrollment as Freshman in BSBA'),
(22, 21, 1, 1, 'Enrolled', '2021-08-10', 'Initial enrollment as Freshman in BSIT'),
(23, 21, 1, 5, 'Graduated', '2025-05-30', 'Graduated with honors - Cum Laude'),
-- New 3rd Year and 4th Year students
(24, 22, 1, 1, 'Enrolled', '2023-08-14', 'Initial enrollment as Freshman in BSIT - Deans Lister'),
(25, 23, 2, 1, 'Enrolled', '2023-08-14', 'Initial enrollment as Freshman in BSCS'),
(26, 24, 1, 11, 'Enrolled', '2022-08-08', 'Initial enrollment as Freshman in BSIT'),
(27, 25, 2, 11, 'Enrolled', '2022-08-08', 'Initial enrollment as Freshman in BSCS - Government Scholar');

-- ============================================================
-- ENROLLMENTS
-- ============================================================

-- Student 1: Reginald Cano - BSIT 2nd Year (Original - 19 enrollments)
INSERT INTO enrollments (enrollment_id, student_id, curriculum_id, academic_year_id, enrollment_date, enrollment_status, midterm_grade, final_grade, grade, grade_status, instructor_id, remarks) VALUES
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Completed
(1, 1, 1, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 5, NULL),
(2, 1, 2, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(3, 1, 3, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 8, NULL),
(4, 1, 4, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 9, NULL),
(5, 1, 5, 4, '2024-08-12', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 10, NULL),
(6, 1, 6, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(7, 1, 7, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed
(8, 1, 8, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(9, 1, 9, 5, '2025-01-06', 'Enrolled', 2.50, 2.50, 2.50, 'Passed', 10, NULL),
(10, 1, 10, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(11, 1, 11, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(12, 1, 12, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', NULL, NULL),
(13, 1, 13, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(14, 1, 14, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(15, 1, 15, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(16, 1, 16, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(17, 1, 17, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(18, 1, 18, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(19, 1, 19, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 2: Maria Elena Santos - BSIT 1st Year, 1st Semester (New Freshman)
(20, 2, 1, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(21, 2, 2, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(22, 2, 3, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(23, 2, 4, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(24, 2, 5, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(25, 2, 6, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(26, 2, 7, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 3: Juan Carlos Reyes - BSIT 2nd Year (Same batch as Reginald)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Completed
(27, 3, 1, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 5, NULL),
(28, 3, 2, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 2, NULL),
(29, 3, 3, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(30, 3, 4, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 9, NULL),
(31, 3, 5, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(32, 3, 6, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', NULL, NULL),
(33, 3, 7, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed
(34, 3, 8, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(35, 3, 9, 5, '2025-01-06', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 10, NULL),
(36, 3, 10, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(37, 3, 11, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(38, 3, 12, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', NULL, NULL),
(39, 3, 13, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(40, 3, 14, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(41, 3, 15, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(42, 3, 16, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(43, 3, 17, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(44, 3, 18, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(45, 3, 19, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 4: Angela Rose Cruz - BSCS 1st Year (Uses BSCS curriculum - program_id=2)
(46, 4, 44, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(47, 4, 45, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(48, 4, 46, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(49, 4, 47, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(50, 4, 48, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(51, 4, 49, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(52, 4, 50, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 5: Carlos Miguel Mendoza - BSIT 1st Year, 2nd Semester (Transferee - started 2nd sem)
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed
(53, 5, 8, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 2, NULL),
(54, 5, 9, 5, '2025-01-06', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 10, NULL),
(55, 5, 10, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(56, 5, 11, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 8, NULL),
(57, 5, 12, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(58, 5, 13, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(59, 5, 14, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(60, 5, 15, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(61, 5, 16, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(62, 5, 17, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(63, 5, 18, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(64, 5, 19, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 6: Sofia Isabel Garcia - BSIT 2nd Year (On Leave - completed 1st year only)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Completed
(65, 6, 1, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 5, NULL),
(66, 6, 2, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(67, 6, 3, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(68, 6, 4, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 9, NULL),
(69, 6, 5, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 10, NULL),
(70, 6, 6, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', NULL, NULL),
(71, 6, 7, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed
(72, 6, 8, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(73, 6, 9, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(74, 6, 10, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(75, 6, 11, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(76, 6, 12, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', NULL, NULL),
(77, 6, 13, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),

-- Student 7: Miguel Antonio Dela Cruz - BSCS 2nd Year (Dean's Lister)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Completed with excellent grades
(78, 7, 44, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 5, NULL),
(79, 7, 45, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 2, NULL),
(80, 7, 46, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(81, 7, 47, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 9, NULL),
(82, 7, 48, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 10, NULL),
(83, 7, 49, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', NULL, NULL),
(84, 7, 50, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed
(85, 7, 51, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 2, NULL),
(86, 7, 52, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 10, NULL),
(87, 7, 53, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 8, NULL),
(88, 7, 54, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(89, 7, 55, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', NULL, NULL),
(90, 7, 56, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(91, 7, 57, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(92, 7, 58, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(93, 7, 59, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(94, 7, 60, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(95, 7, 61, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(96, 7, 62, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 8: Princess Joy Villanueva - BSIS 1st Year (New Freshman)
(97, 8, 87, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(98, 8, 88, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(99, 8, 89, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(100, 8, 90, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(101, 8, 91, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(102, 8, 92, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(103, 8, 93, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 9: John Patrick Aquino - BSIT 1st Year (Dropped after 1st sem)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Dropped/Incomplete
(104, 9, 1, 4, '2024-08-12', 'Dropped', 3.00, NULL, 5.00, 'Failed', 5, 'Stopped attending'),
(105, 9, 2, 4, '2024-08-12', 'Dropped', 2.75, NULL, 5.00, 'Failed', 2, 'Stopped attending'),
(106, 9, 3, 4, '2024-08-12', 'Dropped', 2.50, NULL, NULL, 'Incomplete', 8, 'Did not finish'),
(107, 9, 4, 4, '2024-08-12', 'Dropped', NULL, NULL, NULL, 'Dropped', 9, 'Never attended'),
(108, 9, 5, 4, '2024-08-12', 'Dropped', 3.00, NULL, 5.00, 'Failed', 10, 'Stopped attending'),
(109, 9, 6, 4, '2024-08-12', 'Dropped', NULL, NULL, NULL, 'Dropped', NULL, 'Did not complete'),
(110, 9, 7, 4, '2024-08-12', 'Dropped', 2.00, NULL, NULL, 'Incomplete', 7, 'Medical issues'),

-- Student 10: Samantha Rose Lim - BSBA 1st Year (uses shared GE subjects from BSIT curriculum - BSBA-specific curriculum not yet available)
(111, 10, 3, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(112, 10, 4, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(113, 10, 5, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(114, 10, 6, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(115, 10, 7, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 11: Roberto James Santos Jr. - BSIT 2nd Year (Irregular - has failed subjects)
-- 1st Year, 1st Semester (S.Y. 2023-2024) - Mixed results
(116, 11, 1, 1, '2023-08-14', 'Enrolled', 2.50, 2.50, 2.50, 'Passed', 5, NULL),
(117, 11, 2, 1, '2023-08-14', 'Enrolled', 3.00, 3.50, 5.00, 'Failed', 2, 'Failed - needs retake'),
(118, 11, 3, 1, '2023-08-14', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 8, NULL),
(119, 11, 4, 1, '2023-08-14', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 9, NULL),
(120, 11, 5, 1, '2023-08-14', 'Enrolled', 3.00, 3.50, 5.00, 'Failed', 10, 'Failed - needs retake'),
(121, 11, 6, 1, '2023-08-14', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', NULL, NULL),
(122, 11, 7, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(123, 11, 8, 2, '2024-01-08', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 2, NULL),
(124, 11, 9, 2, '2024-01-08', 'Enrolled', 2.75, 2.75, 2.75, 'Passed', 10, NULL),
(125, 11, 10, 2, '2024-01-08', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 8, NULL),
(126, 11, 11, 2, '2024-01-08', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 8, NULL),
(127, 11, 12, 2, '2024-01-08', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', NULL, NULL),
(128, 11, 13, 2, '2024-01-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- Retake failed subjects + 2nd Year subjects (S.Y. 2024-2025, 1st Sem)
(129, 11, 2, 4, '2024-08-12', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 2, 'Retake - Passed'),
(130, 11, 5, 4, '2024-08-12', 'Enrolled', 2.50, 2.50, 2.50, 'Passed', 10, 'Retake - Passed'),
(131, 11, 14, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 1, NULL),
(132, 11, 15, 4, '2024-08-12', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 2, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(133, 11, 16, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(134, 11, 17, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(135, 11, 18, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(136, 11, 19, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 12: Patricia Anne Gonzales - BSIT 1st Year (Regular freshman)
(137, 12, 1, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(138, 12, 2, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(139, 12, 3, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(140, 12, 4, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(141, 12, 5, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(142, 12, 6, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(143, 12, 7, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 13: Mark Anthony Rivera - BSCS 1st Year (Athlete Scholar)
(144, 13, 44, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(145, 13, 45, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(146, 13, 46, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(147, 13, 47, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(148, 13, 48, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(149, 13, 49, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(150, 13, 50, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 14: Christine Joy Bautista - BSIS 2nd Year (has 1st year completed)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Completed
(151, 14, 87, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 5, NULL),
(152, 14, 88, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(153, 14, 89, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 8, NULL),
(154, 14, 90, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 9, NULL),
(155, 14, 91, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(156, 14, 92, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(157, 14, 93, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed
(158, 14, 94, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(159, 14, 95, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(160, 14, 96, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(161, 14, 97, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(162, 14, 98, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', NULL, NULL),
(163, 14, 99, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(164, 14, 100, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(165, 14, 101, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(166, 14, 102, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(167, 14, 103, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(168, 14, 104, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(169, 14, 105, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 15: Joshua David Fernandez - BSCE 1st Year (uses shared GE courses from BSIT curriculum)
(170, 15, 1, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(171, 15, 2, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(172, 15, 3, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(173, 15, 4, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(174, 15, 5, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(175, 15, 6, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(176, 15, 7, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 16: Anna Marie Pascual - BSA 1st Year (Government Scholar, uses shared GE courses from BSIT curriculum)
(177, 16, 1, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(178, 16, 2, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(179, 16, 3, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(180, 16, 4, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(181, 16, 5, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(182, 16, 6, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(183, 16, 7, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 17: Kevin John Tolentino - BSIT 2nd Year (Working Student)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Completed
(184, 17, 1, 4, '2024-08-12', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 5, NULL),
(185, 17, 2, 4, '2024-08-12', 'Enrolled', 2.50, 2.50, 2.50, 'Passed', 2, NULL),
(186, 17, 3, 4, '2024-08-12', 'Enrolled', 2.75, 2.75, 2.75, 'Passed', 8, NULL),
(187, 17, 4, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 9, NULL),
(188, 17, 5, 4, '2024-08-12', 'Enrolled', 2.50, 2.50, 2.50, 'Passed', 10, NULL),
(189, 17, 6, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', NULL, NULL),
(190, 17, 7, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed
(191, 17, 8, 5, '2025-01-06', 'Enrolled', 2.50, 2.50, 2.50, 'Passed', 2, NULL),
(192, 17, 9, 5, '2025-01-06', 'Enrolled', 2.75, 2.75, 2.75, 'Passed', 10, NULL),
(193, 17, 10, 5, '2025-01-06', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 8, NULL),
(194, 17, 11, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 8, NULL),
(195, 17, 12, 5, '2025-01-06', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', NULL, NULL),
(196, 17, 13, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(197, 17, 14, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(198, 17, 15, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(199, 17, 16, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(200, 17, 17, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(201, 17, 18, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(202, 17, 19, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 18: Rachel Marie Domingo - BSIT 1st Year (Transferee)
(203, 18, 1, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(204, 18, 2, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(205, 18, 3, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(206, 18, 4, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(207, 18, 5, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(208, 18, 6, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(209, 18, 7, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 19: Gabriel Luis Ramos - BSCS 2nd Year (Dean's Lister - excellent grades)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Completed with honors
(210, 19, 44, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 5, 'Dean\'s Lister'),
(211, 19, 45, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 2, NULL),
(212, 19, 46, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 8, 'Perfect score'),
(213, 19, 47, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 9, NULL),
(214, 19, 48, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 10, NULL),
(215, 19, 49, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', NULL, NULL),
(216, 19, 50, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Completed with honors
(217, 19, 51, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 2, NULL),
(218, 19, 52, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 10, 'Perfect score'),
(219, 19, 53, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 8, NULL),
(220, 19, 54, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(221, 19, 55, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', NULL, NULL),
(222, 19, 56, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(223, 19, 57, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(224, 19, 58, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(225, 19, 59, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(226, 19, 60, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(227, 19, 61, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(228, 19, 62, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 20: Jasmine Claire Soriano - BSBA 1st Year (uses shared GE subjects - BSBA-specific curriculum not yet available)
(229, 20, 1, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 5, NULL),
(230, 20, 2, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(231, 20, 3, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(232, 20, 4, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 9, NULL),
(233, 20, 5, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 10, NULL),
(234, 20, 6, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', NULL, NULL),
(235, 20, 7, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 21: Ryan Christopher Mercado - BSIT Graduated (full 4 years)
-- 1st Year, 1st Semester (S.Y. 2021-2022)
(236, 21, 1, 9, '2021-08-10', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 5, NULL),
(237, 21, 2, 9, '2021-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(238, 21, 3, 9, '2021-08-10', 'Enrolled', 2.25, 2.25, 2.25, 'Passed', 8, NULL),
(239, 21, 4, 9, '2021-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 9, NULL),
(240, 21, 5, 9, '2021-08-10', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(241, 21, 6, 9, '2021-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', NULL, NULL),
(242, 21, 7, 9, '2021-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2021-2022)
(243, 21, 8, 10, '2022-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(244, 21, 9, 10, '2022-01-10', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(245, 21, 10, 10, '2022-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(246, 21, 11, 10, '2022-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(247, 21, 12, 10, '2022-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(248, 21, 13, 10, '2022-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2022-2023)
(249, 21, 14, 11, '2022-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 1, NULL),
(250, 21, 15, 11, '2022-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(251, 21, 16, 11, '2022-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 3, NULL),
(252, 21, 17, 11, '2022-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 4, NULL),
(253, 21, 18, 11, '2022-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 6, NULL),
(254, 21, 19, 11, '2022-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 2nd Year, 2nd Semester (S.Y. 2022-2023)
(255, 21, 20, 12, '2023-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 5, NULL),
(256, 21, 21, 12, '2023-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(257, 21, 22, 12, '2023-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 10, NULL),
(258, 21, 23, 12, '2023-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(259, 21, 24, 12, '2023-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(260, 21, 25, 12, '2023-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
-- 3rd Year, 1st Semester (S.Y. 2023-2024)
(261, 21, 26, 1, '2023-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 1, NULL),
(262, 21, 27, 1, '2023-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(263, 21, 28, 1, '2023-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 3, NULL),
(264, 21, 29, 1, '2023-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 4, NULL),
(265, 21, 30, 1, '2023-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 6, NULL),
(266, 21, 31, 1, '2023-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 3rd Year, 2nd Semester (S.Y. 2023-2024)
(267, 21, 32, 2, '2024-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, 'Capstone Project 1'),
(268, 21, 33, 2, '2024-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(269, 21, 34, 2, '2024-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 9, NULL),
(270, 21, 35, 2, '2024-01-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 10, NULL),
(271, 21, 36, 2, '2024-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
-- 4th Year, 1st Semester (S.Y. 2024-2025)
(272, 21, 37, 4, '2024-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 1, 'Capstone Project 2'),
(273, 21, 38, 4, '2024-08-10', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(274, 21, 39, 4, '2024-08-10', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 3, NULL),
(275, 21, 40, 4, '2024-08-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 4, NULL),
(276, 21, 41, 4, '2024-08-10', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 6, NULL),
-- 4th Year, 2nd Semester (S.Y. 2024-2025) - Final semester
(277, 21, 42, 5, '2025-01-10', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 5, 'Practicum/Internship'),
(278, 21, 43, 5, '2025-01-10', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, 'IT Elective 5'),

-- Student 22: Jerome Paul Villanueva - BSIT 3rd Year (5 semesters completed + current)
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(285, 22, 1, 1, '2023-08-14', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 5, NULL),
(286, 22, 2, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(287, 22, 3, 1, '2023-08-14', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(288, 22, 4, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 9, NULL),
(289, 22, 5, 1, '2023-08-14', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 10, NULL),
(290, 22, 6, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(291, 22, 7, 1, '2023-08-14', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(292, 22, 8, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(293, 22, 9, 2, '2024-01-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 10, NULL),
(294, 22, 10, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(295, 22, 11, 2, '2024-01-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(296, 22, 12, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(297, 22, 13, 2, '2024-01-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(298, 22, 14, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 1, NULL),
(299, 22, 15, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(300, 22, 16, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 3, NULL),
(301, 22, 17, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 4, NULL),
(302, 22, 18, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 6, NULL),
(303, 22, 19, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 2nd Year, 2nd Semester (S.Y. 2024-2025)
(304, 22, 20, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 3, NULL),
(305, 22, 21, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 4, NULL),
(306, 22, 22, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 3, NULL),
(307, 22, 23, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(308, 22, 24, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(309, 22, 25, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current
(310, 22, 26, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(311, 22, 27, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(312, 22, 28, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(313, 22, 29, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(314, 22, 30, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 8, NULL),
(315, 22, 31, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),

-- Student 23: Michelle Anne Lim - BSCS 3rd Year (5 semesters completed + current)
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(316, 23, 44, 1, '2023-08-14', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 5, NULL),
(317, 23, 45, 1, '2023-08-14', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 2, NULL),
(318, 23, 46, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(319, 23, 47, 1, '2023-08-14', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 9, NULL),
(320, 23, 48, 1, '2023-08-14', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(321, 23, 49, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(322, 23, 50, 1, '2023-08-14', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(323, 23, 51, 2, '2024-01-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(324, 23, 52, 2, '2024-01-08', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 10, NULL),
(325, 23, 53, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(326, 23, 54, 2, '2024-01-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(327, 23, 55, 2, '2024-01-08', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', NULL, NULL),
(328, 23, 56, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(329, 23, 57, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 1, NULL),
(330, 23, 58, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 2, NULL),
(331, 23, 59, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 3, NULL),
(332, 23, 60, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 4, NULL),
(333, 23, 61, 4, '2024-08-12', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 6, NULL),
(334, 23, 62, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 2nd Year, 2nd Semester (S.Y. 2024-2025)
(335, 23, 63, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 5, NULL),
(336, 23, 64, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 2, NULL),
(337, 23, 65, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 10, NULL),
(338, 23, 66, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(339, 23, 67, 5, '2025-01-06', 'Enrolled', 2.00, 2.00, 2.00, 'Passed', 8, NULL),
(340, 23, 68, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current
(341, 23, 69, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, NULL),
(342, 23, 70, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(343, 23, 71, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(344, 23, 72, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(345, 23, 73, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(346, 23, 74, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 24: Daniel Joseph Cruz - BSIT 4th Year (7 semesters completed + current)
-- 1st Year, 1st Semester (S.Y. 2022-2023)
(347, 24, 1, 11, '2022-08-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 5, NULL),
(348, 24, 2, 11, '2022-08-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(349, 24, 3, 11, '2022-08-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(350, 24, 4, 11, '2022-08-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 9, NULL),
(351, 24, 5, 11, '2022-08-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 10, NULL),
(352, 24, 6, 11, '2022-08-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', NULL, NULL),
(353, 24, 7, 11, '2022-08-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2022-2023)
(354, 24, 8, 12, '2023-01-09', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(355, 24, 9, 12, '2023-01-09', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 10, NULL),
(356, 24, 10, 12, '2023-01-09', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(357, 24, 11, 12, '2023-01-09', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(358, 24, 12, 12, '2023-01-09', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
(359, 24, 13, 12, '2023-01-09', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2023-2024)
(360, 24, 14, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 1, NULL),
(361, 24, 15, 1, '2023-08-14', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(362, 24, 16, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 3, NULL),
(363, 24, 17, 1, '2023-08-14', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 4, NULL),
(364, 24, 18, 1, '2023-08-14', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 6, NULL),
(365, 24, 19, 1, '2023-08-14', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 2nd Year, 2nd Semester (S.Y. 2023-2024)
(366, 24, 20, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 5, NULL),
(367, 24, 21, 2, '2024-01-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(368, 24, 22, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 10, NULL),
(369, 24, 23, 2, '2024-01-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(370, 24, 24, 2, '2024-01-08', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 8, NULL),
(371, 24, 25, 2, '2024-01-08', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', NULL, NULL),
-- 3rd Year, 1st Semester (S.Y. 2024-2025)
(372, 24, 26, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 1, NULL),
(373, 24, 27, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 2, NULL),
(374, 24, 28, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 3, NULL),
(375, 24, 29, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 4, NULL),
(376, 24, 30, 4, '2024-08-12', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 6, NULL),
(377, 24, 31, 4, '2024-08-12', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 7, NULL),
-- 3rd Year, 2nd Semester (S.Y. 2024-2025)
(378, 24, 32, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 2, NULL),
(379, 24, 33, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 8, NULL),
(380, 24, 34, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', 9, NULL),
(381, 24, 35, 5, '2025-01-06', 'Enrolled', 1.75, 1.75, 1.75, 'Passed', 10, NULL),
(382, 24, 36, 5, '2025-01-06', 'Enrolled', 1.50, 1.50, 1.50, 'Passed', NULL, NULL),
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current
(383, 24, 37, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, 'Thesis/Capstone'),
(384, 24, 38, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(385, 24, 39, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(386, 24, 40, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(387, 24, 41, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(388, 24, 42, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL),

-- Student 25: Angela Faith Santos - BSCS 4th Year (7 semesters completed + current)
-- 1st Year, 1st Semester (S.Y. 2022-2023)
(389, 25, 44, 11, '2022-08-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 5, NULL),
(390, 25, 45, 11, '2022-08-08', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 2, NULL),
(391, 25, 46, 11, '2022-08-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(392, 25, 47, 11, '2022-08-08', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 9, NULL),
(393, 25, 48, 11, '2022-08-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 10, NULL),
(394, 25, 49, 11, '2022-08-08', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', NULL, NULL),
(395, 25, 50, 11, '2022-08-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 1st Year, 2nd Semester (S.Y. 2022-2023)
(396, 25, 51, 12, '2023-01-09', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 2, NULL),
(397, 25, 52, 12, '2023-01-09', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 10, NULL),
(398, 25, 53, 12, '2023-01-09', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 8, NULL),
(399, 25, 54, 12, '2023-01-09', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(400, 25, 55, 12, '2023-01-09', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', NULL, NULL),
(401, 25, 56, 12, '2023-01-09', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 2nd Year, 1st Semester (S.Y. 2023-2024)
(402, 25, 57, 1, '2023-08-14', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 1, NULL),
(403, 25, 58, 1, '2023-08-14', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 2, NULL),
(404, 25, 59, 1, '2023-08-14', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 3, NULL),
(405, 25, 60, 1, '2023-08-14', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 4, NULL),
(406, 25, 61, 1, '2023-08-14', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 6, NULL),
(407, 25, 62, 1, '2023-08-14', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 2nd Year, 2nd Semester (S.Y. 2023-2024)
(408, 25, 63, 2, '2024-01-08', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 5, NULL),
(409, 25, 64, 2, '2024-01-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 2, NULL),
(410, 25, 65, 2, '2024-01-08', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 10, NULL),
(411, 25, 66, 2, '2024-01-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(412, 25, 67, 2, '2024-01-08', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 8, NULL),
(413, 25, 68, 2, '2024-01-08', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', NULL, NULL),
-- 3rd Year, 1st Semester (S.Y. 2024-2025)
(414, 25, 69, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 1, NULL),
(415, 25, 70, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 2, NULL),
(416, 25, 71, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 3, NULL),
(417, 25, 72, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 4, NULL),
(418, 25, 73, 4, '2024-08-12', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 6, NULL),
(419, 25, 74, 4, '2024-08-12', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 7, NULL),
-- 3rd Year, 2nd Semester (S.Y. 2024-2025)
(420, 25, 75, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 2, NULL),
(421, 25, 76, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 8, NULL),
(422, 25, 77, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', 9, NULL),
(423, 25, 78, 5, '2025-01-06', 'Enrolled', 1.25, 1.25, 1.25, 'Passed', 10, NULL),
(424, 25, 79, 5, '2025-01-06', 'Enrolled', 1.00, 1.00, 1.00, 'Passed', NULL, NULL),
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current
(425, 25, 80, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 1, 'Thesis/Capstone'),
(426, 25, 81, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 2, NULL),
(427, 25, 82, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 3, NULL),
(428, 25, 83, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 4, NULL),
(429, 25, 84, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 6, NULL),
(430, 25, 85, 7, '2025-08-11', 'Enrolled', NULL, NULL, NULL, 'Pending', 7, NULL);

-- ============================================================
-- CLASS SCHEDULES
-- Current Semester Only (S.Y. 2025-2026, 1st Semester)
-- ============================================================
INSERT INTO class_schedules (schedule_id, enrollment_id, day_of_week, start_time, end_time, room, building, instructor_id, class_type, is_active, notes) VALUES

-- Student 1: Reginald Cano - 2nd Year, 1st Semester (enrollment_ids: 14-19)
(1, 14, 'Monday', '08:00:00', '09:00:00', 'Room 301', 'IT Building', 1, 'Lecture', TRUE, NULL),
(2, 14, 'Wednesday', '08:00:00', '09:00:00', 'Room 301', 'IT Building', 1, 'Lecture', TRUE, NULL),
(3, 14, 'Friday', '13:00:00', '14:00:00', 'CompLab 2', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(4, 15, 'Tuesday', '08:00:00', '09:00:00', 'Room 302', 'IT Building', 2, 'Lecture', TRUE, NULL),
(5, 15, 'Thursday', '08:00:00', '09:00:00', 'Room 302', 'IT Building', 2, 'Lecture', TRUE, NULL),
(6, 15, 'Tuesday', '13:00:00', '14:00:00', 'CompLab 1', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(7, 16, 'Monday', '09:00:00', '10:00:00', 'Room 205', 'IT Building', 3, 'Lecture', TRUE, NULL),
(8, 16, 'Wednesday', '09:00:00', '10:00:00', 'Room 205', 'IT Building', 3, 'Lecture', TRUE, NULL),
(9, 16, 'Monday', '14:00:00', '15:00:00', 'CompLab 3', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(10, 17, 'Thursday', '09:00:00', '10:00:00', 'Room 401', 'IT Building', 4, 'Lecture', TRUE, NULL),
(11, 17, 'Thursday', '13:00:00', '14:00:00', 'CompLab 4', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(12, 18, 'Wednesday', '13:00:00', '14:00:00', 'Room 101', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(13, 19, 'Friday', '08:00:00', '09:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 2: Maria Elena Santos - 1st Year, 1st Semester (enrollment_ids: 20-26)
(14, 20, 'Monday', '10:00:00', '11:00:00', 'Room 101', 'IT Building', 5, 'Lecture', TRUE, NULL),
(15, 20, 'Wednesday', '10:00:00', '11:00:00', 'Room 101', 'IT Building', 5, 'Lecture', TRUE, NULL),
(16, 20, 'Friday', '10:00:00', '11:00:00', 'Room 101', 'IT Building', 5, 'Lecture', TRUE, NULL),
(17, 21, 'Monday', '13:00:00', '14:00:00', 'Room 102', 'IT Building', 2, 'Lecture', TRUE, NULL),
(18, 21, 'Wednesday', '13:00:00', '14:00:00', 'Room 102', 'IT Building', 2, 'Lecture', TRUE, NULL),
(19, 21, 'Monday', '15:00:00', '16:00:00', 'CompLab 1', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(20, 22, 'Tuesday', '09:00:00', '10:00:00', 'Room 201', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(21, 22, 'Thursday', '09:00:00', '10:00:00', 'Room 201', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(22, 22, 'Tuesday', '10:00:00', '11:00:00', 'Room 201', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(23, 23, 'Tuesday', '13:00:00', '14:00:00', 'Room 202', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(24, 23, 'Thursday', '13:00:00', '14:00:00', 'Room 202', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(25, 23, 'Thursday', '14:00:00', '15:00:00', 'Room 202', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(26, 24, 'Wednesday', '14:00:00', '15:00:00', 'Room 301', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(27, 24, 'Friday', '14:00:00', '15:00:00', 'Room 301', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(28, 24, 'Wednesday', '15:00:00', '16:00:00', 'Room 301', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(29, 25, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(30, 26, 'Friday', '16:00:00', '17:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 3: Juan Carlos Reyes - 2nd Year, 1st Semester (enrollment_ids: 40-45, same schedule as Reginald but Section B)
(31, 40, 'Monday', '08:00:00', '09:00:00', 'Room 301', 'IT Building', 1, 'Lecture', TRUE, NULL),
(32, 40, 'Wednesday', '08:00:00', '09:00:00', 'Room 301', 'IT Building', 1, 'Lecture', TRUE, NULL),
(33, 40, 'Friday', '13:00:00', '14:00:00', 'CompLab 2', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(34, 41, 'Tuesday', '08:00:00', '09:00:00', 'Room 302', 'IT Building', 2, 'Lecture', TRUE, NULL),
(35, 41, 'Thursday', '08:00:00', '09:00:00', 'Room 302', 'IT Building', 2, 'Lecture', TRUE, NULL),
(36, 41, 'Tuesday', '13:00:00', '14:00:00', 'CompLab 1', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(37, 42, 'Monday', '09:00:00', '10:00:00', 'Room 205', 'IT Building', 3, 'Lecture', TRUE, NULL),
(38, 42, 'Wednesday', '09:00:00', '10:00:00', 'Room 205', 'IT Building', 3, 'Lecture', TRUE, NULL),
(39, 42, 'Monday', '14:00:00', '15:00:00', 'CompLab 3', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(40, 43, 'Thursday', '09:00:00', '10:00:00', 'Room 401', 'IT Building', 4, 'Lecture', TRUE, NULL),
(41, 43, 'Thursday', '13:00:00', '14:00:00', 'CompLab 4', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(42, 44, 'Wednesday', '13:00:00', '14:00:00', 'Room 101', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(43, 45, 'Friday', '08:00:00', '09:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 4: Angela Rose Cruz - BSCS 1st Year (enrollment_ids: 46-52)
(44, 46, 'Monday', '10:00:00', '11:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(45, 46, 'Wednesday', '10:00:00', '11:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(46, 46, 'Friday', '10:00:00', '11:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(47, 47, 'Tuesday', '10:00:00', '11:00:00', 'Room 104', 'IT Building', 2, 'Lecture', TRUE, NULL),
(48, 47, 'Thursday', '10:00:00', '11:00:00', 'Room 104', 'IT Building', 2, 'Lecture', TRUE, NULL),
(49, 47, 'Tuesday', '14:00:00', '15:00:00', 'CompLab 2', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(50, 48, 'Monday', '13:00:00', '14:00:00', 'Room 203', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(51, 48, 'Wednesday', '13:00:00', '14:00:00', 'Room 203', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(52, 48, 'Friday', '13:00:00', '14:00:00', 'Room 203', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(53, 49, 'Tuesday', '15:00:00', '16:00:00', 'Room 204', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(54, 49, 'Thursday', '15:00:00', '16:00:00', 'Room 204', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(55, 49, 'Thursday', '16:00:00', '17:00:00', 'Room 204', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(56, 50, 'Monday', '15:00:00', '16:00:00', 'Room 302', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(57, 50, 'Wednesday', '15:00:00', '16:00:00', 'Room 302', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(58, 50, 'Friday', '15:00:00', '16:00:00', 'Room 302', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(59, 51, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(60, 52, 'Saturday', '13:00:00', '14:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 5: Carlos Miguel Mendoza - 2nd Year (enrollment_ids: 59-64)
(61, 59, 'Monday', '08:00:00', '09:00:00', 'Room 301', 'IT Building', 1, 'Lecture', TRUE, NULL),
(62, 59, 'Wednesday', '08:00:00', '09:00:00', 'Room 301', 'IT Building', 1, 'Lecture', TRUE, NULL),
(63, 59, 'Friday', '13:00:00', '14:00:00', 'CompLab 2', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(64, 60, 'Tuesday', '08:00:00', '09:00:00', 'Room 302', 'IT Building', 2, 'Lecture', TRUE, NULL),
(65, 60, 'Thursday', '08:00:00', '09:00:00', 'Room 302', 'IT Building', 2, 'Lecture', TRUE, NULL),
(66, 60, 'Tuesday', '13:00:00', '14:00:00', 'CompLab 1', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(67, 61, 'Monday', '09:00:00', '10:00:00', 'Room 205', 'IT Building', 3, 'Lecture', TRUE, NULL),
(68, 61, 'Wednesday', '09:00:00', '10:00:00', 'Room 205', 'IT Building', 3, 'Lecture', TRUE, NULL),
(69, 61, 'Monday', '14:00:00', '15:00:00', 'CompLab 3', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(70, 62, 'Thursday', '09:00:00', '10:00:00', 'Room 401', 'IT Building', 4, 'Lecture', TRUE, NULL),
(71, 62, 'Thursday', '13:00:00', '14:00:00', 'CompLab 4', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(72, 63, 'Wednesday', '13:00:00', '14:00:00', 'Room 101', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(73, 64, 'Friday', '08:00:00', '09:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 7: Miguel Antonio Dela Cruz - BSCS 2nd Year (enrollment_ids: 91-96)
(74, 91, 'Monday', '10:00:00', '11:00:00', 'Room 303', 'IT Building', 1, 'Lecture', TRUE, NULL),
(75, 91, 'Wednesday', '10:00:00', '11:00:00', 'Room 303', 'IT Building', 1, 'Lecture', TRUE, NULL),
(76, 91, 'Monday', '15:00:00', '16:00:00', 'CompLab 5', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(77, 92, 'Tuesday', '10:00:00', '11:00:00', 'Room 304', 'IT Building', 2, 'Lecture', TRUE, NULL),
(78, 92, 'Thursday', '10:00:00', '11:00:00', 'Room 304', 'IT Building', 2, 'Lecture', TRUE, NULL),
(79, 92, 'Thursday', '15:00:00', '16:00:00', 'CompLab 2', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(80, 93, 'Monday', '13:00:00', '14:00:00', 'Room 206', 'IT Building', 3, 'Lecture', TRUE, NULL),
(81, 93, 'Wednesday', '13:00:00', '14:00:00', 'Room 206', 'IT Building', 3, 'Lecture', TRUE, NULL),
(82, 93, 'Wednesday', '15:00:00', '16:00:00', 'CompLab 3', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(83, 94, 'Friday', '09:00:00', '10:00:00', 'Room 402', 'IT Building', 4, 'Lecture', TRUE, NULL),
(84, 94, 'Friday', '10:00:00', '11:00:00', 'CompLab 4', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(85, 95, 'Tuesday', '13:00:00', '14:00:00', 'Room 102', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(86, 96, 'Saturday', '08:00:00', '09:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 8: Princess Joy Villanueva - BSIS 1st Year (enrollment_ids: 97-103)
(87, 97, 'Monday', '08:00:00', '09:00:00', 'Room 105', 'IT Building', 5, 'Lecture', TRUE, NULL),
(88, 97, 'Wednesday', '08:00:00', '09:00:00', 'Room 105', 'IT Building', 5, 'Lecture', TRUE, NULL),
(89, 97, 'Friday', '08:00:00', '09:00:00', 'Room 105', 'IT Building', 5, 'Lecture', TRUE, NULL),
(90, 98, 'Monday', '09:00:00', '10:00:00', 'Room 106', 'IT Building', 2, 'Lecture', TRUE, NULL),
(91, 98, 'Wednesday', '09:00:00', '10:00:00', 'Room 106', 'IT Building', 2, 'Lecture', TRUE, NULL),
(92, 98, 'Wednesday', '10:00:00', '11:00:00', 'CompLab 6', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(93, 99, 'Tuesday', '08:00:00', '09:00:00', 'Room 205', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(94, 99, 'Thursday', '08:00:00', '09:00:00', 'Room 205', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(95, 99, 'Tuesday', '09:00:00', '10:00:00', 'Room 205', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(96, 100, 'Tuesday', '10:00:00', '11:00:00', 'Room 206', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(97, 100, 'Thursday', '10:00:00', '11:00:00', 'Room 206', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(98, 100, 'Thursday', '11:00:00', '12:00:00', 'Room 206', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(99, 101, 'Friday', '09:00:00', '10:00:00', 'Room 303', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(100, 101, 'Friday', '10:00:00', '11:00:00', 'Room 303', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(101, 101, 'Friday', '11:00:00', '12:00:00', 'Room 303', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(102, 102, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(103, 103, 'Saturday', '13:00:00', '14:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 10: Samantha Rose Lim - BSBA 1st Year (enrollment_ids: 111-115)
(104, 111, 'Monday', '13:00:00', '14:00:00', 'Room 207', 'Business Bldg', 8, 'Lecture', TRUE, NULL),
(105, 111, 'Wednesday', '13:00:00', '14:00:00', 'Room 207', 'Business Bldg', 8, 'Lecture', TRUE, NULL),
(106, 111, 'Friday', '13:00:00', '14:00:00', 'Room 207', 'Business Bldg', 8, 'Lecture', TRUE, NULL),
(107, 112, 'Tuesday', '13:00:00', '14:00:00', 'Room 208', 'Business Bldg', 9, 'Lecture', TRUE, NULL),
(108, 112, 'Thursday', '13:00:00', '14:00:00', 'Room 208', 'Business Bldg', 9, 'Lecture', TRUE, NULL),
(109, 112, 'Thursday', '14:00:00', '15:00:00', 'Room 208', 'Business Bldg', 9, 'Lecture', TRUE, NULL),
(110, 113, 'Monday', '14:00:00', '15:00:00', 'Room 304', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(111, 113, 'Wednesday', '14:00:00', '15:00:00', 'Room 304', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(112, 113, 'Friday', '14:00:00', '15:00:00', 'Room 304', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(113, 114, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(114, 115, 'Saturday', '11:00:00', '12:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 11: Roberto James Santos Jr. - BSIT 2nd Year Irregular (enrollment_ids: 133-136)
(115, 133, 'Tuesday', '09:00:00', '10:00:00', 'Room 207', 'IT Building', 3, 'Lecture', TRUE, NULL),
(116, 133, 'Thursday', '09:00:00', '10:00:00', 'Room 207', 'IT Building', 3, 'Lecture', TRUE, NULL),
(117, 133, 'Tuesday', '10:00:00', '11:00:00', 'CompLab 5', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(118, 134, 'Monday', '10:00:00', '11:00:00', 'Room 403', 'IT Building', 4, 'Lecture', TRUE, NULL),
(119, 134, 'Wednesday', '10:00:00', '11:00:00', 'CompLab 6', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(120, 135, 'Friday', '13:00:00', '14:00:00', 'Room 103', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(121, 136, 'Saturday', '10:00:00', '11:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 12: Patricia Anne Gonzales - BSIT 1st Year (enrollment_ids: 137-143)
(122, 137, 'Monday', '08:00:00', '09:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(123, 137, 'Wednesday', '08:00:00', '09:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(124, 137, 'Friday', '08:00:00', '09:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(125, 138, 'Monday', '09:00:00', '10:00:00', 'Room 104', 'IT Building', 2, 'Lecture', TRUE, NULL),
(126, 138, 'Wednesday', '09:00:00', '10:00:00', 'Room 104', 'IT Building', 2, 'Lecture', TRUE, NULL),
(127, 138, 'Wednesday', '10:00:00', '11:00:00', 'CompLab 1', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(128, 139, 'Tuesday', '08:00:00', '09:00:00', 'Room 202', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(129, 139, 'Thursday', '08:00:00', '09:00:00', 'Room 202', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(130, 139, 'Tuesday', '09:00:00', '10:00:00', 'Room 202', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(131, 140, 'Tuesday', '10:00:00', '11:00:00', 'Room 203', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(132, 140, 'Thursday', '10:00:00', '11:00:00', 'Room 203', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(133, 140, 'Thursday', '11:00:00', '12:00:00', 'Room 203', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(134, 141, 'Friday', '09:00:00', '10:00:00', 'Room 305', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(135, 141, 'Friday', '10:00:00', '11:00:00', 'Room 305', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(136, 141, 'Friday', '11:00:00', '12:00:00', 'Room 305', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(137, 142, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(138, 143, 'Saturday', '13:00:00', '14:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 13: Mark Anthony Rivera - BSCS 1st Year (enrollment_ids: 144-150)
(139, 144, 'Monday', '10:00:00', '11:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(140, 144, 'Wednesday', '10:00:00', '11:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(141, 144, 'Friday', '10:00:00', '11:00:00', 'Room 103', 'IT Building', 5, 'Lecture', TRUE, NULL),
(142, 145, 'Monday', '13:00:00', '14:00:00', 'Room 104', 'IT Building', 2, 'Lecture', TRUE, NULL),
(143, 145, 'Wednesday', '13:00:00', '14:00:00', 'Room 104', 'IT Building', 2, 'Lecture', TRUE, NULL),
(144, 145, 'Monday', '14:00:00', '15:00:00', 'CompLab 2', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(145, 146, 'Tuesday', '13:00:00', '14:00:00', 'Room 203', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(146, 146, 'Thursday', '13:00:00', '14:00:00', 'Room 203', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(147, 146, 'Tuesday', '14:00:00', '15:00:00', 'Room 203', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(148, 147, 'Tuesday', '15:00:00', '16:00:00', 'Room 204', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(149, 147, 'Thursday', '15:00:00', '16:00:00', 'Room 204', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(150, 147, 'Thursday', '16:00:00', '17:00:00', 'Room 204', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(151, 148, 'Friday', '13:00:00', '14:00:00', 'Room 306', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(152, 148, 'Friday', '14:00:00', '15:00:00', 'Room 306', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(153, 148, 'Friday', '15:00:00', '16:00:00', 'Room 306', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(154, 149, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(155, 150, 'Saturday', '15:00:00', '16:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, 'Athlete schedule'),

-- Student 14: Christine Joy Bautista - BSIS 2nd Year (enrollment_ids: 164-169)
(156, 164, 'Monday', '08:00:00', '09:00:00', 'Room 305', 'IT Building', 1, 'Lecture', TRUE, NULL),
(157, 164, 'Wednesday', '08:00:00', '09:00:00', 'Room 305', 'IT Building', 1, 'Lecture', TRUE, NULL),
(158, 164, 'Friday', '10:00:00', '11:00:00', 'CompLab 3', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(159, 165, 'Tuesday', '08:00:00', '09:00:00', 'Room 306', 'IT Building', 2, 'Lecture', TRUE, NULL),
(160, 165, 'Thursday', '08:00:00', '09:00:00', 'Room 306', 'IT Building', 2, 'Lecture', TRUE, NULL),
(161, 165, 'Tuesday', '09:00:00', '10:00:00', 'CompLab 4', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(162, 166, 'Monday', '09:00:00', '10:00:00', 'Room 208', 'IT Building', 3, 'Lecture', TRUE, NULL),
(163, 166, 'Wednesday', '09:00:00', '10:00:00', 'Room 208', 'IT Building', 3, 'Lecture', TRUE, NULL),
(164, 166, 'Monday', '10:00:00', '11:00:00', 'CompLab 5', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(165, 167, 'Thursday', '10:00:00', '11:00:00', 'Room 404', 'IT Building', 4, 'Lecture', TRUE, NULL),
(166, 167, 'Thursday', '11:00:00', '12:00:00', 'CompLab 6', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(167, 168, 'Wednesday', '13:00:00', '14:00:00', 'Room 104', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(168, 169, 'Friday', '08:00:00', '09:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 15: Joshua David Fernandez - BSCE 1st Year (enrollment_ids: 170-176)
(169, 170, 'Monday', '13:00:00', '14:00:00', 'Room 105', 'IT Building', 5, 'Lecture', TRUE, NULL),
(170, 170, 'Wednesday', '13:00:00', '14:00:00', 'Room 105', 'IT Building', 5, 'Lecture', TRUE, NULL),
(171, 170, 'Friday', '13:00:00', '14:00:00', 'Room 105', 'IT Building', 5, 'Lecture', TRUE, NULL),
(172, 171, 'Monday', '14:00:00', '15:00:00', 'Room 106', 'IT Building', 2, 'Lecture', TRUE, NULL),
(173, 171, 'Wednesday', '14:00:00', '15:00:00', 'Room 106', 'IT Building', 2, 'Lecture', TRUE, NULL),
(174, 171, 'Monday', '15:00:00', '16:00:00', 'CompLab 1', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(175, 172, 'Tuesday', '08:00:00', '09:00:00', 'Room 205', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(176, 172, 'Thursday', '08:00:00', '09:00:00', 'Room 205', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(177, 172, 'Tuesday', '09:00:00', '10:00:00', 'Room 205', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(178, 173, 'Tuesday', '10:00:00', '11:00:00', 'Room 206', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(179, 173, 'Thursday', '10:00:00', '11:00:00', 'Room 206', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(180, 173, 'Thursday', '11:00:00', '12:00:00', 'Room 206', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(181, 174, 'Friday', '14:00:00', '15:00:00', 'Room 307', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(182, 174, 'Friday', '15:00:00', '16:00:00', 'Room 307', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(183, 174, 'Friday', '16:00:00', '17:00:00', 'Room 307', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(184, 175, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(185, 176, 'Saturday', '11:00:00', '12:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 16: Anna Marie Pascual - BSA 1st Year (enrollment_ids: 177-183)
(186, 177, 'Monday', '08:00:00', '09:00:00', 'Room 107', 'Business Bldg', 5, 'Lecture', TRUE, NULL),
(187, 177, 'Wednesday', '08:00:00', '09:00:00', 'Room 107', 'Business Bldg', 5, 'Lecture', TRUE, NULL),
(188, 177, 'Friday', '08:00:00', '09:00:00', 'Room 107', 'Business Bldg', 5, 'Lecture', TRUE, NULL),
(189, 178, 'Monday', '09:00:00', '10:00:00', 'Room 108', 'Business Bldg', 2, 'Lecture', TRUE, NULL),
(190, 178, 'Wednesday', '09:00:00', '10:00:00', 'Room 108', 'Business Bldg', 2, 'Lecture', TRUE, NULL),
(191, 178, 'Wednesday', '10:00:00', '11:00:00', 'CompLab 7', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(192, 179, 'Tuesday', '08:00:00', '09:00:00', 'Room 207', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(193, 179, 'Thursday', '08:00:00', '09:00:00', 'Room 207', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(194, 179, 'Tuesday', '09:00:00', '10:00:00', 'Room 207', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(195, 180, 'Tuesday', '10:00:00', '11:00:00', 'Room 208', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(196, 180, 'Thursday', '10:00:00', '11:00:00', 'Room 208', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(197, 180, 'Thursday', '11:00:00', '12:00:00', 'Room 208', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(198, 181, 'Friday', '09:00:00', '10:00:00', 'Room 308', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(199, 181, 'Friday', '10:00:00', '11:00:00', 'Room 308', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(200, 181, 'Friday', '11:00:00', '12:00:00', 'Room 308', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(201, 182, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(202, 183, 'Saturday', '13:00:00', '14:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 17: Kevin John Tolentino - BSIT 2nd Year (enrollment_ids: 197-202) - Evening classes for working student
(203, 197, 'Monday', '17:00:00', '18:00:00', 'Room 309', 'IT Building', 1, 'Lecture', TRUE, 'Evening class'),
(204, 197, 'Wednesday', '17:00:00', '18:00:00', 'Room 309', 'IT Building', 1, 'Lecture', TRUE, 'Evening class'),
(205, 197, 'Friday', '17:00:00', '18:00:00', 'CompLab 8', 'IT Building', 1, 'Laboratory', TRUE, 'Evening lab'),
(206, 198, 'Tuesday', '17:00:00', '18:00:00', 'Room 310', 'IT Building', 2, 'Lecture', TRUE, 'Evening class'),
(207, 198, 'Thursday', '17:00:00', '18:00:00', 'Room 310', 'IT Building', 2, 'Lecture', TRUE, 'Evening class'),
(208, 198, 'Tuesday', '18:00:00', '19:00:00', 'CompLab 8', 'IT Building', 2, 'Laboratory', TRUE, 'Evening lab'),
(209, 199, 'Monday', '18:00:00', '19:00:00', 'Room 209', 'IT Building', 3, 'Lecture', TRUE, 'Evening class'),
(210, 199, 'Wednesday', '18:00:00', '19:00:00', 'Room 209', 'IT Building', 3, 'Lecture', TRUE, 'Evening class'),
(211, 199, 'Wednesday', '19:00:00', '20:00:00', 'CompLab 9', 'IT Building', 3, 'Laboratory', TRUE, 'Evening lab'),
(212, 200, 'Thursday', '18:00:00', '19:00:00', 'Room 405', 'IT Building', 4, 'Lecture', TRUE, 'Evening class'),
(213, 200, 'Thursday', '19:00:00', '20:00:00', 'CompLab 9', 'IT Building', 4, 'Laboratory', TRUE, 'Evening lab'),
(214, 201, 'Saturday', '08:00:00', '09:00:00', 'Room 105', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, 'Weekend class'),
(215, 202, 'Saturday', '13:00:00', '14:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 18: Rachel Marie Domingo - BSIT 1st Year (enrollment_ids: 203-209)
(216, 203, 'Monday', '08:00:00', '09:00:00', 'Room 109', 'IT Building', 5, 'Lecture', TRUE, NULL),
(217, 203, 'Wednesday', '08:00:00', '09:00:00', 'Room 109', 'IT Building', 5, 'Lecture', TRUE, NULL),
(218, 203, 'Friday', '08:00:00', '09:00:00', 'Room 109', 'IT Building', 5, 'Lecture', TRUE, NULL),
(219, 204, 'Monday', '09:00:00', '10:00:00', 'Room 110', 'IT Building', 2, 'Lecture', TRUE, NULL),
(220, 204, 'Wednesday', '09:00:00', '10:00:00', 'Room 110', 'IT Building', 2, 'Lecture', TRUE, NULL),
(221, 204, 'Monday', '10:00:00', '11:00:00', 'CompLab 3', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(222, 205, 'Tuesday', '08:00:00', '09:00:00', 'Room 209', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(223, 205, 'Thursday', '08:00:00', '09:00:00', 'Room 209', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(224, 205, 'Tuesday', '09:00:00', '10:00:00', 'Room 209', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(225, 206, 'Tuesday', '10:00:00', '11:00:00', 'Room 210', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(226, 206, 'Thursday', '10:00:00', '11:00:00', 'Room 210', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(227, 206, 'Thursday', '11:00:00', '12:00:00', 'Room 210', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(228, 207, 'Friday', '09:00:00', '10:00:00', 'Room 309', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(229, 207, 'Friday', '10:00:00', '11:00:00', 'Room 309', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(230, 207, 'Friday', '11:00:00', '12:00:00', 'Room 309', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(231, 208, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(232, 209, 'Saturday', '11:00:00', '12:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 19: Gabriel Luis Ramos - BSCS 2nd Year (enrollment_ids: 223-228)
(233, 223, 'Monday', '08:00:00', '09:00:00', 'Room 311', 'IT Building', 1, 'Lecture', TRUE, NULL),
(234, 223, 'Wednesday', '08:00:00', '09:00:00', 'Room 311', 'IT Building', 1, 'Lecture', TRUE, NULL),
(235, 223, 'Friday', '08:00:00', '09:00:00', 'CompLab 4', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(236, 224, 'Tuesday', '08:00:00', '09:00:00', 'Room 312', 'IT Building', 2, 'Lecture', TRUE, NULL),
(237, 224, 'Thursday', '08:00:00', '09:00:00', 'Room 312', 'IT Building', 2, 'Lecture', TRUE, NULL),
(238, 224, 'Thursday', '09:00:00', '10:00:00', 'CompLab 5', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(239, 225, 'Monday', '09:00:00', '10:00:00', 'Room 210', 'IT Building', 3, 'Lecture', TRUE, NULL),
(240, 225, 'Wednesday', '09:00:00', '10:00:00', 'Room 210', 'IT Building', 3, 'Lecture', TRUE, NULL),
(241, 225, 'Monday', '10:00:00', '11:00:00', 'CompLab 6', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(242, 226, 'Thursday', '13:00:00', '14:00:00', 'Room 406', 'IT Building', 4, 'Lecture', TRUE, NULL),
(243, 226, 'Thursday', '14:00:00', '15:00:00', 'CompLab 7', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(244, 227, 'Tuesday', '13:00:00', '14:00:00', 'Room 106', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(245, 228, 'Friday', '11:00:00', '12:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 20: Jasmine Claire Soriano - BSBA 1st Year (enrollment_ids: 229-235)
(246, 229, 'Monday', '13:00:00', '14:00:00', 'Room 209', 'Business Bldg', 5, 'Lecture', TRUE, NULL),
(247, 229, 'Wednesday', '13:00:00', '14:00:00', 'Room 209', 'Business Bldg', 5, 'Lecture', TRUE, NULL),
(248, 229, 'Friday', '13:00:00', '14:00:00', 'Room 209', 'Business Bldg', 5, 'Lecture', TRUE, NULL),
(249, 230, 'Monday', '14:00:00', '15:00:00', 'Room 210', 'Business Bldg', 2, 'Lecture', TRUE, NULL),
(250, 230, 'Wednesday', '14:00:00', '15:00:00', 'Room 210', 'Business Bldg', 2, 'Lecture', TRUE, NULL),
(251, 230, 'Monday', '15:00:00', '16:00:00', 'CompLab 10', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(252, 231, 'Tuesday', '13:00:00', '14:00:00', 'Room 211', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(253, 231, 'Thursday', '13:00:00', '14:00:00', 'Room 211', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(254, 231, 'Tuesday', '14:00:00', '15:00:00', 'Room 211', 'Liberal Arts Bldg', 8, 'Lecture', TRUE, NULL),
(255, 232, 'Tuesday', '15:00:00', '16:00:00', 'Room 212', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(256, 232, 'Thursday', '15:00:00', '16:00:00', 'Room 212', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(257, 232, 'Thursday', '16:00:00', '17:00:00', 'Room 212', 'Liberal Arts Bldg', 9, 'Lecture', TRUE, NULL),
(258, 233, 'Friday', '14:00:00', '15:00:00', 'Room 310', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(259, 233, 'Friday', '15:00:00', '16:00:00', 'Room 310', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(260, 233, 'Friday', '16:00:00', '17:00:00', 'Room 310', 'Science Bldg', 10, 'Lecture', TRUE, NULL),
(261, 234, 'Saturday', '08:00:00', '09:00:00', 'NSTP Hall', 'Admin Building', NULL, 'Lecture', TRUE, NULL),
(262, 235, 'Saturday', '13:00:00', '14:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 22: Jerome Paul Villanueva - BSIT 3rd Year (enrollment_ids: 310-315)
(263, 310, 'Monday', '08:00:00', '09:00:00', 'Room 401', 'IT Building', 1, 'Lecture', TRUE, NULL),
(264, 310, 'Wednesday', '08:00:00', '09:00:00', 'Room 401', 'IT Building', 1, 'Lecture', TRUE, NULL),
(265, 310, 'Friday', '08:00:00', '09:00:00', 'CompLab 5', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(266, 311, 'Tuesday', '08:00:00', '09:00:00', 'Room 402', 'IT Building', 2, 'Lecture', TRUE, NULL),
(267, 311, 'Thursday', '08:00:00', '09:00:00', 'Room 402', 'IT Building', 2, 'Lecture', TRUE, NULL),
(268, 311, 'Tuesday', '09:00:00', '10:00:00', 'CompLab 6', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(269, 312, 'Monday', '09:00:00', '10:00:00', 'Room 403', 'IT Building', 3, 'Lecture', TRUE, NULL),
(270, 312, 'Wednesday', '09:00:00', '10:00:00', 'Room 403', 'IT Building', 3, 'Lecture', TRUE, NULL),
(271, 312, 'Monday', '10:00:00', '11:00:00', 'CompLab 7', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(272, 313, 'Thursday', '10:00:00', '11:00:00', 'Room 404', 'IT Building', 4, 'Lecture', TRUE, NULL),
(273, 313, 'Thursday', '11:00:00', '12:00:00', 'CompLab 8', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(274, 314, 'Wednesday', '13:00:00', '14:00:00', 'Room 301', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(275, 315, 'Friday', '13:00:00', '14:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 23: Michelle Anne Lim - BSCS 3rd Year (enrollment_ids: 341-346)
(276, 341, 'Monday', '10:00:00', '11:00:00', 'Room 405', 'IT Building', 1, 'Lecture', TRUE, NULL),
(277, 341, 'Wednesday', '10:00:00', '11:00:00', 'Room 405', 'IT Building', 1, 'Lecture', TRUE, NULL),
(278, 341, 'Friday', '10:00:00', '11:00:00', 'CompLab 9', 'IT Building', 1, 'Laboratory', TRUE, NULL),
(279, 342, 'Tuesday', '10:00:00', '11:00:00', 'Room 406', 'IT Building', 2, 'Lecture', TRUE, NULL),
(280, 342, 'Thursday', '10:00:00', '11:00:00', 'Room 406', 'IT Building', 2, 'Lecture', TRUE, NULL),
(281, 342, 'Tuesday', '11:00:00', '12:00:00', 'CompLab 10', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(282, 343, 'Monday', '13:00:00', '14:00:00', 'Room 407', 'IT Building', 3, 'Lecture', TRUE, NULL),
(283, 343, 'Wednesday', '13:00:00', '14:00:00', 'Room 407', 'IT Building', 3, 'Lecture', TRUE, NULL),
(284, 343, 'Monday', '14:00:00', '15:00:00', 'CompLab 11', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(285, 344, 'Thursday', '13:00:00', '14:00:00', 'Room 408', 'IT Building', 4, 'Lecture', TRUE, NULL),
(286, 344, 'Thursday', '14:00:00', '15:00:00', 'CompLab 12', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(287, 345, 'Wednesday', '15:00:00', '16:00:00', 'Room 302', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(288, 346, 'Friday', '14:00:00', '15:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 24: Daniel Joseph Cruz - BSIT 4th Year (enrollment_ids: 383-388)
(289, 383, 'Monday', '08:00:00', '09:00:00', 'Room 501', 'IT Building', 1, 'Lecture', TRUE, 'Thesis/Capstone'),
(290, 383, 'Wednesday', '08:00:00', '09:00:00', 'Room 501', 'IT Building', 1, 'Lecture', TRUE, 'Thesis Defense Prep'),
(291, 384, 'Tuesday', '08:00:00', '09:00:00', 'Room 502', 'IT Building', 2, 'Lecture', TRUE, NULL),
(292, 384, 'Thursday', '08:00:00', '09:00:00', 'Room 502', 'IT Building', 2, 'Lecture', TRUE, NULL),
(293, 384, 'Tuesday', '09:00:00', '10:00:00', 'CompLab 13', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(294, 385, 'Monday', '13:00:00', '14:00:00', 'Room 503', 'IT Building', 3, 'Lecture', TRUE, NULL),
(295, 385, 'Wednesday', '13:00:00', '14:00:00', 'Room 503', 'IT Building', 3, 'Lecture', TRUE, NULL),
(296, 385, 'Monday', '14:00:00', '15:00:00', 'CompLab 14', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(297, 386, 'Thursday', '10:00:00', '11:00:00', 'Room 504', 'IT Building', 4, 'Lecture', TRUE, NULL),
(298, 386, 'Thursday', '11:00:00', '12:00:00', 'CompLab 15', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(299, 387, 'Friday', '08:00:00', '09:00:00', 'Room 303', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(300, 388, 'Saturday', '08:00:00', '09:00:00', 'Covered Court', 'Sports Complex', 7, 'Lecture', TRUE, NULL),

-- Student 25: Angela Faith Santos - BSCS 4th Year (enrollment_ids: 425-430)
(301, 425, 'Monday', '10:00:00', '11:00:00', 'Room 505', 'IT Building', 1, 'Lecture', TRUE, 'Thesis/Capstone'),
(302, 425, 'Wednesday', '10:00:00', '11:00:00', 'Room 505', 'IT Building', 1, 'Lecture', TRUE, 'Thesis Defense Prep'),
(303, 426, 'Tuesday', '10:00:00', '11:00:00', 'Room 506', 'IT Building', 2, 'Lecture', TRUE, NULL),
(304, 426, 'Thursday', '10:00:00', '11:00:00', 'Room 506', 'IT Building', 2, 'Lecture', TRUE, NULL),
(305, 426, 'Tuesday', '11:00:00', '12:00:00', 'CompLab 16', 'IT Building', 2, 'Laboratory', TRUE, NULL),
(306, 427, 'Monday', '14:00:00', '15:00:00', 'Room 507', 'IT Building', 3, 'Lecture', TRUE, NULL),
(307, 427, 'Wednesday', '14:00:00', '15:00:00', 'Room 507', 'IT Building', 3, 'Lecture', TRUE, NULL),
(308, 427, 'Monday', '15:00:00', '16:00:00', 'CompLab 17', 'IT Building', 3, 'Laboratory', TRUE, NULL),
(309, 428, 'Thursday', '13:00:00', '14:00:00', 'Room 508', 'IT Building', 4, 'Lecture', TRUE, NULL),
(310, 428, 'Thursday', '14:00:00', '15:00:00', 'CompLab 18', 'IT Building', 4, 'Laboratory', TRUE, NULL),
(311, 429, 'Friday', '10:00:00', '11:00:00', 'Room 304', 'Liberal Arts Bldg', 6, 'Lecture', TRUE, NULL),
(312, 430, 'Saturday', '10:00:00', '11:00:00', 'Gymnasium', 'Sports Complex', 7, 'Lecture', TRUE, NULL);

-- ============================================================
-- PAYMENTS
-- All Students
-- ============================================================
INSERT INTO payments (payment_id, student_id, payment_type_id, academic_year_id, description, amount_due, amount_paid, payment_date, due_date, payment_method, reference_number, payment_status, processed_by, remarks) VALUES

-- Student 1: Reginald Cano (14 payments - original)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(1, 1, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081001', 'Paid', 3, 'Full payment for 1st sem'),
(2, 1, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081002', 'Paid', 3, NULL),
(3, 1, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081003', 'Paid', 3, NULL),
(4, 1, 4, 4, 'NSTP Fee', 1000.00, 1000.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081004', 'Paid', 3, NULL),
(5, 1, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081005', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(6, 1, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BDO-2025-010501', 'Paid', 3, 'Full payment via BDO'),
(7, 1, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BDO-2025-010502', 'Paid', 3, NULL),
(8, 1, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BDO-2025-010503', 'Paid', 3, NULL),
(9, 1, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BDO-2025-010504', 'Paid', 3, NULL),
(10, 1, 8, 5, 'Student Insurance', 1500.00, 1500.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BDO-2025-010505', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current - Partial Payment
(11, 1, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 15000.00, '2025-08-12', '2025-08-20', 'Bank Transfer', 'BDO-2025-081201', 'Partial', 3, 'Initial payment - balance due'),
(12, 1, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-12', '2025-08-20', 'Bank Transfer', 'BDO-2025-081202', 'Paid', 3, NULL),
(13, 1, 3, 7, 'Miscellaneous Fee', 8500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, NULL),
(14, 1, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, NULL),

-- Student 2: Maria Elena Santos - 1st Year (Government Scholar - reduced fees)
(15, 2, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'GOV-CHED-2025-001', 'Paid', 3, 'CHED Scholarship - Full Tuition'),
(16, 2, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'GOV-CHED-2025-002', 'Paid', 3, 'CHED covers lab fees'),
(17, 2, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081101', 'Paid', 3, 'Parent paid cash'),
(18, 2, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081102', 'Paid', 3, NULL),
(19, 2, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081103', 'Paid', 3, NULL),

-- Student 3: Juan Carlos Reyes - 2nd Year (Partial Scholar)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(20, 3, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081201', 'Paid', 3, NULL),
(21, 3, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081202', 'Paid', 3, NULL),
(22, 3, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081203', 'Paid', 3, NULL),
(23, 3, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081204', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(24, 3, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010601', 'Paid', 3, NULL),
(25, 3, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010602', 'Paid', 3, NULL),
(26, 3, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010603', 'Paid', 3, NULL),
(27, 3, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010604', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Partial (scholarship covers 50%)
(28, 3, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-08-12', '2025-08-20', 'Scholarship', 'PRIV-DEL-2025-001', 'Paid', 3, 'Deans List Scholarship - 50% tuition'),
(29, 3, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-12', '2025-08-20', 'Bank Transfer', 'BPI-2025-081201', 'Paid', 3, NULL),
(30, 3, 3, 7, 'Miscellaneous Fee', 8500.00, 4250.00, '2025-08-12', '2025-08-20', 'Bank Transfer', 'BPI-2025-081202', 'Partial', 3, 'Installment 1 of 2'),
(31, 3, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, NULL),

-- Student 4: Angela Rose Cruz - BSCS 1st Year (Full Scholar - all fees covered)
(32, 4, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ACAD-EXC-2025-001', 'Paid', 3, 'Academic Excellence Award'),
(33, 4, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ACAD-EXC-2025-002', 'Paid', 3, NULL),
(34, 4, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ACAD-EXC-2025-003', 'Paid', 3, NULL),
(35, 4, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ACAD-EXC-2025-004', 'Paid', 3, NULL),
(36, 4, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ACAD-EXC-2025-005', 'Paid', 3, NULL),

-- Student 5: Carlos Miguel Mendoza - Transferee (pays normal fees)
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(37, 5, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-06', '2025-01-10', 'Online Payment', 'GCASH-2025-010601', 'Paid', 3, 'GCash payment'),
(38, 5, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', '2025-01-10', 'Online Payment', 'GCASH-2025-010602', 'Paid', 3, NULL),
(39, 5, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', '2025-01-10', 'Online Payment', 'GCASH-2025-010603', 'Paid', 3, NULL),
(40, 5, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-01-06', '2025-01-10', 'Online Payment', 'GCASH-2025-010604', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Has balance
(41, 5, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 20000.00, '2025-08-12', '2025-08-20', 'Online Payment', 'GCASH-2025-081201', 'Partial', 3, 'Partial via GCash'),
(42, 5, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-12', '2025-08-20', 'Online Payment', 'GCASH-2025-081202', 'Paid', 3, NULL),
(43, 5, 3, 7, 'Miscellaneous Fee', 8500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, NULL),
(44, 5, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, NULL),

-- Student 6: Sofia Isabel Garcia - On Leave (completed 1st year payments only)
-- 1st Year, 1st Semester (S.Y. 2024-2025) - Fully Paid
(45, 6, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'METRO-2024-081201', 'Paid', 3, NULL),
(46, 6, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'METRO-2024-081202', 'Paid', 3, NULL),
(47, 6, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'METRO-2024-081203', 'Paid', 3, NULL),
(48, 6, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'METRO-2024-081204', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025) - Fully Paid
(49, 6, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'METRO-2025-010601', 'Paid', 3, NULL),
(50, 6, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'METRO-2025-010602', 'Paid', 3, NULL),
(51, 6, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'METRO-2025-010603', 'Paid', 3, NULL),
(52, 6, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'METRO-2025-010604', 'Paid', 3, NULL),

-- Student 7: Miguel Antonio Dela Cruz - BSCS 2nd Year (Dean's Lister - Partial Scholar)
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(53, 7, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'UB-2024-081201', 'Paid', 3, NULL),
(54, 7, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'UB-2024-081202', 'Paid', 3, NULL),
(55, 7, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'UB-2024-081203', 'Paid', 3, NULL),
(56, 7, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'UB-2024-081204', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(57, 7, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'UB-2025-010601', 'Paid', 3, NULL),
(58, 7, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'UB-2025-010602', 'Paid', 3, NULL),
(59, 7, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'UB-2025-010603', 'Paid', 3, NULL),
(60, 7, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'UB-2025-010604', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Scholarship covers 50%
(61, 7, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'DL-SCHOLAR-2025-001', 'Paid', 3, 'Deans List 50% Scholarship'),
(62, 7, 2, 7, 'Computer Laboratory Fee', 5000.00, 2500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'DL-SCHOLAR-2025-002', 'Partial', 3, '50% covered'),
(63, 7, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081101', 'Paid', 3, NULL),
(64, 7, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081102', 'Paid', 3, NULL),

-- Student 8: Princess Joy Villanueva - BSIS 1st Year (paying installments)
(65, 8, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 15000.00, '2025-08-11', '2025-08-20', 'Installment', 'INST-2025-081101', 'Partial', 3, 'First of 2 installments'),
(66, 8, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081102', 'Paid', 3, NULL),
(67, 8, 3, 7, 'Miscellaneous Fee', 8500.00, 4250.00, '2025-08-11', '2025-08-20', 'Installment', 'INST-2025-081103', 'Partial', 3, 'First installment'),
(68, 8, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081104', 'Paid', 3, NULL),
(69, 8, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Due next payment'),

-- Student 9: John Patrick Aquino - Dropped (partial payments only)
(70, 9, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 10000.00, '2024-08-12', '2024-08-15', 'Cash', 'CASH-2024-081201', 'Partial', 3, 'Dropped - balance remains'),
(71, 9, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', '2024-08-15', 'Cash', 'CASH-2024-081202', 'Paid', 3, NULL),
(72, 9, 7, 4, 'Energy Fee', 3500.00, 0.00, NULL, '2024-08-15', NULL, NULL, 'Unpaid', NULL, 'Never paid - dropped'),

-- Student 10: Samantha Rose Lim - BSBA 1st Year (Private Scholar - company sponsored)
(73, 10, 1, 7, 'Tuition Fee (14 units x P1,500)', 21000.00, 21000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'LIM-CORP-2025-001', 'Paid', 3, 'Family business scholarship'),
(74, 10, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'LIM-CORP-2025-002', 'Paid', 3, NULL),
(75, 10, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'LIM-CORP-2025-003', 'Paid', 3, NULL),
(76, 10, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'LIM-CORP-2025-004', 'Paid', 3, NULL),

-- Student 11: Roberto James Santos Jr. - Irregular (long payment history)
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(77, 11, 1, 1, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2023-08-14', '2023-08-20', 'Bank Transfer', 'PNB-2023-081401', 'Paid', 3, NULL),
(78, 11, 2, 1, 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-14', '2023-08-20', 'Bank Transfer', 'PNB-2023-081402', 'Paid', 3, NULL),
(79, 11, 3, 1, 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-14', '2023-08-20', 'Bank Transfer', 'PNB-2023-081403', 'Paid', 3, NULL),
(80, 11, 7, 1, 'Energy Fee', 3500.00, 3500.00, '2023-08-14', '2023-08-20', 'Bank Transfer', 'PNB-2023-081404', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester (S.Y. 2023-2024)
(81, 11, 1, 2, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-01-08', '2024-01-15', 'Bank Transfer', 'PNB-2024-010801', 'Paid', 3, NULL),
(82, 11, 2, 2, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-08', '2024-01-15', 'Bank Transfer', 'PNB-2024-010802', 'Paid', 3, NULL),
(83, 11, 3, 2, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-08', '2024-01-15', 'Bank Transfer', 'PNB-2024-010803', 'Paid', 3, NULL),
(84, 11, 7, 2, 'Energy Fee', 3500.00, 3500.00, '2024-01-08', '2024-01-15', 'Bank Transfer', 'PNB-2024-010804', 'Paid', 3, NULL),
-- Retake semester (S.Y. 2024-2025, 1st Sem)
(85, 11, 1, 4, 'Tuition Fee (retake 2 + new 6 units)', 12000.00, 12000.00, '2024-08-12', '2024-08-20', 'Bank Transfer', 'PNB-2024-081201', 'Paid', 3, 'Retake subjects included'),
(86, 11, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', '2024-08-20', 'Bank Transfer', 'PNB-2024-081202', 'Paid', 3, NULL),
(87, 11, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', '2024-08-20', 'Bank Transfer', 'PNB-2024-081203', 'Paid', 3, NULL),
(88, 11, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-08-12', '2024-08-20', 'Bank Transfer', 'PNB-2024-081204', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026) - Current
(89, 11, 1, 7, 'Tuition Fee (11 units x P1,500)', 16500.00, 16500.00, '2025-08-11', '2025-08-20', 'Online Payment', 'MAYA-2025-081101', 'Paid', 3, 'Paid via Maya'),
(90, 11, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Online Payment', 'MAYA-2025-081102', 'Paid', 3, NULL),
(91, 11, 3, 7, 'Miscellaneous Fee', 8500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Pending payment'),
(92, 11, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Pending payment'),

-- Student 12: Patricia Anne Gonzales - BSIT 1st Year (Regular - full payment)
(93, 12, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081103', 'Paid', 3, 'Full payment'),
(94, 12, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081104', 'Paid', 3, NULL),
(95, 12, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081105', 'Paid', 3, NULL),
(96, 12, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081106', 'Paid', 3, NULL),
(97, 12, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081107', 'Paid', 3, NULL),

-- Student 13: Mark Anthony Rivera - BSCS 1st Year (Athlete Full Scholar)
(98, 13, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ATH-BBall-2025-001', 'Paid', 3, 'Athletic Scholarship - Basketball'),
(99, 13, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ATH-BBall-2025-002', 'Paid', 3, NULL),
(100, 13, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ATH-BBall-2025-003', 'Paid', 3, NULL),
(101, 13, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ATH-BBall-2025-004', 'Paid', 3, NULL),
(102, 13, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'ATH-BBall-2025-005', 'Paid', 3, NULL),

-- Student 14: Christine Joy Bautista - BSIS 2nd Year (Payment history)
-- 1st Year, 1st Semester (S.Y. 2024-2025)
(103, 14, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'MB-2024-081201', 'Paid', 3, NULL),
(104, 14, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'MB-2024-081202', 'Paid', 3, NULL),
(105, 14, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'MB-2024-081203', 'Paid', 3, NULL),
(106, 14, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'MB-2024-081204', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester (S.Y. 2024-2025)
(107, 14, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'MB-2025-010601', 'Paid', 3, NULL),
(108, 14, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'MB-2025-010602', 'Paid', 3, NULL),
(109, 14, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'MB-2025-010603', 'Paid', 3, NULL),
(110, 14, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'MB-2025-010604', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2025-2026)
(111, 14, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 15000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'MB-2025-081101', 'Partial', 3, 'Installment 1'),
(112, 14, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'MB-2025-081102', 'Paid', 3, NULL),
(113, 14, 3, 7, 'Miscellaneous Fee', 8500.00, 4250.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'MB-2025-081103', 'Partial', 3, 'Installment 1'),
(114, 14, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Due next payment'),

-- Student 15: Joshua David Fernandez - BSCE 1st Year (partial payer)
(115, 15, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 20000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'RCBC-2025-081101', 'Partial', 3, 'First installment'),
(116, 15, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'RCBC-2025-081102', 'Paid', 3, NULL),
(117, 15, 3, 7, 'Miscellaneous Fee', 8500.00, 4250.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'RCBC-2025-081103', 'Partial', 3, 'First installment'),
(118, 15, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'RCBC-2025-081104', 'Paid', 3, NULL),
(119, 15, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Due later'),

-- Student 16: Anna Marie Pascual - BSA 1st Year (Government Scholar)
(120, 16, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'CHED-TES-2025-001', 'Paid', 3, 'CHED TES Scholarship'),
(121, 16, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'CHED-TES-2025-002', 'Paid', 3, NULL),
(122, 16, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'CHED-TES-2025-003', 'Paid', 3, NULL),
(123, 16, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'CHED-TES-2025-004', 'Paid', 3, NULL),
(124, 16, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'CHED-TES-2025-005', 'Paid', 3, NULL),

-- Student 17: Kevin John Tolentino - BSIT 2nd Year (Working student - installments)
-- 1st Year payments
(125, 17, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2024-08-12', '2024-08-15', 'Installment', 'KT-2024-081201', 'Paid', 3, 'Paid in 3 installments'),
(126, 17, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', '2024-08-15', 'Cash', 'CASH-2024-081202', 'Paid', 3, NULL),
(127, 17, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-09-15', '2024-08-15', 'Installment', 'KT-2024-091501', 'Paid', 3, 'Late payment'),
(128, 17, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-10-15', '2024-08-15', 'Installment', 'KT-2024-101501', 'Paid', 3, 'Late payment'),
-- 2nd semester
(129, 17, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-06', '2025-01-10', 'Installment', 'KT-2025-010601', 'Paid', 3, NULL),
(130, 17, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', '2025-01-10', 'Cash', 'CASH-2025-010602', 'Paid', 3, NULL),
(131, 17, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-02-15', '2025-01-10', 'Installment', 'KT-2025-021501', 'Paid', 3, 'Late payment'),
(132, 17, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-03-15', '2025-01-10', 'Installment', 'KT-2025-031501', 'Paid', 3, 'Late payment'),
-- Current semester - still paying
(133, 17, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 10000.00, '2025-08-11', '2025-08-20', 'Installment', 'KT-2025-081101', 'Partial', 3, 'First installment'),
(134, 17, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081102', 'Paid', 3, NULL),
(135, 17, 3, 7, 'Miscellaneous Fee', 8500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Next installment'),
(136, 17, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Next installment'),

-- Student 18: Rachel Marie Domingo - BSIT 1st Year (Transferee - partial payment)
(137, 18, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 15000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'LBP-2025-081101', 'Partial', 3, 'From Batangas'),
(138, 18, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'LBP-2025-081102', 'Paid', 3, NULL),
(139, 18, 3, 7, 'Miscellaneous Fee', 8500.00, 4250.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'LBP-2025-081103', 'Partial', 3, 'First installment'),
(140, 18, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'LBP-2025-081104', 'Paid', 3, NULL),
(141, 18, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Due later'),

-- Student 19: Gabriel Luis Ramos - BSCS 2nd Year (Dean's Lister - Partial Scholar)
-- 1st Year payments (regular price)
(142, 19, 1, 4, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081205', 'Paid', 3, NULL),
(143, 19, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081206', 'Paid', 3, NULL),
(144, 19, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081207', 'Paid', 3, NULL),
(145, 19, 7, 4, 'Energy Fee', 3500.00, 3500.00, '2024-08-12', '2024-08-15', 'Bank Transfer', 'BPI-2024-081208', 'Paid', 3, NULL),
-- 2nd semester (became Dean's Lister - 50% off next sem)
(146, 19, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010605', 'Paid', 3, NULL),
(147, 19, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010606', 'Paid', 3, NULL),
(148, 19, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010607', 'Paid', 3, NULL),
(149, 19, 7, 5, 'Energy Fee', 3500.00, 3500.00, '2025-01-06', '2025-01-10', 'Bank Transfer', 'BPI-2025-010608', 'Paid', 3, NULL),
-- Current semester (50% scholarship for being Dean's Lister)
(150, 19, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'DL-2025-081101', 'Paid', 3, 'Deans List 50% discount applied'),
(151, 19, 2, 7, 'Computer Laboratory Fee', 5000.00, 2500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'DL-2025-081102', 'Partial', 3, '50% covered by scholarship'),
(152, 19, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BPI-2025-081205', 'Paid', 3, NULL),
(153, 19, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BPI-2025-081206', 'Paid', 3, NULL),

-- Student 20: Jasmine Claire Soriano - BSBA 1st Year (paying in installments)
(154, 20, 1, 7, 'Tuition Fee (20 units x P1,500)', 30000.00, 10000.00, '2025-08-11', '2025-08-20', 'Installment', 'INST-2025-081105', 'Partial', 3, 'First of 3 installments'),
(155, 20, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081106', 'Paid', 3, NULL),
(156, 20, 3, 7, 'Miscellaneous Fee', 8500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Next installment'),
(157, 20, 4, 7, 'NSTP Fee', 1000.00, 1000.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081107', 'Paid', 3, NULL),
(158, 20, 7, 7, 'Energy Fee', 3500.00, 0.00, NULL, '2025-08-20', NULL, NULL, 'Unpaid', NULL, 'Next installment'),

-- Student 21: Ryan Christopher Mercado - BSIT Graduated (Full 4-year payment history)
-- Year 1 Sem 1 (S.Y. 2021-2022)
(159, 21, 1, 9, 'Tuition Fee (20 units x P1,200)', 24000.00, 24000.00, '2021-08-10', '2021-08-15', 'Bank Transfer', 'OLD-2021-081001', 'Paid', 3, 'Old rate'),
(160, 21, 3, 9, 'Miscellaneous Fee', 6500.00, 6500.00, '2021-08-10', '2021-08-15', 'Bank Transfer', 'OLD-2021-081002', 'Paid', 3, 'Old rate'),
-- Year 1 Sem 2
(161, 21, 1, 10, 'Tuition Fee (17 units x P1,200)', 20400.00, 20400.00, '2022-01-10', '2022-01-15', 'Bank Transfer', 'OLD-2022-011001', 'Paid', 3, NULL),
(162, 21, 3, 10, 'Miscellaneous Fee', 6500.00, 6500.00, '2022-01-10', '2022-01-15', 'Bank Transfer', 'OLD-2022-011002', 'Paid', 3, NULL),
-- Year 2 Sem 1 (S.Y. 2022-2023)
(163, 21, 1, 11, 'Tuition Fee (18 units x P1,300)', 23400.00, 23400.00, '2022-08-10', '2022-08-15', 'Bank Transfer', 'OLD-2022-081001', 'Paid', 3, 'Rate increase'),
(164, 21, 3, 11, 'Miscellaneous Fee', 7000.00, 7000.00, '2022-08-10', '2022-08-15', 'Bank Transfer', 'OLD-2022-081002', 'Paid', 3, NULL),
-- Year 2 Sem 2
(165, 21, 1, 12, 'Tuition Fee (18 units x P1,300)', 23400.00, 23400.00, '2023-01-10', '2023-01-15', 'Bank Transfer', 'OLD-2023-011001', 'Paid', 3, NULL),
(166, 21, 3, 12, 'Miscellaneous Fee', 7000.00, 7000.00, '2023-01-10', '2023-01-15', 'Bank Transfer', 'OLD-2023-011002', 'Paid', 3, NULL),
-- Year 3 Sem 1 (S.Y. 2023-2024)
(167, 21, 1, 1, 'Tuition Fee (18 units x P1,400)', 25200.00, 25200.00, '2023-08-10', '2023-08-15', 'Bank Transfer', 'OLD-2023-081001', 'Paid', 3, 'Another rate increase'),
(168, 21, 3, 1, 'Miscellaneous Fee', 7500.00, 7500.00, '2023-08-10', '2023-08-15', 'Bank Transfer', 'OLD-2023-081002', 'Paid', 3, NULL),
-- Year 3 Sem 2
(169, 21, 1, 2, 'Tuition Fee (18 units x P1,400)', 25200.00, 25200.00, '2024-01-10', '2024-01-15', 'Bank Transfer', 'OLD-2024-011001', 'Paid', 3, NULL),
(170, 21, 3, 2, 'Miscellaneous Fee', 7500.00, 7500.00, '2024-01-10', '2024-01-15', 'Bank Transfer', 'OLD-2024-011002', 'Paid', 3, NULL),
-- Year 4 Sem 1 (S.Y. 2024-2025)
(171, 21, 1, 4, 'Tuition Fee (18 units x P1,500)', 27000.00, 27000.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'OLD-2024-081001', 'Paid', 3, 'Current rate'),
(172, 21, 3, 4, 'Miscellaneous Fee', 8000.00, 8000.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'OLD-2024-081002', 'Paid', 3, NULL),
-- Year 4 Sem 2 (Final semester - Graduation)
(173, 21, 1, 5, 'Tuition Fee (18 units x P1,500)', 27000.00, 27000.00, '2025-01-10', '2025-01-15', 'Bank Transfer', 'OLD-2025-011001', 'Paid', 3, 'Final semester'),
(174, 21, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-10', '2025-01-15', 'Bank Transfer', 'OLD-2025-011002', 'Paid', 3, NULL),
(175, 21, 9, 5, 'Graduation Fee', 5000.00, 5000.00, '2025-04-15', '2025-04-30', 'Bank Transfer', 'GRAD-2025-041501', 'Paid', 3, 'Graduation clearance'),

-- Student 22: Jerome Paul Villanueva - BSIT 3rd Year (Partial Scholar - Dean's Lister)
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(176, 22, 1, 1, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2023-08-10', '2023-08-15', 'Bank Transfer', 'BDO-2023-081001', 'Paid', 3, NULL),
(177, 22, 2, 1, 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-10', '2023-08-15', 'Bank Transfer', 'BDO-2023-081002', 'Paid', 3, NULL),
(178, 22, 3, 1, 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-10', '2023-08-15', 'Bank Transfer', 'BDO-2023-081003', 'Paid', 3, NULL),
(179, 22, 4, 1, 'NSTP Fee', 1000.00, 1000.00, '2023-08-10', '2023-08-15', 'Bank Transfer', 'BDO-2023-081004', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester
(180, 22, 1, 2, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-01-05', '2024-01-10', 'Bank Transfer', 'BDO-2024-010501', 'Paid', 3, NULL),
(181, 22, 2, 2, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-05', '2024-01-10', 'Bank Transfer', 'BDO-2024-010502', 'Paid', 3, NULL),
(182, 22, 3, 2, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-05', '2024-01-10', 'Bank Transfer', 'BDO-2024-010503', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(183, 22, 1, 4, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081001', 'Paid', 3, NULL),
(184, 22, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081002', 'Paid', 3, NULL),
(185, 22, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BDO-2024-081003', 'Paid', 3, NULL),
-- 2nd Year, 2nd Semester
(186, 22, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-05', '2025-01-10', 'Scholarship', 'DL-2025-010501', 'Paid', 3, 'Dean Lister Scholarship'),
(187, 22, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BDO-2025-010502', 'Paid', 3, NULL),
(188, 22, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BDO-2025-010503', 'Paid', 3, NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current
(189, 22, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'DL-2025-081101', 'Paid', 3, 'Dean Lister - 50% discount'),
(190, 22, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081102', 'Paid', 3, NULL),
(191, 22, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081103', 'Paid', 3, NULL),
(192, 22, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BDO-2025-081104', 'Paid', 3, NULL),

-- Student 23: Michelle Anne Lim - BSCS 3rd Year (Regular Student)
-- 1st Year, 1st Semester (S.Y. 2023-2024)
(193, 23, 1, 1, 'Tuition Fee (20 units x P1,500)', 30000.00, 30000.00, '2023-08-12', '2023-08-15', 'Bank Transfer', 'BPI-2023-081201', 'Paid', 3, NULL),
(194, 23, 2, 1, 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-12', '2023-08-15', 'Bank Transfer', 'BPI-2023-081202', 'Paid', 3, NULL),
(195, 23, 3, 1, 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-12', '2023-08-15', 'Bank Transfer', 'BPI-2023-081203', 'Paid', 3, NULL),
(196, 23, 4, 1, 'NSTP Fee', 1000.00, 1000.00, '2023-08-12', '2023-08-15', 'Bank Transfer', 'BPI-2023-081204', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester
(197, 23, 1, 2, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-01-05', '2024-01-10', 'Bank Transfer', 'BPI-2024-010501', 'Paid', 3, NULL),
(198, 23, 2, 2, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-05', '2024-01-10', 'Bank Transfer', 'BPI-2024-010502', 'Paid', 3, NULL),
(199, 23, 3, 2, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-05', '2024-01-10', 'Bank Transfer', 'BPI-2024-010503', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2024-2025)
(200, 23, 1, 4, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BPI-2024-081001', 'Paid', 3, NULL),
(201, 23, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BPI-2024-081002', 'Paid', 3, NULL),
(202, 23, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-10', '2024-08-15', 'Bank Transfer', 'BPI-2024-081003', 'Paid', 3, NULL),
-- 2nd Year, 2nd Semester
(203, 23, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BPI-2025-010501', 'Paid', 3, NULL),
(204, 23, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BPI-2025-010502', 'Paid', 3, NULL),
(205, 23, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', '2025-01-10', 'Bank Transfer', 'BPI-2025-010503', 'Paid', 3, NULL),
-- 3rd Year, 1st Semester (S.Y. 2025-2026) - Current
(206, 23, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BPI-2025-081101', 'Paid', 3, NULL),
(207, 23, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BPI-2025-081102', 'Paid', 3, NULL),
(208, 23, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BPI-2025-081103', 'Paid', 3, NULL),
(209, 23, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Bank Transfer', 'BPI-2025-081104', 'Paid', 3, NULL),

-- Student 24: Daniel Joseph Cruz - BSIT 4th Year (Full Scholar)
-- 1st Year, 1st Semester (S.Y. 2022-2023)
(210, 24, 1, 11, 'Tuition Fee (20 units x P1,400)', 28000.00, 28000.00, '2022-08-05', '2022-08-15', 'Scholarship', 'FULL-2022-080501', 'Paid', 3, 'Full Scholarship'),
(211, 24, 2, 11, 'Computer Laboratory Fee', 5000.00, 5000.00, '2022-08-05', '2022-08-15', 'Scholarship', 'FULL-2022-080502', 'Paid', 3, NULL),
(212, 24, 3, 11, 'Miscellaneous Fee', 7500.00, 7500.00, '2022-08-05', '2022-08-15', 'Scholarship', 'FULL-2022-080503', 'Paid', 3, NULL),
(213, 24, 4, 11, 'NSTP Fee', 1000.00, 1000.00, '2022-08-05', '2022-08-15', 'Scholarship', 'FULL-2022-080504', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester
(214, 24, 1, 12, 'Tuition Fee (17 units x P1,400)', 23800.00, 23800.00, '2023-01-05', '2023-01-10', 'Scholarship', 'FULL-2023-010501', 'Paid', 3, NULL),
(215, 24, 2, 12, 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-01-05', '2023-01-10', 'Scholarship', 'FULL-2023-010502', 'Paid', 3, NULL),
(216, 24, 3, 12, 'Miscellaneous Fee', 7500.00, 7500.00, '2023-01-05', '2023-01-10', 'Scholarship', 'FULL-2023-010503', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2023-2024)
(217, 24, 1, 1, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2023-08-10', '2023-08-15', 'Scholarship', 'FULL-2023-081001', 'Paid', 3, NULL),
(218, 24, 2, 1, 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-10', '2023-08-15', 'Scholarship', 'FULL-2023-081002', 'Paid', 3, NULL),
(219, 24, 3, 1, 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-10', '2023-08-15', 'Scholarship', 'FULL-2023-081003', 'Paid', 3, NULL),
-- 2nd Year, 2nd Semester
(220, 24, 1, 2, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-01-05', '2024-01-10', 'Scholarship', 'FULL-2024-010501', 'Paid', 3, NULL),
(221, 24, 2, 2, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-05', '2024-01-10', 'Scholarship', 'FULL-2024-010502', 'Paid', 3, NULL),
(222, 24, 3, 2, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-05', '2024-01-10', 'Scholarship', 'FULL-2024-010503', 'Paid', 3, NULL),
-- 3rd Year, 1st Semester (S.Y. 2024-2025)
(223, 24, 1, 4, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-08-10', '2024-08-15', 'Scholarship', 'FULL-2024-081001', 'Paid', 3, NULL),
(224, 24, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', '2024-08-15', 'Scholarship', 'FULL-2024-081002', 'Paid', 3, NULL),
(225, 24, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-10', '2024-08-15', 'Scholarship', 'FULL-2024-081003', 'Paid', 3, NULL),
-- 3rd Year, 2nd Semester
(226, 24, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-05', '2025-01-10', 'Scholarship', 'FULL-2025-010501', 'Paid', 3, NULL),
(227, 24, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-05', '2025-01-10', 'Scholarship', 'FULL-2025-010502', 'Paid', 3, NULL),
(228, 24, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', '2025-01-10', 'Scholarship', 'FULL-2025-010503', 'Paid', 3, NULL),
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current
(229, 24, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'FULL-2025-081101', 'Paid', 3, 'Final year'),
(230, 24, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'FULL-2025-081102', 'Paid', 3, NULL),
(231, 24, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'FULL-2025-081103', 'Paid', 3, NULL),
(232, 24, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'FULL-2025-081104', 'Paid', 3, NULL),

-- Student 25: Angela Faith Santos - BSCS 4th Year (Government Scholar)
-- 1st Year, 1st Semester (S.Y. 2022-2023)
(233, 25, 1, 11, 'Tuition Fee (20 units x P1,400)', 28000.00, 28000.00, '2022-08-08', '2022-08-15', 'Scholarship', 'GOV-2022-080801', 'Paid', 3, 'CHED Scholarship'),
(234, 25, 2, 11, 'Computer Laboratory Fee', 5000.00, 5000.00, '2022-08-08', '2022-08-15', 'Scholarship', 'GOV-2022-080802', 'Paid', 3, NULL),
(235, 25, 3, 11, 'Miscellaneous Fee', 7500.00, 7500.00, '2022-08-08', '2022-08-15', 'Cash', 'CASH-2022-080803', 'Paid', 3, 'Parent paid'),
(236, 25, 4, 11, 'NSTP Fee', 1000.00, 1000.00, '2022-08-08', '2022-08-15', 'Cash', 'CASH-2022-080804', 'Paid', 3, NULL),
-- 1st Year, 2nd Semester
(237, 25, 1, 12, 'Tuition Fee (17 units x P1,400)', 23800.00, 23800.00, '2023-01-05', '2023-01-10', 'Scholarship', 'GOV-2023-010501', 'Paid', 3, NULL),
(238, 25, 2, 12, 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-01-05', '2023-01-10', 'Scholarship', 'GOV-2023-010502', 'Paid', 3, NULL),
(239, 25, 3, 12, 'Miscellaneous Fee', 7500.00, 7500.00, '2023-01-05', '2023-01-10', 'Cash', 'CASH-2023-010503', 'Paid', 3, NULL),
-- 2nd Year, 1st Semester (S.Y. 2023-2024)
(240, 25, 1, 1, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2023-08-10', '2023-08-15', 'Scholarship', 'GOV-2023-081001', 'Paid', 3, NULL),
(241, 25, 2, 1, 'Computer Laboratory Fee', 5000.00, 5000.00, '2023-08-10', '2023-08-15', 'Scholarship', 'GOV-2023-081002', 'Paid', 3, NULL),
(242, 25, 3, 1, 'Miscellaneous Fee', 8500.00, 8500.00, '2023-08-10', '2023-08-15', 'Cash', 'CASH-2023-081003', 'Paid', 3, NULL),
-- 2nd Year, 2nd Semester
(243, 25, 1, 2, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-01-05', '2024-01-10', 'Scholarship', 'GOV-2024-010501', 'Paid', 3, NULL),
(244, 25, 2, 2, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-01-05', '2024-01-10', 'Scholarship', 'GOV-2024-010502', 'Paid', 3, NULL),
(245, 25, 3, 2, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-01-05', '2024-01-10', 'Cash', 'CASH-2024-010503', 'Paid', 3, NULL),
-- 3rd Year, 1st Semester (S.Y. 2024-2025)
(246, 25, 1, 4, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2024-08-10', '2024-08-15', 'Scholarship', 'GOV-2024-081001', 'Paid', 3, NULL),
(247, 25, 2, 4, 'Computer Laboratory Fee', 5000.00, 5000.00, '2024-08-10', '2024-08-15', 'Scholarship', 'GOV-2024-081002', 'Paid', 3, NULL),
(248, 25, 3, 4, 'Miscellaneous Fee', 8500.00, 8500.00, '2024-08-10', '2024-08-15', 'Cash', 'CASH-2024-081003', 'Paid', 3, NULL),
-- 3rd Year, 2nd Semester
(249, 25, 1, 5, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-01-05', '2025-01-10', 'Scholarship', 'GOV-2025-010501', 'Paid', 3, NULL),
(250, 25, 2, 5, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-01-05', '2025-01-10', 'Scholarship', 'GOV-2025-010502', 'Paid', 3, NULL),
(251, 25, 3, 5, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-01-05', '2025-01-10', 'Cash', 'CASH-2025-010503', 'Paid', 3, NULL),
-- 4th Year, 1st Semester (S.Y. 2025-2026) - Current
(252, 25, 1, 7, 'Tuition Fee (17 units x P1,500)', 25500.00, 25500.00, '2025-08-11', '2025-08-20', 'Scholarship', 'GOV-2025-081101', 'Paid', 3, 'Final year'),
(253, 25, 2, 7, 'Computer Laboratory Fee', 5000.00, 5000.00, '2025-08-11', '2025-08-20', 'Scholarship', 'GOV-2025-081102', 'Paid', 3, NULL),
(254, 25, 3, 7, 'Miscellaneous Fee', 8500.00, 8500.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081103', 'Paid', 3, NULL),
(255, 25, 7, 7, 'Energy Fee', 3500.00, 3500.00, '2025-08-11', '2025-08-20', 'Cash', 'CASH-2025-081104', 'Paid', 3, NULL);

-- ============================================================
-- UPDATE GRADES FOR COMPLETED SEMESTERS
-- Students who completed past semesters should have grades
-- ============================================================

-- Note: Grade updates are already included in the INSERT statements above.
-- The following updates apply random grades for testing purposes only.

-- Update grades for past semester enrollments (not current semester)
-- Current semester (academic_year_id = 7) grades remain NULL (pending)

-- Fix any grades that might be out of range after random generation
UPDATE enrollments 
SET grade = LEAST(grade, 3.00), 
    midterm_grade = LEAST(midterm_grade, 3.00),
    final_grade = LEAST(final_grade, 3.00)
WHERE grade > 3.00 AND grade_status = 'Passed';

-- Ensure failed grades are properly set
UPDATE enrollments 
SET grade = 5.00, grade_status = 'Failed'
WHERE grade > 3.00 AND grade_status != 'Passed';

-- ============================================================
-- UPDATE NULL INSTRUCTOR IDs FOR NSTP SCHEDULES
-- Assign an instructor to NSTP classes
-- ============================================================
UPDATE class_schedules SET instructor_id = 9 WHERE instructor_id IS NULL;

-- ============================================================
-- Re-enable foreign key checks
-- ============================================================
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- End of Sample Data v2.0.0
-- ============================================================
