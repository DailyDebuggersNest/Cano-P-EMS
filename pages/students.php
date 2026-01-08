<?php
/**
 * Students Page - Student Information System (SIS)
 * 
 * Comprehensive student profiling with detailed bio-data capture:
 * - Student ID, Name components (First, Middle, Last, Suffix)
 * - Sex, Date of Birth, Civil Status
 * - Contact Information
 * - Address Details
 * - Guardian/Emergency Contact
 * - Academic Information
 */

// Load our helper functions
require_once __DIR__ . '/../includes/functions.php';

// Set the page title and base path
$pageTitle = 'Student Information';
$basePath = '../';

// Get the action from the URL
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

// Handle delete action
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
    
    if (!$student) {
        setFlashMessage('Student not found.', 'error');
        redirect('students.php');
    }
}

// View single student profile
if ($action === 'view' && isset($_GET['id'])) {
    $student = getStudentById((int) $_GET['id']);
    
    if (!$student) {
        setFlashMessage('Student not found.', 'error');
        redirect('students.php');
    }
}

// Get all students for the list view
$students = getAllStudents();
$programs = getAllPrograms();

// Get filter/search parameters
$searchQuery = $_GET['search'] ?? '';
$filterProgram = $_GET['program'] ?? '';
$filterYearLevel = $_GET['year_level'] ?? '';
$filterSemester = $_GET['semester'] ?? '';
$filterStatus = $_GET['status'] ?? '';
$filterSex = $_GET['sex'] ?? '';

// Get sort parameters
$sortBy = $_GET['sort'] ?? 'student_id';
$sortOrder = $_GET['order'] ?? 'asc';

// Apply filters to students
if (!empty($students)) {
    $students = array_filter($students, function($student) use ($searchQuery, $filterProgram, $filterYearLevel, $filterSemester, $filterStatus, $filterSex) {
        // Search filter (name, student_id, email)
        if (!empty($searchQuery)) {
            $search = strtolower($searchQuery);
            $fullName = strtolower(($student['first_name'] ?? '') . ' ' . ($student['middle_name'] ?? '') . ' ' . ($student['last_name'] ?? ''));
            $studentId = strtolower($student['student_id'] ?? '');
            $email = strtolower($student['email'] ?? '');
            
            if (strpos($fullName, $search) === false && 
                strpos($studentId, $search) === false && 
                strpos($email, $search) === false) {
                return false;
            }
        }
        
        // Program filter
        if (!empty($filterProgram) && ($student['program'] ?? '') !== $filterProgram) {
            return false;
        }
        
        // Year level filter
        if (!empty($filterYearLevel) && ($student['year_level'] ?? '') !== $filterYearLevel) {
            return false;
        }
        
        // Semester filter
        if (!empty($filterSemester) && ($student['semester'] ?? '') !== $filterSemester) {
            return false;
        }
        
        // Status filter
        if (!empty($filterStatus) && ($student['student_status'] ?? 'Active') !== $filterStatus) {
            return false;
        }
        
        // Sex filter
        if (!empty($filterSex) && ($student['sex'] ?? '') !== $filterSex) {
            return false;
        }
        
        return true;
    });
    
    // Apply sorting
    usort($students, function($a, $b) use ($sortBy, $sortOrder) {
        $valA = '';
        $valB = '';
        
        switch ($sortBy) {
            case 'student_id':
                $valA = $a['student_id'] ?? '';
                $valB = $b['student_id'] ?? '';
                break;
            case 'name':
                $valA = ($a['last_name'] ?? '') . ', ' . ($a['first_name'] ?? '');
                $valB = ($b['last_name'] ?? '') . ', ' . ($b['first_name'] ?? '');
                break;
            case 'sex':
                $valA = $a['sex'] ?? '';
                $valB = $b['sex'] ?? '';
                break;
            case 'program':
                $valA = $a['program'] ?? '';
                $valB = $b['program'] ?? '';
                break;
            case 'year_level':
                $valA = $a['year_level'] ?? '';
                $valB = $b['year_level'] ?? '';
                break;
            case 'status':
                $valA = $a['student_status'] ?? '';
                $valB = $b['student_status'] ?? '';
                break;
            case 'admission_date':
                $valA = $a['admission_date'] ?? '';
                $valB = $b['admission_date'] ?? '';
                break;
            default:
                $valA = $a['student_id'] ?? '';
                $valB = $b['student_id'] ?? '';
        }
        
        $result = strcasecmp($valA, $valB);
        return $sortOrder === 'desc' ? -$result : $result;
    });
}

// Include the header and sidebar
include __DIR__ . '/../templates/header.php';
include __DIR__ . '/../templates/sidebar.php';
?>

