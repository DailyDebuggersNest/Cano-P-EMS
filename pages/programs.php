<?php
/**
 * Program Management Page
 * 
 * Manage academic programs (BSIT, BSCS, BSA, etc.)
 * - View all programs with enrolled student counts
 * - Add/Edit/Delete programs
 * - Assign students to programs
 * - Track year level distribution
 */

require_once __DIR__ . '/../includes/functions.php';

$pageTitle = 'Program Management';
$basePath = '../';

$action = $_GET['action'] ?? 'list';

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    if ($action === 'add') {
        $result = addProgram($_POST);
        if ($result) {
            setFlashMessage('Program added successfully!', 'success');
        } else {
            setFlashMessage('Failed to add program. Code may already exist.', 'error');
        }
        redirect('programs.php');
    }
    
    if ($action === 'edit' && isset($_GET['id'])) {
        $id = (int) $_GET['id'];
        $result = updateProgram($id, $_POST);
        if ($result) {
            setFlashMessage('Program updated successfully!', 'success');
        } else {
            setFlashMessage('Failed to update program.', 'error');
        }
        redirect('programs.php');
    }
    
    // Assign student to program
    if ($action === 'assign') {
        $studentId = (int) $_POST['student_id'];
        $programName = $_POST['program'];
        $yearLevel = $_POST['year_level'];
        $semester = $_POST['semester'];
        
        $result = assignStudentToProgram($studentId, $programName, $yearLevel, $semester);
        if ($result) {
            setFlashMessage('Student assigned to program successfully!', 'success');
        } else {
            setFlashMessage('Failed to assign student.', 'error');
        }
        redirect('programs.php?action=view&id=' . $_GET['id']);
    }
    
    // Bulk update year levels
    if ($action === 'bulk_update') {
        $updates = $_POST['students'] ?? [];
        $successCount = 0;
        foreach ($updates as $studentId => $data) {
            if (updateStudentAcademicInfo($studentId, $data)) {
                $successCount++;
            }
        }
        setFlashMessage("Updated $successCount student(s) successfully!", 'success');
        redirect('programs.php?action=view&id=' . $_GET['id']);
    }
}

// Handle delete action
if ($action === 'delete' && isset($_GET['id'])) {
    $id = (int) $_GET['id'];
    $result = deleteProgram($id);
    if ($result) {
        setFlashMessage('Program deleted successfully.', 'success');
    } else {
        setFlashMessage('Cannot delete program with enrolled students.', 'error');
    }
    redirect('programs.php');
}

// Get program for edit/view
if (($action === 'edit' || $action === 'view') && isset($_GET['id'])) {
    $program = getProgramById((int) $_GET['id']);
    if (!$program) {
        setFlashMessage('Program not found.', 'error');
        redirect('programs.php');
    }
    
    if ($action === 'view') {
        $enrolledStudents = getStudentsByProgram($program['program_name']);
        $yearLevelStats = getYearLevelStatsByProgram($program['program_name']);
    }
}

// Get all programs for list
$programs = getAllProgramsWithStats();

// Get unassigned students for assignment
$unassignedStudents = getStudentsWithoutProgram();

include __DIR__ . '/../templates/header.php';
include __DIR__ . '/../templates/sidebar.php';
?>

