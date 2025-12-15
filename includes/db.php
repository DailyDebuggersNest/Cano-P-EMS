<?php
/**
 * Database Connection File
 * 
 * Hey! This file handles connecting to our MySQL database.
 * Just update the credentials below if yours are different.
 * 
 * Most XAMPP installations use:
 * - Host: localhost
 * - Username: root
 * - Password: (empty)
 */

// Database credentials - change these if needed!
define('DB_HOST', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');  // Default XAMPP has no password
define('DB_NAME', 'ems_O6');

/**
 * Get a database connection
 * 
 * This function creates and returns a PDO connection.
 * We use PDO because it's secure and easy to work with!
 * 
 * @return PDO The database connection object
 */
function getDBConnection() {
    try {
        // Create the DSN (Data Source Name) - it's like the address of our database
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
        
        // Some options to make PDO work nicely
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,  // Throw exceptions on errors
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,  // Return arrays with column names
            PDO::ATTR_EMULATE_PREPARES => false,  // Use real prepared statements
        ];
        
        // Create and return the connection
        $pdo = new PDO($dsn, DB_USERNAME, DB_PASSWORD, $options);
        return $pdo;
        
    } catch (PDOException $e) {
        // Uh oh, something went wrong!
        // In production, you'd want to log this instead of displaying it
        die("Oops! Couldn't connect to the database. Error: " . $e->getMessage());
    }
}

// Create a global connection we can use anywhere
// (Just include this file and you're good to go!)
$db = getDBConnection();
?>
