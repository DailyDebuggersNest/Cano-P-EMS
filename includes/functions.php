<?php
/**
 * Helper Functions
 * 
 * This file contains all our handy helper functions.
 * Think of it as a toolbox - grab what you need!
 */

// Make sure we have the database connection
require_once __DIR__ . '/db.php';

// ============================================
// STUDENT FUNCTIONS
// Everything related to managing students
// ============================================

/**
 * Get all students from the database with program info
 * 
 * @return array List of all students
 */
function getAllStudents() {
    global $db;
    
    try {
        $sql = "SELECT s.*, p.program_code, p.program_name,
                       s.current_semester as semester
                FROM students s
                LEFT JOIN programs p ON s.current_program_id = p.id
                ORDER BY s.last_name, s.first_name";
        $stmt = $db->query($sql);
        
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get a single student by their ID with program info
 * 
 * @param int $id The student's ID
 * @return array|false Student data or false if not found
 */
function getStudentById($id) {
    global $db;
    
    try {
        $sql = "SELECT s.*, p.program_code, p.program_name, p.degree_type,
                       d.department_name, d.department_code,
                       s.current_semester as semester
                FROM students s
                LEFT JOIN programs p ON s.current_program_id = p.id
                LEFT JOIN departments d ON p.department_id = d.id
                WHERE s.id = :id";
        $stmt = $db->prepare($sql);
        $stmt->execute(['id' => $id]);
        
        return $stmt->fetch();
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Get a student by their Student ID (STU-YYYY-XXXXX format)
 * 
 * @param string $studentId The student's unique ID
 * @return array|false Student data or false if not found
 */
function getStudentByStudentId($studentId) {
    global $db;
    
    $sql = "SELECT * FROM students WHERE student_id = :student_id";
    $stmt = $db->prepare($sql);
    $stmt->execute(['student_id' => $studentId]);
    
    return $stmt->fetch();
}

/**
 * Generate a new unique Student ID
 * Format: STU-YYYY-XXXXX
 * 
 * @return string The generated student ID
 */
function generateStudentId() {
    global $db;
    
    $year = date('Y');
    $prefix = "STU-{$year}-";
    
    // Get the highest existing number for this year
    $sql = "SELECT student_id FROM students WHERE student_id LIKE :prefix ORDER BY student_id DESC LIMIT 1";
    $stmt = $db->prepare($sql);
    $stmt->execute(['prefix' => $prefix . '%']);
    $result = $stmt->fetch();
    
    if ($result) {
        // Extract the number and increment
        $lastNumber = (int) substr($result['student_id'], -5);
        $newNumber = $lastNumber + 1;
    } else {
        $newNumber = 1;
    }
    
    return $prefix . str_pad($newNumber, 5, '0', STR_PAD_LEFT);
}

/**
 * Add a new student to the database with full SIS profile
 * 
 * @param array $data Student data
 * @return bool|int Returns the new student ID on success, false on failure
 */
function addStudent($data) {
    global $db;
    
    // Generate student ID if not provided
    $studentId = $data['student_id'] ?? generateStudentId();
    
    $sql = "INSERT INTO students (
                student_id, first_name, middle_name, last_name, suffix,
                sex, civil_status, nationality, religion, blood_type,
                email, phone, date_of_birth, place_of_birth,
                address_street, address_barangay, address_city, address_province, address_zip,
                permanent_address,
                guardian_name, guardian_relationship, guardian_contact, guardian_email, guardian_occupation, guardian_address,
                emergency_contact_name, emergency_contact_phone, emergency_contact_relationship,
                current_program_id, admission_date, admission_type, year_level, current_semester, section,
                student_status, scholarship_status, lrn
            ) VALUES (
                :student_id, :first_name, :middle_name, :last_name, :suffix,
                :sex, :civil_status, :nationality, :religion, :blood_type,
                :email, :phone, :date_of_birth, :place_of_birth,
                :address_street, :address_barangay, :address_city, :address_province, :address_zip,
                :permanent_address,
                :guardian_name, :guardian_relationship, :guardian_contact, :guardian_email, :guardian_occupation, :guardian_address,
                :emergency_contact_name, :emergency_contact_phone, :emergency_contact_relationship,
                :current_program_id, :admission_date, :admission_type, :year_level, :current_semester, :section,
                :student_status, :scholarship_status, :lrn
            )";
    
    $stmt = $db->prepare($sql);
    
    $result = $stmt->execute([
        'student_id' => $studentId,
        'first_name' => $data['first_name'],
        'middle_name' => $data['middle_name'] ?? null,
        'last_name' => $data['last_name'],
        'suffix' => $data['suffix'] ?? null,
        'sex' => $data['sex'] ?? null,
        'civil_status' => $data['civil_status'] ?? 'Single',
        'nationality' => $data['nationality'] ?? 'Filipino',
        'religion' => $data['religion'] ?? null,
        'blood_type' => $data['blood_type'] ?? null,
        'email' => $data['email'],
        'phone' => $data['phone'] ?? null,
        'date_of_birth' => $data['date_of_birth'] ?? null,
        'place_of_birth' => $data['place_of_birth'] ?? null,
        'address_street' => $data['address_street'] ?? null,
        'address_barangay' => $data['address_barangay'] ?? null,
        'address_city' => $data['address_city'] ?? null,
        'address_province' => $data['address_province'] ?? null,
        'address_zip' => $data['address_zip'] ?? null,
        'permanent_address' => $data['permanent_address'] ?? null,
        'guardian_name' => $data['guardian_name'] ?? null,
        'guardian_relationship' => $data['guardian_relationship'] ?? null,
        'guardian_contact' => $data['guardian_contact'] ?? null,
        'guardian_email' => $data['guardian_email'] ?? null,
        'guardian_occupation' => $data['guardian_occupation'] ?? null,
        'guardian_address' => $data['guardian_address'] ?? null,
        'emergency_contact_name' => $data['emergency_contact_name'] ?? null,
        'emergency_contact_phone' => $data['emergency_contact_phone'] ?? null,
        'emergency_contact_relationship' => $data['emergency_contact_relationship'] ?? null,
        'current_program_id' => $data['current_program_id'] ?? $data['program_id'] ?? null,
        'admission_date' => $data['admission_date'] ?? date('Y-m-d'),
        'admission_type' => $data['admission_type'] ?? 'Freshman',
        'year_level' => $data['year_level'] ?? '1st Year',
        'current_semester' => $data['current_semester'] ?? $data['semester'] ?? '1st Semester',
        'section' => $data['section'] ?? null,
        'student_status' => $data['student_status'] ?? 'Active',
        'scholarship_status' => $data['scholarship_status'] ?? 'None',
        'lrn' => $data['lrn'] ?? null
    ]);
    
    return $result ? $db->lastInsertId() : false;
}

/**
 * Update an existing student's info with full SIS profile
 * 
 * @param int $id The student's ID
 * @param array $data Updated student data
 * @return bool True if successful
 */
function updateStudent($id, $data) {
    global $db;
    
    $sql = "UPDATE students SET
                first_name = :first_name,
                middle_name = :middle_name,
                last_name = :last_name,
                suffix = :suffix,
                sex = :sex,
                civil_status = :civil_status,
                nationality = :nationality,
                religion = :religion,
                blood_type = :blood_type,
                email = :email,
                phone = :phone,
                date_of_birth = :date_of_birth,
                place_of_birth = :place_of_birth,
                address_street = :address_street,
                address_barangay = :address_barangay,
                address_city = :address_city,
                address_province = :address_province,
                address_zip = :address_zip,
                permanent_address = :permanent_address,
                guardian_name = :guardian_name,
                guardian_relationship = :guardian_relationship,
                guardian_contact = :guardian_contact,
                guardian_email = :guardian_email,
                guardian_occupation = :guardian_occupation,
                guardian_address = :guardian_address,
                emergency_contact_name = :emergency_contact_name,
                emergency_contact_phone = :emergency_contact_phone,
                emergency_contact_relationship = :emergency_contact_relationship,
                current_program_id = :current_program_id,
                admission_type = :admission_type,
                year_level = :year_level,
                current_semester = :current_semester,
                section = :section,
                student_status = :student_status,
                scholarship_status = :scholarship_status,
                lrn = :lrn
            WHERE id = :id";
    
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'id' => $id,
        'first_name' => $data['first_name'],
        'middle_name' => $data['middle_name'] ?? null,
        'last_name' => $data['last_name'],
        'suffix' => $data['suffix'] ?? null,
        'sex' => $data['sex'] ?? null,
        'civil_status' => $data['civil_status'] ?? 'Single',
        'nationality' => $data['nationality'] ?? 'Filipino',
        'religion' => $data['religion'] ?? null,
        'blood_type' => $data['blood_type'] ?? null,
        'email' => $data['email'],
        'phone' => $data['phone'] ?? null,
        'date_of_birth' => $data['date_of_birth'] ?? null,
        'place_of_birth' => $data['place_of_birth'] ?? null,
        'address_street' => $data['address_street'] ?? null,
        'address_barangay' => $data['address_barangay'] ?? null,
        'address_city' => $data['address_city'] ?? null,
        'address_province' => $data['address_province'] ?? null,
        'address_zip' => $data['address_zip'] ?? null,
        'permanent_address' => $data['permanent_address'] ?? null,
        'guardian_name' => $data['guardian_name'] ?? null,
        'guardian_relationship' => $data['guardian_relationship'] ?? null,
        'guardian_contact' => $data['guardian_contact'] ?? null,
        'guardian_email' => $data['guardian_email'] ?? null,
        'guardian_occupation' => $data['guardian_occupation'] ?? null,
        'guardian_address' => $data['guardian_address'] ?? null,
        'emergency_contact_name' => $data['emergency_contact_name'] ?? null,
        'emergency_contact_phone' => $data['emergency_contact_phone'] ?? null,
        'emergency_contact_relationship' => $data['emergency_contact_relationship'] ?? null,
        'current_program_id' => $data['current_program_id'] ?? $data['program_id'] ?? null,
        'admission_type' => $data['admission_type'] ?? 'Freshman',
        'year_level' => $data['year_level'] ?? '1st Year',
        'current_semester' => $data['current_semester'] ?? $data['semester'] ?? '1st Semester',
        'section' => $data['section'] ?? null,
        'student_status' => $data['student_status'] ?? 'Active',
        'scholarship_status' => $data['scholarship_status'] ?? 'None',
        'lrn' => $data['lrn'] ?? null
    ]);
}

/**
 * Delete a student (this also removes their enrollments!)
 * 
 * @param int $id The student's ID
 * @return bool True if successful
 */
function deleteStudent($id) {
    global $db;
    
    $sql = "DELETE FROM students WHERE id = :id";
    $stmt = $db->prepare($sql);
    
    return $stmt->execute(['id' => $id]);
}

// ============================================
// UTILITY FUNCTIONS
// Handy helpers for common tasks
// ============================================

/**
 * Sanitize user input to prevent XSS attacks
 * Always use this when displaying user data!
 * 
 * @param string $data The data to sanitize
 * @return string Sanitized data
 */
function sanitize($data) {
    return htmlspecialchars(trim($data), ENT_QUOTES, 'UTF-8');
}

/**
 * Redirect to another page
 * 
 * @param string $url The URL to redirect to
 */
function redirect($url) {
    header("Location: $url");
    exit;
}

/**
 * Display a flash message
 * Store a message in session to display after redirect
 * 
 * @param string $message The message to display
 * @param string $type Message type (success, error, warning, info)
 */
function setFlashMessage($message, $type = 'info') {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    $_SESSION['flash_message'] = $message;
    $_SESSION['flash_type'] = $type;
}

/**
 * Get and clear the flash message
 * 
 * @return array|null Message and type, or null if no message
 */
function getFlashMessage() {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    
    if (isset($_SESSION['flash_message'])) {
        $message = $_SESSION['flash_message'];
        $type = $_SESSION['flash_type'];
        
        // Clear it so it only shows once
        unset($_SESSION['flash_message']);
        unset($_SESSION['flash_type']);
        
        return ['message' => $message, 'type' => $type];
    }
    
    return null;
}

// ============================================
// USER AUTHENTICATION FUNCTIONS
// User management with bcrypt passwords
// ============================================

/**
 * Get user by username
 * 
 * @param string $username The username
 * @return array|false User data or false
 */
function getUserByUsername($username) {
    global $db;
    
    $sql = "SELECT * FROM users WHERE username = :username";
    $stmt = $db->prepare($sql);
    $stmt->execute(['username' => $username]);
    
    return $stmt->fetch();
}

/**
 * Get user by ID
 * 
 * @param int $id User ID
 * @return array|false User data or false
 */
function getUserById($id) {
    global $db;
    
    $sql = "SELECT * FROM users WHERE id = :id";
    $stmt = $db->prepare($sql);
    $stmt->execute(['id' => $id]);
    
    return $stmt->fetch();
}

/**
 * Create a new user with bcrypt password
 * 
 * @param array $data User data (username, password, email, full_name, role)
 * @return bool Success status
 */
function createUser($data) {
    global $db;
    
    try {
        $sql = "INSERT INTO users (username, email, password, full_name, role) 
                VALUES (:username, :email, :password, :full_name, :role)";
        
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'username' => $data['username'],
            'email' => $data['email'] ?? null,
            'password' => password_hash($data['password'], PASSWORD_DEFAULT),
            'full_name' => $data['full_name'] ?? $data['username'],
            'role' => $data['role'] ?? 'staff'
        ]);
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Update user password
 * 
 * @param int $userId User ID
 * @param string $newPassword New password (will be hashed)
 * @return bool Success status
 */
function updateUserPassword($userId, $newPassword) {
    global $db;
    
    $sql = "UPDATE users SET password = :password WHERE id = :id";
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'id' => $userId,
        'password' => password_hash($newPassword, PASSWORD_DEFAULT)
    ]);
}

