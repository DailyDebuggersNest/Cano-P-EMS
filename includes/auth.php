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
 * Get the current logged-in username
 */
function getCurrentUser() {
    return $_SESSION['username'] ?? 'User';
}

/**
 * Check if user is logged in
 */
function isLoggedIn() {
    return isset($_SESSION['user_logged_in']) && $_SESSION['user_logged_in'] === true;
}