<?php if ($action === 'list'): ?>
    <!-- ============================================
         PROGRAMS LIST VIEW
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-graduation-cap"></i> Program Management</h1>
            <p class="page-subtitle">Manage academic programs and student assignments</p>
        </div>
        <div class="page-actions">
            <a href="programs.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> New Program</a>
        </div>
    </div>
    
    <!-- Program Statistics Cards -->
    <div class="stats-grid">
        <?php 
        $totalPrograms = count($programs);
        $totalEnrolled = array_sum(array_column($programs, 'student_count'));
        ?>
        <div class="stat-card">
            <div class="stat-icon" style="background: var(--primary-light); color: var(--primary-color);">
                <i class="fas fa-graduation-cap"></i>
            </div>
            <div class="stat-info">
                <span class="stat-value"><?php echo $totalPrograms; ?></span>
                <span class="stat-label">Total Programs</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: #dcfce7; color: #16a34a;">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-info">
                <span class="stat-value"><?php echo $totalEnrolled; ?></span>
                <span class="stat-label">Total Enrolled</span>
            </div>
        </div>
    </div>
    
    <div class="panel">
        <?php if (empty($programs)): ?>
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-graduation-cap"></i></div>
                <h3>No programs yet</h3>
                <p>Get started by adding your first academic program.</p>
                <a href="programs.php?action=add" class="btn btn-primary mt-2"><i class="fas fa-plus"></i> Add Program</a>
            </div>
        <?php else: ?>
            <div class="programs-grid">
                <?php foreach ($programs as $prog): ?>
                    <div class="program-card">
                        <div class="program-card-header">
                            <div class="program-code-badge"><?php echo sanitize($prog['program_code']); ?></div>
                            <div class="program-actions-mini">
                                <a href="programs.php?action=edit&id=<?php echo $prog['id']; ?>" class="btn-icon" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                            </div>
                        </div>
                        <h3 class="program-name"><?php echo sanitize($prog['program_name']); ?></h3>
                        <p class="program-department"><?php echo sanitize($prog['department'] ?? 'No Department'); ?></p>
                        
                        <div class="program-stats">
                            <div class="program-stat">
                                <span class="stat-number"><?php echo $prog['student_count'] ?? 0; ?></span>
                                <span class="stat-text">Students</span>
                            </div>
                            <div class="program-stat">
                                <span class="stat-number"><?php echo $prog['years_duration'] ?? 4; ?></span>
                                <span class="stat-text">Years</span>
                            </div>
                        </div>
                        
                        <!-- Year Level Breakdown - Always visible -->
                        <div class="year-level-bars">
                            <?php 
                            $yearStats = getYearLevelStatsByProgram($prog['program_name']);
                            $studentCount = $prog['student_count'] ?? 0;
                            foreach (['1st Year', '2nd Year', '3rd Year', '4th Year'] as $year):
                                $count = $yearStats[$year] ?? 0;
                                $percentage = $studentCount > 0 ? ($count / $studentCount) * 100 : 0;
                            ?>
                                <div class="year-bar-item">
                                    <span class="year-label"><?php echo substr($year, 0, 3); ?></span>
                                    <div class="year-bar">
                                        <div class="year-bar-fill" style="width: <?php echo $percentage; ?>%"></div>
                                    </div>
                                    <span class="year-count"><?php echo $count; ?></span>
                                </div>
                            <?php endforeach; ?>
                        </div>
                        
                        <div class="program-card-footer">
                            <a href="programs.php?action=view&id=<?php echo $prog['id']; ?>" class="btn btn-outline btn-sm btn-block">
                                <i class="fas fa-eye"></i> View Students
                            </a>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>

