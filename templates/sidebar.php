<?php
/**
 * Sidebar Navigation - Desktop Application Style
 * 
 * Collapsible sidebar with smooth animations.
 * Toggle button to expand/collapse sidebar.
 */

// Figure out which page we're on so we can highlight it
$currentPage = basename($_SERVER['PHP_SELF']);
?>

<!-- Sidebar Navigation -->
<aside class="sidebar" id="sidebar">
    <!-- Toggle Button -->
    <div class="sidebar-toggle-wrapper">
        <button class="sidebar-toggle" id="sidebarToggle" title="Toggle Sidebar">
            <i class="fas fa-bars"></i>
        </button>
    </div>
    
    <!-- Navigation Menu -->
    <nav class="nav-menu">
        <ul>
            <li>
                <a href="<?php echo $basePath ?? ''; ?>index.php" 
                   class="nav-item <?php echo $currentPage === 'index.php' ? 'active' : ''; ?>">
                    <i class="fas fa-th-large"></i>
                    <span class="nav-text">Dashboard</span>
                    <span class="tooltip">Dashboard</span>
                </a>
            </li>
            <li>
                <a href="<?php echo $basePath ?? ''; ?>pages/enrollments.php" 
                   class="nav-item <?php echo $currentPage === 'enrollments.php' ? 'active' : ''; ?>">
                    <i class="fas fa-file-alt"></i>
                    <span class="nav-text">Applications</span>
                    <span class="tooltip">Applications</span>
                </a>
            </li>
            <li>
                <a href="<?php echo $basePath ?? ''; ?>pages/students.php" 
                   class="nav-item <?php echo $currentPage === 'students.php' ? 'active' : ''; ?>">
                    <i class="fas fa-users"></i>
                    <span class="nav-text">Students</span>
                    <span class="tooltip">Students</span>
                </a>
            </li>
            <li>
                <a href="<?php echo $basePath ?? ''; ?>pages/courses.php" 
                   class="nav-item <?php echo $currentPage === 'courses.php' ? 'active' : ''; ?>">
                    <i class="fas fa-graduation-cap"></i>
                    <span class="nav-text">Courses</span>
                    <span class="tooltip">Courses</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item disabled">
                    <i class="fas fa-chart-pie"></i>
                    <span class="nav-text">Reports</span>
                    <span class="tooltip">Coming Soon</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>

<!-- Main Content Panel -->
<main class="main-panel">
    <!-- Top Header Bar -->
    <header class="main-header">
        <h1 class="app-title">EMS Pro</h1>
        <div class="header-right">
            <div class="user-profile" id="userProfile">
                <img src="https://ui-avatars.com/api/?name=<?php echo urlencode(getCurrentUser()); ?>&background=0078d4&color=fff&size=40" alt="Profile" class="profile-avatar" id="profileAvatar">
                <div class="profile-dropdown" id="profileDropdown">
                    <div class="dropdown-header">
                        <span class="dropdown-name"><?php echo htmlspecialchars(getCurrentUser()); ?></span>
                        <span class="dropdown-role">Administrator</span>
                    </div>
                    <div class="dropdown-divider"></div>
                    <a href="<?php echo $basePath ?? ''; ?>logout.php" class="dropdown-item logout-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>
        </div>
    </header>
    
    <?php
    // Show flash message if there is one
    $flash = getFlashMessage();
    if ($flash): 
        $iconClass = 'fa-info-circle';
        if ($flash['type'] === 'success') $iconClass = 'fa-check-circle';
        if ($flash['type'] === 'error') $iconClass = 'fa-exclamation-circle';
        if ($flash['type'] === 'warning') $iconClass = 'fa-exclamation-triangle';
    ?>
    <!-- Content Area with alerts -->
    <div class="content-area">
        <div class="alert alert-<?php echo $flash['type']; ?>" onclick="this.remove()">
            <span><i class="fas <?php echo $iconClass; ?>"></i> <?php echo sanitize($flash['message']); ?></span>
            <span class="alert-close"><i class="fas fa-times"></i></span>
        </div>
    <?php else: ?>
    <div class="content-area">
    <?php endif; ?>
