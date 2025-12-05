<?php
/**
 * Dashboard / Home Page
 * 
 * Welcome to the EMS! This is the main landing page.
 * It shows some quick stats and recent activity.
 */

// Load our helper functions (this also loads the database connection)
require_once __DIR__ . '/includes/functions.php';

// Set the page title (used in header.php)
$pageTitle = 'Dashboard';

// Grab some stats for the dashboard
$stats = getDashboardStats();

// Get recent students (last 5)
$recentStudents = getAllStudents();
$recentStudents = array_slice($recentStudents, 0, 5);

// Get recent courses (last 5)  
$recentCourses = getAllCourses();
$recentCourses = array_slice($recentCourses, 0, 5);

// Include the header and sidebar
include __DIR__ . '/templates/header.php';
include __DIR__ . '/templates/sidebar.php';
?>

<!-- Dashboard Content -->
<div class="page-header">
    <div>
        <h1><i class="fas fa-th-large"></i> Dashboard</h1>
        <p class="page-subtitle">System overview and quick actions</p>
    </div>
</div>

<!-- Stats Cards -->
<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon students">
            <i class="fas fa-users"></i>
        </div>
        <div class="stat-info">
            <div class="stat-number"><?php echo $stats['students']; ?></div>
            <div class="stat-label">Total Students</div>
        </div>
    </div>
    
    <div class="stat-card">
        <div class="stat-icon courses">
            <i class="fas fa-book"></i>
        </div>
        <div class="stat-info">
            <div class="stat-number"><?php echo $stats['courses']; ?></div>
            <div class="stat-label">Total Courses</div>
        </div>
    </div>
    
    <div class="stat-card">
        <div class="stat-icon enrollments">
            <i class="fas fa-clipboard-check"></i>
        </div>
        <div class="stat-info">
            <div class="stat-number"><?php echo $stats['active_enrollments']; ?></div>
            <div class="stat-label">Active Enrollments</div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="card">
    <div class="card-header">
        <h2><i class="fas fa-bolt"></i> Quick Actions</h2>
    </div>
    <div class="quick-actions">
        <a href="pages/students.php?action=add" class="btn btn-primary">
            <i class="fas fa-user-plus"></i> Add New Student
        </a>
        <a href="pages/courses.php?action=add" class="btn btn-primary">
            <i class="fas fa-plus-circle"></i> Add New Course
        </a>
        <a href="pages/enrollments.php?action=add" class="btn btn-success">
            <i class="fas fa-user-graduate"></i> Create Enrollment
        </a>
    </div>
</div>

<!-- Recent Students -->
<div class="card">
    <div class="card-header">
        <h2><i class="fas fa-users"></i> Recent Students</h2>
        <a href="pages/students.php" class="btn btn-outline btn-sm">
            View All <i class="fas fa-arrow-right"></i>
        </a>
    </div>
    
    <?php if (empty($recentStudents)): ?>
        <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-users"></i>
            </div>
            <h3>No students yet</h3>
            <p>Get started by adding your first student.</p>
        </div>
    <?php else: ?>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($recentStudents as $student): ?>
                        <tr>
                            <td>
                                <div class="user-info">
                                    <div class="user-avatar">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <span><?php echo sanitize($student['first_name'] . ' ' . $student['last_name']); ?></span>
                                </div>
                            </td>
                            <td><?php echo sanitize($student['email']); ?></td>
                            <td><?php echo sanitize($student['phone'] ?? 'N/A'); ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>
</div>

<!-- Recent Courses -->
<div class="card">
    <div class="card-header">
        <h2><i class="fas fa-book"></i> Recent Courses</h2>
        <a href="pages/courses.php" class="btn btn-outline btn-sm">
            View All <i class="fas fa-arrow-right"></i>
        </a>
    </div>
    
    <?php if (empty($recentCourses)): ?>
        <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-book"></i>
            </div>
            <h3>No courses yet</h3>
            <p>Get started by adding your first course.</p>
        </div>
    <?php else: ?>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Credits</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($recentCourses as $course): ?>
                        <tr>
                            <td><span class="course-code"><?php echo sanitize($course['course_code']); ?></span></td>
                            <td><?php echo sanitize($course['course_name']); ?></td>
                            <td><span class="badge badge-info"><?php echo sanitize($course['credits']); ?> Credits</span></td></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>
</div>

    </div>
</main>
</div>
<script src="assets/js/script.js"></script>
</body>
</html>
