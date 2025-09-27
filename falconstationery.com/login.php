<?php
// Start the session
session_start();

// Database connection details
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');

// Attempt to connect to MySQL database
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check connection
if($conn === false){
    die("ERROR: Could not connect. " . $conn->connect_error);
}

// Initialize variables for login and signup errors
$login_error = '';
$signup_error = '';
$signup_success = false;

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Determine which form was submitted based on a hidden input field
    $action = isset($_POST['action']) ? $_POST['action'] : '';

    if ($action === 'login') {
        // --- LOGIN LOGIC ---
        $email = trim($_POST['email']);
        $password = trim($_POST['password']);

        // Prepare a SQL statement to find a user with the given email
        $sql = "SELECT user_id, full_name, password FROM users WHERE email = ?";
        
        if ($stmt = $conn->prepare($sql)) {
            $stmt->bind_param("s", $email);
            
            if ($stmt->execute()) {
                $result = $stmt->get_result();
                if ($result->num_rows == 1) {
                    $user = $result->fetch_assoc();
                    // Verify the password
                    if (password_verify($password, $user['password'])) {
                        // Password is correct, so start a new session
                        $_SESSION['loggedin'] = true;
                        $_SESSION['user_id'] = $user['user_id'];
                        $_SESSION['full_name'] = $user['full_name'];
                        $_SESSION['email'] = $email;
                        
                        // Redirect to the home page
                        header("location: index.php");
                        exit;
                    } else {
                        $login_error = "Invalid email or password.";
                    }
                } else {
                    $login_error = "Invalid email or password.";
                }
            } else {
                $login_error = "Oops! Something went wrong. Please try again later.";
            }
            $stmt->close();
        }
    } elseif ($action === 'signup') {
        // --- SIGNUP LOGIC ---
        $full_name = trim($_POST['full_name']);
        $email = trim($_POST['email']);
        $phone = trim($_POST['phone']);
        $password = trim($_POST['password']);
        $confirm_password = trim($_POST['confirm_password']);

        // Validate inputs
        if (empty($full_name) || empty($email) || empty($phone) || empty($password) || empty($confirm_password)) {
            $signup_error = "All fields are required.";
        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $signup_error = "Invalid email format.";
        } elseif (!preg_match('/^[0-9]{10}$/', $phone)) {
            $signup_error = "Please enter a valid 10-digit phone number.";
        } elseif ($password !== $confirm_password) {
            $signup_error = "Passwords do not match.";
        } elseif (strlen($password) < 6) {
            $signup_error = "Password must be at least 6 characters long.";
        } else {
            // Check if email or phone already exists
            $sql = "SELECT user_id FROM users WHERE email = ? OR phone = ?";
            if ($stmt = $conn->prepare($sql)) {
                $stmt->bind_param("ss", $email, $phone);
                $stmt->execute();
                $stmt->store_result();
                if ($stmt->num_rows > 0) {
                    $signup_error = "This email or phone number is already registered.";
                } else {
                    // Hash the password
                    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

                    // Insert the new user into the database
                    $sql_insert = "INSERT INTO users (full_name, email, phone, password) VALUES (?, ?, ?, ?)";
                    if ($stmt_insert = $conn->prepare($sql_insert)) {
                        $stmt_insert->bind_param("ssss", $full_name, $email, $phone, $hashed_password);
                        if ($stmt_insert->execute()) {
                            $signup_success = true;
                        } else {
                            $signup_error = "Something went wrong. Please try again later.";
                        }
                        $stmt_insert->close();
                    }
                }
                $stmt->close();
            }
        }
    }
}

// Close the database connection
$conn->close();

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login / Sign Up - Falcon Stationery PVT LTD</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
        }
        .gradient-bg {
            background: white;
        }
        .form-container {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }
        .slide-animation {
            animation: slideIn 0.6s ease-out;
        }
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .tab-button {
            position: relative;
            overflow: hidden;
        }
        .tab-button::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: #3b82f6;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        .tab-button.active::after {
            width: 100%;
        }
    </style>
