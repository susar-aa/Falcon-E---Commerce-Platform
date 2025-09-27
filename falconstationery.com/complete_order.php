<?php
session_start();

// --- Pre-flight Checks ---

// 1. Check if the user is logged in. If not, redirect to the login page.
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    // Save the user's intention to return to the cart after logging in
    $_SESSION['redirect_url'] = 'cart.php';
    header("Location: login.php");
    exit;
}

// 2. Check if the cart is empty. If so, redirect back to the cart page.
if (empty($_SESSION['cart'])) {
    header("Location: cart.php");
    exit;
}


// --- Database Connection ---
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
if ($conn->connect_error) {
    // For a real-world scenario, you might want a more user-friendly error page
    die("Database connection failed: " . $conn->connect_error);
}


// --- Order Processing with a Transaction ---
$conn->begin_transaction();

try {
    // 1. Insert the main order record into the 'Orders' table
    $userId = $_SESSION['user_id'];
    $totalAmount = $_SESSION['cart_total'];

    $sql_order = "INSERT INTO Orders (user_id, TotalAmount, OrderDate) VALUES (?, ?, NOW())";
    $stmt_order = $conn->prepare($sql_order);
    $stmt_order->bind_param("id", $userId, $totalAmount);
    $stmt_order->execute();
    
    // Get the ID of the order we just created
    $orderId = $conn->insert_id;
    $stmt_order->close();

    // 2. Insert each item from the cart into the 'OrderItems' table
    $sql_items = "INSERT INTO OrderItems (OrderID, ItemID, VariantID, Quantity, Price) VALUES (?, ?, ?, ?, ?)";
    $stmt_items = $conn->prepare($sql_items);

    foreach ($_SESSION['cart'] as $cart_key => $item) {
        $itemId = intval($item['item_id']);
        $variantId = intval($item['variant_id']) > 0 ? intval($item['variant_id']) : null; // Use NULL if no variant
        $quantity = intval($item['quantity']);
        $price = floatval($item['price']);
        
        $stmt_items->bind_param("iiiid", $orderId, $itemId, $variantId, $quantity, $price);
        $stmt_items->execute();
    }
    $stmt_items->close();

    // If everything was successful, commit the transaction
    $conn->commit();

    // --- Final Steps ---
    
    // 1. Store the new order ID in the session for the receipt page to use
    $_SESSION['last_order_id'] = $orderId;
    
    // 2. Clear the shopping cart
    $_SESSION['cart'] = [];
    $_SESSION['cart_total'] = 0;

    // 3. Redirect to the receipt page
    header("Location: receipt.php");
    exit;

} catch (Exception $e) {
    // If any part of the process failed, roll back the transaction
    $conn->rollback();
    
    // You could log the error and show a generic error message
    // error_log("Order processing failed: " . $e->getMessage());
    die("There was an error processing your order. Please try again.");
}

$conn->close();
?>
