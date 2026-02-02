<?php
require_once '../config/db_helpers.php';
require_once '../config/academic_helpers.php';

$conn = getDBConnection();
$message = '';
$message_type = '';

$student_id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($student_id <= 0) {
    header('Location: ../index.php');
    exit;
}

// Fetch System Settings
$settings = [];
$set_res = db_query($conn, "SELECT setting_key, setting_value FROM system_settings");
while ($row = $set_res->fetch_assoc()) {
    $settings[$row['setting_key']] = $row['setting_value'];
}

// 2. Resolve default academic year using student context
$student_info = db_fetch_one(db_query($conn, "SELECT year_level, current_semester FROM students WHERE student_id = ?", 'i', [$student_id]));
$current_year_val = $settings['current_academic_year'] ?? (date('Y') . '-' . (date('Y') + 1));

// Check if student is "ahead" of system AY (e.g. just promoted)
// We use a simplified version of the logic in get_student_term_options
$hist_sql = "SELECT e.academic_year, c.year_level 
            FROM enrollments e 
            JOIN curriculum c ON e.curriculum_id = c.curriculum_id 
            WHERE e.student_id = ? 
            ORDER BY e.academic_year DESC, c.year_level DESC LIMIT 1";
$latest = db_fetch_one(db_query($conn, $hist_sql, 'i', [$student_id]));

if ($latest && $student_info['year_level'] > $latest['year_level']) {
    $diff = $student_info['year_level'] - $latest['year_level'];
    for ($i = 0; $i < $diff; $i++) {
        $current_year_val = getNextAcademicYear($current_year_val);
    }
}

$academic_year = $current_year_val;

// Fetch student details
$student_sql = "SELECT s.*, p.program_code, p.program_name 
                FROM students s 
                LEFT JOIN programs p ON s.program_id = p.program_id 
                WHERE s.student_id = ?";
$student = db_fetch_one(db_query($conn, $student_sql, 'i', [$student_id]));

if (!$student) {
    die("Student not found.");
}