</head>
<body class="gradient-bg min-h-screen flex items-center justify-center p-4">
    
    <!-- Header with Logo and Back Button -->
    <div class="absolute top-0 left-0 w-full p-4">
        <div class="container mx-auto flex items-center justify-between">
            <a href="index.php" class="flex items-center space-x-2 text-black hover:text-gray-600 transition duration-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                <span class="font-medium">Back to Home</span>
            </a>
            <div class="flex items-center space-x-2">
                <img src="./images/logo.png" alt="Logo" class="h-8">
            </div>
        </div>
    </div>

    <!-- Main Form Container -->
    <div class="w-full max-w-4xl mx-auto slide-animation">
        <div class="bg-white rounded-2xl shadow-2xl overflow-hidden form-container">
            
            <!-- Tab Navigation -->
            <div class="flex border-b border-gray-200">
                <button id="login-tab" class="flex-1 py-4 px-6 text-center font-semibold text-blue-600 tab-button active transition-colors">
                    <i class="fas fa-sign-in-alt mr-2"></i>
                    Sign In
                </button>
                <button id="signup-tab" class="flex-1 py-4 px-6 text-center font-semibold text-gray-500 tab-button hover:text-blue-600 transition-colors">
                    <i class="fas fa-user-plus mr-2"></i>
                    Create Account
                </button>
            </div>

            <div class="md:flex">
                <!-- Welcome Section -->
                <div class="hidden md:flex md:w-1/2 bg-gradient-to-br from-blue-600 to-purple-700 p-8 lg:p-12 flex-col justify-center">
                    <div class="text-white">
                        <h2 class="text-3xl lg:text-4xl font-bold mb-6">Welcome to Falcon Stationery</h2>
                        <p class="text-lg opacity-90 mb-8">Your trusted partner for all stationery and cosmetic needs. Quality products, exceptional service.</p>
                        <div class="space-y-4">
                            <div class="flex items-center space-x-3">
                                <div class="w-2 h-2 bg-white rounded-full"></div>
                                <span>Premium Quality Products</span>
                            </div>
                            <div class="flex items-center space-x-3">
                                <div class="w-2 h-2 bg-white rounded-full"></div>
                                <span>Fast & Reliable Delivery</span>
                            </div>
                            <div class="flex items-center space-x-3">
                                <div class="w-2 h-2 bg-white rounded-full"></div>
                                <span>Excellent Customer Support</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Form Section -->
                <div class="w-full md:w-1/2 p-8 lg:p-12">
                    
                    <!-- Login Form -->
                    <div id="login-form" class="form-panel">
                        <div class="text-center mb-8">
                            <h3 class="text-2xl lg:text-3xl font-bold text-gray-900 mb-2">Welcome Back!</h3>
                            <p class="text-gray-600">Sign in to your account to continue shopping</p>
                        </div>

                        <?php if (!empty($login_error)): ?>
                            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 flex items-center" role="alert">
                                <i class="fas fa-exclamation-circle mr-2"></i>
                                <span><?php echo $login_error; ?></span>
                            </div>
                        <?php endif; ?>

                        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post" class="space-y-6">
                            <input type="hidden" name="action" value="login">
                            
                            <div>
                                <label for="login-email" class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-envelope mr-1 text-gray-400"></i>
                                    Email Address
                                </label>
                                <input type="email" name="email" id="login-email" 
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" 
                                       placeholder="Enter your email" required>
                            </div>
                            
                            <div>
                                <label for="login-password" class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-lock mr-1 text-gray-400"></i>
                                    Password
                                </label>
                                <input type="password" name="password" id="login-password" 
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" 
                                       placeholder="Enter your password" required>
                            </div>
                            
                            <button type="submit" 
                                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg transition-colors shadow-lg hover:shadow-xl">
                                <i class="fas fa-sign-in-alt mr-2"></i>
                                Sign In
                            </button>
                        </form>
                    </div>

                    <!-- Sign Up Form -->
                    <div id="signup-form" class="form-panel hidden">
                        <div class="text-center mb-8">
                            <h3 class="text-2xl lg:text-3xl font-bold text-gray-900 mb-2">Create Account</h3>
                            <p class="text-gray-600">Join us and start your shopping journey</p>
                        </div>

                        <?php if (!empty($signup_error)): ?>
                            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 flex items-center" role="alert">
                                <i class="fas fa-exclamation-circle mr-2"></i>
                                <span><?php echo $signup_error; ?></span>
                            </div>
                        <?php endif; ?>

                        <?php if ($signup_success): ?>
                            <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6 flex items-center" role="alert">
                                <i class="fas fa-check-circle mr-2"></i>
                                <span>Account created successfully! Please sign in.</span>
                            </div>
                        <?php endif; ?>

                        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post" class="space-y-6">
                            <input type="hidden" name="action" value="signup">
                            
                            <div>
                                <label for="signup-fullname" class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-user mr-1 text-gray-400"></i>
                                    Full Name
                                </label>
                                <input type="text" name="full_name" id="signup-fullname" 
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" 
                                       placeholder="Enter your full name" required>
                            </div>
                            
                            <div>
                                <label for="signup-email" class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-envelope mr-1 text-gray-400"></i>
                                    Email Address
                                </label>
                                <input type="email" name="email" id="signup-email" 
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" 
                                       placeholder="Enter your email" required>
                            </div>
                            
                            <div>
                                <label for="signup-phone" class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-phone mr-1 text-gray-400"></i>
                                    Phone Number
                                </label>
                                <input type="tel" name="phone" id="signup-phone" 
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" 
                                       placeholder="Enter your phone number (10 digits)" 
                                       pattern="[0-9]{10}" maxlength="10" required>
                            </div>
                            
                            <div>
                                <label for="signup-password" class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-lock mr-1 text-gray-400"></i>
                                    Password
                                </label>
                                <input type="password" name="password" id="signup-password" 
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" 
                                       placeholder="Create a password" required>
                            </div>
                            
                            <div>
                                <label for="signup-confirm-password" class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-lock mr-1 text-gray-400"></i>
                                    Confirm Password
                                </label>
                                <input type="password" name="confirm_password" id="signup-confirm-password" 
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" 
                                       placeholder="Confirm your password" required>
                            </div>
                            
                            <button type="submit" 
                                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg transition-colors shadow-lg hover:shadow-xl">
                                <i class="fas fa-user-plus mr-2"></i>
                                Create Account
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginTab = document.getElementById('login-tab');
            const signupTab = document.getElementById('signup-tab');
            const loginForm = document.getElementById('login-form');
            const signupForm = document.getElementById('signup-form');

            function showLogin() {
                loginTab.classList.add('active', 'text-blue-600');
                loginTab.classList.remove('text-gray-500');
                signupTab.classList.remove('active', 'text-blue-600');
                signupTab.classList.add('text-gray-500');
                loginForm.classList.remove('hidden');
                signupForm.classList.add('hidden');
            }

            function showSignup() {
                signupTab.classList.add('active', 'text-blue-600');
                signupTab.classList.remove('text-gray-500');
                loginTab.classList.remove('active', 'text-blue-600');
                loginTab.classList.add('text-gray-500');
                signupForm.classList.remove('hidden');
                loginForm.classList.add('hidden');
            }

            loginTab.addEventListener('click', showLogin);
            signupTab.addEventListener('click', showSignup);

            // Set initial state based on PHP output
            const loginError = <?php echo json_encode(!empty($login_error)); ?>;
            const signupError = <?php echo json_encode(!empty($signup_error)); ?>;
            const signupSuccess = <?php echo json_encode($signup_success); ?>;

            if (signupError || signupSuccess) {
                showSignup();
            } else {
                showLogin();
            }
        });
    </script>
</body>
</html>