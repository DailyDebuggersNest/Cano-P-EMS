<?php
/**
 * Academic Helper Functions
 * Includes: GPA/GWA calculation, Academic Standing, Prerequisites checking
 */
require_once __DIR__ . '/db_helpers.php';

/**
 * Philippine Grading Scale Reference:
 * 1.00 - Excellent
 * 1.25 - Very Good
 * 1.50 - Very Good
 * 1.75 - Good
 * 2.00 - Good
 * 2.25 - Satisfactory
 * 2.50 - Satisfactory
 * 2.75 - Fair
 * 3.00 - Passing
 * 4.00 - Conditional
 * 5.00 - Failed
 */

/**
 * Calculate GPA for a specific term
 * @param mysqli $conn Database connection
 * @param int $student_id Student ID
 * @param string $academic_year Academic year (e.g., "2025-2026")
 * @param int $semester Semester (1 or 2)
 * @return array ['gpa' => float, 'total_units' => int, 'passed_units' => int, 'grades' => array]
 */
function calculateTermGPA($conn, $student_id, $academic_year, $semester) {
    $sql = "SELECT e.enrollment_id, e.final_grade, c.units, c.course_code, c.course_name
            FROM enrollments e
            JOIN curriculum c ON e.curriculum_id = c.curriculum_id
            WHERE e.student_id = ? 
            AND e.academic_year = ? 
            AND c.semester = ?
            AND e.final_grade IS NOT NULL";
    
    $result = db_query($conn, $sql, 'isi', [$student_id, $academic_year, $semester]);
    $enrollments = $result ? db_fetch_all($result) : [];
    
    $total_weighted = 0;
    $total_units = 0;
    $passed_units = 0;
    $grades = [];
    
    foreach ($enrollments as $e) {
        $grade = floatval($e['final_grade']);
        $units = intval($e['units']);
        
        $grades[] = [
            'course_code' => $e['course_code'],
            'course_name' => $e['course_name'],
            'units' => $units,
            'grade' => $grade,
            'status' => $grade <= 3.00 ? 'Passed' : ($grade <= 4.00 ? 'Conditional' : 'Failed')
        ];
        
        $total_weighted += ($grade * $units);
        $total_units += $units;
        
        if ($grade <= 3.00) {
            $passed_units += $units;
        }
    }
    
    $gpa = $total_units > 0 ? round($total_weighted / $total_units, 2) : 0;
    
    return [
        'gpa' => $gpa,
        'total_units' => $total_units,
        'passed_units' => $passed_units,
        'failed_units' => $total_units - $passed_units,
        'grades' => $grades
    ];
}

/**
 * Calculate Cumulative GPA (GWA) for a student across all terms
 * @param mysqli $conn Database connection
 * @param int $student_id Student ID
 * @return array ['cumulative_gpa' => float, 'total_units' => int, 'passed_units' => int, 'terms' => array]
 */
