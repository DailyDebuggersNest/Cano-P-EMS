<?php
// api/dashboard_stats.php
require_once __DIR__ . '/../config/db_helpers.php';
header('Content-Type: application/json');

$conn = getDBConnection();

$response = [
    'programs' => [],
    'financials' => [],
    'population' => [],
    'totals' => []
];

// 1. Total Students
$response['totals']['students'] = db_count($conn, 'students');
$response['totals']['courses'] = db_count($conn, 'curriculum');

// 2. Students by Program (Pie Chart)
$prog_sql = "SELECT p.program_code, COUNT(s.student_id) as count 
             FROM students s 
             LEFT JOIN programs p ON s.program_id = p.program_id 
             GROUP BY p.program_code";
$response['programs'] = db_fetch_all(db_query($conn, $prog_sql));

// 3. Financials (Current Term Only) - Paid vs Expected
// Identify Latest Term
$latest_sql = "SELECT e.academic_year, c.semester 
               FROM enrollments e 
               JOIN curriculum c ON e.curriculum_id = c.curriculum_id 
               ORDER BY e.academic_year DESC, c.semester DESC LIMIT 1";
$latest = db_fetch_one(db_query($conn, $latest_sql));

if ($latest) {
    $ay = $latest['academic_year'];
    $sem = $latest['semester'];
    
    // Get Fees
    $tuition_rate = 0;
    $total_fixed = 0;
    $res = db_query($conn, "SELECT * FROM fees");
    while($row = $res->fetch_assoc()) {
        if ($row['code'] === 'TUITION') $tuition_rate = $row['amount'];
        elseif ($row['type'] === 'fixed') $total_fixed += $row['amount'];
    }
    
    // Calculate Total Assessment for this Term
    // Sum of (Units * Rate) + (Students * Fixed)
    // Get distinct students enrolled this term
    $stud_sql = "SELECT COUNT(DISTINCT e.student_id) as count 
                 FROM enrollments e 
                 JOIN curriculum c ON e.curriculum_id = c.curriculum_id 
                 WHERE e.academic_year = ? AND c.semester = ? AND e.status='Enrolled'";
    $student_count_term = db_fetch_one(db_query($conn, $stud_sql, 'si', [$ay, $sem]))['count'] ?? 0;
    
    $unit_sql = "SELECT SUM(c.units) as total_units 
                 FROM enrollments e 
                 JOIN curriculum c ON e.curriculum_id = c.curriculum_id 
                 WHERE e.academic_year = ? AND c.semester = ? AND e.status='Enrolled'";
    $total_units_term = db_fetch_one(db_query($conn, $unit_sql, 'si', [$ay, $sem]))['total_units'] ?? 0;
    
    $total_assessment = ($total_units_term * $tuition_rate) + ($student_count_term * $total_fixed);
    
    // Calculate Total Paid for this Term
    $paid_sql = "SELECT SUM(amount) as paid 
                 FROM payments 
                 WHERE academic_year = ? AND semester = ?";
    $total_paid = db_fetch_one(db_query($conn, $paid_sql, 'si', [$ay, $sem]))['paid'] ?? 0;
    
    $response['financials'] = [
        'term' => "$ay - Sem $sem",
        'assessed' => $total_assessment,
        'collected' => $total_paid,
        'balance' => $total_assessment - $total_paid
    ];
}

$conn->close();
echo json_encode($response);
?>
