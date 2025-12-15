<?php
/**
 * Index Page - Redirect to Students
 * 
 * Main entry point - redirects to the Students page
 */

// Load our helper functions (this also loads the database connection)
require_once __DIR__ . '/includes/functions.php';

// Redirect to students page
header('Location: pages/students.php');
exit;
