<?php
/**
 * Courses Page
 * 
 * This page handles everything related to courses:
 * - Listing all courses
 * - Adding a new course
 * - Editing an existing course
 * - Deleting a course
 * 
 * Works the same way as the students page - check the action parameter!
 */

// Load our helper functions
require_once __DIR__ . '/../includes/functions.php';

// Set the page title and base path
$pageTitle = 'Courses';
$basePath = '../';

// Get the action from the URL
$action = $_GET['action'] ?? 'list';

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Adding a new course
    if ($action === 'add') {
        $result = addCourse($_POST);
        
        if ($result) {
            setFlashMessage('Course added successfully!', 'success');
        } else {
            setFlashMessage('Oops! Something went wrong. The course code might already exist.', 'error');
        }
        
        redirect('courses.php');
    }
    
    // Updating an existing course
    if ($action === 'edit' && isset($_GET['id'])) {
        $id = (int) $_GET['id'];
        $result = updateCourse($id, $_POST);
        
        if ($result) {
            setFlashMessage('Course updated successfully!', 'success');
        } else {
            setFlashMessage('Oops! Something went wrong. Please try again.', 'error');
        }
        
        redirect('courses.php');
    }
}

// Handle delete action
if ($action === 'delete' && isset($_GET['id'])) {
    $id = (int) $_GET['id'];
    $result = deleteCourse($id);
    
    if ($result) {
        setFlashMessage('Course deleted successfully.', 'success');
    } else {
        setFlashMessage('Could not delete the course.', 'error');
    }
    
    redirect('courses.php');
}

// Get data based on action
if ($action === 'edit' && isset($_GET['id'])) {
    $course = getCourseById((int) $_GET['id']);
    
    if (!$course) {
        setFlashMessage('Course not found.', 'error');
        redirect('courses.php');
    }
}

// Get all courses for the list view
$courses = getAllCourses();

// Include the header and navbar
include __DIR__ . '/../templates/header.php';
include __DIR__ . '/../templates/sidebar.php';
?>

<?php if ($action === 'list'): ?>
    <!-- ============================================
         COURSES LIST VIEW
         Shows all courses in a table
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-book-open"></i> Courses</h1>
            <p class="page-subtitle">Manage course catalog</p>
        </div>
        <div class="page-actions">
            <a href="courses.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> New Course</a>
        </div>
    </div>
    
    <div class="panel">
        <?php if (empty($courses)): ?>
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-book-open"></i></div>
                <h3>No courses yet</h3>
                <p>Get started by adding your first course.</p>
                <a href="courses.php?action=add" class="btn btn-primary mt-2"><i class="fas fa-plus"></i> Add Course</a>
            </div>
        <?php else: ?>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Credits</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($courses as $course): ?>
                            <tr>
                                <td><span class="course-code"><?php echo sanitize($course['course_code']); ?></span></td>
                                <td><?php echo sanitize($course['course_name']); ?></td>
                                <td>
                                    <?php 
                                    // Show a truncated description
                                    $desc = $course['description'] ?? 'No description';
                                    echo sanitize(strlen($desc) > 50 ? substr($desc, 0, 50) . '...' : $desc);
                                    ?>
                                </td>
                                <td><span class="badge badge-info"><?php echo $course['credits']; ?> Credits</span></td>
                                <td>
                                    <div class="table-actions">
                                        <a href="courses.php?action=edit&id=<?php echo $course['id']; ?>" 
                                           class="btn btn-secondary btn-sm"><i class="fas fa-edit"></i> Edit</a>
                                        <button onclick="confirmDelete('course', '<?php echo sanitize($course['course_name']); ?>', 'courses.php?action=delete&id=<?php echo $course['id']; ?>')"
                                                class="btn btn-danger btn-sm"><i class="fas fa-trash"></i> Delete</button>
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
         ADD COURSE FORM
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-plus"></i> Add New Course</h1>
            <p class="page-subtitle">Create a new course entry</p>
        </div>
        <div class="page-actions">
            <a href="courses.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <div class="panel">
        <div class="panel-body">
            <form method="POST" action="courses.php?action=add" data-validate="course">
                <div class="form-row">
                    <div class="form-group">
                        <label for="course_code">Course Code <span class="required">*</span></label>
                        <input type="text" id="course_code" name="course_code" class="form-control" 
                               placeholder="IT103" required>
                        <span class="form-hint">Unique identifier (e.g., IT103, CS201)</span>
                    </div>
                    
                    <div class="form-group">
                        <label for="credits">Credits</label>
                        <input type="number" id="credits" name="credits" class="form-control" 
                               value="3" min="1" max="10">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="course_name">Course Name <span class="required">*</span></label>
                    <input type="text" id="course_name" name="course_name" class="form-control" 
                           placeholder="Computer Programming 1" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" 
                              placeholder="Course description and learning objectives"
                              rows="4"></textarea>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Course</button>
                    <a href="courses.php" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

<?php elseif ($action === 'edit' && isset($course)): ?>
    <!-- ============================================
         EDIT COURSE FORM
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-edit"></i> Edit Course</h1>
            <p class="page-subtitle">Update course information</p>
        </div>
        <div class="page-actions">
            <a href="courses.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <div class="panel">
        <div class="panel-body">
            <form method="POST" action="courses.php?action=edit&id=<?php echo $course['id']; ?>" data-validate="course">
                <div class="form-row">
                    <div class="form-group">
                        <label for="course_code">Course Code <span class="required">*</span></label>
                        <input type="text" id="course_code" name="course_code" class="form-control" 
                               value="<?php echo sanitize($course['course_code']); ?>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="credits">Credits</label>
                        <input type="number" id="credits" name="credits" class="form-control" 
                               value="<?php echo $course['credits']; ?>" min="1" max="10">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="course_name">Course Name <span class="required">*</span></label>
                    <input type="text" id="course_name" name="course_name" class="form-control" 
                           value="<?php echo sanitize($course['course_name']); ?>" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" 
                              rows="4"><?php echo sanitize($course['description'] ?? ''); ?></textarea>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Course</button>
                    <a href="courses.php" class="btn btn-secondary">Cancel</a>
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
