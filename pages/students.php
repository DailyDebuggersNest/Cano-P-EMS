<?php
/**
 * Students Page
 * 
 * This page handles everything related to students:
 * - Listing all students
 * - Adding a new student
 * - Editing an existing student
 * - Deleting a student
 * 
 * We use the 'action' URL parameter to know what to do:
 * - ?action=add     -> Show the add form
 * - ?action=edit&id=1 -> Show the edit form for student #1
 * - ?action=delete&id=1 -> Delete student #1
 * - (no action)     -> Show the list of students
 */

// Load our helper functions
require_once __DIR__ . '/../includes/functions.php';

// Set the page title and base path (we're in a subfolder!)
$pageTitle = 'Students';
$basePath = '../';

// Get the action from the URL (defaults to 'list')
$action = $_GET['action'] ?? 'list';

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Adding a new student
    if ($action === 'add') {
        $result = addStudent($_POST);
        
        if ($result) {
            setFlashMessage('Student added successfully!', 'success');
        } else {
            setFlashMessage('Oops! Something went wrong. Please try again.', 'error');
        }
        
        redirect('students.php');
    }
    
    // Updating an existing student
    if ($action === 'edit' && isset($_GET['id'])) {
        $id = (int) $_GET['id'];
        $result = updateStudent($id, $_POST);
        
        if ($result) {
            setFlashMessage('Student updated successfully!', 'success');
        } else {
            setFlashMessage('Oops! Something went wrong. Please try again.', 'error');
        }
        
        redirect('students.php');
    }
}

// Handle delete action (via GET request for simplicity)
if ($action === 'delete' && isset($_GET['id'])) {
    $id = (int) $_GET['id'];
    $result = deleteStudent($id);
    
    if ($result) {
        setFlashMessage('Student deleted successfully.', 'success');
    } else {
        setFlashMessage('Could not delete the student.', 'error');
    }
    
    redirect('students.php');
}

// Get data based on action
if ($action === 'edit' && isset($_GET['id'])) {
    $student = getStudentById((int) $_GET['id']);
    
    // If student not found, redirect back
    if (!$student) {
        setFlashMessage('Student not found.', 'error');
        redirect('students.php');
    }
}

// Get all students for the list view
$students = getAllStudents();

// Include the header and navbar
include __DIR__ . '/../templates/header.php';
include __DIR__ . '/../templates/sidebar.php';
?>

<?php if ($action === 'list'): ?>
    <!-- ============================================
         STUDENTS LIST VIEW
         Shows all students in a nice table
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-users"></i> Students</h1>
            <p class="page-subtitle">Manage student records</p>
        </div>
        <div class="page-actions">
            <a href="students.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> New Student</a>
        </div>
    </div>
    
    <div class="panel">
        <?php if (empty($students)): ?>
            <!-- No students yet - show a friendly message -->
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-users"></i></div>
                <h3>No students yet</h3>
                <p>Get started by adding your first student record.</p>
                <a href="students.php?action=add" class="btn btn-primary mt-2"><i class="fas fa-plus"></i> Add Student</a>
            </div>
        <?php else: ?>
            <!-- Students table -->
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Date of Birth</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($students as $student): ?>
                            <tr>
                                <td><?php echo $student['id']; ?></td>
                                <td>
                                    <div class="user-info">
                                        <div class="user-avatar"><i class="fas fa-user"></i></div>
                                        <span><?php echo sanitize($student['first_name'] . ' ' . $student['last_name']); ?></span>
                                    </div>
                                </td>
                                <td><?php echo sanitize($student['email']); ?></td>
                                <td><?php echo sanitize($student['phone'] ?? 'N/A'); ?></td>
                                <td><?php echo $student['date_of_birth'] ? date('M d, Y', strtotime($student['date_of_birth'])) : 'N/A'; ?></td>
                                <td>
                                    <div class="table-actions">
                                        <a href="students.php?action=edit&id=<?php echo $student['id']; ?>" 
                                           class="btn btn-secondary btn-sm"><i class="fas fa-edit"></i> Edit</a>
                                        <button onclick="confirmDelete('student', '<?php echo sanitize($student['first_name'] . ' ' . $student['last_name']); ?>', 'students.php?action=delete&id=<?php echo $student['id']; ?>')"
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
         ADD STUDENT FORM
         A form to add a new student
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-user-plus"></i> Add New Student</h1>
            <p class="page-subtitle">Create a new student record</p>
        </div>
        <div class="page-actions">
            <a href="students.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <div class="panel">
        <div class="panel-body">
            <form method="POST" action="students.php?action=add" data-validate="student">
                <div class="form-row">
                    <div class="form-group">
                        <label for="first_name">First Name <span class="required">*</span></label>
                        <input type="text" id="first_name" name="first_name" class="form-control" 
                               placeholder="Enter first name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="last_name">Last Name <span class="required">*</span></label>
                        <input type="text" id="last_name" name="last_name" class="form-control" 
                               placeholder="Enter last name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address <span class="required">*</span></label>
                    <input type="email" id="email" name="email" class="form-control" 
                           placeholder="student@email.com" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               placeholder="+63 9171234567">
                    </div>
                    
                    <div class="form-group">
                        <label for="date_of_birth">Date of Birth</label>
                        <input type="date" id="date_of_birth" name="date_of_birth" class="form-control">
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Student</button>
                    <a href="students.php" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

<?php elseif ($action === 'edit' && isset($student)): ?>
    <!-- ============================================
         EDIT STUDENT FORM
         A form to update an existing student
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-user-edit"></i> Edit Student</h1>
            <p class="page-subtitle">Update student information</p>
        </div>
        <div class="page-actions">
            <a href="students.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <div class="panel">
        <div class="panel-body">
            <form method="POST" action="students.php?action=edit&id=<?php echo $student['id']; ?>" data-validate="student">
                <div class="form-row">
                    <div class="form-group">
                        <label for="first_name">First Name <span class="required">*</span></label>
                        <input type="text" id="first_name" name="first_name" class="form-control" 
                               value="<?php echo sanitize($student['first_name']); ?>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="last_name">Last Name <span class="required">*</span></label>
                        <input type="text" id="last_name" name="last_name" class="form-control" 
                               value="<?php echo sanitize($student['last_name']); ?>" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address <span class="required">*</span></label>
                    <input type="email" id="email" name="email" class="form-control" 
                           value="<?php echo sanitize($student['email']); ?>" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               value="<?php echo sanitize($student['phone'] ?? ''); ?>">
                    </div>
                    
                    <div class="form-group">
                        <label for="date_of_birth">Date of Birth</label>
                        <input type="date" id="date_of_birth" name="date_of_birth" class="form-control"
                               value="<?php echo $student['date_of_birth'] ?? ''; ?>">
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Student</button>
                    <a href="students.php" class="btn btn-secondary">Cancel</a>
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
