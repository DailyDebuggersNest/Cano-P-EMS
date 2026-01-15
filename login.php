<?php
/**
 * Login Page - Desktop Application Style
 * 
 * Secure authentication using database and bcrypt.
 */

session_start();

// Include database connection
require_once __DIR__ . '/includes/db.php';

// If already logged in, redirect to students page
if (isset($_SESSION['user_logged_in']) && $_SESSION['user_logged_in'] === true) {
    header('Location: pages/students.php');
    exit;
}

$error = '';

// Handle login form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    if (empty($username) || empty($password)) {
        $error = 'Please enter both username and password';
    } else {
        // Look up user in database
        try {
            $sql = "SELECT * FROM users WHERE username = :username AND is_active = 1";
            $stmt = $db->prepare($sql);
            $stmt->execute(['username' => $username]);
            $user = $stmt->fetch();
            
            if ($user && password_verify($password, $user['password'])) {
                // Password is correct - create session
                $_SESSION['user_logged_in'] = true;
                $_SESSION['user_id'] = $user['user_id'];
                $_SESSION['username'] = $user['username'];
                $_SESSION['user_role'] = $user['role'];
                $_SESSION['full_name'] = $user['full_name'];
                $_SESSION['login_time'] = time();
                
                // Update last login time
                $updateSql = "UPDATE users SET last_login = NOW() WHERE user_id = :user_id";
                $updateStmt = $db->prepare($updateSql);
                $updateStmt->execute(['user_id' => $user['user_id']]);
                
                header('Location: pages/students.php');
                exit;
            } else {
                $error = 'Invalid username or password';
            }
        } catch (PDOException $e) {
            $error = 'Database error. Please try again.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EMS Pro</title>
    <link rel="icon" type="image/svg+xml" href="favicon.svg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: #f3f4f6;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-container {
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }
        
        .login-box {
            background-color: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
        }
        
        .login-header {
            background-color: #f9fafb;
            padding: 28px 24px;
            text-align: center;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .login-logo {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #0078d4, #00a8ff);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            box-shadow: 0 4px 14px rgba(0, 120, 212, 0.25);
        }
        
        .login-logo i {
            font-size: 28px;
            color: white;
        }
        
        .login-header h1 {
            font-size: 20px;
            font-weight: 600;
            color: #111827;
            margin-bottom: 4px;
        }
        
        .login-header p {
            font-size: 13px;
            color: #6b7280;
        }
        
        .login-body {
            padding: 28px 24px;
        }
        
        .form-group {
            margin-bottom: 18px;
        }
        
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: #374151;
            margin-bottom: 6px;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 11px 12px 11px 40px;
            font-size: 14px;
            font-family: inherit;
            background-color: #f9fafb;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            color: #111827;
            transition: all 0.15s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #0078d4;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(0, 120, 212, 0.12);
        }
        
        .form-control::placeholder {
            color: #9ca3af;
        }
        
        .error-message {
            background-color: #fef2f2;
            border: 1px solid #fecaca;
            color: #dc2626;
            padding: 12px 14px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-login {
            width: 100%;
            padding: 12px 16px;
            font-size: 14px;
            font-weight: 600;
            font-family: inherit;
            background-color: #0078d4;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.15s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-login:hover {
            background-color: #106ebe;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 120, 212, 0.25);
        }
        
        .btn-login:active {
            transform: scale(0.98);
        }
        
        .login-footer {
            padding: 16px 24px;
            background-color: #f9fafb;
            border-top: 1px solid #e5e7eb;
            text-align: center;
        }
        
        .login-footer p {
            font-size: 12px;
            color: #6b7280;
        }
        
        .credentials-hint {
            background-color: #f0f9ff;
            border: 1px solid #bae6fd;
            padding: 14px;
            border-radius: 8px;
            margin-top: 18px;
        }
        
        .credentials-hint p {
            font-size: 12px;
            color: #0369a1;
            margin-bottom: 4px;
        }
        
        .credentials-hint code {
            font-family: 'Consolas', monospace;
            background-color: #e0f2fe;
            color: #0c4a6e;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="login-logo">
                    <i class="fas fa-graduation-cap"></i>
                </div>
                <h1>EMS Pro</h1>
                <p>Sign in to continue</p>
            </div>
            
            <div class="login-body">
                <?php if ($error): ?>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <?php echo htmlspecialchars($error); ?>
                    </div>
                <?php endif; ?>
                
                <form method="POST" action="login.php">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <div class="input-group">
                            <i class="fas fa-user"></i>
                            <input type="text" id="username" name="username" class="form-control" 
                                   placeholder="Enter username" required autofocus
                                   value="<?php echo htmlspecialchars($_POST['username'] ?? ''); ?>">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="password" name="password" class="form-control" 
                                   placeholder="Enter password" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-login">
                        <i class="fas fa-sign-in-alt"></i>
                        Sign In
                    </button>
                </form>
                
                <div class="credentials-hint">
                    <p><i class="fas fa-info-circle"></i> Demo Credentials:</p>
                    <p>Username: <code>admin</code> | Password: <code>admin123</code></p>
                </div>
            </div>
            
            <div class="login-footer">
                <p>&copy; 2025 EMS Pro</p>
            </div>
        </div>
    </div>
</body>
</html>