<?php elseif ($action === 'view' && isset($program)): ?>
    <!-- ============================================
         VIEW PROGRAM - Student List & Management
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-graduation-cap"></i> <?php echo sanitize($program['program_code']); ?></h1>
            <p class="page-subtitle"><?php echo sanitize($program['program_name']); ?></p>
        </div>
        <div class="page-actions">
            <button class="btn btn-primary" onclick="openAssignModal()"><i class="fas fa-user-plus"></i> Assign Student</button>
            <a href="programs.php?action=edit&id=<?php echo $program['id']; ?>" class="btn btn-secondary"><i class="fas fa-edit"></i> Edit Program</a>
            <a href="programs.php" class="btn btn-outline"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <!-- Year Level Statistics -->
    <div class="stats-grid stats-grid-4">
        <?php 
        $yearColors = [
            '1st Year' => ['bg' => '#dbeafe', 'color' => '#2563eb'],
            '2nd Year' => ['bg' => '#dcfce7', 'color' => '#16a34a'],
            '3rd Year' => ['bg' => '#fef3c7', 'color' => '#d97706'],
            '4th Year' => ['bg' => '#fce7f3', 'color' => '#db2777'],
        ];
        foreach ($yearColors as $year => $colors):
            $count = $yearLevelStats[$year] ?? 0;
        ?>
            <div class="stat-card">
                <div class="stat-icon" style="background: <?php echo $colors['bg']; ?>; color: <?php echo $colors['color']; ?>;">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="stat-info">
                    <span class="stat-value"><?php echo $count; ?></span>
                    <span class="stat-label"><?php echo $year; ?></span>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
    
    <div class="panel">
        <div class="panel-header">
            <h3><i class="fas fa-users"></i> Enrolled Students (<?php echo count($enrolledStudents); ?>)</h3>
            <?php if (!empty($enrolledStudents)): ?>
                <button class="btn btn-secondary btn-sm" onclick="toggleBulkEdit()">
                    <i class="fas fa-edit"></i> Bulk Edit
                </button>
            <?php endif; ?>
        </div>
        
        <?php if (empty($enrolledStudents)): ?>
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-users"></i></div>
                <h3>No students enrolled</h3>
                <p>Assign students to this program to get started.</p>
                <button class="btn btn-primary mt-2" onclick="openAssignModal()"><i class="fas fa-user-plus"></i> Assign Student</button>
            </div>
        <?php else: ?>
            <form method="POST" action="programs.php?action=bulk_update&id=<?php echo $program['id']; ?>" id="bulkEditForm">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Year Level</th>
                                <th>Semester</th>
                                <th>Section</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($enrolledStudents as $student): ?>
                                <tr>
                                    <td><span class="student-id"><?php echo sanitize($student['student_id']); ?></span></td>
                                    <td>
                                        <div class="user-info">
                                            <div class="user-avatar"><i class="fas fa-user"></i></div>
                                            <div>
                                                <strong><?php echo sanitize(getStudentFullName($student, 'formal')); ?></strong>
                                                <br><small class="text-muted"><?php echo sanitize($student['email']); ?></small>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="editable-cell">
                                        <span class="display-value"><?php echo sanitize($student['year_level'] ?? '—'); ?></span>
                                        <select name="students[<?php echo $student['id']; ?>][year_level]" class="edit-input form-control" style="display:none;">
                                            <?php foreach (['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year'] as $yr): ?>
                                                <option value="<?php echo $yr; ?>" <?php echo ($student['year_level'] ?? '') === $yr ? 'selected' : ''; ?>><?php echo $yr; ?></option>
                                            <?php endforeach; ?>
                                        </select>
                                    </td>
                                    <td class="editable-cell">
                                        <span class="display-value"><?php echo sanitize($student['semester'] ?? '—'); ?></span>
                                        <select name="students[<?php echo $student['id']; ?>][semester]" class="edit-input form-control" style="display:none;">
                                            <option value="1st Semester" <?php echo ($student['semester'] ?? '') === '1st Semester' ? 'selected' : ''; ?>>1st Semester</option>
                                            <option value="2nd Semester" <?php echo ($student['semester'] ?? '') === '2nd Semester' ? 'selected' : ''; ?>>2nd Semester</option>
                                            <option value="Summer" <?php echo ($student['semester'] ?? '') === 'Summer' ? 'selected' : ''; ?>>Summer</option>
                                        </select>
                                    </td>
                                    <td class="editable-cell">
                                        <span class="display-value"><?php echo sanitize($student['section'] ?? '—'); ?></span>
                                        <input type="text" name="students[<?php echo $student['id']; ?>][section]" class="edit-input form-control" value="<?php echo sanitize($student['section'] ?? ''); ?>" style="display:none;" placeholder="Section">
                                    </td>
                                    <td>
                                        <?php 
                                        $statusClass = 'active';
                                        $status = $student['student_status'] ?? 'Active';
                                        if ($status === 'Inactive' || $status === 'Dropped') $statusClass = 'dropped';
                                        if ($status === 'Graduated') $statusClass = 'complete';
                                        ?>
                                        <span class="badge badge-<?php echo $statusClass; ?>"><?php echo sanitize($status); ?></span>
                                    </td>
                                    <td>
                                        <div class="table-actions">
                                            <a href="students.php?action=view&id=<?php echo $student['id']; ?>" class="btn btn-outline btn-sm" title="View Profile"><i class="fas fa-eye"></i></a>
                                            <a href="students.php?action=edit&id=<?php echo $student['id']; ?>" class="btn btn-secondary btn-sm" title="Edit"><i class="fas fa-edit"></i></a>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
                <div class="bulk-edit-actions" id="bulkEditActions" style="display:none;">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Changes</button>
                    <button type="button" class="btn btn-secondary" onclick="toggleBulkEdit()">Cancel</button>
                </div>
            </form>
        <?php endif; ?>
    </div>
    
    <!-- Assign Student Modal -->
    <div class="modal-overlay" id="assignModal">
        <div class="modal">
            <div class="modal-header">
                <h3><i class="fas fa-user-plus"></i> Assign Student to Program</h3>
                <button class="modal-close" onclick="closeAssignModal()"><i class="fas fa-times"></i></button>
            </div>
            <form method="POST" action="programs.php?action=assign&id=<?php echo $program['id']; ?>">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="student_id">Select Student</label>
                        <select name="student_id" id="student_id" class="form-control" required>
                            <option value="">Choose a student...</option>
                            <?php 
                            $allStudents = getAllStudents();
                            foreach ($allStudents as $s): 
                                if (($s['program'] ?? '') !== $program['program_name']):
                            ?>
                                <option value="<?php echo $s['id']; ?>">
                                    <?php echo sanitize($s['student_id'] . ' - ' . getStudentFullName($s, 'formal')); ?>
                                </option>
                            <?php 
                                endif;
                            endforeach; 
                            ?>
                        </select>
                    </div>
                    <input type="hidden" name="program" value="<?php echo sanitize($program['program_name']); ?>">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="year_level">Year Level</label>
                            <select name="year_level" id="year_level" class="form-control" required>
                                <option value="1st Year">1st Year</option>
                                <option value="2nd Year">2nd Year</option>
                                <option value="3rd Year">3rd Year</option>
                                <option value="4th Year">4th Year</option>
                                <option value="5th Year">5th Year</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="semester">Semester</label>
                            <select name="semester" id="semester" class="form-control" required>
                                <option value="1st Semester">1st Semester</option>
                                <option value="2nd Semester">2nd Semester</option>
                                <option value="Summer">Summer</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeAssignModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Assign Student</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
    function openAssignModal() {
        document.getElementById('assignModal').classList.add('show');
    }
    function closeAssignModal() {
        document.getElementById('assignModal').classList.remove('show');
    }
    function toggleBulkEdit() {
        const form = document.getElementById('bulkEditForm');
        const displayValues = form.querySelectorAll('.display-value');
        const editInputs = form.querySelectorAll('.edit-input');
        const actions = document.getElementById('bulkEditActions');
        
        const isEditing = actions.style.display !== 'none';
        
        displayValues.forEach(el => el.style.display = isEditing ? '' : 'none');
        editInputs.forEach(el => el.style.display = isEditing ? 'none' : '');
        actions.style.display = isEditing ? 'none' : 'flex';
    }
    </script>