/**
 * Verify user password
 * 
 * @param string $password Plain text password
 * @param string $hash Bcrypt hash from database
 * @return bool True if password matches
 */
function verifyPassword($password, $hash) {
    return password_verify($password, $hash);
}

// ============================================
// SIS HELPER FUNCTIONS
// Student Information System utilities
// ============================================

/**
 * Get all available programs
 * 
 * @return array List of programs
 */
function getAllPrograms() {
    global $db;
    
    try {
        $sql = "SELECT * FROM programs ORDER BY program_name";
        $stmt = $db->query($sql);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        // Table might not exist yet
        return [];
    }
}

/**
 * Get program abbreviation/code from full program name
 * 
 * @param string $programName Full program name
 * @return array ['code' => abbreviation, 'name' => full name]
 */
function getProgramAbbreviation($programName) {
    // Common program mappings
    $programMap = [
        'Bachelor of Science in Information Technology' => 'BSIT',
        'Bachelor of Science in Computer Science' => 'BSCS',
        'Bachelor of Science in Information Systems' => 'BSIS',
        'Bachelor of Science in Computer Engineering' => 'BSCpE',
        'Bachelor of Science in Electronics Engineering' => 'BSECE',
        'Bachelor of Science in Electrical Engineering' => 'BSEE',
        'Bachelor of Science in Civil Engineering' => 'BSCE',
        'Bachelor of Science in Mechanical Engineering' => 'BSME',
        'Bachelor of Science in Accountancy' => 'BSA',
        'Bachelor of Science in Business Administration' => 'BSBA',
        'Bachelor of Science in Nursing' => 'BSN',
        'Bachelor of Science in Education' => 'BSEd',
        'Bachelor of Arts in Communication' => 'BAC',
        'Bachelor of Science in Hospitality Management' => 'BSHM',
        'Bachelor of Science in Tourism Management' => 'BSTM',
        'Bachelor of Science in Criminology' => 'BSCrim',
        'Bachelor of Science in Psychology' => 'BSPsych',
    ];
    
    // Check if program exists in map
    if (isset($programMap[$programName])) {
        return ['code' => $programMap[$programName], 'name' => $programName];
    }
    
    // Try to generate abbreviation from first letters of capitalized words
    $words = preg_split('/\s+/', $programName);
    $abbrev = '';
    $skipWords = ['of', 'in', 'the', 'and', 'for'];
    
    foreach ($words as $word) {
        if (!in_array(strtolower($word), $skipWords) && strlen($word) > 0) {
            $abbrev .= strtoupper($word[0]);
        }
    }
    
    return ['code' => $abbrev ?: $programName, 'name' => $programName];
}