<?php if ($action === 'list'): ?>
    <!-- ============================================
         STUDENTS LIST VIEW
         Shows all students in a comprehensive table
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-user-graduate"></i> Student Information System</h1>
            <p class="page-subtitle">Manage student profiles and bio-data</p>
        </div>
        <div class="page-actions">
            <a href="students.php?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> New Student</a>
        </div>
    </div>
    
    <!-- Search and Filter Section -->
    <div class="panel filter-panel">
        <form method="GET" action="students.php" class="filter-form">
            <div class="filter-row">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" name="search" placeholder="Search by name, ID, or email..." 
                           value="<?php echo sanitize($searchQuery); ?>">
                </div>
                
                <div class="filter-group">
                    <select name="program" class="form-control filter-select">
                        <option value="">All Programs</option>
                        <?php if (!empty($programs)): ?>
                            <?php foreach ($programs as $prog): ?>
                                <option value="<?php echo sanitize($prog['program_name']); ?>"
                                        <?php echo $filterProgram === $prog['program_name'] ? 'selected' : ''; ?>>
                                    <?php echo sanitize($prog['program_code']); ?>
                                </option>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <option value="Bachelor of Science in Information Technology" <?php echo $filterProgram === 'Bachelor of Science in Information Technology' ? 'selected' : ''; ?>>BSIT</option>
                            <option value="Bachelor of Science in Computer Science" <?php echo $filterProgram === 'Bachelor of Science in Computer Science' ? 'selected' : ''; ?>>BSCS</option>
                        <?php endif; ?>
                    </select>
                </div>
                
                <div class="filter-group">
                    <select name="year_level" class="form-control filter-select">
                        <option value="">All Year Levels</option>
                        <option value="1st Year" <?php echo $filterYearLevel === '1st Year' ? 'selected' : ''; ?>>1st Year</option>
                        <option value="2nd Year" <?php echo $filterYearLevel === '2nd Year' ? 'selected' : ''; ?>>2nd Year</option>
                        <option value="3rd Year" <?php echo $filterYearLevel === '3rd Year' ? 'selected' : ''; ?>>3rd Year</option>
                        <option value="4th Year" <?php echo $filterYearLevel === '4th Year' ? 'selected' : ''; ?>>4th Year</option>
                        <option value="5th Year" <?php echo $filterYearLevel === '5th Year' ? 'selected' : ''; ?>>5th Year</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <select name="semester" class="form-control filter-select">
                        <option value="">All Semesters</option>
                        <option value="1st Semester" <?php echo $filterSemester === '1st Semester' ? 'selected' : ''; ?>>1st Semester</option>
                        <option value="2nd Semester" <?php echo $filterSemester === '2nd Semester' ? 'selected' : ''; ?>>2nd Semester</option>
                        <option value="Summer" <?php echo $filterSemester === 'Summer' ? 'selected' : ''; ?>>Summer</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <select name="sex" class="form-control filter-select">
                        <option value="">All Sex</option>
                        <option value="Male" <?php echo $filterSex === 'Male' ? 'selected' : ''; ?>>Male</option>
                        <option value="Female" <?php echo $filterSex === 'Female' ? 'selected' : ''; ?>>Female</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <select name="status" class="form-control filter-select">
                        <option value="">All Status</option>
                        <option value="Active" <?php echo $filterStatus === 'Active' ? 'selected' : ''; ?>>Active</option>
                        <option value="Inactive" <?php echo $filterStatus === 'Inactive' ? 'selected' : ''; ?>>Inactive</option>
                        <option value="On Leave" <?php echo $filterStatus === 'On Leave' ? 'selected' : ''; ?>>On Leave</option>
                        <option value="Graduated" <?php echo $filterStatus === 'Graduated' ? 'selected' : ''; ?>>Graduated</option>
                        <option value="Dropped" <?php echo $filterStatus === 'Dropped' ? 'selected' : ''; ?>>Dropped</option>
                    </select>
                </div>
                
                <div class="filter-actions">
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fas fa-filter"></i> Filter</button>
                    <a href="students.php" class="btn btn-secondary btn-sm"><i class="fas fa-times"></i> Clear</a>
                </div>
            </div>
        </form>
    </div>
    
    <div class="panel">
        <?php 
        $hasFilters = !empty($searchQuery) || !empty($filterProgram) || !empty($filterYearLevel) || !empty($filterSemester) || !empty($filterStatus) || !empty($filterSex);
        $totalCount = count($students);
        ?>
        
        <?php if ($hasFilters): ?>
            <div class="results-info">
                <i class="fas fa-info-circle"></i> 
                Showing <strong><?php echo $totalCount; ?></strong> result<?php echo $totalCount !== 1 ? 's' : ''; ?>
                <?php if (!empty($searchQuery)): ?> for "<strong><?php echo sanitize($searchQuery); ?></strong>"<?php endif; ?>
            </div>
        <?php endif; ?>
        
        <?php if (empty($students)): ?>
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-<?php echo $hasFilters ? 'search' : 'user-graduate'; ?>"></i></div>
                <h3><?php echo $hasFilters ? 'No matching students found' : 'No students yet'; ?></h3>
                <p><?php echo $hasFilters ? 'Try adjusting your search or filter criteria.' : 'Get started by adding your first student record.'; ?></p>
                <?php if ($hasFilters): ?>
                    <a href="students.php" class="btn btn-secondary mt-2"><i class="fas fa-times"></i> Clear Filters</a>
                <?php else: ?>
                    <a href="students.php?action=add" class="btn btn-primary mt-2"><i class="fas fa-plus"></i> Add Student</a>
                <?php endif; ?>
            </div>
        <?php else: ?>
            <?php
            // Build sort URL helper function
            function getSortUrl($column, $currentSort, $currentOrder, $params = []) {
                $newOrder = ($currentSort === $column && $currentOrder === 'asc') ? 'desc' : 'asc';
                $queryParams = array_merge($params, ['sort' => $column, 'order' => $newOrder]);
                return 'students.php?' . http_build_query($queryParams);
            }
            
            // Preserve filter params for sort links
            $filterParams = [];
            if (!empty($searchQuery)) $filterParams['search'] = $searchQuery;
            if (!empty($filterProgram)) $filterParams['program'] = $filterProgram;
            if (!empty($filterYearLevel)) $filterParams['year_level'] = $filterYearLevel;
            if (!empty($filterSemester)) $filterParams['semester'] = $filterSemester;
            if (!empty($filterStatus)) $filterParams['status'] = $filterStatus;
            if (!empty($filterSex)) $filterParams['sex'] = $filterSex;
            ?>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Seq</th>
                            <th class="sortable">
                                <a href="<?php echo getSortUrl('student_id', $sortBy, $sortOrder, $filterParams); ?>">
                                    <span>Student ID</span>
                                    <?php if ($sortBy === 'student_id'): ?><i class="fas fa-sort-<?php echo $sortOrder === 'asc' ? 'up' : 'down'; ?>"></i><?php else: ?><i class="fas fa-sort sort-inactive"></i><?php endif; ?>
                                </a>
                            </th>
                            <th class="sortable">
                                <a href="<?php echo getSortUrl('name', $sortBy, $sortOrder, $filterParams); ?>">
                                    <span>Name</span>
                                    <?php if ($sortBy === 'name'): ?><i class="fas fa-sort-<?php echo $sortOrder === 'asc' ? 'up' : 'down'; ?>"></i><?php else: ?><i class="fas fa-sort sort-inactive"></i><?php endif; ?>
                                </a>
                            </th>
                            <th class="sortable">
                                <a href="<?php echo getSortUrl('sex', $sortBy, $sortOrder, $filterParams); ?>">
                                    <span>Sex</span>
                                    <?php if ($sortBy === 'sex'): ?><i class="fas fa-sort-<?php echo $sortOrder === 'asc' ? 'up' : 'down'; ?>"></i><?php else: ?><i class="fas fa-sort sort-inactive"></i><?php endif; ?>
                                </a>
                            </th>
                            <th class="sortable">
                                <a href="<?php echo getSortUrl('program', $sortBy, $sortOrder, $filterParams); ?>">
                                    <span>Program</span>
                                    <?php if ($sortBy === 'program'): ?><i class="fas fa-sort-<?php echo $sortOrder === 'asc' ? 'up' : 'down'; ?>"></i><?php else: ?><i class="fas fa-sort sort-inactive"></i><?php endif; ?>
                                </a>
                            </th>
                            <th class="sortable">
                                <a href="<?php echo getSortUrl('year_level', $sortBy, $sortOrder, $filterParams); ?>">
                                    <span>Year Level</span>
                                    <?php if ($sortBy === 'year_level'): ?><i class="fas fa-sort-<?php echo $sortOrder === 'asc' ? 'up' : 'down'; ?>"></i><?php else: ?><i class="fas fa-sort sort-inactive"></i><?php endif; ?>
                                </a>
                            </th>
                            <th class="sortable">
                                <a href="<?php echo getSortUrl('status', $sortBy, $sortOrder, $filterParams); ?>">
                                    <span>Status</span>
                                    <?php if ($sortBy === 'status'): ?><i class="fas fa-sort-<?php echo $sortOrder === 'asc' ? 'up' : 'down'; ?>"></i><?php else: ?><i class="fas fa-sort sort-inactive"></i><?php endif; ?>
                                </a>
                            </th>
                            <th class="sortable">
                                <a href="<?php echo getSortUrl('admission_date', $sortBy, $sortOrder, $filterParams); ?>">
                                    <span>Edate</span>
                                    <?php if ($sortBy === 'admission_date'): ?><i class="fas fa-sort-<?php echo $sortOrder === 'asc' ? 'up' : 'down'; ?>"></i><?php else: ?><i class="fas fa-sort sort-inactive"></i><?php endif; ?>
                                </a>
                            </th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $seq = 1; foreach ($students as $student): ?>
                            <tr>
                                <td><?php echo $seq++; ?></td>
                                <td><span class="student-id"><?php echo sanitize($student['student_id'] ?? 'N/A'); ?></span></td>
                                <td>
                                    <div class="user-info">
                                        <div class="user-avatar"><i class="fas fa-user"></i></div>
                                        <div>
                                            <strong><?php echo sanitize(getStudentFullName($student, 'formal')); ?></strong>
                                            <br><small class="text-muted"><?php echo sanitize($student['email']); ?></small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <?php if (!empty($student['sex'])): ?>
                                        <span class="badge badge-<?php echo $student['sex'] === 'Male' ? 'info' : 'pink'; ?>">
                                            <?php echo sanitize($student['sex']); ?>
                                        </span>
                                    <?php else: ?>
                                        <span class="text-muted">—</span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <?php 
                                    $program = $student['program'] ?? '';
                                    if (!empty($program)) {
                                        $progInfo = getProgramAbbreviation($program);
                                        echo '<span class="program-abbr" data-tooltip="' . sanitize($progInfo['name']) . '">' . sanitize($progInfo['code']) . '</span>';
                                    } else {
                                        echo '—';
                                    }
                                    ?>
                                </td>
                                <td><?php echo sanitize($student['year_level'] ?? '—'); ?></td>
                                <td>
                                    <?php 
                                    $statusClass = 'active';
                                    $status = $student['student_status'] ?? 'Active';
                                    if ($status === 'Inactive' || $status === 'Dropped') $statusClass = 'dropped';
                                    if ($status === 'Graduated') $statusClass = 'complete';
                                    if ($status === 'On Leave') $statusClass = 'pending';
                                    ?>
                                    <span class="badge badge-<?php echo $statusClass; ?>">
                                        <?php echo sanitize($status); ?>
                                    </span>
                                </td>
                                <td>
                                    <?php echo !empty($student['admission_date']) ? date('M d, Y', strtotime($student['admission_date'])) : '—'; ?>
                                </td>
                                <td>
                                    <div class="table-actions">
                                        <a href="students.php?action=view&id=<?php echo $student['id']; ?>" 
                                           class="btn btn-outline btn-sm" title="View Profile"><i class="fas fa-eye"></i></a>
                                    </div>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>
    </div>