<?php elseif ($action === 'add'): ?>
    <!-- ============================================
         ADD NEW PROGRAM
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-plus-circle"></i> Add New Program</h1>
            <p class="page-subtitle">Create a new academic program</p>
        </div>
        <div class="page-actions">
            <a href="programs.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <div class="panel">
        <form method="POST" action="programs.php?action=add">
            <div class="panel-body">
                <div class="form-row">
                    <div class="form-group">
                        <label for="program_code">Program Code <span class="required">*</span></label>
                        <input type="text" id="program_code" name="program_code" class="form-control" 
                               placeholder="e.g., BSIT" required maxlength="20">
                        <small class="form-text">Short code for the program (e.g., BSIT, BSCS, BSA)</small>
                    </div>
                    <div class="form-group">
                        <label for="years_duration">Duration (Years) <span class="required">*</span></label>
                        <select id="years_duration" name="years_duration" class="form-control" required>
                            <option value="4">4 Years</option>
                            <option value="5">5 Years</option>
                            <option value="2">2 Years</option>
                            <option value="3">3 Years</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="program_name">Program Name <span class="required">*</span></label>
                    <input type="text" id="program_name" name="program_name" class="form-control" 
                           placeholder="e.g., Bachelor of Science in Information Technology" required maxlength="150">
                </div>
                
                <div class="form-group">
                    <label for="department">Department</label>
                    <input type="text" id="department" name="department" class="form-control" 
                           placeholder="e.g., College of Computer Studies" maxlength="100">
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" rows="3"
                              placeholder="Brief description of the program..."></textarea>
                </div>
            </div>
            
            <div class="form-actions-bar">
                <button type="submit" class="btn btn-primary btn-lg"><i class="fas fa-save"></i> Save Program</button>
                <a href="programs.php" class="btn btn-secondary btn-lg">Cancel</a>
            </div>
        </form>
    </div>