function calculateCumulativeGPA($conn, $student_id) {
    $sql = "SELECT e.final_grade, c.units, c.course_code, c.semester, e.academic_year
            FROM enrollments e
            JOIN curriculum c ON e.curriculum_id = c.curriculum_id
            WHERE e.student_id = ? 
            AND e.final_grade IS NOT NULL
            AND e.status IN ('Passed', 'Failed')
            ORDER BY e.academic_year, c.semester";
    
    $result = db_query($conn, $sql, 'i', [$student_id]);
    $enrollments = $result ? db_fetch_all($result) : [];
    
    $total_weighted = 0;
    $total_units = 0;
    $passed_units = 0;
    $terms = [];
    
    foreach ($enrollments as $e) {
        $grade = floatval($e['final_grade']);
        $units = intval($e['units']);
        $term_key = $e['academic_year'] . '-S' . $e['semester'];
        
        if (!isset($terms[$term_key])) {
            $terms[$term_key] = [
                'academic_year' => $e['academic_year'],
                'semester' => $e['semester'],
                'weighted_sum' => 0,
                'units' => 0,
                'gpa' => 0
            ];
        }
        
        $total_weighted += ($grade * $units);
        $total_units += $units;
        $terms[$term_key]['weighted_sum'] += ($grade * $units);
        $terms[$term_key]['units'] += $units;
        
        if ($grade <= 3.00) {
            $passed_units += $units;
        }
    }
    
    // Calculate per-term GPA
    foreach ($terms as &$term) {
        $term['gpa'] = $term['units'] > 0 ? round($term['weighted_sum'] / $term['units'], 2) : 0;
    }
    
    $cumulative_gpa = $total_units > 0 ? round($total_weighted / $total_units, 2) : 0;
    
    return [
        'cumulative_gpa' => $cumulative_gpa,
        'total_units' => $total_units,
        'passed_units' => $passed_units,
        'failed_units' => $total_units - $passed_units,
        'completion_rate' => $total_units > 0 ? round(($passed_units / $total_units) * 100, 1) : 0,
        'terms' => array_values($terms)
    ];
}

/**
 * Determine academic standing based on GPA
 * @param mysqli $conn Database connection
 * @param float $gpa The GPA to evaluate
 * @param int $units Total units taken
 * @return array ['standing' => string, 'description' => string]
 */
function determineAcademicStanding($conn, $gpa, $units = 0) {
    // Fetch standing configurations ordered by priority
    $sql = "SELECT * FROM academic_standing_config 
            WHERE is_active = 1 
            ORDER BY priority DESC";
    $result = db_query($conn, $sql);
    $configs = $result ? db_fetch_all($result) : [];
    
    // Default standing
    $standing = 'Good Standing';
    $description = 'Meeting academic requirements';
    
    if ($gpa == 0) {
        return [
            'standing' => 'Pending',
            'description' => 'No grades recorded yet',
            'css_class' => 'status-pending'
        ];
    }
    
    foreach ($configs as $config) {
        $meets_gpa = true;
        $meets_units = ($units >= $config['min_units']);
        
        // Check GPA range
        if ($config['min_gpa'] !== null && $gpa < $config['min_gpa']) {
            $meets_gpa = false;
        }
        if ($config['max_gpa'] !== null && $gpa > $config['max_gpa']) {
            $meets_gpa = false;
        }
        
        if ($meets_gpa && $meets_units) {
            $standing = $config['standing'];
            $description = $config['description'];
            break;
        }
    }
    
    // Determine CSS class for display
    $css_classes = [
        'Dean\'s List' => 'status-deans-list',
        'With Honors' => 'status-honors',
        'Good Standing' => 'status-good',
        'Warning' => 'status-warning',
        'Probation' => 'status-probation',
        'Dismissed' => 'status-dismissed'
    ];
    
    return [
        'standing' => $standing,
        'description' => $description,
        'css_class' => $css_classes[$standing] ?? 'status-default'
    ];
}

/**
 * Update student's academic standing in database
 * @param mysqli $conn Database connection
 * @param int $student_id Student ID
 * @param string $academic_year Academic year
 * @param int $semester Semester
 * @return bool Success status
 */
