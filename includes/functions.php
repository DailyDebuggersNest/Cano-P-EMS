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
 * Add a new student to the database
 * 
 * @param array $data Student data (first_name, last_name, email, phone, date_of_birth)
 * @return bool True if successful, false otherwise
 */
function addStudent($data) {
    global $db;
    
    $sql = "INSERT INTO students (first_name, last_name, email, phone, date_of_birth) 
            VALUES (:first_name, :last_name, :email, :phone, :date_of_birth)";
    
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'first_name' => $data['first_name'],
        'last_name' => $data['last_name'],
        'email' => $data['email'],
        'phone' => $data['phone'] ?? null,
        'date_of_birth' => $data['date_of_birth'] ?? null
    ]);
}

/**
 * Update an existing student's info
 * 
 * @param int $id The student's ID
 * @param array $data Updated student data
 * @return bool True if successful
 */
function updateStudent($id, $data) {
    global $db;
    
    $sql = "UPDATE students 
            SET first_name = :first_name, 
                last_name = :last_name, 
                email = :email, 
                phone = :phone, 
                date_of_birth = :date_of_birth 
            WHERE id = :id";
    
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'id' => $id,
        'first_name' => $data['first_name'],
        'last_name' => $data['last_name'],
        'email' => $data['email'],
        'phone' => $data['phone'] ?? null,
        'date_of_birth' => $data['date_of_birth'] ?? null
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
// COURSE FUNCTIONS
// Everything related to managing courses
// ============================================

/**
 * Get all courses from the database
 * 
 * @return array List of all courses
 */
function getAllCourses() {
    global $db;
    
    $sql = "SELECT * FROM courses ORDER BY course_code";
    $stmt = $db->query($sql);
    
    return $stmt->fetchAll();
}

/**
 * Get a single course by its ID
 * 
 * @param int $id The course's ID
 * @return array|false Course data or false if not found
 */
function getCourseById($id) {
    global $db;
    
    $sql = "SELECT * FROM courses WHERE id = :id";
    $stmt = $db->prepare($sql);
    $stmt->execute(['id' => $id]);
    
    return $stmt->fetch();
}

/**
 * Add a new course to the database
 * 
 * @param array $data Course data (course_code, course_name, description, credits)
 * @return bool True if successful
 */
function addCourse($data) {
    global $db;
    
    $sql = "INSERT INTO courses (course_code, course_name, description, credits) 
            VALUES (:course_code, :course_name, :description, :credits)";
    
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'course_code' => $data['course_code'],
        'course_name' => $data['course_name'],
        'description' => $data['description'] ?? null,
        'credits' => $data['credits'] ?? 3
    ]);
}

/**
 * Update an existing course
 * 
 * @param int $id The course's ID
 * @param array $data Updated course data
 * @return bool True if successful
 */
function updateCourse($id, $data) {
    global $db;
    
    $sql = "UPDATE courses 
            SET course_code = :course_code, 
                course_name = :course_name, 
                description = :description, 
                credits = :credits 
            WHERE id = :id";
    
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'id' => $id,
        'course_code' => $data['course_code'],
        'course_name' => $data['course_name'],
        'description' => $data['description'] ?? null,
        'credits' => $data['credits'] ?? 3
    ]);
}

/**
 * Delete a course (this also removes all enrollments in it!)
 * 
 * @param int $id The course's ID
 * @return bool True if successful
 */
function deleteCourse($id) {
    global $db;
    
    $sql = "DELETE FROM courses WHERE id = :id";
    $stmt = $db->prepare($sql);
    
    return $stmt->execute(['id' => $id]);
}

// ============================================
// ENROLLMENT FUNCTIONS
// Connecting students with courses
// ============================================

/**
 * Get all enrollments with student and course details
 * This joins all three tables so we get the full picture!
 * 
 * @return array List of all enrollments with details
 */
function getAllEnrollments() {
    global $db;
    
    $sql = "SELECT 
                e.id,
                e.enrollment_date,
                e.grade,
                e.status,
                s.id as student_id,
                s.first_name,
                s.last_name,
                s.email,
                c.id as course_id,
                c.course_code,
                c.course_name
            FROM enrollments e
            JOIN students s ON e.student_id = s.id
            JOIN courses c ON e.course_id = c.id
            ORDER BY e.enrollment_date DESC";
    
    $stmt = $db->query($sql);
    
    return $stmt->fetchAll();
}

/**
 * Get a single enrollment by ID
 * 
 * @param int $id The enrollment ID
 * @return array|false Enrollment data or false if not found
 */
function getEnrollmentById($id) {
    global $db;
    
    $sql = "SELECT 
                e.*,
                s.first_name,
                s.last_name,
                c.course_code,
                c.course_name
            FROM enrollments e
            JOIN students s ON e.student_id = s.id
            JOIN courses c ON e.course_id = c.id
            WHERE e.id = :id";
    
    $stmt = $db->prepare($sql);
    $stmt->execute(['id' => $id]);
    
    return $stmt->fetch();
}

/**
 * Enroll a student in a course
 * 
 * @param int $studentId The student's ID
 * @param int $courseId The course's ID
 * @return bool True if successful
 */
function enrollStudent($studentId, $courseId) {
    global $db;
    
    // Check if already enrolled
    $checkSql = "SELECT id FROM enrollments WHERE student_id = :student_id AND course_id = :course_id";
    $checkStmt = $db->prepare($checkSql);
    $checkStmt->execute(['student_id' => $studentId, 'course_id' => $courseId]);
    
    if ($checkStmt->fetch()) {
        // Already enrolled!
        return false;
    }
    
    $sql = "INSERT INTO enrollments (student_id, course_id) VALUES (:student_id, :course_id)";
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'student_id' => $studentId,
        'course_id' => $courseId
    ]);
}

/**
 * Update an enrollment (change status or grade)
 * 
 * @param int $id The enrollment ID
 * @param array $data Updated data (status, grade)
 * @return bool True if successful
 */
function updateEnrollment($id, $data) {
    global $db;
    
    $sql = "UPDATE enrollments SET status = :status, grade = :grade WHERE id = :id";
    $stmt = $db->prepare($sql);
    
    return $stmt->execute([
        'id' => $id,
        'status' => $data['status'],
        'grade' => $data['grade'] ?? null
    ]);
}

/**
 * Remove an enrollment (unenroll a student from a course)
 * 
 * @param int $id The enrollment ID
 * @return bool True if successful
 */
function deleteEnrollment($id) {
    global $db;
    
    $sql = "DELETE FROM enrollments WHERE id = :id";
    $stmt = $db->prepare($sql);
    
    return $stmt->execute(['id' => $id]);
}

/**
 * Get courses a student is NOT enrolled in
 * Useful for the enrollment dropdown!
 * 
 * @param int $studentId The student's ID
 * @return array List of available courses
 */
function getAvailableCoursesForStudent($studentId) {
    global $db;
    
    $sql = "SELECT * FROM courses 
            WHERE id NOT IN (
                SELECT course_id FROM enrollments WHERE student_id = :student_id
            )
            ORDER BY course_code";
    
    $stmt = $db->prepare($sql);
    $stmt->execute(['student_id' => $studentId]);
    
    return $stmt->fetchAll();
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
    
    // Count courses
    $stmt = $db->query("SELECT COUNT(*) as count FROM courses");
    $stats['courses'] = $stmt->fetch()['count'];
    
    // Count active enrollments
    $stmt = $db->query("SELECT COUNT(*) as count FROM enrollments WHERE status = 'active'");
    $stats['active_enrollments'] = $stmt->fetch()['count'];
    
    return $stats;
}
?>
