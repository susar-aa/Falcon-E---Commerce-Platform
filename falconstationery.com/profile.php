<?php
// Start the session to access session variables
session_start();

// Check if the user is logged in. If not, redirect them to the login page.
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header("location: login.php");
    exit;
}

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

// Get user data from the session
$user_id = $_SESSION['user_id'];

// Fetch all user details from the database
$user_details = [];
$sql_user_details = "SELECT full_name, shop_name, email, phone, address, city, district FROM users WHERE user_id = ?";
if ($stmt_user_details = $conn->prepare($sql_user_details)) {
    $stmt_user_details->bind_param("i", $user_id);
    if ($stmt_user_details->execute()) {
        $result_user_details = $stmt_user_details->get_result();
        if ($result_user_details->num_rows > 0) {
            $user_details = $result_user_details->fetch_assoc();
        }
    }
    $stmt_user_details->close();
}

// Assign values to variables for use in the HTML form
$full_name = htmlspecialchars($user_details['full_name'] ?? '');
$shop_name = htmlspecialchars($user_details['shop_name'] ?? '');
$email = htmlspecialchars($user_details['email'] ?? '');
$phone = htmlspecialchars($user_details['phone'] ?? '');
$address = htmlspecialchars($user_details['address'] ?? '');
$city = htmlspecialchars($user_details['city'] ?? '');
$district = htmlspecialchars($user_details['district'] ?? '');

// Helper function to format currency
function formatCurrency($value) {
    if ($value === null || !is_numeric($value)) return '0.00';
    return number_format(floatval($value), 2);
}

// Function to convert Google Drive URL to a direct thumbnail link.
function getDirectImageUrl($url, $size = "w200-h200") {
    if (!empty($url) && preg_match('/(?:d\/|id=)([a-zA-Z0-9_-]+)/', $url, $matches)) {
        $fileId = $matches[1];
        return "https://drive.google.com/thumbnail?id=" . $fileId . "&sz=" . $size;
    }
    return "https://placehold.co/200x200/e5e7eb/7f8c8d?text=No+Image";
}

// --- Fetch User's Orders ---
$orders = [];
$sql_orders = "SELECT OrderID, OrderDate, TotalAmount, Status FROM Orders WHERE user_id = ? ORDER BY OrderDate DESC";
if ($stmt_orders = $conn->prepare($sql_orders)) {
    $stmt_orders->bind_param("i", $user_id);
    if ($stmt_orders->execute()) {
        $result_orders = $stmt_orders->get_result();
        while ($order = $result_orders->fetch_assoc()) {
            $order['items'] = [];
            
            $sql_items = "SELECT OrderItemID, ItemID, VariantID, Price, Quantity FROM OrderItems WHERE OrderID = ?";
            if ($stmt_items = $conn->prepare($sql_items)) {
                $stmt_items->bind_param("i", $order['OrderID']);
                if ($stmt_items->execute()) {
                    $result_items = $stmt_items->get_result();
                    while ($item = $result_items->fetch_assoc()) {
                        $itemName = '';
                        $variantName = '';
                        $photoUrl = "https://placehold.co/200x200/e5e7eb/7f8c8d?text=No+Image";

                        $sql_item_details = "SELECT Name, ProductPhoto FROM Item_List WHERE ItemID = ?";
                        if ($stmt_item_details = $conn->prepare($sql_item_details)) {
                            $stmt_item_details->bind_param("i", $item['ItemID']);
                            $stmt_item_details->execute();
                            $result_item_details = $stmt_item_details->get_result();
                            if ($item_row = $result_item_details->fetch_assoc()) {
                                $itemName = $item_row['Name'];
                                $photoUrl = getDirectImageUrl($item_row['ProductPhoto']);
                            }
                            $stmt_item_details->close();
                        }
                        
                        if (!empty($item['VariantID'])) {
                            $sql_variant_details = "SELECT VariantName, ProductPhoto FROM Product_Variants WHERE VariantID = ?";
                            if ($stmt_variant_details = $conn->prepare($sql_variant_details)) {
                                $stmt_variant_details->bind_param("i", $item['VariantID']);
                                $stmt_variant_details->execute();
                                $result_variant_details = $stmt_variant_details->get_result();
                                if ($variant_row = $result_variant_details->fetch_assoc()) {
                                    $variantName = " (" . $variant_row['VariantName'] . ")";
                                    if (!empty($variant_row['ProductPhoto'])) {
                                        $photoUrl = getDirectImageUrl($variant_row['ProductPhoto']);
                                    }
                                }
                                $stmt_variant_details->close();
                            }
                        }
                        
                        $item['Name'] = $itemName . $variantName;
                        $item['ProductPhoto'] = $photoUrl;
                        $order['items'][] = $item;
                    }
                }
                $stmt_items->close();
            }
            $orders[] = $order;
        }
    }
    $stmt_orders->close();
}