// Handle Enrollment
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['confirm_enroll'])) {
    $ay = $_POST['academic_year'];
    
    // Validate inputs
    if (!isset($_POST['courses']) || !is_array($_POST['courses'])) {
         $message = "No courses selected.";
         $message_type = "error";
    } else {
        $conn->begin_transaction();
        try {
            // 1. Check Capacity Again (Race Condition Check)
            foreach ($_POST['courses'] as $curr_id) {
                // Check if any schedule for this course is full
                $cap_check_sql = "SELECT count(*) as full_scheds 
                                  FROM schedules 
                                  WHERE curriculum_id = ? AND enrolled_count >= capacity";
                $full = db_fetch_one(db_query($conn, $cap_check_sql, 'i', [$curr_id]))['full_scheds'];
                
                if ($full > 0) {
                    throw new Exception("One of the selected courses is full.");
                }
            }

            // 2. Clear existing enrollment for this AY?
            // Conservative approach: Only delete if replacing. 
            // For now, assuming fresh enrollment or re-enrollment for the term.
            // We need to decrement counts if we delete old enrollments, but logic is complex.
            // Simplified: DELETE existing enrollments for this Student+AY AND decrement their counts in schedules.
            
            // Get existing enrolled courses to decrement
            $exist_sql = "SELECT curriculum_id FROM enrollments WHERE student_id = ? AND academic_year = ?";
            $exist_res = db_query($conn, $exist_sql, 'is', [$student_id, $ay]);
            $existing_ids = [];
            while($row = $exist_res->fetch_assoc()) {
                $existing_ids[] = $row['curriculum_id'];
            }
            
            if (!empty($existing_ids)) {
                // Use prepared statement for decrement
                $placeholders = implode(',', array_fill(0, count($existing_ids), '?'));
                $types = str_repeat('i', count($existing_ids));
                db_query($conn, "UPDATE schedules SET enrolled_count = GREATEST(0, enrolled_count - 1) WHERE curriculum_id IN ($placeholders)", $types, $existing_ids);
                
                // Use prepared statement for delete
                db_query($conn, "DELETE FROM enrollments WHERE student_id = ? AND academic_year = ?", 'is', [$student_id, $ay]);
            }
            
            // 3. Insert Enrollments & Increment Counts
            $enroll_sql = "INSERT INTO enrollments (student_id, curriculum_id, academic_year, status) VALUES (?, ?, ?, 'Enrolled')";
            $stmt = $conn->prepare($enroll_sql);
            
            $update_sched_sql = "UPDATE schedules SET enrolled_count = enrolled_count + 1 WHERE curriculum_id = ?";
            $sched_stmt = $conn->prepare($update_sched_sql);
            
            foreach ($_POST['courses'] as $curr_id) {
                // Insert Enrollment
                $stmt->bind_param('iis', $student_id, $curr_id, $ay);
                $stmt->execute();
                
                // Update Schedule Count
                $sched_stmt->bind_param('i', $curr_id);
                $sched_stmt->execute();
            }
            $stmt->close();
            $sched_stmt->close();
            
            // 4. Update/Insert Semester Status
            // Check if exists
            $current_sem = intval($student['current_semester']);
            $chk_status = db_query($conn, "SELECT status_id FROM semester_status WHERE student_id = ? AND academic_year = ? AND semester = ?", 'isi', [$student_id, $ay, $current_sem]);
            if ($chk_status && $chk_status->num_rows > 0) {
                // Update using prepared statement
                db_query($conn, "UPDATE semester_status SET status = 'In Progress', updated_at = NOW() WHERE student_id = ? AND academic_year = ? AND semester = ? AND status != 'In Progress'", 'isi', [$student_id, $ay, $current_sem]);
            } else {
                // Insert
                $ins_status = "INSERT INTO semester_status (student_id, year_level, semester, academic_year, status, total_units) VALUES (?, ?, ?, ?, 'In Progress', ?)";
                $units = isset($_POST['total_units']) ? intval($_POST['total_units']) : 0;
                $status_stmt = $conn->prepare($ins_status);
                $status_stmt->bind_param('iiisi', $student_id, $student['year_level'], $student['current_semester'], $ay, $units);
                $status_stmt->execute();
                $status_stmt->close();
            }

            $conn->commit();
            $message = "Enrollment successful!";
            $message_type = "success";
            // Redirect after success
            header("Location: ../index.php?msg=enrolled&name=" . urlencode($student['last_name']));
            exit;

        } catch (Exception $e) {
            $conn->rollback();
            $message = "Error enrolling: " . $e->getMessage();
            $message_type = "error";
        }
    }
}

// Fetch Curriculum Courses matching Year and Semester
$courses = [];
$schedules = [];
$conflicts = [];
$prerequisite_issues = [];
$has_conflicts = false;

