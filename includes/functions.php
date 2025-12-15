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
 * Get all students from the database
 * 
 * @return array List of all students
 */
function getAllStudents() {
    global $db;
    
    $sql = "SELECT * FROM students ORDER BY last_name, first_name";
    $stmt = $db->query($sql);
    
    return $stmt->fetchAll();
}

/**
 * Get a single student by their ID
 * 
 * @param int $id The student's ID
 * @return array|false Student data or false if not found
 */
function getStudentById($id) {
    global $db;
    
    $sql = "SELECT * FROM students WHERE id = :id";
    $stmt = $db->prepare($sql);
    $stmt->execute(['id' => $id]);
    
    return $stmt->fetch();
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
                guardian_name, guardian_relationship, guardian_contact, guardian_address,
                emergency_contact_name, emergency_contact_phone,
                student_status, admission_date, year_level, semester, section, program
            ) VALUES (
                :student_id, :first_name, :middle_name, :last_name, :suffix,
                :sex, :civil_status, :nationality, :religion, :blood_type,
                :email, :phone, :date_of_birth, :place_of_birth,
                :address_street, :address_barangay, :address_city, :address_province, :address_zip,
                :guardian_name, :guardian_relationship, :guardian_contact, :guardian_address,
                :emergency_contact_name, :emergency_contact_phone,
                :student_status, :admission_date, :year_level, :semester, :section, :program
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
        'blood_type' => $data['blood_type'] ?? 'Unknown',
        'email' => $data['email'],
        'phone' => $data['phone'] ?? null,
        'date_of_birth' => $data['date_of_birth'] ?? null,
        'place_of_birth' => $data['place_of_birth'] ?? null,
        'address_street' => $data['address_street'] ?? null,
        'address_barangay' => $data['address_barangay'] ?? null,
        'address_city' => $data['address_city'] ?? null,
        'address_province' => $data['address_province'] ?? null,
        'address_zip' => $data['address_zip'] ?? null,
        'guardian_name' => $data['guardian_name'] ?? null,
        'guardian_relationship' => $data['guardian_relationship'] ?? null,
        'guardian_contact' => $data['guardian_contact'] ?? null,
        'guardian_address' => $data['guardian_address'] ?? null,
        'emergency_contact_name' => $data['emergency_contact_name'] ?? null,
        'emergency_contact_phone' => $data['emergency_contact_phone'] ?? null,
        'student_status' => $data['student_status'] ?? 'Active',
        'admission_date' => $data['admission_date'] ?? date('Y-m-d'),
        'year_level' => $data['year_level'] ?? '1st Year',
        'semester' => $data['semester'] ?? '1st Semester',
        'section' => $data['section'] ?? null,
        'program' => $data['program'] ?? null
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
                guardian_name = :guardian_name,
                guardian_relationship = :guardian_relationship,
                guardian_contact = :guardian_contact,
                guardian_address = :guardian_address,
                emergency_contact_name = :emergency_contact_name,
                emergency_contact_phone = :emergency_contact_phone,
                student_status = :student_status,
                year_level = :year_level,
                semester = :semester,
                section = :section,
                program = :program
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
        'blood_type' => $data['blood_type'] ?? 'Unknown',
        'email' => $data['email'],
        'phone' => $data['phone'] ?? null,
        'date_of_birth' => $data['date_of_birth'] ?? null,
        'place_of_birth' => $data['place_of_birth'] ?? null,
        'address_street' => $data['address_street'] ?? null,
        'address_barangay' => $data['address_barangay'] ?? null,
        'address_city' => $data['address_city'] ?? null,
        'address_province' => $data['address_province'] ?? null,
        'address_zip' => $data['address_zip'] ?? null,
        'guardian_name' => $data['guardian_name'] ?? null,
        'guardian_relationship' => $data['guardian_relationship'] ?? null,
        'guardian_contact' => $data['guardian_contact'] ?? null,
        'guardian_address' => $data['guardian_address'] ?? null,
        'emergency_contact_name' => $data['emergency_contact_name'] ?? null,
        'emergency_contact_phone' => $data['emergency_contact_phone'] ?? null,
        'student_status' => $data['student_status'] ?? 'Active',
        'year_level' => $data['year_level'] ?? '1st Year',
        'semester' => $data['semester'] ?? '1st Semester',
        'section' => $data['section'] ?? null,
        'program' => $data['program'] ?? null
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

/**
 * Get some quick stats for the dashboard
 * 
 * @return array Stats array with counts
 */
function getDashboardStats() {
    global $db;
    
    $stats = [];
    
    // Count students
    $stmt = $db->query("SELECT COUNT(*) as count FROM students");
    $stats['students'] = $stmt->fetch()['count'];
    
    // Count programs
    $stmt = $db->query("SELECT COUNT(*) as count FROM programs");
    $stats['programs'] = $stmt->fetch()['count'];
    
    return $stats;
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

/**
 * Get students by status
 * 
 * @param string $status The student status to filter by
 * @return array List of students
 */
function getStudentsByStatus($status) {
    global $db;
    
    $sql = "SELECT * FROM students WHERE student_status = :status ORDER BY last_name, first_name";
    $stmt = $db->prepare($sql);
    $stmt->execute(['status' => $status]);
    
    return $stmt->fetchAll();
}

/**
 * Get students by year level
 * 
 * @param string $yearLevel The year level to filter by
 * @return array List of students
 */
function getStudentsByYearLevel($yearLevel) {
    global $db;
    
    $sql = "SELECT * FROM students WHERE year_level = :year_level ORDER BY last_name, first_name";
    $stmt = $db->prepare($sql);
    $stmt->execute(['year_level' => $yearLevel]);
    
    return $stmt->fetchAll();
}

/**
 * Search students by name or ID
 * 
 * @param string $query Search query
 * @return array List of matching students
 */
function searchStudents($query) {
    global $db;
    
    $searchTerm = "%{$query}%";
    
    $sql = "SELECT * FROM students 
            WHERE student_id LIKE :query 
               OR first_name LIKE :query 
               OR middle_name LIKE :query 
               OR last_name LIKE :query 
               OR email LIKE :query
            ORDER BY last_name, first_name";
    
    $stmt = $db->prepare($sql);
    $stmt->execute(['query' => $searchTerm]);
    
    return $stmt->fetchAll();
}

/**
 * Get SIS statistics for dashboard
 * 
 * @return array Statistics array
 */
function getSISStats() {
    global $db;
    
    $stats = [];
    
    try {
        // Total students
        $stmt = $db->query("SELECT COUNT(*) as count FROM students");
        $stats['total_students'] = $stmt->fetch()['count'];
        
        // Active students
        $stmt = $db->query("SELECT COUNT(*) as count FROM students WHERE student_status = 'Active'");
        $stats['active_students'] = $stmt->fetch()['count'];
        
        // Male students
        $stmt = $db->query("SELECT COUNT(*) as count FROM students WHERE sex = 'Male'");
        $stats['male_students'] = $stmt->fetch()['count'];
        
        // Female students
        $stmt = $db->query("SELECT COUNT(*) as count FROM students WHERE sex = 'Female'");
        $stats['female_students'] = $stmt->fetch()['count'];
        
        // Students by year level
        $stmt = $db->query("SELECT year_level, COUNT(*) as count FROM students GROUP BY year_level");
        $stats['by_year_level'] = $stmt->fetchAll();
        
    } catch (PDOException $e) {
        // Handle case where new columns don't exist yet
        $stats['total_students'] = 0;
        $stats['active_students'] = 0;
        $stats['male_students'] = 0;
        $stats['female_students'] = 0;
        $stats['by_year_level'] = [];
    }
    
    return $stats;
}

// ============================================
// PROGRAM MANAGEMENT FUNCTIONS
// Everything related to managing academic programs
// ============================================

/**
 * Get all programs with student count statistics
 * 
 * @return array List of programs with stats
 */
function getAllProgramsWithStats() {
    global $db;
    
    try {
        $sql = "SELECT p.*, 
                       (SELECT COUNT(*) FROM students s WHERE s.program = p.program_name) as student_count
                FROM programs p 
                ORDER BY p.program_code";
        $stmt = $db->query($sql);
        return $stmt->fetchAll();
    } catch (PDOException $e) {
        return [];
    }
}

/**
 * Get a single program by ID
 * 
 * @param int $id Program ID
 * @return array|false Program data or false
 */
function getProgramById($id) {
    global $db;
    
    $sql = "SELECT * FROM programs WHERE id = :id";
    $stmt = $db->prepare($sql);
    $stmt->execute(['id' => $id]);
    
    return $stmt->fetch();
}

/**
 * Get a program by its code
 * 
 * @param string $code Program code (e.g., BSIT)
 * @return array|false Program data or false
 */
function getProgramByCode($code) {
    global $db;
    
    $sql = "SELECT * FROM programs WHERE program_code = :code";
    $stmt = $db->prepare($sql);
    $stmt->execute(['code' => $code]);
    
    return $stmt->fetch();
}

/**
 * Add a new program
 * 
 * @param array $data Program data
 * @return bool Success status
 */
function addProgram($data) {
    global $db;
    
    try {
        // Check if code already exists
        if (getProgramByCode($data['program_code'])) {
            return false;
        }
        
        $sql = "INSERT INTO programs (program_code, program_name, department, years_duration, description) 
                VALUES (:program_code, :program_name, :department, :years_duration, :description)";
        
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'program_code' => strtoupper(trim($data['program_code'])),
            'program_name' => trim($data['program_name']),
            'department' => trim($data['department'] ?? ''),
            'years_duration' => (int) ($data['years_duration'] ?? 4),
            'description' => trim($data['description'] ?? '')
        ]);
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Update an existing program
 * 
 * @param int $id Program ID
 * @param array $data Updated data
 * @return bool Success status
 */
function updateProgram($id, $data) {
    global $db;
    
    try {
        // Get current program
        $current = getProgramById($id);
        if (!$current) {
            return false;
        }
        
        // If code changed, check it doesn't conflict
        if (strtoupper($data['program_code']) !== $current['program_code']) {
            $existing = getProgramByCode($data['program_code']);
            if ($existing && $existing['id'] != $id) {
                return false;
            }
        }
        
        // If program name changed, update students
        if ($data['program_name'] !== $current['program_name']) {
            $updateStudents = "UPDATE students SET program = :new_name WHERE program = :old_name";
            $stmt = $db->prepare($updateStudents);
            $stmt->execute([
                'new_name' => $data['program_name'],
                'old_name' => $current['program_name']
            ]);
        }
        
        $sql = "UPDATE programs SET 
                    program_code = :program_code,
                    program_name = :program_name,
                    department = :department,
                    years_duration = :years_duration,
                    description = :description
                WHERE id = :id";
        
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'id' => $id,
            'program_code' => strtoupper(trim($data['program_code'])),
            'program_name' => trim($data['program_name']),
            'department' => trim($data['department'] ?? ''),
            'years_duration' => (int) ($data['years_duration'] ?? 4),
            'description' => trim($data['description'] ?? '')
        ]);
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Delete a program (only if no students enrolled)
 * 
 * @param int $id Program ID
 * @return bool Success status
 */
function deleteProgram($id) {
    global $db;
    
    try {
        $program = getProgramById($id);
        if (!$program) {
            return false;
        }
        
        // Check for enrolled students
        $count = getStudentCountByProgram($program['program_name']);
        if ($count > 0) {
            return false;
        }
        
        $sql = "DELETE FROM programs WHERE id = :id";
        $stmt = $db->prepare($sql);
        return $stmt->execute(['id' => $id]);
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Get students enrolled in a specific program
 * 
 * @param string $programName Program name
 * @return array List of students
 */
function getStudentsByProgram($programName) {
    global $db;
    
    $sql = "SELECT * FROM students 
            WHERE program = :program 
            ORDER BY year_level, last_name, first_name";
    $stmt = $db->prepare($sql);
    $stmt->execute(['program' => $programName]);
    
    return $stmt->fetchAll();
}

/**
 * Get student count by program name
 * 
 * @param string $programName Program name
 * @return int Student count
 */
function getStudentCountByProgram($programName) {
    global $db;
    
    $sql = "SELECT COUNT(*) as count FROM students WHERE program = :program";
    $stmt = $db->prepare($sql);
    $stmt->execute(['program' => $programName]);
    $result = $stmt->fetch();
    
    return (int) ($result['count'] ?? 0);
}

/**
 * Get year level statistics for a program
 * 
 * @param string $programName Program name
 * @return array Year level counts
 */
function getYearLevelStatsByProgram($programName) {
    global $db;
    
    $sql = "SELECT year_level, COUNT(*) as count 
            FROM students 
            WHERE program = :program 
            GROUP BY year_level";
    $stmt = $db->prepare($sql);
    $stmt->execute(['program' => $programName]);
    $results = $stmt->fetchAll();
    
    // Convert to associative array
    $stats = [];
    foreach ($results as $row) {
        $stats[$row['year_level']] = (int) $row['count'];
    }
    
    return $stats;
}

/**
 * Get students without a program assigned
 * 
 * @return array List of unassigned students
 */
function getStudentsWithoutProgram() {
    global $db;
    
    $sql = "SELECT * FROM students 
            WHERE program IS NULL OR program = '' 
            ORDER BY last_name, first_name";
    $stmt = $db->query($sql);
    
    return $stmt->fetchAll();
}

/**
 * Assign a student to a program
 * 
 * @param int $studentId Student ID
 * @param string $programName Program name
 * @param string $yearLevel Year level
 * @param string $semester Current semester
 * @return bool Success status
 */
function assignStudentToProgram($studentId, $programName, $yearLevel, $semester) {
    global $db;
    
    try {
        $sql = "UPDATE students SET 
                    program = :program,
                    year_level = :year_level,
                    semester = :semester
                WHERE id = :id";
        
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'id' => $studentId,
            'program' => $programName,
            'year_level' => $yearLevel,
            'semester' => $semester
        ]);
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * Update student academic information (year level, semester, status)
 * 
 * @param int $studentId Student ID
 * @param array $data Academic data
 * @return bool Success status
 */
function updateStudentAcademicInfo($studentId, $data) {
    global $db;
    
    try {
        $updates = [];
        $params = ['id' => $studentId];
        
        if (isset($data['year_level'])) {
            $updates[] = "year_level = :year_level";
            $params['year_level'] = $data['year_level'];
        }
        
        if (isset($data['semester'])) {
            $updates[] = "semester = :semester";
            $params['semester'] = $data['semester'];
        }
        
        if (isset($data['student_status'])) {
            $updates[] = "student_status = :student_status";
            $params['student_status'] = $data['student_status'];
        }
        
        if (empty($updates)) {
            return false;
        }
        
        $sql = "UPDATE students SET " . implode(', ', $updates) . " WHERE id = :id";
        $stmt = $db->prepare($sql);
        return $stmt->execute($params);
    } catch (PDOException $e) {
        return false;
    }
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
        $sql = "SELECT e.*, s.subject_code, s.subject_name, s.description as subject_description, 
                       s.units, s.lecture_hours, s.lab_hours
                FROM enrollments e
                JOIN subjects s ON e.subject_id = s.id
                WHERE e.student_id = :student_id";
        
        $params = ['student_id' => $studentId];
        
        if ($academicYear) {
            $sql .= " AND e.academic_year = :academic_year";
            $params['academic_year'] = $academicYear;
        }
        
        if ($semester) {
            $sql .= " AND e.semester = :semester";
            $params['semester'] = $semester;
        }
        
        $sql .= " ORDER BY e.academic_year DESC, e.semester, s.subject_code";
        
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
        // Get the most recent enrollment academic year/semester for this student
        $sql = "SELECT DISTINCT academic_year, semester 
                FROM enrollments 
                WHERE student_id = :student_id 
                ORDER BY academic_year DESC, FIELD(semester, '1st Semester', '2nd Semester', 'Summer') DESC 
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
                       COALESCE(SUM(CASE WHEN e.grade_status = 'Passed' THEN s.units ELSE 0 END), 0) as units
                FROM enrollments e
                JOIN subjects s ON e.subject_id = s.id
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
        
        // Current semester units (most recent academic year/semester)
        $sql = "SELECT COALESCE(SUM(s.units), 0) as units
                FROM enrollments e
                JOIN subjects s ON e.subject_id = s.id
                WHERE e.student_id = :student_id
                AND (e.academic_year, e.semester) = (
                    SELECT academic_year, semester 
                    FROM enrollments 
                    WHERE student_id = :student_id2 
                    ORDER BY academic_year DESC, FIELD(semester, '2nd Semester', '1st Semester', 'Summer') DESC 
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
        $sql = "SELECT * FROM subjects";
        $params = [];
        
        if ($programId) {
            $sql .= " WHERE program_id = :program_id";
            $params['program_id'] = $programId;
        }
        
        $sql .= " ORDER BY year_level, semester, subject_code";
        
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
function enrollStudent($studentId, $subjectId, $academicYear, $semester) {
    global $db;
    
    try {
        $sql = "INSERT INTO enrollments (student_id, subject_id, academic_year, semester, enrollment_date, grade_status)
                VALUES (:student_id, :subject_id, :academic_year, :semester, CURRENT_DATE, 'Pending')";
        
        $stmt = $db->prepare($sql);
        return $stmt->execute([
            'student_id' => $studentId,
            'subject_id' => $subjectId,
            'academic_year' => $academicYear,
            'semester' => $semester
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
        $sql = "SELECT p.*, pt.type_name as payment_type_name
                FROM payments p
                LEFT JOIN payment_types pt ON p.payment_type_id = pt.id
                WHERE p.student_id = :student_id";
        
        $params = ['student_id' => $studentId];
        
        if ($academicYear) {
            $sql .= " AND p.academic_year = :academic_year";
            $params['academic_year'] = $academicYear;
        }
        
        if ($semester) {
            $sql .= " AND p.semester = :semester";
            $params['semester'] = $semester;
        }
        
        $sql .= " ORDER BY p.academic_year DESC, p.created_at DESC";
        
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
        // Get the most recent payment academic year/semester for this student
        $sql = "SELECT DISTINCT academic_year, semester 
                FROM payments 
                WHERE student_id = :student_id 
                ORDER BY academic_year DESC, FIELD(semester, '1st Semester', '2nd Semester', 'Summer') DESC 
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
                    COALESCE(SUM(amount_due), 0) as total_due,
                    COALESCE(SUM(amount_paid), 0) as total_paid,
                    COALESCE(SUM(amount_due) - SUM(amount_paid), 0) as balance,
                    COUNT(*) as payment_count,
                    SUM(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END) as paid_count,
                    SUM(CASE WHEN payment_status = 'Partial' THEN 1 ELSE 0 END) as partial_count,
                    SUM(CASE WHEN payment_status = 'Unpaid' THEN 1 ELSE 0 END) as unpaid_count,
                    SUM(CASE WHEN payment_status = 'Overdue' THEN 1 ELSE 0 END) as overdue_count
                FROM payments 
                WHERE student_id = :student_id";
        
        $params = ['student_id' => $studentId];
        
        if ($academicYear) {
            $sql .= " AND academic_year = :academic_year";
            $params['academic_year'] = $academicYear;
        }
        
        if ($semester) {
            $sql .= " AND semester = :semester";
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
                    student_id, payment_type_id, academic_year, semester,
                    description, amount_due, amount_paid, payment_date,
                    payment_method, reference_number, payment_status, due_date, remarks
                ) VALUES (
                    :student_id, :payment_type_id, :academic_year, :semester,
                    :description, :amount_due, :amount_paid, :payment_date,
                    :payment_method, :reference_number, :payment_status, :due_date, :remarks
                )";
        
        $stmt = $db->prepare($sql);
        $result = $stmt->execute([
            'student_id' => $data['student_id'],
            'payment_type_id' => $data['payment_type_id'] ?? null,
            'academic_year' => $data['academic_year'],
            'semester' => $data['semester'],
            'description' => $data['description'] ?? null,
            'amount_due' => $data['amount_due'],
            'amount_paid' => $data['amount_paid'] ?? 0,
            'payment_date' => $data['payment_date'] ?? null,
            'payment_method' => $data['payment_method'] ?? 'Cash',
            'reference_number' => $data['reference_number'] ?? null,
            'payment_status' => $data['payment_status'] ?? 'Unpaid',
            'due_date' => $data['due_date'] ?? null,
            'remarks' => $data['remarks'] ?? null
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
?>

