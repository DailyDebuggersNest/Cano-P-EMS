<?php
require_once '../config/db_helpers.php';

header('Content-Type: application/json');

$curriculum_id = isset($_GET['curriculum_id']) ? intval($_GET['curriculum_id']) : 0;
$academic_year = isset($_GET['ay']) ? $_GET['ay'] : '';

if ($curriculum_id <= 0 || empty($academic_year)) {
    echo json_encode(['error' => 'Invalid parameters']);
    exit;
}

$conn = getDBConnection();

// 1. Get Course & Schedule Details
$course_sql = "SELECT c.course_code, c.course_name, c.units, c.year_level, c.semester,
                      s.day_of_week, s.start_time, s.end_time, s.room, s.capacity, s.enrolled_count,
                      t.first_name as teacher_first, t.last_name as teacher_last
               FROM curriculum c
               LEFT JOIN schedules s ON c.curriculum_id = s.curriculum_id
               LEFT JOIN teachers t ON s.teacher_id = t.teacher_id
               WHERE c.curriculum_id = ?";

// Note: schedules might have multiple rows if multiple meetings, but usually capacity/enrolled is same per course section.
// For simplicity, we fetch all schedule rows to show full meeting times.
$sched_res = db_query($conn, $course_sql, 'i', [$curriculum_id]);
$schedules = $sched_res ? db_fetch_all($sched_res) : [];

if (empty($schedules)) {
    echo json_encode(['error' => 'Course not found']);
    $conn->close();
    exit;
}

// Consolidate course info (taking first row for general info)
$info = $schedules[0];
$instructor = 'TBA';
if (!empty($info['teacher_first'])) {
    $instructor = $info['teacher_first'] . ' ' . $info['teacher_last'];
}

// Check real-time enrolled count from table count to be sure, or rely on schedules table?
// Let's count actual enrollments for accuracy.
$count_sql = "SELECT COUNT(*) as cnt 
              FROM enrollments e
              JOIN curriculum c ON e.curriculum_id = c.curriculum_id
              LEFT JOIN semester_status ss ON (e.student_id = ss.student_id AND e.academic_year = ss.academic_year AND c.semester = ss.semester)
              WHERE e.curriculum_id = ? AND e.academic_year = ? AND e.status = 'Enrolled'
              AND (ss.status = 'In Progress' OR ss.status IS NULL)";
$real_count = db_fetch_one(db_query($conn, $count_sql, 'is', [$curriculum_id, $academic_year]))['cnt'] ?? 0;


// 2. Get Enrolled Students (Filtered by Semester Status to match active term)
$stud_sql = "SELECT s.student_id, s.student_number, s.first_name, s.last_name, 
                    p.program_code, COALESCE(ss.year_level, s.year_level) as yr_at_enrollment
             FROM enrollments e
             JOIN curriculum c ON e.curriculum_id = c.curriculum_id
             JOIN students s ON e.student_id = s.student_id
             LEFT JOIN programs p ON s.program_id = p.program_id
             LEFT JOIN semester_status ss ON (e.student_id = ss.student_id AND e.academic_year = ss.academic_year AND c.semester = ss.semester)
             WHERE e.curriculum_id = ? 
               AND e.academic_year = ? 
               AND e.status = 'Enrolled'
               AND (ss.status = 'In Progress' OR ss.status IS NULL)
             ORDER BY s.last_name, s.first_name";

$students_res = db_query($conn, $stud_sql, 'is', [$curriculum_id, $academic_year]);
$students = $students_res ? db_fetch_all($students_res) : [];

echo json_encode([
    'course_code' => $info['course_code'],
    'course_name' => $info['course_name'],
    'instructor' => $instructor,
    'capacity' => $info['capacity'] . '', // cast to string
    'enrolled' => $real_count,
    'year_level' => $info['year_level'],
    'semester' => $info['semester'],
    'schedules' => array_map(function($s) {
        return [
            'day' => $s['day_of_week'],
            'start' => $s['start_time'], // Client can format
            'end' => $s['end_time'],
            'room' => $s['room']
        ];
    }, $schedules),
    'students' => $students
]);

$conn->close();
?>