if ($student) {
    // Note: We only show courses for the student's current year/semester context
    $curr_sql = "SELECT c.* 
                 FROM curriculum c 
                 WHERE c.program_id = ? AND c.year_level = ? AND c.semester = ?";
    $courses_result = db_query($conn, $curr_sql, 'iii', [$student['program_id'], $student['year_level'], $student['current_semester']]);
    $courses = $courses_result ? db_fetch_all($courses_result) : [];
    
    // Check prerequisites for each course
    foreach ($courses as &$course) {
        $prereq_check = checkPrerequisites($conn, $student_id, $course['curriculum_id']);
        $course['prereq_met'] = $prereq_check['can_enroll'];
        $course['prereq_missing'] = $prereq_check['missing'];
        $course['prereq_message'] = $prereq_check['message'];
        $course['prerequisites'] = getCoursePrerequisites($conn, $course['curriculum_id']);
        
        if (!$prereq_check['can_enroll']) {
            $prerequisite_issues[] = $course['course_code'] . ': ' . $prereq_check['message'];
            $has_conflicts = true;
        }
    }
    unset($course); // Break reference
    
    // Fetch Schedules for these courses
    if (!empty($courses)) {
        $course_ids = array_column($courses, 'curriculum_id');
        if (!empty($course_ids)) {
            $sched_sql = "SELECT s.*, t.last_name as teacher_name 
                          FROM schedules s 
                          LEFT JOIN teachers t ON s.teacher_id = t.teacher_id
                          WHERE s.curriculum_id IN (" . implode(',', $course_ids) . ")";
            $sched_result = db_query($conn, $sched_sql);
            $all_schedules = $sched_result ? db_fetch_all($sched_result) : [];
            
            // Map schedules to courses
            foreach ($all_schedules as $sched) {
                $schedules[$sched['curriculum_id']][] = $sched;
            }
            
            // CONFLICT & CAPACITY CHECKING
            // Flatten to list of time blocks
            $blocks = [];
            foreach ($courses as $c) {
                if (isset($schedules[$c['curriculum_id']])) {
                    foreach ($schedules[$c['curriculum_id']] as $s) {
                        // Check Capacity
                        if ($s['enrolled_count'] >= $s['capacity']) {
                            $conflicts[] = "Full: {$c['course_code']} (Schedule ID: {$s['schedule_id']}) is full ({$s['enrolled_count']}/{$s['capacity']}).";
                            $has_conflicts = true;
                        }
                        
                        $blocks[] = [
                            'course_code' => $c['course_code'],
                            'day' => $s['day_of_week'],
                            'start' => $s['start_time'],
                            'end' => $s['end_time']
                        ];
                    }
                } else {
                    // No schedule found? potentially strictly warn, but maybe it's TBA
                }
            }
            
            // Check overlaps
            $count = count($blocks);
            for ($i = 0; $i < $count; $i++) {
                for ($j = $i + 1; $j < $count; $j++) {
                    $b1 = $blocks[$i];
                    $b2 = $blocks[$j];
                    
                    // Only check conflict if different courses
                    if ($b1['course_code'] !== $b2['course_code']) {
                        if ($b1['day'] === $b2['day']) {
                            if ($b1['start'] < $b2['end'] && $b2['start'] < $b1['end']) {
                                $conflicts[] = "Conflict: {$b1['course_code']} vs {$b2['course_code']} on {$b1['day']} ({$b1['start']}-{$b1['end']} / {$b2['start']}-{$b2['end']})";
                                $has_conflicts = true;
                            }
                        }
                    }
                }
            }
            
            // Deduplicate conflicts
            $conflicts = array_unique($conflicts);
        }
    }
}