<?php elseif ($action === 'edit' && isset($program)): ?>
    <!-- ============================================
         EDIT PROGRAM
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-edit"></i> Edit Program</h1>
            <p class="page-subtitle"><?php echo sanitize($program['program_code']); ?></p>
        </div>
        <div class="page-actions">
            <a href="programs.php?action=view&id=<?php echo $program['id']; ?>" class="btn btn-outline"><i class="fas fa-eye"></i> View</a>
            <a href="programs.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <div class="panel">
        <form method="POST" action="programs.php?action=edit&id=<?php echo $program['id']; ?>">
            <div class="panel-body">
                <div class="form-row">
                    <div class="form-group">
                        <label for="program_code">Program Code <span class="required">*</span></label>
                        <input type="text" id="program_code" name="program_code" class="form-control" 
                               value="<?php echo sanitize($program['program_code']); ?>" required maxlength="20">
                    </div>
                    <div class="form-group">
                        <label for="years_duration">Duration (Years) <span class="required">*</span></label>
                        <select id="years_duration" name="years_duration" class="form-control" required>
                            <?php foreach ([2, 3, 4, 5] as $y): ?>
                                <option value="<?php echo $y; ?>" <?php echo ($program['years_duration'] ?? 4) == $y ? 'selected' : ''; ?>><?php echo $y; ?> Years</option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="program_name">Program Name <span class="required">*</span></label>
                    <input type="text" id="program_name" name="program_name" class="form-control" 
                           value="<?php echo sanitize($program['program_name']); ?>" required maxlength="150">
                </div>
                
                <div class="form-group">
                    <label for="department">Department</label>
                    <input type="text" id="department" name="department" class="form-control" 
                           value="<?php echo sanitize($program['department'] ?? ''); ?>" maxlength="100">
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" rows="3"><?php echo sanitize($program['description'] ?? ''); ?></textarea>
                </div>
            </div>
            
            <div class="form-actions-bar">
                <button type="submit" class="btn btn-primary btn-lg"><i class="fas fa-save"></i> Update Program</button>
                <a href="programs.php" class="btn btn-secondary btn-lg">Cancel</a>
                <?php 
                $studentCount = getStudentCountByProgram($program['program_name']);
                if ($studentCount === 0): 
                ?>
                    <button type="button" class="btn btn-danger btn-lg" 
                            onclick="confirmDelete('program', '<?php echo sanitize($program['program_code']); ?>', 'programs.php?action=delete&id=<?php echo $program['id']; ?>')">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                <?php endif; ?>
            </div>
        </form>
    </div>

<?php endif; ?>

    </div>
</main>
</div>
<script src="../assets/js/script.js"></script>
</body>
</html>
