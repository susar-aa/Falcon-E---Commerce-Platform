<?php
// Start the session and connect to the database
session_start();
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
if ($conn->connect_error) {
    // Return a JSON error if the DB connection fails
    header('Content-Type: application/json');
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database connection error.']);
    exit;
}


header('Content-Type: application/json');

$response = [
    'success' => false,
    'message' => 'Invalid request.',
    'cart_total' => 0,
    'cart_item_count' => 0,
    'item_subtotal' => 0
];

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $response['message'] = 'Invalid request method.';
    echo json_encode($response);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

$cartKey = isset($data['cartKey']) && is_string($data['cartKey']) ? $data['cartKey'] : null;
$action = isset($data['action']) ? $data['action'] : 'update';

if (!$cartKey || !isset($_SESSION['cart'][$cartKey])) {
    $response['message'] = 'Item not found in cart.';
    echo json_encode($response);
    exit;
}

$quantity = isset($data['quantity']) ? intval($data['quantity']) : 0;

if ($action === 'remove' || $quantity <= 0) {
    unset($_SESSION['cart'][$cartKey]);
    $response['success'] = true;
    $response['message'] = 'Item removed from cart.';
} else { // 'update' action
    $parts = explode('_', $cartKey);
    $itemId = intval($parts[0]);
    $variantId = isset($parts[1]) ? intval($parts[1]) : null;

    $db_price = null;
    if ($variantId) {
        $stmt = $conn->prepare("SELECT Price FROM Product_Variants WHERE VariantID = ? AND ItemID = ?");
        $stmt->bind_param("ii", $variantId, $itemId);
    } else {
        $stmt = $conn->prepare("SELECT Price FROM Item_List WHERE ItemID = ?");
        $stmt->bind_param("i", $itemId);
    }

    $stmt->execute();
    $result = $stmt->get_result();
    $db_item = $result->fetch_assoc();
    $stmt->close();

    if (!$db_item) {
        unset($_SESSION['cart'][$cartKey]);
        $response['message'] = 'Item is no longer available and has been removed.';
    } else {
        $current_price = floatval($db_item['Price']);
        $_SESSION['cart'][$cartKey]['price'] = $current_price;
        $_SESSION['cart'][$cartKey]['quantity'] = $quantity;
        $response['success'] = true;
        $response['message'] = 'Cart updated successfully.';
        $response['item_subtotal'] = $current_price * $quantity;
    }
}

// Recalculate totals for the entire cart
$total = 0;
$item_count = 0;
foreach ($_SESSION['cart'] as $item) {
    $total += $item['price'] * $item['quantity'];
    $item_count++;
}
$_SESSION['cart_total'] = $total;

$response['cart_total'] = $total;
$response['cart_item_count'] = $item_count;

$conn->close();
echo json_encode($response);
?>

