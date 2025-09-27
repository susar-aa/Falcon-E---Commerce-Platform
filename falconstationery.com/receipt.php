<?php
session_start();

// Database connection details
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');

// Attempt to connect to MySQL database
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check connection and gracefully handle errors
if ($conn === false) {
    error_log("ERROR: Could not connect to the database. " . $conn->connect_error);
    die("<div class='container mx-auto px-4 py-12 text-center'><h1 class='text-4xl font-bold text-red-500'>Service Unavailable</h1><p class='mt-4 text-gray-600'>We are experiencing technical difficulties. Please try again later.</p></div>");
}

// Helper function to format currency
function formatCurrency($value) {
    if ($value === null || !is_numeric($value)) return '0.00';
    return number_format(floatval($value), 2);
}

$order = null;
$orderItems = [];
$user = null;
$cart_total_for_receipt = 0;
$order_date = null;

// Check if a recent order ID exists in the session
if (isset($_SESSION['last_order_id'])) {
    $orderId = $_SESSION['last_order_id'];

    // Fetch order details from the Orders table
    $sql_order = "SELECT user_id, OrderDate, TotalAmount FROM Orders WHERE OrderID = ?";
    if ($stmt_order = $conn->prepare($sql_order)) {
        $stmt_order->bind_param("i", $orderId);
        $stmt_order->execute();
        $result_order = $stmt_order->get_result();
        if ($result_order->num_rows > 0) {
            $order = $result_order->fetch_assoc();
            $cart_total_for_receipt = $order['TotalAmount'];
            $order_date = new DateTime($order['OrderDate']);
            $order_date_formatted = $order_date->format('Y-m-d');

            // Fetch user details from the users table using the user_id from the order
            $sql_user = "SELECT full_name, email, address FROM users WHERE user_id = ?";
            if ($stmt_user = $conn->prepare($sql_user)) {
                $stmt_user->bind_param("i", $order['user_id']);
                $stmt_user->execute();
                $result_user = $stmt_user->get_result();
                if ($result_user->num_rows > 0) {
                    $user = $result_user->fetch_assoc();
                }
                $stmt_user->close();
            }
        }
        $stmt_order->close();
    }

    // Fetch order items from the OrderItems table, joining with Item_List and Product_Variants
    $sql_items = "
        SELECT 
            il.Name AS MainName,
            oi.Price,
            oi.Quantity,
            pv.VariantName
        FROM 
            OrderItems oi
        LEFT JOIN
            Item_List il ON oi.ItemID = il.ItemID
        LEFT JOIN
            Product_Variants pv ON oi.VariantID = pv.VariantID
        WHERE 
            oi.OrderID = ?
    ";
    if ($stmt_items = $conn->prepare($sql_items)) {
        $stmt_items->bind_param("i", $orderId);
        $stmt_items->execute();
        $orderItems = $stmt_items->get_result()->fetch_all(MYSQLI_ASSOC);
        $stmt_items->close();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Receipt - Falcon Stationery PVT LTD</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
        }
        .container-receipt {
            max-width: 800px;
        }
        @media print {
            .no-print {
                display: none;
            }
            .container-receipt {
                max-width: 100%;
                box-shadow: none;
            }
        }
    </style>
</head>
<body class="bg-gray-50 text-gray-800">

    <div class="container container-receipt mx-auto px-4 py-12">
        <div id="receipt-content" class="bg-white rounded-lg shadow-xl p-8 lg:p-12">
            <!-- Header section -->
            <div class="flex justify-between items-center pb-6 border-b border-gray-200 mb-6">
                <img src="./images/logo.png" alt="Falcon Stationery Logo" class="h-16 w-auto">
                <div>
                    <h2 class="text-3xl font-bold text-gray-900">Order Receipt</h2>
                    <p class="text-gray-500 mt-1">Date: <?php echo htmlspecialchars($order_date_formatted ?? date('Y-m-d')); ?></p>
                </div>
            </div>

            <!-- Customer and Business Details -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
                <div>
                    <h3 class="text-lg font-bold text-gray-900 mb-2">Falcon Stationery PVT LTD</h3>
                    <p class="text-gray-600">No 79, Dambakanda Estate</p>
                    <p class="text-gray-600">Boyagane, Kurunegala</p>
                    <p class="text-gray-600">Contact: 077 862 8023, 037 222 8025</p>
                    <p class="text-gray-600">Email: falconstationary@gmail.com</p>
                </div>
                <div class="mt-4 md:mt-0">
                    <h3 class="text-lg font-bold text-gray-900 mb-2">Customer Details</h3>
                    <?php if ($user): ?>
                        <p class="text-gray-600">Name: <?php echo htmlspecialchars($user['full_name']); ?></p>
                        <p class="text-gray-600">Address: <?php echo htmlspecialchars($user['address'] ?? 'Not provided'); ?></p>
                        <p class="text-gray-600">Email: <?php echo htmlspecialchars($user['email']); ?></p>
                    <?php else: ?>
                        <p class="text-gray-600">User details not available.</p>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Order Items table -->
            <div class="border-t border-gray-200 pt-6">
                <div class="grid grid-cols-4 gap-4 pb-4 text-gray-500 font-semibold uppercase tracking-wide border-b border-gray-200">
                    <div class="col-span-1">Item</div>
                    <div class="text-center">Price</div>
                    <div class="text-center">Quantity</div>
                    <div class="text-right">Total</div>
                </div>
                <?php if (!empty($orderItems)): ?>
                    <?php foreach ($orderItems as $item): ?>
                        <div class="grid grid-cols-4 gap-4 items-center py-4 border-b last:border-b-0">
                            <div class="col-span-1 font-semibold text-gray-900">
                                <?php
                                    echo htmlspecialchars($item['MainName']);
                                    // Check if a variant name exists and is different from the main item name
                                    if (!empty($item['VariantName']) && $item['MainName'] !== $item['VariantName']) {
                                        echo " - " . htmlspecialchars($item['VariantName']);
                                    }
                                ?>
                            </div>
                            <div class="text-center text-gray-600">LKR <?php echo formatCurrency($item['Price']); ?></div>
                            <div class="text-center text-gray-600"><?php echo htmlspecialchars($item['Quantity']); ?></div>
                            <div class="text-right font-semibold text-gray-900">LKR <?php echo formatCurrency($item['Price'] * $item['Quantity']); ?></div>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <p class="text-center text-gray-500 py-4">No items found for this order.</p>
                <?php endif; ?>
            </div>

            <!-- Total and Thank You -->
            <div class="flex justify-end items-center mt-6 pt-6 border-t border-gray-200">
                <p class="text-2xl font-bold text-gray-900">Grand Total:</p>
                <p class="text-2xl font-bold text-blue-600 ml-4">LKR <?php echo formatCurrency($cart_total_for_receipt); ?></p>
            </div>
            <div class="mt-8 text-center text-gray-600">
                <p class="text-lg font-semibold mb-2">Thank you for your order!</p>
                <p>We appreciate your business. You can print this receipt for your records.</p>
            </div>
        </div>
    </div>
    
    <!-- Buttons -->
    <div class="mt-8 text-center no-print space-x-4">
        <a href="index.php" class="bg-gray-800 text-white py-3 px-8 rounded-lg font-semibold text-lg hover:bg-gray-900 transition-colors shadow-md">
            Back to Home
        </a>
        <button id="download-button" class="bg-blue-600 text-white py-3 px-8 rounded-lg font-semibold text-lg hover:bg-blue-700 transition-colors shadow-md">
            Download as PDF
        </button>
    </div>
    
    <script>
        document.getElementById('download-button').addEventListener('click', () => {
            const element = document.getElementById('receipt-content');
            const opt = {
                margin:       [10, 10, 10, 10],
                filename:     'receipt-<?php echo htmlspecialchars($orderId); ?>.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2 },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };
            html2pdf().from(element).set(opt).save();
        });
    </script>
</body>
</html>