$conn->close();

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enroll Student</title>
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/details.css">
    <style>
        .conflict-box {
            background: #ffe6e6;
            border: 1px solid #ffcccc;
            color: #cc0000;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
        }
        .prereq-warning {
            background: #fff3cd;
            border: 1px solid #ffc107;
            color: #856404;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
        }
        .schedule-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 14px;
        }
        .schedule-table th, .schedule-table td {
            border: 1px solid #eee;
            padding: 8px;
            text-align: left;
        }
        .schedule-table th {
            background: #f8f9fa;
        }
        .prereq-badge {
            display: inline-block;
            font-size: 0.75em;
            padding: 2px 6px;
            border-radius: 4px;
            margin-left: 5px;
        }
        .prereq-met { background: #d4edda; color: #155724; }
        .prereq-missing { background: #f8d7da; color: #721c24; }
        .prereq-list {
            font-size: 0.85em;
            color: #666;
            margin-top: 3px;
        }
        .course-disabled {
            background: #f8f9fa;
            opacity: 0.7;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Enroll Student</h1>
            <a href="../index.php" class="btn btn-back">Back</a>
        </header>

        <?php if ($message): ?>
            <div class="message <?php echo $message_type; ?>"><?php echo $message; ?></div>
        <?php endif; ?>

        <div class="card">
            <h2><?php echo htmlspecialchars($student['last_name'] . ', ' . $student['first_name']); ?></h2>
            <p><strong>Program:</strong> <?php echo htmlspecialchars($student['program_code']); ?></p>
            <p><strong>Year Level:</strong> <?php echo $student['year_level']; ?> | <strong>Semester:</strong> <?php echo $student['current_semester']; ?></p>
            <p><strong>Academic Year:</strong> <?php echo $academic_year; ?></p>
        </div>

        <?php if (!empty($prerequisite_issues)): ?>
            <div class="prereq-warning">
                <h3>Prerequisite Requirements Not Met</h3>
                <p>The following courses have unmet prerequisites. You may still enroll with advisor approval.</p>
                <ul>
                    <?php foreach ($prerequisite_issues as $issue): ?>
                        <li><?php echo htmlspecialchars($issue); ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <?php if (!empty($conflicts)): ?>
            <div class="conflict-box">
                <h3>Schedule Conflicts Detected!</h3>
                <p>Cannot proceed with enrollment until conflicts are resolved in the curriculum/schedule.</p>
                <ul>
                    <?php foreach ($conflicts as $c): ?>
                        <li><?php echo htmlspecialchars($c); ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <form method="post">
            <input type="hidden" name="academic_year" value="<?php echo $academic_year; ?>">
            <input type="hidden" name="total_units" value="<?php echo array_sum(array_column($courses, 'units')); ?>">
            
            <div class="card">
                <h3>Available Courses</h3>
                <table class="schedule-table">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Name</th>
                            <th>Units</th>
                            <th>Prerequisites</th>
                            <th>Schedule</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($courses as $c): ?>
                            <tr class="<?php echo !$c['prereq_met'] ? 'course-disabled' : ''; ?>">
                                <td>
                                    <?php echo htmlspecialchars($c['course_code']); ?>
                                    <?php if ($c['prereq_met']): ?>
                                        <input type="hidden" name="courses[]" value="<?php echo $c['curriculum_id']; ?>">
                                    <?php endif; ?>
                                </td>
                                <td><?php echo htmlspecialchars($c['course_name']); ?></td>
                                <td><?php echo $c['units']; ?></td>
                                <td>
                                    <?php if (empty($c['prerequisites'])): ?>
                                        <span style="color:#28a745;">None</span>
                                    <?php else: ?>
                                        <span class="prereq-badge <?php echo $c['prereq_met'] ? 'prereq-met' : 'prereq-missing'; ?>">
                                            <?php echo $c['prereq_met'] ? 'Met' : 'Missing'; ?>
                                        </span>
                                        <div class="prereq-list">
                                            <?php foreach ($c['prerequisites'] as $p): ?>
                                                <div><?php echo htmlspecialchars($p['course_code']); ?> (min: <?php echo $p['min_grade']; ?>)</div>
                                            <?php endforeach; ?>
                                        </div>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <?php 
                                    if (isset($schedules[$c['curriculum_id']])) {
                                        foreach ($schedules[$c['curriculum_id']] as $s) {
                                            echo "<div>" . $s['day_of_week'] . " " . date('H:i', strtotime($s['start_time'])) . "-" . date('H:i', strtotime($s['end_time'])) . " (" . ($s['room'] ?? 'TBA') . ")</div>";
                                        }
                                    } else {
                                        echo "<span style='color:orange'>TBA</span>";
                                    }
                                    ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>

            <div class="form-actions" style="margin-top:20px;">
                <?php 
                // Check if there are any enrollable courses (prereqs met and no schedule conflicts)
                $enrollable_courses = array_filter($courses, function($c) { return $c['prereq_met']; });
                $schedule_conflicts_only = !empty($conflicts);
                ?>
                <?php if (!$schedule_conflicts_only && !empty($enrollable_courses)): ?>
                    <button type="submit" name="confirm_enroll" class="btn btn-primary" style="background:green;">
                        Confirm Enrollment (<?php echo count($enrollable_courses); ?> courses)
                    </button>
                    <?php if (count($enrollable_courses) < count($courses)): ?>
                        <p style="margin-top:10px; color:#856404;">
                            <em>Note: <?php echo count($courses) - count($enrollable_courses); ?> course(s) excluded due to missing prerequisites.</em>
                        </p>
                    <?php endif; ?>
                <?php else: ?>
                    <button type="button" class="btn" disabled style="background:#ccc; cursor:not-allowed;">
                        <?php 
                        if (empty($courses)) {
                            echo 'No courses available';
                        } elseif ($schedule_conflicts_only) {
                            echo 'Fix Schedule Conflicts to Enroll';
                        } else {
                            echo 'No courses meet prerequisites';
                        }
                        ?>
                    </button>
                <?php endif; ?>
            </div>
        </form>
    </div>
</body>
</html>
