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

// Check if the user is logged in
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    // Redirect to login page if user is not logged in
    header("location: login.php");
    exit;
}

// Check if the cart is not empty
if (empty($_SESSION['cart'])) {
    // If cart is empty, redirect back to cart page
    header("location: cart.php");
    exit;
}

// Retrieve user ID and cart data from session
$userId = $_SESSION['user_id'];
$cart = $_SESSION['cart'];
$totalAmount = $_SESSION['cart_total'];

// Start a database transaction for atomicity
$conn->begin_transaction();

try {
    // 1. Insert into Orders table
    $sql_order = "INSERT INTO Orders (user_id, TotalAmount, Status) VALUES (?, ?, 'Pending')";
    $stmt_order = $conn->prepare($sql_order);
    $stmt_order->bind_param("id", $userId, $totalAmount);
    $stmt_order->execute();
    
    // Get the newly created OrderID
    $orderId = $conn->insert_id;
    $stmt_order->close();

    // 2. Insert into OrderItems table for each item in the cart
    $sql_order_item = "INSERT INTO OrderItems (OrderID, ItemID, VariantID, Name, Price, Quantity) VALUES (?, ?, ?, ?, ?, ?)";
    $stmt_item = $conn->prepare($sql_order_item);

    foreach ($cart as $item) {
        $itemId = $item['item_id'];
        $variantId = isset($item['variant_id']) ? $item['variant_id'] : null;
        $name = $item['name'];
        $price = $item['price'];
        $quantity = $item['quantity'];

        $stmt_item->bind_param(
            "iisidi", 
            $orderId, 
            $itemId,
            $variantId, 
            $name, 
            $price, 
            $quantity
        );
        $stmt_item->execute();
    }

    $stmt_item->close();

    // 3. Commit the transaction
    $conn->commit();

    // Clear the cart from the session after successful order
    unset($_SESSION['cart']);
    unset($_SESSION['cart_total']);

    // Store the OrderID in the session to be used on the receipt page
    $_SESSION['last_order_id'] = $orderId;

    // Redirect to a receipt page
    header("location: receipt.php");
    exit;

} catch (mysqli_sql_exception $exception) {
    // 4. Rollback the transaction on error
    $conn->rollback();
    error_log("Order processing failed: " . $exception->getMessage());
    // Redirect with an error message
    die("Error processing your order. Please try again later.");
}

$conn->close();
?>