function updateAcademicStanding($conn, $student_id, $academic_year, $semester) {
    // Calculate term GPA
    $term_data = calculateTermGPA($conn, $student_id, $academic_year, $semester);
    
    if ($term_data['total_units'] == 0) {
        return false; // No grades yet
    }
    
    // Determine standing
    $standing_info = determineAcademicStanding($conn, $term_data['gpa'], $term_data['total_units']);
    
    // Check if record exists
    $exists = db_exists($conn, 'academic_standings', 
        'student_id = ? AND academic_year = ? AND semester = ?',
        'isi', [$student_id, $academic_year, $semester]);
    
    if ($exists) {
        // Update existing
        $sql = "UPDATE academic_standings SET 
                gpa = ?, standing = ?, total_units_taken = ?, total_units_passed = ?, evaluated_at = NOW()
                WHERE student_id = ? AND academic_year = ? AND semester = ?";
        db_query($conn, $sql, 'dsiisi', [
            $term_data['gpa'], 
            $standing_info['standing'],
            $term_data['total_units'],
            $term_data['passed_units'],
            $student_id, $academic_year, $semester
        ]);
    } else {
        // Insert new
        $sql = "INSERT INTO academic_standings 
                (student_id, academic_year, semester, gpa, standing, total_units_taken, total_units_passed)
                VALUES (?, ?, ?, ?, ?, ?, ?)";
        db_query($conn, $sql, 'isidsii', [
            $student_id, $academic_year, $semester,
            $term_data['gpa'], $standing_info['standing'],
            $term_data['total_units'], $term_data['passed_units']
        ]);
    }
    
    // Also update cumulative GPA in students table
    $cumulative = calculateCumulativeGPA($conn, $student_id);
    $sql = "UPDATE students SET cumulative_gpa = ?, academic_standing = ? WHERE student_id = ?";
    db_query($conn, $sql, 'dsi', [$cumulative['cumulative_gpa'], $standing_info['standing'], $student_id]);
    
    return true;
}

/**
 * Get academic standing history for a student
 * @param mysqli $conn Database connection
 * @param int $student_id Student ID
 * @return array List of academic standings by term
 */
function getAcademicStandingHistory($conn, $student_id) {
    $sql = "SELECT * FROM academic_standings 
            WHERE student_id = ? 
            ORDER BY academic_year DESC, semester DESC";
    $result = db_query($conn, $sql, 'i', [$student_id]);
    return $result ? db_fetch_all($result) : [];
}

/**
 * Check if a student has met prerequisites for a course
 * @param mysqli $conn Database connection
 * @param int $student_id Student ID
 * @param int $curriculum_id Course curriculum ID
 * @return array ['can_enroll' => bool, 'missing' => array, 'message' => string]
 */
function checkPrerequisites($conn, $student_id, $curriculum_id) {
    // Get prerequisites for this course
    $sql = "SELECT cp.*, c.course_code, c.course_name, cp.min_grade
            FROM course_prerequisites cp
            JOIN curriculum c ON cp.required_curriculum_id = c.curriculum_id
            WHERE cp.curriculum_id = ?";
    
    $result = db_query($conn, $sql, 'i', [$curriculum_id]);
    $prerequisites = $result ? db_fetch_all($result) : [];
    
    if (empty($prerequisites)) {
        return [
            'can_enroll' => true,
            'missing' => [],
            'message' => 'No prerequisites required'
        ];
    }
    
    $missing = [];
    $can_enroll = true;
    
    foreach ($prerequisites as $prereq) {
        // Check if student has passed this prerequisite
        $check_sql = "SELECT e.final_grade, e.status
                      FROM enrollments e
                      WHERE e.student_id = ? 
                      AND e.curriculum_id = ?
                      AND (e.status = 'Passed' OR (e.final_grade IS NOT NULL AND e.final_grade <= ?))
                      LIMIT 1";
        
        $check_result = db_query($conn, $check_sql, 'iid', [
            $student_id, 
            $prereq['required_curriculum_id'],
            $prereq['min_grade']
        ]);
        
        $passed = $check_result ? db_fetch_one($check_result) : null;
        
        if (!$passed) {
            $can_enroll = false;
            $missing[] = [
                'course_code' => $prereq['course_code'],
                'course_name' => $prereq['course_name'],
                'min_grade' => $prereq['min_grade'],
                'status' => 'Not Taken/Passed'
            ];
        }
    }
    
    $message = $can_enroll 
        ? 'All prerequisites met' 
        : 'Missing ' . count($missing) . ' prerequisite(s): ' . implode(', ', array_column($missing, 'course_code'));
    
    return [
        'can_enroll' => $can_enroll,
        'missing' => $missing,
        'message' => $message
    ];
}