/**
 * Get student's full name with format options
 * 
 * @param array $student Student data array
 * @param string $format 'full', 'formal', 'short'
 * @return string Formatted name
 */
function getStudentFullName($student, $format = 'full') {
    $first = $student['first_name'] ?? '';
    $middle = $student['middle_name'] ?? '';
    $last = $student['last_name'] ?? '';
    $suffix = $student['suffix'] ?? '';
    
    switch ($format) {
        case 'formal':
            // Last, First Middle Suffix
            $name = $last;
            if ($first) $name .= ", {$first}";
            if ($middle) $name .= " {$middle}";
            if ($suffix) $name .= " {$suffix}";
            return $name;
            
        case 'short':
            // First Last
            return trim("{$first} {$last}");
            
        case 'full':
        default:
            // First Middle Last Suffix
            $name = $first;
            if ($middle) $name .= " {$middle}";
            if ($last) $name .= " {$last}";
            if ($suffix) $name .= " {$suffix}";
            return trim($name);
    }
}

/**
 * Calculate age from date of birth
 * 
 * @param string $dob Date of birth (Y-m-d format)
 * @return int|null Age in years or null if no DOB
 */
function calculateAge($dob) {
    if (!$dob) return null;
    
    $birthDate = new DateTime($dob);
    $today = new DateTime();
    $age = $today->diff($birthDate);
    
    return $age->y;
}