<?php elseif ($action === 'view' && isset($student)): ?>
    <!-- ============================================
         VIEW STUDENT PROFILE
         Detailed student information display with tabs
         ============================================ -->
    
    <?php 
    // Get the active tab from URL, default to 'personal'
    $activeTab = $_GET['tab'] ?? 'personal';
    
    // Pre-fetch data for all tabs
    $enrollments = getCurrentEnrollments($student['id']);
    $enrollmentStats = getEnrollmentStats($student['id']);
    $payments = getCurrentPayments($student['id']);
    $paymentSummary = getPaymentSummary($student['id']);
    ?>
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-id-card"></i> Student Profile</h1>
            <p class="page-subtitle"><?php echo sanitize($student['student_id'] ?? 'Student Details'); ?></p>
        </div>
        <div class="page-actions">
            <a href="students.php?action=edit&id=<?php echo $student['id']; ?>" class="btn btn-primary"><i class="fas fa-edit"></i> Edit</a>
            <a href="students.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <!-- Profile Header Card -->
    <div class="panel profile-header-card">
        <div class="profile-header">
            <div class="profile-avatar-large">
                <i class="fas fa-user-graduate"></i>
            </div>
            <div class="profile-header-info">
                <h2><?php echo sanitize(getStudentFullName($student, 'full')); ?></h2>
                <p class="student-id-display"><?php echo sanitize($student['student_id'] ?? 'No ID'); ?></p>
                <div class="profile-badges">
                    <?php if (!empty($student['sex'])): ?>
                        <span class="badge badge-<?php echo $student['sex'] === 'Male' ? 'info' : 'pink'; ?>">
                            <?php echo sanitize($student['sex']); ?>
                        </span>
                    <?php endif; ?>
                    <span class="badge badge-<?php echo ($student['student_status'] ?? 'Active') === 'Active' ? 'active' : 'dropped'; ?>">
                        <?php echo sanitize($student['student_status'] ?? 'Active'); ?>
                    </span>
                    <span class="badge badge-info"><?php echo sanitize($student['year_level'] ?? ''); ?></span>
                </div>
            </div>
            <div class="profile-quick-stats">
                <div class="quick-stat">
                    <span class="quick-stat-value"><?php echo $enrollmentStats['current_units']; ?></span>
                    <span class="quick-stat-label">Units</span>
                </div>
                <div class="quick-stat">
                    <span class="quick-stat-value"><?php echo $enrollmentStats['pending_subjects']; ?></span>
                    <span class="quick-stat-label">Subjects</span>
                </div>
                <div class="quick-stat <?php echo $paymentSummary['balance'] > 0 ? 'has-balance' : ''; ?>">
                    <span class="quick-stat-value"><?php echo formatCurrency($paymentSummary['balance']); ?></span>
                    <span class="quick-stat-label">Balance</span>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Profile Tab Navigation -->
    <div class="profile-tabs">
        <a href="students.php?action=view&id=<?php echo $student['id']; ?>&tab=personal" 
           class="profile-tab <?php echo $activeTab === 'personal' ? 'active' : ''; ?>">
            <i class="fas fa-user"></i>
            <span>Personal Info</span>
        </a>
        <a href="students.php?action=view&id=<?php echo $student['id']; ?>&tab=subjects" 
           class="profile-tab <?php echo $activeTab === 'subjects' ? 'active' : ''; ?>">
            <i class="fas fa-book"></i>
            <span>Subjects</span>
        </a>
        <a href="students.php?action=view&id=<?php echo $student['id']; ?>&tab=payments" 
           class="profile-tab <?php echo $activeTab === 'payments' ? 'active' : ''; ?>">
            <i class="fas fa-money-bill-wave"></i>
            <span>Payments</span>
        </a>
    </div>
    
    <!-- Tab Content -->
    <div class="profile-tab-content">
        
        <?php if ($activeTab === 'personal'): ?>
        <!-- ==================== PERSONAL INFO TAB ==================== -->
        <div class="profile-grid">
            <!-- Personal Information -->
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-user"></i> Personal Information</h3>
                </div>
                <div class="panel-body">
                    <div class="info-grid">
                        <div class="info-item">
                            <label>First Name</label>
                            <span><?php echo sanitize($student['first_name']); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Middle Name</label>
                            <span><?php echo sanitize($student['middle_name'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Last Name</label>
                            <span><?php echo sanitize($student['last_name']); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Suffix</label>
                            <span><?php echo sanitize($student['suffix'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Sex</label>
                            <span><?php echo sanitize($student['sex'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Date of Birth</label>
                            <span>
                                <?php 
                                if (!empty($student['date_of_birth'])) {
                                    echo date('F j, Y', strtotime($student['date_of_birth']));
                                    $age = calculateAge($student['date_of_birth']);
                                    if ($age) echo " ({$age} years old)";
                                } else {
                                    echo '—';
                                }
                                ?>
                            </span>
                        </div>
                        <div class="info-item">
                            <label>Place of Birth</label>
                            <span><?php echo sanitize($student['place_of_birth'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Civil Status</label>
                            <span><?php echo sanitize($student['civil_status'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Nationality</label>
                            <span><?php echo sanitize($student['nationality'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Religion</label>
                            <span><?php echo sanitize($student['religion'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Blood Type</label>
                            <span><?php echo sanitize($student['blood_type'] ?? '—'); ?></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Contact Information -->
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-address-book"></i> Contact Information</h3>
                </div>
                <div class="panel-body">
                    <div class="info-grid">
                        <div class="info-item">
                            <label>Email Address</label>
                            <span><?php echo sanitize($student['email']); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Phone Number</label>
                            <span><?php echo sanitize($student['phone'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item full-width">
                            <label>Complete Address</label>
                            <span><?php echo sanitize(getStudentAddress($student)); ?></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Guardian Information -->
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-users"></i> Guardian / Emergency Contact</h3>
                </div>
                <div class="panel-body">
                    <div class="info-grid">
                        <div class="info-item">
                            <label>Guardian Name</label>
                            <span><?php echo sanitize($student['guardian_name'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Relationship</label>
                            <span><?php echo sanitize($student['guardian_relationship'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Guardian Contact</label>
                            <span><?php echo sanitize($student['guardian_contact'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Guardian Address</label>
                            <span><?php echo sanitize($student['guardian_address'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Emergency Contact Name</label>
                            <span><?php echo sanitize($student['emergency_contact_name'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Emergency Contact Phone</label>
                            <span><?php echo sanitize($student['emergency_contact_phone'] ?? '—'); ?></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Academic Information -->
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-graduation-cap"></i> Academic Information</h3>
                </div>
                <div class="panel-body">
                    <div class="info-grid">
                        <div class="info-item">
                            <label>Program</label>
                            <span><?php echo sanitize($student['program'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Year Level</label>
                            <span><?php echo sanitize($student['year_level'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Semester</label>
                            <span><?php echo sanitize($student['semester'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Section</label>
                            <span><?php echo sanitize($student['section'] ?? '—'); ?></span>
                        </div>
                        <div class="info-item">
                            <label>Admission Date</label>
                            <span><?php echo !empty($student['admission_date']) ? date('F j, Y', strtotime($student['admission_date'])) : '—'; ?></span>
                        </div>
                        <div class="info-item">
                            <label>Student Status</label>
                            <span><?php echo sanitize($student['student_status'] ?? 'Active'); ?></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <?php elseif ($activeTab === 'subjects'): ?>
        <!-- ==================== SUBJECTS TAB ==================== -->
        <div class="subjects-tab-content">
            
            <!-- Enrollment History - Dropdown Selector -->
            <?php 
            $allEnrollments = getStudentEnrollments($student['id']); 
            
            // Group enrollments by Year Level and Semester
            $groupedEnrollments = [];
            foreach ($allEnrollments as $enrollment) {
                $academicYear = $enrollment['academic_year'];
                $semester = $enrollment['semester'];
                $enrollYear = (int)substr($academicYear, 0, 4);
                $admissionYear = !empty($student['admission_date']) ? (int)date('Y', strtotime($student['admission_date'])) : $enrollYear;
                $yearDiff = $enrollYear - $admissionYear;
                $yearLevel = $yearDiff + 1;
                if ($yearLevel < 1) $yearLevel = 1;
                if ($yearLevel > 5) $yearLevel = 5;
                
                $yearLevelText = match($yearLevel) {
                    1 => '1st Year', 2 => '2nd Year', 3 => '3rd Year', 4 => '4th Year', 5 => '5th Year', default => '1st Year'
                };
                
                $key = $yearLevelText . '|' . $semester . '|' . $academicYear;
                if (!isset($groupedEnrollments[$key])) {
                    $groupedEnrollments[$key] = [
                        'year_level' => $yearLevelText,
                        'semester' => $semester,
                        'academic_year' => $academicYear,
                        'subjects' => [],
                        'total_units' => 0,
                        'is_current' => ($academicYear === '2025-2026' && $semester === '1st Semester')
                    ];
                }
                $groupedEnrollments[$key]['subjects'][] = $enrollment;
                $groupedEnrollments[$key]['total_units'] += $enrollment['units'];
            }
            
            // Sort by year level then semester (most recent first for dropdown)
            uksort($groupedEnrollments, function($a, $b) {
                $orderA = str_replace(['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year'], ['1', '2', '3', '4', '5'], explode('|', $a)[0]);
                $orderB = str_replace(['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year'], ['1', '2', '3', '4', '5'], explode('|', $b)[0]);
                $semOrderA = str_contains($a, '1st Semester') ? 1 : (str_contains($a, '2nd Semester') ? 2 : 3);
                $semOrderB = str_contains($b, '1st Semester') ? 1 : (str_contains($b, '2nd Semester') ? 2 : 3);
                
                if ($orderA === $orderB) {
                    return $semOrderA - $semOrderB;
                }
                return $orderA - $orderB;
            });
            ?>
            
            <?php if (count($allEnrollments) > 0): ?>
            <?php 
            // Prepare enrollment data - put current semester first
            $enrollmentGroups = array_values($groupedEnrollments);
            $enrollmentGroups = array_reverse($enrollmentGroups); // Most recent first
            
            // Find the current semester index (should be index 0 after reverse, but let's be sure)
            $currentSemesterIndex = 0;
            foreach ($enrollmentGroups as $idx => $grp) {
                if ($grp['is_current']) {
                    $currentSemesterIndex = $idx;
                    break;
                }
            }
            ?>
            <div class="panel enrollment-history-panel">
                <div class="panel-header">
                    <h3><i class="fas fa-history"></i> Enrollment History</h3>
                    <div class="panel-header-actions">
                        <div class="semester-dropdown-wrapper">
                            <label for="semesterSelector" class="dropdown-label">Select Semester</label>
                            <select id="semesterSelector" class="semester-selector" onchange="showSelectedSemester()">
                                <?php foreach ($enrollmentGroups as $index => $group): ?>
                                <option value="<?php echo $index; ?>" <?php echo ($index === $currentSemesterIndex) ? 'selected' : ''; ?>>
                                    <?php echo $group['year_level'] . ' • ' . $group['semester'] . ' • S.Y. ' . $group['academic_year']; ?>
                                </option>
                                <?php endforeach; ?>
                                <option value="all">Show All Semesters</option>
                            </select>
                            <i class="fas fa-chevron-down dropdown-arrow"></i>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <?php foreach ($enrollmentGroups as $index => $group): 
                        // Calculate GWA for this semester
                        $totalGradePoints = 0;
                        $totalUnits = 0;
                        foreach ($group['subjects'] as $s) {
                            if ($s['grade'] !== null) {
                                $totalGradePoints += $s['grade'] * $s['units'];
                                $totalUnits += $s['units'];
                            }
                        }
                        $gwa = $totalUnits > 0 ? $totalGradePoints / $totalUnits : 0;
                        $isVisible = ($index === $currentSemesterIndex);
                    ?>
                    <div class="semester-content" id="semester-<?php echo $index; ?>" style="<?php echo !$isVisible ? 'display: none;' : ''; ?>">
                        <!-- Semester Summary Bar -->
                        <div class="semester-summary-bar">
                            <div class="summary-item">
                                <span class="year-level-badge"><?php echo $group['year_level']; ?></span>
                                <span class="semester-name"><?php echo $group['semester']; ?></span>
                                <span class="academic-year-tag">S.Y. <?php echo $group['academic_year']; ?></span>
                                <?php if ($group['is_current']): ?>
                                <span class="current-badge">Current</span>
                                <?php endif; ?>
                            </div>
                            <div class="summary-stats">
                                <span class="stat-item"><i class="fas fa-book"></i> <?php echo count($group['subjects']); ?> subjects</span>
                                <span class="stat-item"><i class="fas fa-calculator"></i> <?php echo $group['total_units']; ?> units</span>
                                <?php if ($gwa > 0): ?>
                                <span class="gwa-badge <?php echo $gwa <= 1.75 ? 'gwa-excellent' : ($gwa <= 2.5 ? 'gwa-good' : 'gwa-fair'); ?>">
                                    GWA: <?php echo number_format($gwa, 2); ?>
                                </span>
                                <?php endif; ?>
                            </div>
                        </div>
                        
                        <!-- Subjects Table -->
                        <div class="table-container">
                            <table class="data-table grades-table">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">#</th>
                                        <th style="width: 110px;">Code</th>
                                        <th>Subject Name</th>
                                        <th style="width: 60px;" class="text-center">Units</th>
                                        <th style="width: 70px;" class="text-center">Grade</th>
                                        <th style="width: 100px;">Remarks</th>
                                        <th style="width: 80px;" class="text-center">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $num = 1; foreach ($group['subjects'] as $subject): ?>
                                    <tr>
                                        <td class="text-center"><?php echo $num++; ?></td>
                                        <td><code class="subject-code-badge"><?php echo sanitize($subject['subject_code']); ?></code></td>
                                        <td><strong><?php echo sanitize($subject['subject_name']); ?></strong></td>
                                        <td class="text-center"><span class="units-badge"><?php echo $subject['units']; ?></span></td>
                                        <td class="text-center">
                                            <?php if ($subject['grade'] !== null): ?>
                                                <span class="grade-pill <?php echo $subject['grade'] <= 3.0 ? 'grade-pass' : 'grade-fail'; ?>">
                                                    <?php echo number_format($subject['grade'], 2); ?>
                                                </span>
                                            <?php else: ?>
                                                <span class="grade-pill grade-pending">—</span>
                                            <?php endif; ?>
                                        </td>
                                        <td>
                                            <?php if ($subject['grade'] !== null): ?>
                                                <span class="remarks-text"><?php echo getGradeDescription($subject['grade']); ?></span>
                                            <?php else: ?>
                                                <span class="remarks-text text-muted">In Progress</span>
                                            <?php endif; ?>
                                        </td>
                                        <td class="text-center">
                                            <?php 
                                            $statusClass = $subject['grade_status'] === 'Passed' ? 'active' : ($subject['grade_status'] === 'Failed' ? 'dropped' : 'pending');
                                            ?>
                                            <span class="status-badge status-<?php echo $statusClass; ?>">
                                                <?php echo sanitize($subject['grade_status']); ?>
                                            </span>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                                <tfoot>
                                    <tr class="table-summary-row">
                                        <td colspan="3" class="text-right"><strong>Semester Total:</strong></td>
                                        <td class="text-center"><strong class="total-units"><?php echo $group['total_units']; ?> units</strong></td>
                                        <td colspan="3"></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>
        </div>
        
        <?php elseif ($activeTab === 'payments'): ?>
        <!-- ==================== PAYMENTS TAB ==================== -->
        <div class="payments-tab-content">
            <!-- Payment Summary Cards -->
            <div class="payment-overview-cards">
                <div class="payment-overview-card total-fees">
                    <div class="overview-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                    <div class="overview-content">
                        <span class="overview-label">Total Fees</span>
                        <span class="overview-value"><?php echo formatCurrency($paymentSummary['total_due']); ?></span>
                    </div>
                </div>
                <div class="payment-overview-card total-paid">
                    <div class="overview-icon"><i class="fas fa-check-circle"></i></div>
                    <div class="overview-content">
                        <span class="overview-label">Total Paid</span>
                        <span class="overview-value"><?php echo formatCurrency($paymentSummary['total_paid']); ?></span>
                    </div>
                </div>
                <div class="payment-overview-card balance <?php echo $paymentSummary['balance'] > 0 ? 'has-balance' : 'fully-paid'; ?>">
                    <div class="overview-icon"><i class="fas fa-<?php echo $paymentSummary['balance'] > 0 ? 'exclamation-triangle' : 'smile'; ?>"></i></div>
                    <div class="overview-content">
                        <span class="overview-label">Outstanding Balance</span>
                        <span class="overview-value"><?php echo formatCurrency($paymentSummary['balance']); ?></span>
                    </div>
                </div>
            </div>
            
            <!-- Payment Status Summary -->
            <div class="payment-status-bar">
                <div class="status-item">
                    <span class="status-dot paid"></span>
                    <span class="status-count"><?php echo $paymentSummary['paid_count']; ?></span>
                    <span class="status-label">Paid</span>
                </div>
                <div class="status-item">
                    <span class="status-dot partial"></span>
                    <span class="status-count"><?php echo $paymentSummary['partial_count']; ?></span>
                    <span class="status-label">Partial</span>
                </div>
                <div class="status-item">
                    <span class="status-dot unpaid"></span>
                    <span class="status-count"><?php echo $paymentSummary['unpaid_count']; ?></span>
                    <span class="status-label">Unpaid</span>
                </div>
                <div class="status-item">
                    <span class="status-dot overdue"></span>
                    <span class="status-count"><?php echo $paymentSummary['overdue_count']; ?></span>
                    <span class="status-label">Overdue</span>
                </div>
            </div>
            
            <!-- Payment History - Dropdown Selector -->
            <?php 
            $allPayments = getStudentPayments($student['id']);
            
            // Group payments by academic year and semester
            $groupedPayments = [];
            foreach ($allPayments as $payment) {
                $key = $payment['academic_year'] . '|' . $payment['semester'];
                
                // Determine if this is the current semester
                $isCurrent = ($payment['academic_year'] === '2025-2026' && $payment['semester'] === '1st Semester');
                
                if (!isset($groupedPayments[$key])) {
                    $groupedPayments[$key] = [
                        'academic_year' => $payment['academic_year'],
                        'semester' => $payment['semester'],
                        'payments' => [],
                        'total_due' => 0,
                        'total_paid' => 0,
                        'is_current' => $isCurrent
                    ];
                }
                $groupedPayments[$key]['payments'][] = $payment;
                $groupedPayments[$key]['total_due'] += $payment['amount_due'];
                $groupedPayments[$key]['total_paid'] += $payment['amount_paid'];
            }
            
            // Sort by academic year (newest first)
            uksort($groupedPayments, function($a, $b) {
                $yearA = explode('|', $a)[0];
                $yearB = explode('|', $b)[0];
                $semA = str_contains($a, '1st Semester') ? 1 : (str_contains($a, '2nd Semester') ? 2 : 3);
                $semB = str_contains($b, '1st Semester') ? 1 : (str_contains($b, '2nd Semester') ? 2 : 3);
                
                if ($yearA === $yearB) {
                    return $semB - $semA;
                }
                return strcmp($yearB, $yearA);
            });
            
            // Convert to indexed array and find current semester
            $paymentGroups = array_values($groupedPayments);
            $currentPaymentIndex = 0;
            foreach ($paymentGroups as $idx => $grp) {
                if ($grp['is_current']) {
                    $currentPaymentIndex = $idx;
                    break;
                }
            }
            ?>
            
            <?php if (count($allPayments) > 0): ?>
            <div class="panel enrollment-history-panel payment-history-panel">
                <div class="panel-header">
                    <h3><i class="fas fa-history"></i> Payment History</h3>
                    <div class="panel-header-actions">
                        <div class="semester-dropdown-wrapper">
                            <label for="paymentSemesterSelector" class="dropdown-label">Select Term</label>
                            <select id="paymentSemesterSelector" class="semester-selector" onchange="showSelectedPaymentSemester()">
                                <?php foreach ($paymentGroups as $index => $group): ?>
                                <option value="<?php echo $index; ?>" <?php echo ($index === $currentPaymentIndex) ? 'selected' : ''; ?>>
                                    <?php echo $group['semester'] . ' • S.Y. ' . $group['academic_year']; ?>
                                </option>
                                <?php endforeach; ?>
                                <option value="all">Show All Terms</option>
                            </select>
                            <i class="fas fa-chevron-down dropdown-arrow"></i>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <?php foreach ($paymentGroups as $index => $group): 
                        $balance = $group['total_due'] - $group['total_paid'];
                        $isPaid = $balance <= 0;
                        $isVisible = ($index === $currentPaymentIndex);
                    ?>
                    <div class="payment-content" id="payment-semester-<?php echo $index; ?>" style="<?php echo !$isVisible ? 'display: none;' : ''; ?>">
                        <!-- Payment Summary Bar -->
                        <div class="semester-summary-bar payment-summary-bar">
                            <div class="summary-item">
                                <span class="semester-name"><?php echo $group['semester']; ?></span>
                                <span class="academic-year-tag">S.Y. <?php echo $group['academic_year']; ?></span>
                                <?php if ($group['is_current']): ?>
                                <span class="current-badge">Current</span>
                                <?php endif; ?>
                            </div>
                            <div class="summary-stats">
                                <span class="stat-item"><i class="fas fa-receipt"></i> <?php echo count($group['payments']); ?> fees</span>
                                <span class="stat-item"><i class="fas fa-peso-sign"></i> <?php echo formatCurrency($group['total_due']); ?></span>
                                <span class="payment-status-indicator <?php echo $isPaid ? 'status-fully-paid' : 'status-has-balance'; ?>">
                                    <?php if ($isPaid): ?>
                                        <i class="fas fa-check-circle"></i> Fully Paid
                                    <?php else: ?>
                                        <i class="fas fa-exclamation-circle"></i> Balance: <?php echo formatCurrency($balance); ?>
                                    <?php endif; ?>
                                </span>
                            </div>
                        </div>
                        
                        <!-- Payments Table -->
                        <div class="table-container">
                            <table class="data-table grades-table payment-table">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">#</th>
                                        <th>Fee Type</th>
                                        <th>Description</th>
                                        <th class="text-right" style="width: 110px;">Amount Due</th>
                                        <th class="text-right" style="width: 110px;">Amount Paid</th>
                                        <th style="width: 100px;">Date</th>
                                        <th style="width: 90px;">Method</th>
                                        <th style="width: 80px;" class="text-center">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $num = 1; foreach ($group['payments'] as $payment): ?>
                                    <tr>
                                        <td class="text-center"><?php echo $num++; ?></td>
                                        <td><strong><?php echo sanitize($payment['payment_type_name'] ?? 'Other'); ?></strong></td>
                                        <td><span class="payment-desc"><?php echo sanitize($payment['description'] ?? '—'); ?></span></td>
                                        <td class="text-right"><?php echo formatCurrency($payment['amount_due']); ?></td>
                                        <td class="text-right text-success"><strong><?php echo formatCurrency($payment['amount_paid']); ?></strong></td>
                                        <td>
                                            <?php if ($payment['payment_date']): ?>
                                                <span class="payment-date"><?php echo date('M d, Y', strtotime($payment['payment_date'])); ?></span>
                                            <?php else: ?>
                                                <span class="text-muted">—</span>
                                            <?php endif; ?>
                                        </td>
                                        <td>
                                            <?php if ($payment['payment_method']): ?>
                                                <span class="payment-method-badge"><?php echo sanitize($payment['payment_method']); ?></span>
                                            <?php else: ?>
                                                <span class="text-muted">—</span>
                                            <?php endif; ?>
                                        </td>
                                        <td class="text-center">
                                            <?php 
                                            $statusClass = 'pending';
                                            switch ($payment['payment_status']) {
                                                case 'Paid': $statusClass = 'active'; break;
                                                case 'Partial': $statusClass = 'pending'; break;
                                                case 'Unpaid': $statusClass = 'dropped'; break;
                                                case 'Overdue': $statusClass = 'dropped'; break;
                                            }
                                            ?>
                                            <span class="status-badge status-<?php echo $statusClass; ?>">
                                                <?php echo sanitize($payment['payment_status']); ?>
                                            </span>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                                <tfoot>
                                    <tr class="table-summary-row">
                                        <td colspan="3" class="text-right"><strong>Term Total:</strong></td>
                                        <td class="text-right"><strong><?php echo formatCurrency($group['total_due']); ?></strong></td>
                                        <td class="text-right text-success"><strong><?php echo formatCurrency($group['total_paid']); ?></strong></td>
                                        <td colspan="3"></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php else: ?>
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-receipt"></i> Payment History</h3>
                </div>
                <div class="panel-body">
                    <div class="empty-state-small">
                        <i class="fas fa-receipt"></i>
                        <p>No payment records found.</p>
                    </div>
                </div>
            </div>
            <?php endif; ?>
        </div>
        
        <?php endif; ?>
    </div>

<?php elseif ($action === 'add'): ?>
    <!-- ============================================
         ADD STUDENT FORM
         Comprehensive student registration form
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-user-plus"></i> Add New Student</h1>
            <p class="page-subtitle">Create a new student profile</p>
        </div>
        <div class="page-actions">
            <a href="students.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <form method="POST" action="students.php?action=add" class="sis-form">
        <!-- Personal Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-user"></i> Personal Information</h3>
            </div>
            <div class="panel-body">
                <div class="form-row form-row-4">
                    <div class="form-group">
                        <label for="first_name">First Name <span class="required">*</span></label>
                        <input type="text" id="first_name" name="first_name" class="form-control" 
                               placeholder="Juan" required>
                    </div>
                    <div class="form-group">
                        <label for="middle_name">Middle Name</label>
                        <input type="text" id="middle_name" name="middle_name" class="form-control" 
                               placeholder="Santos">
                    </div>
                    <div class="form-group">
                        <label for="last_name">Last Name <span class="required">*</span></label>
                        <input type="text" id="last_name" name="last_name" class="form-control" 
                               placeholder="Dela Cruz" required>
                    </div>
                    <div class="form-group">
                        <label for="suffix">Suffix</label>
                        <select id="suffix" name="suffix" class="form-control">
                            <option value="">None</option>
                            <option value="Jr.">Jr.</option>
                            <option value="Sr.">Sr.</option>
                            <option value="II">II</option>
                            <option value="III">III</option>
                            <option value="IV">IV</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row form-row-4">
                    <div class="form-group">
                        <label for="sex">Sex <span class="required">*</span></label>
                        <select id="sex" name="sex" class="form-control" required>
                            <option value="">Select Sex</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="date_of_birth">Date of Birth <span class="required">*</span></label>
                        <input type="date" id="date_of_birth" name="date_of_birth" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="place_of_birth">Place of Birth</label>
                        <input type="text" id="place_of_birth" name="place_of_birth" class="form-control" 
                               placeholder="City, Province">
                    </div>
                    <div class="form-group">
                        <label for="civil_status">Civil Status</label>
                        <select id="civil_status" name="civil_status" class="form-control">
                            <option value="Single">Single</option>
                            <option value="Married">Married</option>
                            <option value="Widowed">Widowed</option>
                            <option value="Separated">Separated</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="nationality">Nationality</label>
                        <input type="text" id="nationality" name="nationality" class="form-control" 
                               value="Filipino" placeholder="Filipino">
                    </div>
                    <div class="form-group">
                        <label for="religion">Religion</label>
                        <input type="text" id="religion" name="religion" class="form-control" 
                               placeholder="Roman Catholic">
                    </div>
                    <div class="form-group">
                        <label for="blood_type">Blood Type</label>
                        <select id="blood_type" name="blood_type" class="form-control">
                            <option value="Unknown">Unknown</option>
                            <option value="A+">A+</option>
                            <option value="A-">A-</option>
                            <option value="B+">B+</option>
                            <option value="B-">B-</option>
                            <option value="AB+">AB+</option>
                            <option value="AB-">AB-</option>
                            <option value="O+">O+</option>
                            <option value="O-">O-</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Contact Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-address-book"></i> Contact Information</h3>
            </div>
            <div class="panel-body">
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email Address <span class="required">*</span></label>
                        <input type="email" id="email" name="email" class="form-control" 
                               placeholder="student@email.com" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               placeholder="+63 917 123 4567">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address_street">Street Address</label>
                    <input type="text" id="address_street" name="address_street" class="form-control" 
                           placeholder="123 Rizal Street">
                </div>
                
                <div class="form-row form-row-4">
                    <div class="form-group">
                        <label for="address_barangay">Barangay</label>
                        <input type="text" id="address_barangay" name="address_barangay" class="form-control" 
                               placeholder="Barangay San Jose">
                    </div>
                    <div class="form-group">
                        <label for="address_city">City/Municipality</label>
                        <input type="text" id="address_city" name="address_city" class="form-control" 
                               placeholder="Quezon City">
                    </div>
                    <div class="form-group">
                        <label for="address_province">Province</label>
                        <input type="text" id="address_province" name="address_province" class="form-control" 
                               placeholder="Metro Manila">
                    </div>
                    <div class="form-group">
                        <label for="address_zip">ZIP Code</label>
                        <input type="text" id="address_zip" name="address_zip" class="form-control" 
                               placeholder="1100">
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Guardian Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-users"></i> Guardian / Emergency Contact</h3>
            </div>
            <div class="panel-body">
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="guardian_name">Guardian Name</label>
                        <input type="text" id="guardian_name" name="guardian_name" class="form-control" 
                               placeholder="Parent/Guardian Full Name">
                    </div>
                    <div class="form-group">
                        <label for="guardian_relationship">Relationship</label>
                        <select id="guardian_relationship" name="guardian_relationship" class="form-control">
                            <option value="">Select Relationship</option>
                            <option value="Father">Father</option>
                            <option value="Mother">Mother</option>
                            <option value="Guardian">Guardian</option>
                            <option value="Spouse">Spouse</option>
                            <option value="Sibling">Sibling</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="guardian_contact">Guardian Contact</label>
                        <input type="tel" id="guardian_contact" name="guardian_contact" class="form-control" 
                               placeholder="+63 917 123 4567">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="guardian_address">Guardian Address</label>
                    <input type="text" id="guardian_address" name="guardian_address" class="form-control" 
                           placeholder="Complete address if different from student">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="emergency_contact_name">Emergency Contact Name</label>
                        <input type="text" id="emergency_contact_name" name="emergency_contact_name" class="form-control" 
                               placeholder="Emergency contact person">
                    </div>
                    <div class="form-group">
                        <label for="emergency_contact_phone">Emergency Contact Phone</label>
                        <input type="tel" id="emergency_contact_phone" name="emergency_contact_phone" class="form-control" 
                               placeholder="+63 917 123 4567">
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Academic Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-graduation-cap"></i> Academic Information</h3>
            </div>
            <div class="panel-body">
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="program">Program</label>
                        <select id="program" name="program" class="form-control">
                            <option value="">Select Program</option>
                            <?php if (!empty($programs)): ?>
                                <?php foreach ($programs as $prog): ?>
                                    <option value="<?php echo sanitize($prog['program_name']); ?>">
                                        <?php echo sanitize($prog['program_code'] . ' - ' . $prog['program_name']); ?>
                                    </option>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <option value="Bachelor of Science in Information Technology">BSIT - Information Technology</option>
                                <option value="Bachelor of Science in Computer Science">BSCS - Computer Science</option>
                                <option value="Bachelor of Science in Information Systems">BSIS - Information Systems</option>
                            <?php endif; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="year_level">Year Level</label>
                        <select id="year_level" name="year_level" class="form-control">
                            <option value="1st Year">1st Year</option>
                            <option value="2nd Year">2nd Year</option>
                            <option value="3rd Year">3rd Year</option>
                            <option value="4th Year">4th Year</option>
                            <option value="5th Year">5th Year</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="semester">Semester</label>
                        <select id="semester" name="semester" class="form-control">
                            <option value="1st Semester">1st Semester</option>
                            <option value="2nd Semester">2nd Semester</option>
                            <option value="Summer">Summer</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="section">Section</label>
                        <input type="text" id="section" name="section" class="form-control" 
                               placeholder="A, B, C...">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="admission_date">Admission Date</label>
                        <input type="date" id="admission_date" name="admission_date" class="form-control" 
                               value="<?php echo date('Y-m-d'); ?>">
                    </div>
                    <div class="form-group">
                        <label for="student_status">Student Status</label>
                        <select id="student_status" name="student_status" class="form-control">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                            <option value="On Leave">On Leave</option>
                            <option value="Graduated">Graduated</option>
                            <option value="Dropped">Dropped</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Form Actions -->
        <div class="form-actions-bar">
            <button type="submit" class="btn btn-primary btn-lg"><i class="fas fa-save"></i> Save Student</button>
            <a href="students.php" class="btn btn-secondary btn-lg">Cancel</a>
        </div>
    </form>

<?php elseif ($action === 'edit' && isset($student)): ?>
    <!-- ============================================
         EDIT STUDENT FORM
         Update existing student profile
         ============================================ -->
    
    <div class="page-header">
        <div>
            <h1><i class="fas fa-user-edit"></i> Edit Student</h1>
            <p class="page-subtitle"><?php echo sanitize($student['student_id'] ?? 'Update student information'); ?></p>
        </div>
        <div class="page-actions">
            <a href="students.php?action=view&id=<?php echo $student['id']; ?>" class="btn btn-outline"><i class="fas fa-eye"></i> View Profile</a>
            <a href="students.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
    </div>
    
    <form method="POST" action="students.php?action=edit&id=<?php echo $student['id']; ?>" class="sis-form">
        <!-- Personal Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-user"></i> Personal Information</h3>
            </div>
            <div class="panel-body">
                <div class="form-row form-row-4">
                    <div class="form-group">
                        <label for="first_name">First Name <span class="required">*</span></label>
                        <input type="text" id="first_name" name="first_name" class="form-control" 
                               value="<?php echo sanitize($student['first_name']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="middle_name">Middle Name</label>
                        <input type="text" id="middle_name" name="middle_name" class="form-control" 
                               value="<?php echo sanitize($student['middle_name'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="last_name">Last Name <span class="required">*</span></label>
                        <input type="text" id="last_name" name="last_name" class="form-control" 
                               value="<?php echo sanitize($student['last_name']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="suffix">Suffix</label>
                        <select id="suffix" name="suffix" class="form-control">
                            <option value="">None</option>
                            <option value="Jr." <?php echo ($student['suffix'] ?? '') === 'Jr.' ? 'selected' : ''; ?>>Jr.</option>
                            <option value="Sr." <?php echo ($student['suffix'] ?? '') === 'Sr.' ? 'selected' : ''; ?>>Sr.</option>
                            <option value="II" <?php echo ($student['suffix'] ?? '') === 'II' ? 'selected' : ''; ?>>II</option>
                            <option value="III" <?php echo ($student['suffix'] ?? '') === 'III' ? 'selected' : ''; ?>>III</option>
                            <option value="IV" <?php echo ($student['suffix'] ?? '') === 'IV' ? 'selected' : ''; ?>>IV</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row form-row-4">
                    <div class="form-group">
                        <label for="sex">Sex <span class="required">*</span></label>
                        <select id="sex" name="sex" class="form-control" required>
                            <option value="">Select Sex</option>
                            <option value="Male" <?php echo ($student['sex'] ?? '') === 'Male' ? 'selected' : ''; ?>>Male</option>
                            <option value="Female" <?php echo ($student['sex'] ?? '') === 'Female' ? 'selected' : ''; ?>>Female</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="date_of_birth">Date of Birth <span class="required">*</span></label>
                        <input type="date" id="date_of_birth" name="date_of_birth" class="form-control" 
                               value="<?php echo $student['date_of_birth'] ?? ''; ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="place_of_birth">Place of Birth</label>
                        <input type="text" id="place_of_birth" name="place_of_birth" class="form-control" 
                               value="<?php echo sanitize($student['place_of_birth'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="civil_status">Civil Status</label>
                        <select id="civil_status" name="civil_status" class="form-control">
                            <option value="Single" <?php echo ($student['civil_status'] ?? '') === 'Single' ? 'selected' : ''; ?>>Single</option>
                            <option value="Married" <?php echo ($student['civil_status'] ?? '') === 'Married' ? 'selected' : ''; ?>>Married</option>
                            <option value="Widowed" <?php echo ($student['civil_status'] ?? '') === 'Widowed' ? 'selected' : ''; ?>>Widowed</option>
                            <option value="Separated" <?php echo ($student['civil_status'] ?? '') === 'Separated' ? 'selected' : ''; ?>>Separated</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="nationality">Nationality</label>
                        <input type="text" id="nationality" name="nationality" class="form-control" 
                               value="<?php echo sanitize($student['nationality'] ?? 'Filipino'); ?>">
                    </div>
                    <div class="form-group">
                        <label for="religion">Religion</label>
                        <input type="text" id="religion" name="religion" class="form-control" 
                               value="<?php echo sanitize($student['religion'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="blood_type">Blood Type</label>
                        <select id="blood_type" name="blood_type" class="form-control">
                            <option value="Unknown" <?php echo ($student['blood_type'] ?? '') === 'Unknown' ? 'selected' : ''; ?>>Unknown</option>
                            <option value="A+" <?php echo ($student['blood_type'] ?? '') === 'A+' ? 'selected' : ''; ?>>A+</option>
                            <option value="A-" <?php echo ($student['blood_type'] ?? '') === 'A-' ? 'selected' : ''; ?>>A-</option>
                            <option value="B+" <?php echo ($student['blood_type'] ?? '') === 'B+' ? 'selected' : ''; ?>>B+</option>
                            <option value="B-" <?php echo ($student['blood_type'] ?? '') === 'B-' ? 'selected' : ''; ?>>B-</option>
                            <option value="AB+" <?php echo ($student['blood_type'] ?? '') === 'AB+' ? 'selected' : ''; ?>>AB+</option>
                            <option value="AB-" <?php echo ($student['blood_type'] ?? '') === 'AB-' ? 'selected' : ''; ?>>AB-</option>
                            <option value="O+" <?php echo ($student['blood_type'] ?? '') === 'O+' ? 'selected' : ''; ?>>O+</option>
                            <option value="O-" <?php echo ($student['blood_type'] ?? '') === 'O-' ? 'selected' : ''; ?>>O-</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Contact Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-address-book"></i> Contact Information</h3>
            </div>
            <div class="panel-body">
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email Address <span class="required">*</span></label>
                        <input type="email" id="email" name="email" class="form-control" 
                               value="<?php echo sanitize($student['email']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               value="<?php echo sanitize($student['phone'] ?? ''); ?>">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address_street">Street Address</label>
                    <input type="text" id="address_street" name="address_street" class="form-control" 
                           value="<?php echo sanitize($student['address_street'] ?? ''); ?>">
                </div>
                
                <div class="form-row form-row-4">
                    <div class="form-group">
                        <label for="address_barangay">Barangay</label>
                        <input type="text" id="address_barangay" name="address_barangay" class="form-control" 
                               value="<?php echo sanitize($student['address_barangay'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="address_city">City/Municipality</label>
                        <input type="text" id="address_city" name="address_city" class="form-control" 
                               value="<?php echo sanitize($student['address_city'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="address_province">Province</label>
                        <input type="text" id="address_province" name="address_province" class="form-control" 
                               value="<?php echo sanitize($student['address_province'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="address_zip">ZIP Code</label>
                        <input type="text" id="address_zip" name="address_zip" class="form-control" 
                               value="<?php echo sanitize($student['address_zip'] ?? ''); ?>">
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Guardian Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-users"></i> Guardian / Emergency Contact</h3>
            </div>
            <div class="panel-body">
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="guardian_name">Guardian Name</label>
                        <input type="text" id="guardian_name" name="guardian_name" class="form-control" 
                               value="<?php echo sanitize($student['guardian_name'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="guardian_relationship">Relationship</label>
                        <select id="guardian_relationship" name="guardian_relationship" class="form-control">
                            <option value="">Select Relationship</option>
                            <option value="Father" <?php echo ($student['guardian_relationship'] ?? '') === 'Father' ? 'selected' : ''; ?>>Father</option>
                            <option value="Mother" <?php echo ($student['guardian_relationship'] ?? '') === 'Mother' ? 'selected' : ''; ?>>Mother</option>
                            <option value="Guardian" <?php echo ($student['guardian_relationship'] ?? '') === 'Guardian' ? 'selected' : ''; ?>>Guardian</option>
                            <option value="Spouse" <?php echo ($student['guardian_relationship'] ?? '') === 'Spouse' ? 'selected' : ''; ?>>Spouse</option>
                            <option value="Sibling" <?php echo ($student['guardian_relationship'] ?? '') === 'Sibling' ? 'selected' : ''; ?>>Sibling</option>
                            <option value="Other" <?php echo ($student['guardian_relationship'] ?? '') === 'Other' ? 'selected' : ''; ?>>Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="guardian_contact">Guardian Contact</label>
                        <input type="tel" id="guardian_contact" name="guardian_contact" class="form-control" 
                               value="<?php echo sanitize($student['guardian_contact'] ?? ''); ?>">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="guardian_address">Guardian Address</label>
                    <input type="text" id="guardian_address" name="guardian_address" class="form-control" 
                           value="<?php echo sanitize($student['guardian_address'] ?? ''); ?>">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="emergency_contact_name">Emergency Contact Name</label>
                        <input type="text" id="emergency_contact_name" name="emergency_contact_name" class="form-control" 
                               value="<?php echo sanitize($student['emergency_contact_name'] ?? ''); ?>">
                    </div>
                    <div class="form-group">
                        <label for="emergency_contact_phone">Emergency Contact Phone</label>
                        <input type="tel" id="emergency_contact_phone" name="emergency_contact_phone" class="form-control" 
                               value="<?php echo sanitize($student['emergency_contact_phone'] ?? ''); ?>">
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Academic Information Section -->
        <div class="panel">
            <div class="panel-header">
                <h3><i class="fas fa-graduation-cap"></i> Academic Information</h3>
            </div>
            <div class="panel-body">
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="program">Program</label>
                        <select id="program" name="program" class="form-control">
                            <option value="">Select Program</option>
                            <?php if (!empty($programs)): ?>
                                <?php foreach ($programs as $prog): ?>
                                    <option value="<?php echo sanitize($prog['program_name']); ?>"
                                            <?php echo ($student['program'] ?? '') === $prog['program_name'] ? 'selected' : ''; ?>>
                                        <?php echo sanitize($prog['program_code'] . ' - ' . $prog['program_name']); ?>
                                    </option>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <option value="Bachelor of Science in Information Technology" <?php echo ($student['program'] ?? '') === 'Bachelor of Science in Information Technology' ? 'selected' : ''; ?>>BSIT - Information Technology</option>
                                <option value="Bachelor of Science in Computer Science" <?php echo ($student['program'] ?? '') === 'Bachelor of Science in Computer Science' ? 'selected' : ''; ?>>BSCS - Computer Science</option>
                            <?php endif; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="year_level">Year Level</label>
                        <select id="year_level" name="year_level" class="form-control">
                            <option value="1st Year" <?php echo ($student['year_level'] ?? '') === '1st Year' ? 'selected' : ''; ?>>1st Year</option>
                            <option value="2nd Year" <?php echo ($student['year_level'] ?? '') === '2nd Year' ? 'selected' : ''; ?>>2nd Year</option>
                            <option value="3rd Year" <?php echo ($student['year_level'] ?? '') === '3rd Year' ? 'selected' : ''; ?>>3rd Year</option>
                            <option value="4th Year" <?php echo ($student['year_level'] ?? '') === '4th Year' ? 'selected' : ''; ?>>4th Year</option>
                            <option value="5th Year" <?php echo ($student['year_level'] ?? '') === '5th Year' ? 'selected' : ''; ?>>5th Year</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="semester">Semester</label>
                        <select id="semester" name="semester" class="form-control">
                            <option value="1st Semester" <?php echo ($student['semester'] ?? '') === '1st Semester' ? 'selected' : ''; ?>>1st Semester</option>
                            <option value="2nd Semester" <?php echo ($student['semester'] ?? '') === '2nd Semester' ? 'selected' : ''; ?>>2nd Semester</option>
                            <option value="Summer" <?php echo ($student['semester'] ?? '') === 'Summer' ? 'selected' : ''; ?>>Summer</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row form-row-3">
                    <div class="form-group">
                        <label for="section">Section</label>
                        <input type="text" id="section" name="section" class="form-control" 
                               value="<?php echo sanitize($student['section'] ?? ''); ?>">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="admission_date">Admission Date</label>
                        <input type="date" id="admission_date" name="admission_date" class="form-control" 
                               value="<?php echo $student['admission_date'] ?? ''; ?>">
                    </div>
                    <div class="form-group">
                        <label for="student_status">Student Status</label>
                        <select id="student_status" name="student_status" class="form-control">
                            <option value="Active" <?php echo ($student['student_status'] ?? '') === 'Active' ? 'selected' : ''; ?>>Active</option>
                            <option value="Inactive" <?php echo ($student['student_status'] ?? '') === 'Inactive' ? 'selected' : ''; ?>>Inactive</option>
                            <option value="On Leave" <?php echo ($student['student_status'] ?? '') === 'On Leave' ? 'selected' : ''; ?>>On Leave</option>
                            <option value="Graduated" <?php echo ($student['student_status'] ?? '') === 'Graduated' ? 'selected' : ''; ?>>Graduated</option>
                            <option value="Dropped" <?php echo ($student['student_status'] ?? '') === 'Dropped' ? 'selected' : ''; ?>>Dropped</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Form Actions -->
        <div class="form-actions-bar">
            <button type="submit" class="btn btn-primary btn-lg"><i class="fas fa-save"></i> Update Student</button>
            <a href="students.php" class="btn btn-secondary btn-lg">Cancel</a>
        </div>
    </form>

<?php endif; ?>

    </div>
</main>
</div>
<script src="../assets/js/script.js"></script>
</body>
</html>
