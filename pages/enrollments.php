<?php
/**
 * Enrollments Page
 * 
 * This is where the magic happens! Students meet courses.
 * Here we can:
 * - View all enrollments
 * - Enroll a student in a course
 * - Update enrollment status/grade
 * - Remove an enrollment
 */

// Load our helper functions
require_once __DIR__ . '/../includes/functions.php';

// Set the page title and base path
$pageTitle = 'Enrollments';
$basePath = '../';

// Get the action from the URL
$action = $_GET['action'] ?? 'list';

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Creating a new enrollment
    if ($action === 'add') {
        $studentId = (int) $_POST['student_id'];
        $courseId = (int) $_POST['course_id'];
        
        $result = enrollStudent($studentId, $courseId);
        
        if ($result) {
            setFlashMessage('Student enrolled successfully!', 'success');
        } else {
            setFlashMessage('Could not enroll student. They might already be enrolled in this course.', 'error');
        }
        
        redirect('enrollments.php');
    }
    
    // Updating an enrollment
    if ($action === 'edit' && isset($_GET['id'])) {
        $id = (int) $_GET['id'];
        $result = updateEnrollment($id, $_POST);
        
        if ($result) {
            setFlashMessage('Enrollment updated successfully!', 'success');
        } else {
            setFlashMessage('Oops! Something went wrong. Please try again.', 'error');
        }
        
        redirect('enrollments.php');
    }
}

// Handle delete action
if ($action === 'delete' && isset($_GET['id'])) {
    $id = (int) $_GET['id'];
    $result = deleteEnrollment($id);
    
    if ($result) {
        setFlashMessage('Enrollment removed successfully.', 'success');
    } else {
        setFlashMessage('Could not remove the enrollment.', 'error');
    }
    
    redirect('enrollments.php');
}

// Get data based on action
if ($action === 'edit' && isset($_GET['id'])) {
    $enrollment = getEnrollmentById((int) $_GET['id']);
    
    if (!$enrollment) {
        setFlashMessage('Enrollment not found.', 'error');
        redirect('enrollments.php');
    }
}

// Get all enrollments for the list view
$enrollments = getAllEnrollments();

// For the add form, we need students and courses
$students = getAllStudents();
$courses = getAllCourses();

// Include the header and navbar
include __DIR__ . '/../templates/header.php';
include __DIR__ . '/../templates/sidebar.php';
?>

<?php if ($action === 'list'): ?>
    <!-- ============================================
         ENROLLMENTS LIST VIEW
         Shows all enrollments in a table
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-clipboard-list"></i> Enrollments</h1>
            <p class="page-subtitle">Manage student course enrollments</p>
        </div>
        <div class="page-actions">
            <a href="enrollments.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> New Enrollment</a>
        </div>
    </div>
    
    <div class="panel">
        <?php if (empty($enrollments)): ?>
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-clipboard-list"></i></div>
                <h3>No enrollments yet</h3>
                <p>Start by enrolling a student in a course.</p>
                <a href="enrollments.php?action=add" class="btn btn-primary mt-2"><i class="fas fa-plus"></i> Create Enrollment</a>
            </div>
        <?php else: ?>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Course</th>
                            <th>Enrolled On</th>
                            <th>Status</th>
                            <th>Grade</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($enrollments as $enrollment): ?>
                            <tr>
                                <td>
                                    <div class="user-info">
                                        <div class="user-avatar"><i class="fas fa-user"></i></div>
                                        <div>
                                            <strong><?php echo sanitize($enrollment['first_name'] . ' ' . $enrollment['last_name']); ?></strong>
                                            <br>
                                            <small class="text-muted"><?php echo sanitize($enrollment['email']); ?></small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="course-code"><?php echo sanitize($enrollment['course_code']); ?></span>
                                    <br>
                                    <small class="text-muted"><?php echo sanitize($enrollment['course_name']); ?></small>
                                </td>
                                <td><?php echo date('M d, Y', strtotime($enrollment['enrollment_date'])); ?></td>
                                <td>
                                    <span class="badge badge-<?php echo $enrollment['status']; ?>">
                                        <?php echo ucfirst($enrollment['status']); ?>
                                    </span>
                                </td>
                                <td><?php echo sanitize($enrollment['grade'] ?? 'N/A'); ?></td>
                                <td>
                                    <div class="table-actions">
                                        <a href="enrollments.php?action=edit&id=<?php echo $enrollment['id']; ?>" 
                                           class="btn btn-secondary btn-sm"><i class="fas fa-edit"></i> Edit</a>
                                        <button onclick="confirmDelete('enrollment', '<?php echo sanitize($enrollment['first_name'] . ' from ' . $enrollment['course_code']); ?>', 'enrollments.php?action=delete&id=<?php echo $enrollment['id']; ?>')"
                                                class="btn btn-danger btn-sm"><i class="fas fa-trash"></i> Remove</button>
                                    </div>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>
    </div>

