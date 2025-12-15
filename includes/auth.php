<?php
/**
 * Authentication Check
 * 
 * Include this file at the top of protected pages.
 * Redirects to login if not authenticated.
 */

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Check if user is logged in
if (!isset($_SESSION['user_logged_in']) || $_SESSION['user_logged_in'] !== true) {
    header('Location: ' . ($basePath ?? '') . 'login.php');
    exit;
}

/**
 * Get the current logged-in user's display name
 */
function getCurrentUser() {
    return $_SESSION['full_name'] ?? $_SESSION['username'] ?? 'User';
}

/**
 * Get the current user's ID
 */
function getCurrentUserId() {
    return $_SESSION['user_id'] ?? null;
}

/**
 * Get the current user's role
 */
function getCurrentUserRole() {
    return $_SESSION['user_role'] ?? 'viewer';
}

/**
 * Check if user is logged in
 */
function isLoggedIn() {
    return isset($_SESSION['user_logged_in']) && $_SESSION['user_logged_in'] === true;
}

/**
 * Check if current user is admin
 */
function isAdmin() {
    return getCurrentUserRole() === 'admin';
}
