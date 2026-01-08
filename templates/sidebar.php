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
    <!-- Sidebar Header with Logo and Toggle -->
    <div class="sidebar-header">
        <div class="sidebar-brand">
            <i class="fas fa-graduation-cap brand-icon"></i>
            <span class="brand-text">EMS Pro</span>
        </div>
        <button class="sidebar-toggle" id="sidebarToggle" title="Toggle Sidebar">
            <i class="fas fa-chevron-left"></i>
        </button>
    </div>
    
    <!-- Navigation Menu -->
    <nav class="nav-menu">
        <ul>
            <li>
                <a href="<?php echo $basePath ?? ''; ?>pages/students.php" 
                   class="nav-item <?php echo $currentPage === 'students.php' ? 'active' : ''; ?>">
                    <i class="fas fa-users"></i>
                    <span class="nav-text">Students</span>
                    <span class="tooltip">Students</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>

<!-- Main Content Panel -->
<main class="main-panel">
    <!-- Top Header Bar -->
    <header class="main-header">
        <!-- Global Search -->
        <div class="header-search">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search students, programs..." id="globalSearch">
            <kbd>Ctrl+K</kbd>
        </div>
        
        <div class="header-right">
            <!-- Notification Bell -->
            <div class="header-icon-btn" id="notificationBtn" title="Notifications">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">3</span>
            </div>
            
            <!-- User Profile -->
            <div class="user-profile" id="userProfile">
                <div class="profile-trigger" id="profileAvatar">
                    <div class="profile-avatar-icon">
                        <?php 
                        $userName = getCurrentUser();
                        $userRole = ucfirst($_SESSION['user_role'] ?? 'User');
                        $initials = '';
                        $nameParts = explode(' ', $userName);
                        foreach ($nameParts as $part) {
                            $initials .= strtoupper(substr($part, 0, 1));
                        }
                        $initials = substr($initials, 0, 2);
                        ?>
                        <span><?php echo $initials ?: 'AD'; ?></span>
                    </div>
                    <div class="profile-info">
                        <span class="profile-name"><?php echo htmlspecialchars($userName); ?></span>
                        <span class="profile-role"><?php echo htmlspecialchars($userRole); ?></span>
                    </div>
                    <i class="fas fa-chevron-down profile-arrow"></i>
                </div>
                <div class="profile-dropdown" id="profileDropdown">
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-user"></i>
                        <span>My Profile</span>
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
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