<?php elseif ($action === 'add'): ?>
    <!-- ============================================
         ADD ENROLLMENT FORM
         Enroll a student in a course
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-user-graduate"></i> New Enrollment</h1>
            <p class="page-subtitle">Enroll a student in a course</p>
        </div>
        <div class="page-actions">
            <a href="enrollments.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <?php if (empty($students) || empty($courses)): ?>
        <div class="panel">
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-exclamation-triangle"></i></div>
                <h3>Cannot create enrollment</h3>
                <p>You need at least one student and one course first.</p>
                <div class="quick-actions" style="justify-content: center; margin-top: 1rem;">
                    <?php if (empty($students)): ?>
                        <a href="students.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Add Student</a>
                    <?php endif; ?>
                    <?php if (empty($courses)): ?>
                        <a href="courses.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Add Course</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    <?php else: ?>
        <div class="panel">
            <div class="panel-body">
                <form method="POST" action="enrollments.php?action=add">
                    <div class="form-group">
                        <label for="student_id">Select Student <span class="required">*</span></label>
                        <select id="student_id" name="student_id" class="form-control" required>
                            <option value="">-- Choose a student --</option>
                            <?php foreach ($students as $student): ?>
                                <option value="<?php echo $student['id']; ?>">
                                    <?php echo sanitize($student['first_name'] . ' ' . $student['last_name']); ?> 
                                    (<?php echo sanitize($student['email']); ?>)
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="course_id">Select Course <span class="required">*</span></label>
                        <select id="course_id" name="course_id" class="form-control" required>
                            <option value="">-- Choose a course --</option>
                            <?php foreach ($courses as $course): ?>
                                <option value="<?php echo $course['id']; ?>">
                                    <?php echo sanitize($course['course_code'] . ' - ' . $course['course_name']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Enroll Student</button>
                        <a href="enrollments.php" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    <?php endif; ?>

<?php elseif ($action === 'edit' && isset($enrollment)): ?>
    <!-- ============================================
         EDIT ENROLLMENT FORM
         Update status or grade
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-edit"></i> Edit Enrollment</h1>
            <p class="page-subtitle">Update enrollment details</p>
        </div>
        <div class="page-actions">
            <a href="enrollments.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <div class="panel">
        <div class="panel-body">
            <!-- Show who this enrollment is for -->
            <div class="info-box">
                <p><i class="fas fa-user"></i> <strong>Student:</strong> <?php echo sanitize($enrollment['first_name'] . ' ' . $enrollment['last_name']); ?></p>
                <p><i class="fas fa-book-open"></i> <strong>Course:</strong> <?php echo sanitize($enrollment['course_code'] . ' - ' . $enrollment['course_name']); ?></p>
            </div>
            
            <form method="POST" action="enrollments.php?action=edit&id=<?php echo $enrollment['id']; ?>">
                <div class="form-row">
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" class="form-control">
                            <option value="active" <?php echo $enrollment['status'] === 'active' ? 'selected' : ''; ?>>
                                Active
                            </option>
                            <option value="completed" <?php echo $enrollment['status'] === 'completed' ? 'selected' : ''; ?>>
                                Completed
                            </option>
                            <option value="dropped" <?php echo $enrollment['status'] === 'dropped' ? 'selected' : ''; ?>>
                                Dropped
                            </option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="grade">Grade</label>
                        <input type="text" id="grade" name="grade" class="form-control" 
                               value="<?php echo sanitize($enrollment['grade'] ?? ''); ?>"
                               placeholder="A, B+, 85%">
                        <span class="form-hint">Leave blank if not yet graded</span>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Enrollment</button>
                    <a href="enrollments.php" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

<?php endif; ?>

    </div>
</main>
</div>
<script src="../assets/js/script.js"></script>
</body>
</html>