/**
 * Get all prerequisites for a course
 * @param mysqli $conn Database connection
 * @param int $curriculum_id Course curriculum ID
 * @return array List of prerequisites
 */
function getCoursePrerequisites($conn, $curriculum_id) {
    $sql = "SELECT c.course_code, c.course_name, c.units, cp.min_grade
            FROM course_prerequisites cp
            JOIN curriculum c ON cp.required_curriculum_id = c.curriculum_id
            WHERE cp.curriculum_id = ?";
    
    $result = db_query($conn, $sql, 'i', [$curriculum_id]);
    return $result ? db_fetch_all($result) : [];
}

/**
 * Get courses that require this course as a prerequisite
 * @param mysqli $conn Database connection
 * @param int $curriculum_id Course curriculum ID
 * @return array List of dependent courses
 */
function getDependentCourses($conn, $curriculum_id) {
    $sql = "SELECT c.course_code, c.course_name, c.units, c.year_level, c.semester
            FROM course_prerequisites cp
            JOIN curriculum c ON cp.curriculum_id = c.curriculum_id
            WHERE cp.required_curriculum_id = ?";
    
    $result = db_query($conn, $sql, 'i', [$curriculum_id]);
    return $result ? db_fetch_all($result) : [];
}

/**
 * Get GPA interpretation/remarks
 * @param float $gpa The GPA value
 * @return array ['rating' => string, 'color' => string]
 */
function getGPAInterpretation($gpa) {
    if ($gpa == 0) {
        return ['rating' => 'N/A', 'color' => '#999'];
    } elseif ($gpa <= 1.25) {
        return ['rating' => 'Excellent', 'color' => '#28a745'];
    } elseif ($gpa <= 1.75) {
        return ['rating' => 'Very Good', 'color' => '#20c997'];
    } elseif ($gpa <= 2.25) {
        return ['rating' => 'Good', 'color' => '#17a2b8'];
    } elseif ($gpa <= 2.75) {
        return ['rating' => 'Satisfactory', 'color' => '#6c757d'];
    } elseif ($gpa <= 3.00) {
        return ['rating' => 'Passing', 'color' => '#ffc107'];
    } elseif ($gpa <= 4.00) {
        return ['rating' => 'Conditional', 'color' => '#fd7e14'];
    } else {
        return ['rating' => 'Failed', 'color' => '#dc3545'];
    }
}

/**
 * Calculate class statistics for grade distribution
 * @param mysqli $conn Database connection
 * @param int $curriculum_id Course curriculum ID
 * @param string $academic_year Academic year
 * @return array Grade distribution stats
 */
function getClassGradeDistribution($conn, $curriculum_id, $academic_year) {
    $sql = "SELECT 
                COUNT(*) as total_students,
                SUM(CASE WHEN final_grade <= 1.50 THEN 1 ELSE 0 END) as excellent,
                SUM(CASE WHEN final_grade > 1.50 AND final_grade <= 2.00 THEN 1 ELSE 0 END) as very_good,
                SUM(CASE WHEN final_grade > 2.00 AND final_grade <= 2.50 THEN 1 ELSE 0 END) as good,
                SUM(CASE WHEN final_grade > 2.50 AND final_grade <= 3.00 THEN 1 ELSE 0 END) as passing,
                SUM(CASE WHEN final_grade > 3.00 AND final_grade <= 4.00 THEN 1 ELSE 0 END) as conditional,
                SUM(CASE WHEN final_grade > 4.00 THEN 1 ELSE 0 END) as failed,
                AVG(final_grade) as class_average
            FROM enrollments
            WHERE curriculum_id = ? 
            AND academic_year = ?
            AND final_grade IS NOT NULL";
    
    $result = db_query($conn, $sql, 'is', [$curriculum_id, $academic_year]);
    return $result ? db_fetch_one($result) : [];
}