/**
 * Get student's full address
 * 
 * @param array $student Student data array
 * @return string Formatted address
 */
function getStudentAddress($student) {
    $parts = [];
    
    if (!empty($student['address_street'])) $parts[] = $student['address_street'];
    if (!empty($student['address_barangay'])) $parts[] = $student['address_barangay'];
    if (!empty($student['address_city'])) $parts[] = $student['address_city'];
    if (!empty($student['address_province'])) $parts[] = $student['address_province'];
    if (!empty($student['address_zip'])) $parts[] = $student['address_zip'];
    
    return implode(', ', $parts) ?: 'Not specified';
}

// ============================================
// ENROLLMENT FUNCTIONS
// Manage student course/subject enrollments
// ============================================

/**
 * Get all enrollments for a student
 * 
 * @param int $studentId Student ID
 * @param string|null $academicYear Filter by academic year (optional)
 * @param string|null $semester Filter by semester (optional)
 * @return array List of enrollments with subject details
 */
function getStudentEnrollments($studentId, $academicYear = null, $semester = null) {
    global $db;
    
    try {
        $sql = "SELECT e.*, c.course_code as subject_code, c.course_name as subject_name, 
                       c.description as subject_description, c.units, c.lecture_hours, c.lab_hours,
                       ay.academic_year, ay.semester,
                       i.first_name as instructor_first_name, i.last_name as instructor_last_name
                FROM enrollments e
                JOIN curriculum c ON e.curriculum_id = c.id
                JOIN academic_years ay ON e.academic_year_id = ay.id
                LEFT JOIN instructors i ON e.instructor_id = i.id
                WHERE e.student_id = :student_id";
        
        $params = ['student_id' => $studentId];
        
        if ($academicYear) {
            $sql .= " AND ay.academic_year = :academic_year";
            $params['academic_year'] = $academicYear;
        }
        
        if ($semester) {
            $sql .= " AND ay.semester = :semester";
            $params['semester'] = $semester;
        }
        
        $sql .= " ORDER BY ay.academic_year DESC, ay.semester, c.course_code";
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get current semester enrollments for a student
 * 
 * @param int $studentId Student ID
 * @return array Current enrollments
 */
function getCurrentEnrollments($studentId) {
    global $db;
    
    try {
        // Get the current academic year (is_current = TRUE)
        $sql = "SELECT ay.academic_year, ay.semester 
                FROM enrollments e
                JOIN academic_years ay ON e.academic_year_id = ay.id
                WHERE e.student_id = :student_id 
                ORDER BY ay.start_date DESC 
                LIMIT 1";
        
        $stmt = $db->prepare($sql);
        $stmt->execute(['student_id' => $studentId]);
        $current = $stmt->fetch();
        
        if (!$current) {
            return [];
        }
        
        return getStudentEnrollments($studentId, $current['academic_year'], $current['semester']);
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get enrollment summary stats for a student
 * 
 * @param int $studentId Student ID
 * @return array Enrollment statistics
 */
function getEnrollmentStats($studentId) {
    global $db;
    
    try {
        $stats = [
            'total_subjects' => 0,
            'total_units' => 0,
            'passed_subjects' => 0,
            'failed_subjects' => 0,
            'pending_subjects' => 0,
            'current_units' => 0
        ];
        
        // Total subjects and passed units (only count passed subjects for earned units)
        $sql = "SELECT COUNT(*) as total, 
                       COALESCE(SUM(CASE WHEN e.grade_status = 'Passed' THEN c.units ELSE 0 END), 0) as units
                FROM enrollments e
                JOIN curriculum c ON e.curriculum_id = c.id
                WHERE e.student_id = :student_id";
        $stmt = $db->prepare($sql);
        $stmt->execute(['student_id' => $studentId]);
        $result = $stmt->fetch();
        $stats['total_subjects'] = $result['total'];
        $stats['total_units'] = $result['units'];
        
        // Passed subjects
        $sql = "SELECT COUNT(*) as count FROM enrollments WHERE student_id = :student_id AND grade_status = 'Passed'";
        $stmt = $db->prepare($sql);
        $stmt->execute(['student_id' => $studentId]);
        $stats['passed_subjects'] = $stmt->fetch()['count'];
        
        // Failed subjects
        $sql = "SELECT COUNT(*) as count FROM enrollments WHERE student_id = :student_id AND grade_status = 'Failed'";
        $stmt = $db->prepare($sql);
        $stmt->execute(['student_id' => $studentId]);
        $stats['failed_subjects'] = $stmt->fetch()['count'];
        
        // Pending subjects
        $sql = "SELECT COUNT(*) as count FROM enrollments WHERE student_id = :student_id AND grade_status = 'Pending'";
        $stmt = $db->prepare($sql);
        $stmt->execute(['student_id' => $studentId]);
        $stats['pending_subjects'] = $stmt->fetch()['count'];
        
        // Current semester units (most recent academic year)
        $sql = "SELECT COALESCE(SUM(c.units), 0) as units
                FROM enrollments e
                JOIN curriculum c ON e.curriculum_id = c.id
                JOIN academic_years ay ON e.academic_year_id = ay.id
                WHERE e.student_id = :student_id
                AND e.academic_year_id = (
                    SELECT e2.academic_year_id 
                    FROM enrollments e2
                    JOIN academic_years ay2 ON e2.academic_year_id = ay2.id
                    WHERE e2.student_id = :student_id2 
                    ORDER BY ay2.start_date DESC 
                    LIMIT 1
                )";
        $stmt = $db->prepare($sql);
        $stmt->execute(['student_id' => $studentId, 'student_id2' => $studentId]);
        $result = $stmt->fetch();
        $stats['current_units'] = $result['units'];
        
        return $stats;
    } catch (PDOException $e) {
        return [
            'total_subjects' => 0,
            'total_units' => 0,
            'passed_subjects' => 0,
            'failed_subjects' => 0,
            'pending_subjects' => 0,
            'current_units' => 0
        ];
    }
}

/**
 * Get all subjects available
 * 
 * @param int|null $programId Filter by program (optional)
 * @return array List of subjects
 */
function getAllSubjects($programId = null) {
    global $db;
    
    try {
        $sql = "SELECT c.*, c.course_code as subject_code, c.course_name as subject_name,
                       p.program_code, p.program_name
                FROM curriculum c
                LEFT JOIN programs p ON c.program_id = p.id
                WHERE c.is_active = TRUE";
        $params = [];
        
        if ($programId) {
            $sql .= " AND c.program_id = :program_id";
            $params['program_id'] = $programId;
        }
        
        $sql .= " ORDER BY c.year_level, c.semester, c.course_code";
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Enroll a student in a subject
 * 
 * @param int $studentId Student ID
 * @param int $subjectId Subject ID
 * @param string $academicYear Academic year (e.g., "2025-2026")
 * @param string $semester Semester
 * @return bool Success status
 */
function enrollStudent($studentId, $curriculumId, $academicYearId, $instructorId = null) {
    global $db;
    
    try {
        $sql = "INSERT INTO enrollments (student_id, curriculum_id, academic_year_id, instructor_id, enrollment_date, enrollment_status, grade_status)
                VALUES (:student_id, :curriculum_id, :academic_year_id, :instructor_id, CURRENT_DATE, 'Enrolled', 'Pending')";
        
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'student_id' => $studentId,
            'curriculum_id' => $curriculumId,
            'academic_year_id' => $academicYearId,
            'instructor_id' => $instructorId
        ]);
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Update enrollment grade
 * 
 * @param int $enrollmentId Enrollment ID
 * @param float $grade Grade value
 * @param string $status Grade status (Passed, Failed, etc.)
 * @return bool Success status
 */
function updateEnrollmentGrade($enrollmentId, $grade, $status) {
    global $db;
    
    try {
        $sql = "UPDATE enrollments SET grade = :grade, grade_status = :status WHERE id = :id";
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'id' => $enrollmentId,
            'grade' => $grade,
            'status' => $status
        ]);
    } catch (PDOException $e) {
        return false;
    }
}

// ============================================
// PAYMENT FUNCTIONS
// Manage student payments and fees
// ============================================

/**
 * Get all payments for a student
 * 
 * @param int $studentId Student ID
 * @param string|null $academicYear Filter by academic year (optional)
 * @param string|null $semester Filter by semester (optional)
 * @return array List of payments
 */
function getStudentPayments($studentId, $academicYear = null, $semester = null) {
    global $db;
    
    try {
        $sql = "SELECT p.*, pt.type_name as payment_type_name, pt.type_code,
                       ay.academic_year, ay.semester
                FROM payments p
                LEFT JOIN payment_types pt ON p.payment_type_id = pt.id
                LEFT JOIN academic_years ay ON p.academic_year_id = ay.id
                WHERE p.student_id = :student_id";
        
        $params = ['student_id' => $studentId];
        
        if ($academicYear) {
            $sql .= " AND ay.academic_year = :academic_year";
            $params['academic_year'] = $academicYear;
        }
        
        if ($semester) {
            $sql .= " AND ay.semester = :semester";
            $params['semester'] = $semester;
        }
        
        $sql .= " ORDER BY ay.start_date DESC, p.created_at DESC";
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get current semester payments for a student
 * 
 * @param int $studentId Student ID
 * @return array Current payments
 */
function getCurrentPayments($studentId) {
    global $db;
    
    try {
        // Get the most recent payment academic year for this student
        $sql = "SELECT ay.academic_year, ay.semester 
                FROM payments p
                JOIN academic_years ay ON p.academic_year_id = ay.id
                WHERE p.student_id = :student_id 
                ORDER BY ay.start_date DESC 
                LIMIT 1";
        
        $stmt = $db->prepare($sql);
        $stmt->execute(['student_id' => $studentId]);
        $current = $stmt->fetch();
        
        if (!$current) {
            return [];
        }
        
        return getStudentPayments($studentId, $current['academic_year'], $current['semester']);
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get payment summary for a student
 * 
 * @param int $studentId Student ID
 * @param string|null $academicYear Filter by academic year (optional)
 * @param string|null $semester Filter by semester (optional)
 * @return array Payment summary with totals
 */
function getPaymentSummary($studentId, $academicYear = null, $semester = null) {
    global $db;
    
    try {
        $sql = "SELECT 
                    COALESCE(SUM(p.amount_due), 0) as total_due,
                    COALESCE(SUM(p.amount_paid), 0) as total_paid,
                    COALESCE(SUM(p.amount_due) - SUM(p.amount_paid), 0) as balance,
                    COUNT(*) as payment_count,
                    SUM(CASE WHEN p.payment_status = 'Paid' THEN 1 ELSE 0 END) as paid_count,
                    SUM(CASE WHEN p.payment_status = 'Partial' THEN 1 ELSE 0 END) as partial_count,
                    SUM(CASE WHEN p.payment_status = 'Unpaid' THEN 1 ELSE 0 END) as unpaid_count,
                    SUM(CASE WHEN p.payment_status = 'Overdue' THEN 1 ELSE 0 END) as overdue_count
                FROM payments p
                LEFT JOIN academic_years ay ON p.academic_year_id = ay.id
                WHERE p.student_id = :student_id";
        
        $params = ['student_id' => $studentId];
        
        if ($academicYear) {
            $sql .= " AND ay.academic_year = :academic_year";
            $params['academic_year'] = $academicYear;
        }
        
        if ($semester) {
            $sql .= " AND ay.semester = :semester";
            $params['semester'] = $semester;
        }
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        $result = $stmt->fetch();
        
        return [
            'total_due' => floatval($result['total_due']),
            'total_paid' => floatval($result['total_paid']),
            'balance' => floatval($result['balance']),
            'payment_count' => intval($result['payment_count']),
            'paid_count' => intval($result['paid_count']),
            'partial_count' => intval($result['partial_count']),
            'unpaid_count' => intval($result['unpaid_count']),
            'overdue_count' => intval($result['overdue_count'])
        ];
    } catch (PDOException $e) {
        return [
            'total_due' => 0,
            'total_paid' => 0,
            'balance' => 0,
            'payment_count' => 0,
            'paid_count' => 0,
            'partial_count' => 0,
            'unpaid_count' => 0,
            'overdue_count' => 0
        ];
    }
}

/**
 * Get all payment types
 * 
 * @return array List of payment types
 */
function getAllPaymentTypes() {
    global $db;
    
    try {
        $sql = "SELECT * FROM payment_types WHERE is_active = TRUE ORDER BY type_name";
        $stmt = $db->query($sql);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Add a payment record for a student
 * 
 * @param array $data Payment data
 * @return bool|int Payment ID on success, false on failure
 */
function addPayment($data) {
    global $db;
    
    try {
        $sql = "INSERT INTO payments (
                    student_id, payment_type_id, academic_year_id,
                    description, amount_due, amount_paid, payment_date,
                    payment_method, reference_number, payment_status, due_date, remarks, processed_by
                ) VALUES (
                    :student_id, :payment_type_id, :academic_year_id,
                    :description, :amount_due, :amount_paid, :payment_date,
                    :payment_method, :reference_number, :payment_status, :due_date, :remarks, :processed_by
                )";
        
        $stmt = $db->prepare($sql);
        $result = $stmt->execute([
            'student_id' => $data['student_id'],
            'payment_type_id' => $data['payment_type_id'] ?? null,
            'academic_year_id' => $data['academic_year_id'],
            'description' => $data['description'] ?? null,
            'amount_due' => $data['amount_due'],
            'amount_paid' => $data['amount_paid'] ?? 0,
            'payment_date' => $data['payment_date'] ?? null,
            'payment_method' => $data['payment_method'] ?? 'Cash',
            'reference_number' => $data['reference_number'] ?? null,
            'payment_status' => $data['payment_status'] ?? 'Unpaid',
            'due_date' => $data['due_date'] ?? null,
            'remarks' => $data['remarks'] ?? null,
            'processed_by' => $data['processed_by'] ?? null
        ]);
        
        return $result ? $db->lastInsertId() : false;
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Update a payment record
 * 
 * @param int $paymentId Payment ID
 * @param array $data Updated payment data
 * @return bool Success status
 */
function updatePayment($paymentId, $data) {
    global $db;
    
    try {
        $sql = "UPDATE payments SET
                    amount_paid = :amount_paid,
                    payment_date = :payment_date,
                    payment_method = :payment_method,
                    reference_number = :reference_number,
                    payment_status = :payment_status,
                    remarks = :remarks
                WHERE id = :id";
        
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'id' => $paymentId,
            'amount_paid' => $data['amount_paid'],
            'payment_date' => $data['payment_date'] ?? date('Y-m-d'),
            'payment_method' => $data['payment_method'] ?? 'Cash',
            'reference_number' => $data['reference_number'] ?? null,
            'payment_status' => $data['payment_status'],
            'remarks' => $data['remarks'] ?? null
        ]);
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Format currency for display (Philippine Peso)
 * 
 * @param float $amount Amount to format
 * @return string Formatted currency
 */
function formatCurrency($amount) {
    return '₱' . number_format($amount, 2);
}

/**
 * Get grade equivalent description
 * 
 * @param float|null $grade Numeric grade
 * @return string Grade description
 */
function getGradeDescription($grade) {
    if ($grade === null) return 'Not yet graded';
    
    if ($grade >= 1.0 && $grade <= 1.25) return 'Excellent';
    if ($grade > 1.25 && $grade <= 1.50) return 'Very Good';
    if ($grade > 1.50 && $grade <= 1.75) return 'Good';
    if ($grade > 1.75 && $grade <= 2.00) return 'Satisfactory';
    if ($grade > 2.00 && $grade <= 2.25) return 'Fairly Satisfactory';
    if ($grade > 2.25 && $grade <= 2.50) return 'Fair';
    if ($grade > 2.50 && $grade <= 2.75) return 'Passed';
    if ($grade > 2.75 && $grade <= 3.00) return 'Conditional';
    if ($grade > 3.00) return 'Failed';
    
    return 'Unknown';
}

// ============================================
// SCHEDULE FUNCTIONS
// Manage student class schedules
// ============================================

/**
 * Get all schedules for a student's current semester
 * 
 * @param int $studentId Student ID
 * @param string|null $academicYear Filter by academic year (optional)
 * @param string|null $semester Filter by semester (optional)
 * @return array List of schedules with subject details
 */
function getStudentSchedules($studentId, $academicYear = null, $semester = null) {
    global $db;
    
    try {
        // First, get the most recent enrollment semester if not specified
        if (!$academicYear || !$semester) {
            $sql = "SELECT ay.academic_year, ay.semester 
                    FROM enrollments e
                    JOIN academic_years ay ON e.academic_year_id = ay.id
                    WHERE e.student_id = :student_id 
                    ORDER BY ay.start_date DESC 
                    LIMIT 1";
            
            $stmt = $db->prepare($sql);
            $stmt->execute(['student_id' => $studentId]);
            $current = $stmt->fetch();
            
            if ($current) {
                $academicYear = $academicYear ?? $current['academic_year'];
                $semester = $semester ?? $current['semester'];
            }
        }
        
        $sql = "SELECT cs.*, 
                       c.course_code as subject_code, c.course_name as subject_name, c.units, c.lecture_hours, c.lab_hours,
                       ay.academic_year, ay.semester,
                       i.first_name as instructor_first_name, i.last_name as instructor_last_name, i.title as instructor_title
                FROM class_schedules cs
                JOIN enrollments e ON cs.enrollment_id = e.id
                JOIN curriculum c ON e.curriculum_id = c.id
                JOIN academic_years ay ON e.academic_year_id = ay.id
                LEFT JOIN instructors i ON cs.instructor_id = i.id
                WHERE e.student_id = :student_id
                AND cs.is_active = TRUE";
        
        $params = ['student_id' => $studentId];
        
        if ($academicYear) {
            $sql .= " AND ay.academic_year = :academic_year";
            $params['academic_year'] = $academicYear;
        }
        
        if ($semester) {
            $sql .= " AND ay.semester = :semester";
            $params['semester'] = $semester;
        }
        
        $sql .= " ORDER BY FIELD(cs.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), cs.start_time";
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get schedules grouped by day for timetable view
 * 
 * @param int $studentId Student ID
 * @param string|null $academicYear Filter by academic year (optional)
 * @param string|null $semester Filter by semester (optional)
 * @return array Schedules organized by day of week
 */
function getStudentSchedulesByDay($studentId, $academicYear = null, $semester = null) {
    $schedules = getStudentSchedules($studentId, $academicYear, $semester);
    
    $days = [
        'Monday' => [],
        'Tuesday' => [],
        'Wednesday' => [],
        'Thursday' => [],
        'Friday' => [],
        'Saturday' => [],
        'Sunday' => []
    ];
    
    foreach ($schedules as $schedule) {
        $days[$schedule['day_of_week']][] = $schedule;
    }
    
    return $days;
}

/**
 * Get schedule summary/stats for a student
 * 
 * @param int $studentId Student ID
 * @param string|null $academicYear Filter by academic year (optional)
 * @param string|null $semester Filter by semester (optional)
 * @return array Schedule statistics
 */
function getScheduleStats($studentId, $academicYear = null, $semester = null) {
    $schedules = getStudentSchedules($studentId, $academicYear, $semester);
    
    $stats = [
        'total_classes' => count($schedules),
        'total_hours' => 0,
        'lecture_hours' => 0,
        'lab_hours' => 0,
        'days_with_classes' => 0,
        'earliest_class' => null,
        'latest_class' => null,
        'subjects_count' => 0,
        'days_breakdown' => []
    ];
    
    $daysSet = [];
    $subjectsSet = [];
    
    foreach ($schedules as $schedule) {
        // Calculate hours
        $start = strtotime($schedule['start_time']);
        $end = strtotime($schedule['end_time']);
        $hours = ($end - $start) / 3600;
        $stats['total_hours'] += $hours;
        
        if ($schedule['class_type'] === 'Laboratory') {
            $stats['lab_hours'] += $hours;
        } else {
            $stats['lecture_hours'] += $hours;
        }
        
        // Track unique days
        $daysSet[$schedule['day_of_week']] = true;
        
        // Track unique subjects
        $subjectsSet[$schedule['subject_code']] = true;
        
        // Track earliest and latest
        if ($stats['earliest_class'] === null || $schedule['start_time'] < $stats['earliest_class']) {
            $stats['earliest_class'] = $schedule['start_time'];
        }
        if ($stats['latest_class'] === null || $schedule['end_time'] > $stats['latest_class']) {
            $stats['latest_class'] = $schedule['end_time'];
        }
        
        // Days breakdown
        if (!isset($stats['days_breakdown'][$schedule['day_of_week']])) {
            $stats['days_breakdown'][$schedule['day_of_week']] = 0;
        }
        $stats['days_breakdown'][$schedule['day_of_week']]++;
    }
    
    $stats['days_with_classes'] = count($daysSet);
    $stats['subjects_count'] = count($subjectsSet);
    
    return $stats;
}

/**
 * Format time for display (12-hour format)
 * 
 * @param string $time Time in 24-hour format (HH:MM:SS)
 * @return string Formatted time (e.g., "8:00 AM")
 */
function formatScheduleTime($time) {
    return date('g:i A', strtotime($time));
}

/**
 * Get class type icon
 * 
 * @param string $classType Type of class
 * @return string Font Awesome icon class
 */
function getClassTypeIcon($classType) {
    $icons = [
        'Lecture' => 'fas fa-chalkboard-teacher',
        'Laboratory' => 'fas fa-flask',
        'Tutorial' => 'fas fa-users',
        'Seminar' => 'fas fa-comments',
        'Online' => 'fas fa-laptop',
        'Hybrid' => 'fas fa-random'
    ];
    
    return $icons[$classType] ?? 'fas fa-book';
}

/**
 * Get class type color class
 * 
 * @param string $classType Type of class
 * @return string CSS color class
 */
function getClassTypeColor($classType) {
    $colors = [
        'Lecture' => 'schedule-lecture',
        'Laboratory' => 'schedule-lab',
        'Tutorial' => 'schedule-tutorial',
        'Seminar' => 'schedule-seminar',
        'Online' => 'schedule-online',
        'Hybrid' => 'schedule-hybrid'
    ];
    
    return $colors[$classType] ?? 'schedule-lecture';
}

/**
 * Check for schedule conflicts
 * 
 * @param int $studentId Student ID
 * @param string $day Day of week
 * @param string $startTime Start time
 * @param string $endTime End time
 * @param int|null $excludeId Exclude this schedule ID (for updates)
 * @return array|false Conflicting schedule or false
 */
function checkScheduleConflict($studentId, $day, $startTime, $endTime, $excludeId = null) {
    global $db;
    
    try {
        $sql = "SELECT cs.*, c.course_code as subject_code, c.course_name as subject_name
                FROM class_schedules cs
                JOIN enrollments e ON cs.enrollment_id = e.id
                JOIN curriculum c ON e.curriculum_id = c.id
                WHERE e.student_id = :student_id
                AND cs.day_of_week = :day
                AND cs.is_active = TRUE
                AND (
                    (cs.start_time < :end_time AND cs.end_time > :start_time)
                )";
        
        $params = [
            'student_id' => $studentId,
            'day' => $day,
            'start_time' => $startTime,
            'end_time' => $endTime
        ];
        
        if ($excludeId) {
            $sql .= " AND cs.id != :exclude_id";
            $params['exclude_id'] = $excludeId;
        }
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        $conflict = $stmt->fetch();
        
        return $conflict ?: false;
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Get today's schedule for a student
 * 
 * @param int $studentId Student ID
 * @return array Today's classes
 */
function getTodaySchedule($studentId) {
    $today = date('l'); // Gets current day name (Monday, Tuesday, etc.)
    $schedulesByDay = getStudentSchedulesByDay($studentId);
    
    return $schedulesByDay[$today] ?? [];
}

/**
 * Get next upcoming class for a student
 * 
 * @param int $studentId Student ID
 * @return array|null Next class or null if none
 */
function getNextClass($studentId) {
    $today = date('l');
    $currentTime = date('H:i:s');
    $schedulesByDay = getStudentSchedulesByDay($studentId);
    
    // Order of days starting from today
    $daysOrder = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    $todayIndex = array_search($today, $daysOrder);
    
    // Reorder days starting from today
    $orderedDays = array_merge(
        array_slice($daysOrder, $todayIndex),
        array_slice($daysOrder, 0, $todayIndex)
    );
    
    foreach ($orderedDays as $index => $day) {
        if (isset($schedulesByDay[$day]) && !empty($schedulesByDay[$day])) {
            foreach ($schedulesByDay[$day] as $class) {
                // If today, check if class is still upcoming
                if ($index === 0 && $class['start_time'] <= $currentTime) {
                    continue;
                }
                return array_merge($class, ['day' => $day, 'is_today' => $index === 0]);
            }
        }
    }
    
    return null;
}

// ============================================
// ADDITIONAL HELPER FUNCTIONS
// For new schema support
// ============================================

/**
 * Get all academic years
 * 
 * @param bool $activeOnly Get only active/upcoming years
 * @return array List of academic years
 */
function getAllAcademicYears($activeOnly = false) {
    global $db;
    
    try {
        $sql = "SELECT * FROM academic_years";
        if ($activeOnly) {
            $sql .= " WHERE status IN ('Ongoing', 'Upcoming')";
        }
        $sql .= " ORDER BY start_date DESC";
        
        $stmt = $db->query($sql);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get current academic year
 * 
 * @return array|false Current academic year or false
 */
function getCurrentAcademicYear() {
    global $db;
    
    try {
        $sql = "SELECT * FROM academic_years WHERE is_current = TRUE LIMIT 1";
        $stmt = $db->query($sql);
        return $stmt->fetch();
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Get all departments
 * 
 * @param bool $activeOnly Get only active departments
 * @return array List of departments
 */
function getAllDepartments($activeOnly = true) {
    global $db;
    
    try {
        $sql = "SELECT * FROM departments";
        if ($activeOnly) {
            $sql .= " WHERE is_active = TRUE";
        }
        $sql .= " ORDER BY department_name";
        
        $stmt = $db->query($sql);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get all instructors
 * 
 * @param int|null $departmentId Filter by department
 * @param bool $activeOnly Get only active instructors
 * @return array List of instructors
 */
function getAllInstructors($departmentId = null, $activeOnly = true) {
    global $db;
    
    try {
        $sql = "SELECT i.*, d.department_name, d.department_code
                FROM instructors i
                LEFT JOIN departments d ON i.department_id = d.id
                WHERE 1=1";
        
        $params = [];
        
        if ($activeOnly) {
            $sql .= " AND i.is_active = TRUE";
        }
        
        if ($departmentId) {
            $sql .= " AND i.department_id = :department_id";
            $params['department_id'] = $departmentId;
        }
        
        $sql .= " ORDER BY i.last_name, i.first_name";
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get instructor by ID
 * 
 * @param int $id Instructor ID
 * @return array|false Instructor data or false
 */
function getInstructorById($id) {
    global $db;
    
    try {
        $sql = "SELECT i.*, d.department_name, d.department_code
                FROM instructors i
                LEFT JOIN departments d ON i.department_id = d.id
                WHERE i.id = :id";
        $stmt = $db->prepare($sql);
        $stmt->execute(['id' => $id]);
        return $stmt->fetch();
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Get student with program details
 * 
 * @param int $id Student ID
 * @return array|false Student data with program info
 */
function getStudentWithProgram($id) {
    global $db;
    
    try {
        $sql = "SELECT s.*, p.program_code, p.program_name, p.degree_type,
                       d.department_name, d.department_code
                FROM students s
                LEFT JOIN programs p ON s.current_program_id = p.id
                LEFT JOIN departments d ON p.department_id = d.id
                WHERE s.id = :id";
        $stmt = $db->prepare($sql);
        $stmt->execute(['id' => $id]);
        return $stmt->fetch();
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Get curriculum (courses) for a program
 * 
 * @param int $programId Program ID
 * @param string|null $yearLevel Filter by year level
 * @param string|null $semester Filter by semester
 * @return array List of curriculum/courses
 */
function getCurriculumByProgram($programId, $yearLevel = null, $semester = null) {
    global $db;
    
    try {
        $sql = "SELECT * FROM curriculum WHERE program_id = :program_id AND is_active = TRUE";
        $params = ['program_id' => $programId];
        
        if ($yearLevel) {
            $sql .= " AND year_level = :year_level";
            $params['year_level'] = $yearLevel;
        }
        
        if ($semester) {
            $sql .= " AND semester = :semester";
            $params['semester'] = $semester;
        }
        
        $sql .= " ORDER BY year_level, semester, course_code";
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get academic year by ID
 * 
 * @param int $id Academic year ID
 * @return array|false Academic year data or false
 */
function getAcademicYearById($id) {
    global $db;
    
    try {
        $sql = "SELECT * FROM academic_years WHERE id = :id";
        $stmt = $db->prepare($sql);
        $stmt->execute(['id' => $id]);
        return $stmt->fetch();
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Get program by ID
 * 
 * @param int $id Program ID
 * @return array|false Program data or false
 */
function getProgramById($id) {
    global $db;
    
    try {
        $sql = "SELECT p.*, d.department_name, d.department_code
                FROM programs p
                LEFT JOIN departments d ON p.department_id = d.id
                WHERE p.id = :id";
        $stmt = $db->prepare($sql);
        $stmt->execute(['id' => $id]);
        return $stmt->fetch();
    } catch (PDOException $e) {
        return false;
    }
}
?>