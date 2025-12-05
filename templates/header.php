<?php
/**
 * Header Template - Desktop Application Style
 * 
 * Creates a desktop software-like interface with sidebar navigation.
 * Include this at the start of each page!
 */

// Start session for flash messages
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Check authentication
require_once __DIR__ . '/../includes/auth.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo isset($pageTitle) ? sanitize($pageTitle) . ' - ' : ''; ?>EMS Pro</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="<?php echo $basePath ?? ''; ?>favicon.svg">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Our custom CSS - Desktop App Style -->
    <link rel="stylesheet" href="<?php echo $basePath ?? ''; ?>assets/css/style.css">
</head>
<body>
    <!-- Application Container - Desktop Layout -->
    <div class="app-container">
