<?php
/**
 * Login Page - Desktop Application Style
 * 
 * Simple authentication for the EMS system.
 */

session_start();

// If already logged in, redirect to dashboard
if (isset($_SESSION['user_logged_in']) && $_SESSION['user_logged_in'] === true) {
    header('Location: index.php');
    exit;
}

// Default credentials (in real app, use database)
$valid_username = 'admin';
$valid_password = 'admin123';

$error = '';

// Handle login form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    if ($username === $valid_username && $password === $valid_password) {
        $_SESSION['user_logged_in'] = true;
        $_SESSION['username'] = $username;
        $_SESSION['login_time'] = time();
        
        header('Location: index.php');
        exit;
    } else {
        $error = 'Invalid username or password';
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
            background-color: #1a1a1a;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }
        
        .login-box {
            background-color: #2d2d2d;
            border: 1px solid #3c3c3c;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
        }
        
        .login-header {
            background-color: #252526;
            padding: 24px;
            text-align: center;
            border-bottom: 1px solid #3c3c3c;
        }
        
        .login-logo {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #0078d4, #00a8ff);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            box-shadow: 0 4px 16px rgba(0, 120, 212, 0.3);
        }
        
        .login-logo i {
            font-size: 28px;
            color: white;
        }
        
        .login-header h1 {
            font-size: 18px;
            font-weight: 600;
            color: #e0e0e0;
            margin-bottom: 4px;
        }
        
        .login-header p {
            font-size: 12px;
            color: #9d9d9d;
        }
        
        .login-body {
            padding: 24px;
        }
        
        .form-group {
            margin-bottom: 16px;
        }
        
        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 500;
            color: #9d9d9d;
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
            color: #6d6d6d;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 12px 10px 38px;
            font-size: 13px;
            font-family: inherit;
            background-color: #3c3c3c;
            border: 1px solid #5c5c5c;
            border-radius: 4px;
            color: #e0e0e0;
            transition: all 0.15s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #0078d4;
            box-shadow: 0 0 0 2px rgba(0, 120, 212, 0.2);
        }
        
        .form-control::placeholder {
            color: #6d6d6d;
        }
        
        .error-message {
            background-color: rgba(244, 67, 54, 0.1);
            border: 1px solid rgba(244, 67, 54, 0.3);
            color: #f44336;
            padding: 10px 12px;
            border-radius: 4px;
            font-size: 12px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-login {
            width: 100%;
            padding: 10px 16px;
            font-size: 13px;
            font-weight: 500;
            font-family: inherit;
            background-color: #0078d4;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.15s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-login:hover {
            background-color: #106ebe;
        }
        
        .btn-login:active {
            transform: scale(0.98);
        }
        
        .login-footer {
            padding: 16px 24px;
            background-color: #252526;
            border-top: 1px solid #3c3c3c;
            text-align: center;
        }
        
        .login-footer p {
            font-size: 11px;
            color: #6d6d6d;
        }
        
        .credentials-hint {
            background-color: #3c3c3c;
            padding: 12px;
            border-radius: 4px;
            margin-top: 16px;
        }
        
        .credentials-hint p {
            font-size: 11px;
            color: #9d9d9d;
            margin-bottom: 4px;
        }
        
        .credentials-hint code {
            font-family: 'Consolas', monospace;
            color: #4caf50;
            font-size: 11px;
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
