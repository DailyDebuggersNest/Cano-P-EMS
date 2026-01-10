<?php
/**
 * Database Test File - Delete after testing
 */
require_once __DIR__ . '/includes/functions.php';

header('Content-Type: application/json');

// Test 1: Get all students
$students = getAllStudents();

// Test 2: Get student by ID
$student = getStudentById(1);

// Test 3: Get enrollments
$enrollments = getStudentEnrollments(1);

// Test 4: Get payments
$payments = getStudentPayments(1);

// Test 5: Get schedules
$schedules = getStudentSchedules(1);

// Test 6: Get enrollment stats
$stats = getEnrollmentStats(1);

// Test 7: Get payment summary
$paymentSummary = getPaymentSummary(1);

// Output results
echo json_encode([
    'students_count' => count($students),
    'student' => $student ? [
        'id' => $student['id'],
        'student_id' => $student['student_id'],
        'name' => $student['first_name'] . ' ' . $student['last_name'],
        'program_code' => $student['program_code'] ?? 'NULL',
        'program_name' => $student['program_name'] ?? 'NULL',
        'year_level' => $student['year_level'],
        'current_semester' => $student['current_semester'] ?? $student['semester'] ?? 'NULL'
    ] : 'NOT FOUND',
    'enrollments_count' => count($enrollments),
    'enrollments_sample' => array_slice(array_map(function($e) {
        return [
            'subject_code' => $e['subject_code'] ?? 'NULL',
            'subject_name' => $e['subject_name'] ?? 'NULL',
            'grade' => $e['grade'],
            'grade_status' => $e['grade_status']
        ];
    }, $enrollments), 0, 3),
    'payments_count' => count($payments),
    'schedules_count' => count($schedules),
    'enrollment_stats' => $stats,
    'payment_summary' => $paymentSummary
], JSON_PRETTY_PRINT);
