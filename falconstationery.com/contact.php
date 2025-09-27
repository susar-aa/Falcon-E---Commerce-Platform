<?php
// Start the session
session_start();

// Database connection details
// Note: These details are loaded from your existing files
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

// Get the current cart total from the session. Initialize to 0 if it doesn't exist.
$cart_total = isset($_SESSION['cart_total']) ? $_SESSION['cart_total'] : 0;

// Get logged-in user's name from the session if it exists
$loggedInUserName = isset($_SESSION['full_name']) ? htmlspecialchars($_SESSION['full_name']) : '';

// Helper function to format currency
function formatCurrency($value) {
    if ($value === null || !is_numeric($value)) return '0.00';
    return number_format(floatval($value), 2);
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Falcon Stationery</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
        }
        .container {
            max-width: 1280px;
        }
        /* Style for the floating cart button */
        .floating-cart {
            position: fixed;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            z-index: 50;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #2563eb;
            color: white;
            padding: 1rem;
            border-top-left-radius: 0.5rem;
            border-bottom-left-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            transition: transform 0.3s ease;
        }
        .floating-cart:hover {
            transform: translateY(-50%) scale(1.05);
        }
    </style>
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">

    <!-- Header -->
    <header class="bg-white shadow-md flex-shrink-0">
        <div class="container mx-auto px-4 py-4 flex items-center justify-between">
            <a href="index.php" class="flex items-center space-x-2">
                <img src="./images/logo.png" alt="Logo" class="h-10">
            </a>
            <nav class="hidden md:flex items-center space-x-6">
                <a href="index.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Home</a>
                <a href="stationeries.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Stationeries</a>
                <a href="cosmetics.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Cosmetics</a>
                <a href="new_arrivals.php" class="text-gray-600 hover:text-blue-600 transition duration-300">New Arrivals</a>
                <a href="contact.php" class="text-blue-600 font-semibold transition duration-300">Contact Us</a>
            </nav>
            <div class="flex items-center space-x-4">
                <a href="cart.php" class="text-gray-600 hover:text-blue-600 transition duration-300 relative">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                    <span class="absolute -top-2 -right-2 bg-blue-600 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                        <?php echo isset($_SESSION['cart']) ? count($_SESSION['cart']) : 0; ?>
                    </span>
                </a>
                <div class="flex items-center space-x-2 md:space-x-4">
                    <?php if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true): ?>
                        <div class="hidden md:block text-gray-600">Welcome, <span class="font-semibold"><?php echo $loggedInUserName; ?></span></div>
                        <a href="profile.php" class="text-gray-600 hover:text-blue-600 transition duration-300">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                        </a>
                    <?php else: ?>
                        <a href="login.php" class="text-white bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg font-medium transition duration-300">Login</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow container mx-auto px-4 py-8">
        <div class="bg-white p-6 md:p-12 rounded-xl shadow-lg text-center">
            <h1 class="text-3xl md:text-5xl font-bold text-gray-900 mb-4">Contact Us</h1>
            <p class="text-gray-600 mb-8 max-w-2xl mx-auto">
                We'd love to hear from you! Please feel free to get in touch with us through any of the channels below.
            </p>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-12 text-left">
                <!-- WhatsApp Card -->
                <div class="bg-blue-50 p-6 rounded-xl border border-blue-200 shadow-sm transition-transform transform hover:scale-105">
                    <div class="flex items-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-green-600 mr-4" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12.04 2c-5.46 0-9.91 4.45-9.91 9.91 0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38a9.91 9.91 0 004.74 1.25c5.46 0 9.91-4.45 9.91-9.91s-4.45-9.91-9.91-9.91zm0 2c4.32 0 7.91 3.59 7.91 7.91 0 4.32-3.59 7.91-7.91 7.91-1.46 0-2.86-.4-4.08-1.18l-.29-.17-3.08.81.82-3.01-.19-.31c-.74-1.2-1.14-2.58-1.14-4.05 0-4.32 3.59-7.91 7.91-7.91zm-3.1 5.37c-.16 0-.34-.05-.5-.22-.17-.18-.62-.75-.62-.91 0-.17.12-.34.25-.49.12-.12.27-.16.37-.16s.21.01.3.01.2.04.3.18.35.83.39.9.04.1.08.2.06.12.03.26-.14.28-.24.3-.2.2-.36.2zm-1.8 4.7l-.46.12c-.14.04-.3.04-.46 0-.12-.04-.26-.18-.32-.28-.06-.1-.13-.19-.18-.28-.05-.09-.09-.18-.13-.26s-.08-.18-.08-.25c0-.08.02-.15.06-.21.05-.08.11-.15.19-.24.08-.09.18-.18.25-.25.07-.07.15-.14.23-.21.08-.06.16-.13.25-.19.09-.07.18-.12.28-.15s.21-.05.3-.05c.08 0 .15.01.21.02.08.01.16.05.23.08s.16.08.24.15c.08.07.15.15.22.25s.12.2.16.3c.04.1.06.2.06.31s-.01.2-.04.3-.08.2-.14.3-.14.2-.23.28-.19.14-.3.17c-.11.03-.23.05-.37.05z"/>
                        </svg>
                        <h3 class="text-xl font-semibold">WhatsApp</h3>
                    </div>
                    <p class="text-gray-700">Feel free to message us on WhatsApp for any inquiries.</p>
                    <a href="https://wa.me/94773623623" class="mt-4 inline-block text-blue-600 font-medium hover:underline">
                        +94 77 362 3623
                    </a>
                </div>

                <!-- Email Card -->
                <div class="bg-gray-50 p-6 rounded-xl border border-gray-200 shadow-sm transition-transform transform hover:scale-105">
                    <div class="flex items-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-gray-600 mr-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 8l7.893 5.495a2 2 0 002.214 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                        </svg>
                        <h3 class="text-xl font-semibold">Email Us</h3>
                    </div>
                    <p class="text-gray-700">Send us an email and we'll get back to you as soon as possible.</p>
                    <a href="mailto:info@falconstationary.com" class="mt-4 inline-block text-blue-600 font-medium hover:underline">
                        falconstationary@gmail.com
                    </a>
                </div>

                <!-- Location Card -->
                <div class="bg-gray-50 p-6 rounded-xl border border-gray-200 shadow-sm transition-transform transform hover:scale-105">
                    <div class="flex items-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-gray-600 mr-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                        <h3 class="text-xl font-semibold">Our Address</h3>
                    </div>
                    <p class="text-gray-700">Visit our physical store to explore our full range of products.</p>
                    <p class="mt-4 text-gray-800 font-medium">
                        No 79, Dambakanda Estate<br>
                        Boyagane, Kurunegala<br>
                        </p>
                </div>
            </div>
        </div>
    </main>

    <!-- Floating Shopping Cart Container -->
    <a href="cart.php" class="floating-cart md:hidden">
        <div class="block">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
            </svg>
        </div>
        <div class="text-xs mt-1">LKR <?php echo formatCurrency($cart_total); ?></div>
    </a>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-8 flex-shrink-0">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; <?php echo date("Y"); ?> Falcon Stationery PVT LTD. All Rights Reserved.</p>
        </div>
    </footer>

</body>
</html>