// Close the database connection
$conn->close();

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Falcon Stationery PVT LTD</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
        }
        .profile-card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }
        .animate-fade-in {
            animation: fadeIn 0.5s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .gradient-header {
            background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">
    
    <!-- Header matching index.php -->
    <header class="bg-white shadow-md">
        <div class="container mx-auto px-4 py-4 flex items-center justify-between">
            <a href="index.php" class="flex items-center space-x-2">
                <img src="./images/logo.png" alt="Logo" class="h-10">
            </a>
            <nav class="hidden md:flex items-center space-x-6">
                <a href="index.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Home</a>
                <a href="stationeries.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Stationeries</a>
                <a href="cosmetics.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Cosmetics</a>
                <a href="new_arrivals.php" class="text-gray-600 hover:text-blue-600 transition duration-300">New Arrivals</a>
                <a href="contact.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Contact Us</a>
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
                    <div class="hidden md:block text-gray-600">Welcome, <span class="font-semibold"><?php echo $full_name; ?></span></div>
                    <a href="profile.php" class="text-blue-600 hover:text-blue-700 transition duration-300">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </a>
                    <a href="logout.php" class="text-red-600 hover:text-red-700 transition duration-300">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Profile Hero Section -->
    <section class="gradient-header py-16">
        <div class="container mx-auto px-4 text-center">
            <div class="w-24 h-24 bg-white rounded-full mx-auto mb-4 flex items-center justify-center shadow-lg">
                <i class="fas fa-user text-4xl text-blue-600"></i>
            </div>
            <h1 class="text-4xl font-bold text-white mb-2"><?php echo $full_name; ?></h1>
            <p class="text-blue-100 text-lg"><?php echo $email; ?></p>
        </div>
    </section>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8">
        
        <!-- Quick Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-xl shadow-md p-6 text-center hover:shadow-lg transition-shadow">
                <div class="w-12 h-12 bg-blue-100 rounded-lg mx-auto mb-3 flex items-center justify-center">
                    <i class="fas fa-shopping-bag text-blue-600 text-xl"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-900"><?php echo count($orders); ?></h3>
                <p class="text-gray-600">Total Orders</p>
            </div>
            <div class="bg-white rounded-xl shadow-md p-6 text-center hover:shadow-lg transition-shadow">
                <div class="w-12 h-12 bg-green-100 rounded-lg mx-auto mb-3 flex items-center justify-center">
                    <i class="fas fa-check-circle text-green-600 text-xl"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-900">
                    <?php echo count(array_filter($orders, function($o) { return $o['Status'] === 'Completed'; })); ?>
                </h3>
                <p class="text-gray-600">Completed</p>
            </div>
            <div class="bg-white rounded-xl shadow-md p-6 text-center hover:shadow-lg transition-shadow">
                <div class="w-12 h-12 bg-purple-100 rounded-lg mx-auto mb-3 flex items-center justify-center">
                    <i class="fas fa-clock text-purple-600 text-xl"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-900">
                    <?php echo count(array_filter($orders, function($o) { return $o['Status'] === 'Processing'; })); ?>
                </h3>
                <p class="text-gray-600">Processing</p>
            </div>
        </div>

        <!-- Main Content Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            
            <!-- Profile Information Card -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <div class="bg-gradient-to-r from-blue-600 to-purple-600 p-6 text-white">
                        <h2 class="text-2xl font-bold mb-2">Profile Information</h2>
                        <p class="opacity-90">Manage your account details</p>
                    </div>
                    <div class="p-6 space-y-4">
                        <div class="flex items-center justify-between py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Full Name</span>
                            <span class="text-gray-900 font-semibold"><?php echo $full_name; ?></span>
                        </div>
                        <?php if (!empty($shop_name)): ?>
                        <div class="flex items-center justify-between py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Shop Name</span>
                            <span class="text-gray-900 font-semibold"><?php echo $shop_name; ?></span>
                        </div>
                        <?php endif; ?>
                        <div class="flex items-center justify-between py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Email</span>
                            <span class="text-gray-900 font-semibold"><?php echo $email; ?></span>
                        </div>
                        <div class="flex items-center justify-between py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Phone</span>
                            <span class="text-gray-900 font-semibold"><?php echo $phone; ?></span>
                        </div>
                        <?php if (!empty($address)): ?>
                        <div class="flex items-start justify-between py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">Address</span>
                            <span class="text-gray-900 font-semibold text-right"><?php echo $address; ?></span>
                        </div>
                        <?php endif; ?>
                        <?php if (!empty($city)): ?>
                        <div class="flex items-center justify-between py-3 border-b border-gray-100">
                            <span class="text-gray-600 font-medium">City</span>
                            <span class="text-gray-900 font-semibold"><?php echo $city; ?></span>
                        </div>
                        <?php endif; ?>
                        <?php if (!empty($district)): ?>
                        <div class="flex items-center justify-between py-3">
                            <span class="text-gray-600 font-medium">District</span>
                            <span class="text-gray-900 font-semibold"><?php echo $district; ?></span>
                        </div>
                        <?php endif; ?>
                        
                        <button id="edit-profile-btn" class="w-full mt-6 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-lg transition-colors">
                            <i class="fas fa-edit mr-2"></i>
                            Edit Profile
                        </button>
                    </div>
                </div>
            </div>

            <!-- Orders Section -->
            <div class="lg:col-span-2">
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <div class="bg-gradient-to-r from-blue-600 to-purple-600 p-6 text-white">
                        <h2 class="text-2xl font-bold mb-2">Order History</h2>
                        <p class="opacity-90">Track your recent purchases</p>
                    </div>
                    
                    <!-- Order Filter Tabs -->
                    <div class="border-b border-gray-200">
                        <div class="flex overflow-x-auto px-6">
                            <button class="order-filter-btn py-4 px-6 text-sm font-semibold border-b-2 border-blue-600 text-blue-600 whitespace-nowrap" data-status="All">
                                All Orders
                            </button>
                            <button class="order-filter-btn py-4 px-6 text-sm font-semibold border-b-2 border-transparent text-gray-500 hover:text-gray-700 whitespace-nowrap" data-status="Pending">
                                Pending
                            </button>
							<button class="order-filter-btn py-4 px-6 text-sm font-semibold border-b-2 border-transparent text-gray-500 hover:text-gray-700 whitespace-nowrap" data-status="Processing">
                                Processing
                            </button>
                            <button class="order-filter-btn py-4 px-6 text-sm font-semibold border-b-2 border-transparent text-gray-500 hover:text-gray-700 whitespace-nowrap" data-status="Completed">
                                Completed
                            </button>
                            <button class="order-filter-btn py-4 px-6 text-sm font-semibold border-b-2 border-transparent text-gray-500 hover:text-gray-700 whitespace-nowrap" data-status="Canceled">
                                Canceled
                            </button>
                        </div>
                    </div>

                    <!-- Orders List -->
                    <div class="p-6">
                        <?php if (!empty($orders)): ?>
                            <div class="space-y-4" id="orders-container">
                                <?php foreach ($orders as $order): ?>
                                    <div class="order-item border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow animate-fade-in" data-status="<?php echo htmlspecialchars($order['Status']); ?>">
                                        <div class="flex items-center justify-between mb-3">
                                            <div class="flex items-center space-x-4">
                                                <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                                    <i class="fas fa-receipt text-blue-600"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-semibold text-gray-900">Order #<?php echo htmlspecialchars($order['OrderID']); ?></h3>
                                                    <p class="text-sm text-gray-500"><?php echo date('M j, Y \a\t g:i A', strtotime($order['OrderDate'])); ?></p>
                                                </div>
                                            </div>
                                            <div class="text-right">
                                                <p class="text-lg font-bold text-gray-900">LKR <?php echo formatCurrency($order['TotalAmount']); ?></p>
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium <?php 
                                                    switch ($order['Status']) {
                                                        case 'Completed': echo 'bg-green-100 text-green-800'; break;
                                                        case 'Processing': echo 'bg-yellow-100 text-yellow-800'; break;
                                                        case 'Canceled': echo 'bg-red-100 text-red-800'; break;
                                                        default: echo 'bg-blue-100 text-blue-800'; break;
                                                    }
                                                ?>">
                                                    <?php echo htmlspecialchars($order['Status']); ?>
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <!-- Order Items Preview -->
                                        <div class="border-t pt-3">
                                            <button class="order-toggle-btn flex items-center justify-between w-full text-left text-sm text-gray-600 hover:text-gray-800">
                                                <span class="font-medium"><?php echo count($order['items']); ?> item(s)</span>
                                                <i class="fas fa-chevron-down transition-transform"></i>
                                            </button>
                                            <div class="order-details hidden mt-3 space-y-2">
                                                <?php foreach ($order['items'] as $item): ?>
                                                    <div class="flex items-center space-x-3 p-2 bg-gray-50 rounded-lg">
                                                        <img src="<?php echo htmlspecialchars($item['ProductPhoto']); ?>" alt="<?php echo htmlspecialchars($item['Name']); ?>" class="w-12 h-12 object-cover rounded-lg">
                                                        <div class="flex-grow">
                                                            <p class="font-medium text-gray-900 text-sm"><?php echo htmlspecialchars($item['Name']); ?></p>
                                                            <p class="text-xs text-gray-500">Qty: <?php echo htmlspecialchars($item['Quantity']); ?> × LKR <?php echo formatCurrency($item['Price']); ?></p>
                                                        </div>
                                                        <p class="font-semibold text-gray-900 text-sm">LKR <?php echo formatCurrency($item['Price'] * $item['Quantity']); ?></p>
                                                    </div>
                                                <?php endforeach; ?>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        <?php else: ?>
                            <div class="text-center py-12">
                                <div class="w-20 h-20 bg-gray-100 rounded-full mx-auto mb-4 flex items-center justify-center">
                                    <i class="fas fa-shopping-bag text-3xl text-gray-400"></i>
                                </div>
                                <h3 class="text-xl font-semibold text-gray-900 mb-2">No Orders Yet</h3>
                                <p class="text-gray-600 mb-6">Start shopping to see your orders here!</p>
                                <div class="flex flex-col sm:flex-row justify-center items-center space-y-4 sm:space-y-0 sm:space-x-4">
                                    <a href="stationeries.php" class="bg-blue-600 text-white font-semibold px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors">
                                        Shop Stationeries
                                    </a>
                                    <a href="cosmetics.php" class="bg-purple-600 text-white font-semibold px-6 py-3 rounded-lg hover:bg-purple-700 transition-colors">
                                        Shop Cosmetics
                                    </a>
                                </div>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Edit Profile Modal -->
    <div id="edit-modal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center p-4">
        <div class="bg-white rounded-xl shadow-2xl max-w-2xl w-full max-h-screen overflow-y-auto">
            <div class="bg-gradient-to-r from-blue-600 to-purple-600 p-6 text-white">
                <div class="flex items-center justify-between">
                    <h2 class="text-2xl font-bold">Edit Profile</h2>
                    <button id="close-modal-btn" class="text-white hover:text-gray-200 transition-colors">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
            </div>
            
            <?php 
                // Display message if there's one in the session
                if (isset($_SESSION['profile_message'])):
                    $messageType = $_SESSION['profile_message_type'] ?? 'success';
                    $bgColor = ($messageType === 'success') ? 'bg-green-50 border-green-200 text-green-700' : 'bg-red-50 border-red-200 text-red-700';
                    $iconClass = ($messageType === 'success') ? 'fa-check-circle text-green-500' : 'fa-exclamation-circle text-red-500';
                    $messageText = htmlspecialchars($_SESSION['profile_message']);
                    ?>
                    <div class="m-6 <?php echo $bgColor; ?> border px-4 py-3 rounded-lg flex items-center" role="alert">
                        <i class="fas <?php echo $iconClass; ?> mr-2"></i>
                        <span><?php echo $messageText; ?></span>
                    </div>
                <?php 
                    // Clear the session message after displaying
                    unset($_SESSION['profile_message']);
                    unset($_SESSION['profile_message_type']);
                endif;
            ?>
            
            <form action="update_profile.php" method="POST" class="p-6 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="edit-fullname" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-user mr-1 text-gray-400"></i>
                            Full Name
                        </label>
                        <input type="text" id="edit-fullname" name="full_name" value="<?php echo $full_name; ?>" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                    </div>
                    <div>
                        <label for="edit-shopname" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-store mr-1 text-gray-400"></i>
                            Shop Name
                        </label>
                        <input type="text" id="edit-shopname" name="shop_name" value="<?php echo $shop_name; ?>" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                    </div>
                    <div>
                        <label for="edit-email" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-envelope mr-1 text-gray-400"></i>
                            Email Address
                        </label>
                        <input type="email" id="edit-email" name="email" value="<?php echo $email; ?>" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                    </div>
                    <div>
                        <label for="edit-phone" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-phone mr-1 text-gray-400"></i>
                            Phone Number
                        </label>
                        <input type="tel" id="edit-phone" name="phone" value="<?php echo $phone; ?>" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" required>
                    </div>
                </div>
                <div>
                    <label for="edit-address" class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-map-marker-alt mr-1 text-gray-400"></i>
                        Address
                    </label>
                    <textarea id="edit-address" name="address" rows="3" 
                              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"><?php echo $address; ?></textarea>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="edit-city" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-city mr-1 text-gray-400"></i>
                            City
                        </label>
                        <input type="text" id="edit-city" name="city" value="<?php echo $city; ?>" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                    </div>
                    <div>
                        <label for="edit-district" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-map mr-1 text-gray-400"></i>
                            District
                        </label>
                        <input type="text" id="edit-district" name="district" value="<?php echo $district; ?>" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                    </div>
                </div>
                
                <div class="flex justify-end space-x-4 pt-6">
                    <button type="button" id="cancel-edit-btn" class="px-6 py-3 border border-gray-300 rounded-lg text-gray-700 font-semibold hover:bg-gray-50 transition-colors">
                        Cancel
                    </button>
                    <button type="submit" class="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition-colors">
                        <i class="fas fa-save mr-2"></i>
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Modal functionality
            const editBtn = document.getElementById('edit-profile-btn');
            const modal = document.getElementById('edit-modal');
            const closeBtn = document.getElementById('close-modal-btn');
            const cancelBtn = document.getElementById('cancel-edit-btn');

            editBtn.addEventListener('click', () => {
                modal.classList.remove('hidden');
                document.body.style.overflow = 'hidden';
            });

            [closeBtn, cancelBtn].forEach(btn => {
                btn.addEventListener('click', () => {
                    modal.classList.add('hidden');
                    document.body.style.overflow = 'auto';
                });
            });

            // Close modal when clicking outside
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.classList.add('hidden');
                    document.body.style.overflow = 'auto';
                }
            });

            // Order filter functionality
            const filterBtns = document.querySelectorAll('.order-filter-btn');
            const orderItems = document.querySelectorAll('.order-item');

            filterBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const status = this.dataset.status;

                    // Update active filter button
                    filterBtns.forEach(filterBtn => {
                        filterBtn.classList.remove('border-blue-600', 'text-blue-600');
                        filterBtn.classList.add('border-transparent', 'text-gray-500');
                    });
                    this.classList.remove('border-transparent', 'text-gray-500');
                    this.classList.add('border-blue-600', 'text-blue-600');

                    // Filter orders
                    orderItems.forEach(item => {
                        if (status === 'All' || item.dataset.status === status) {
                            item.classList.remove('hidden');
                        } else {
                            item.classList.add('hidden');
                        }
                    });
                });
            });

            // Order details toggle functionality
            const toggleBtns = document.querySelectorAll('.order-toggle-btn');
            
            toggleBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const orderItem = this.closest('.order-item');
                    const details = orderItem.querySelector('.order-details');
                    const icon = this.querySelector('i');

                    details.classList.toggle('hidden');
                    icon.classList.toggle('fa-chevron-down');
                    icon.classList.toggle('fa-chevron-up');
                });
            });
        });
    </script>
</body>
