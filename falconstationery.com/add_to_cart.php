<?php
session_start();
// --- Database Connection ---
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
if ($conn->connect_error) {
    header('Content-Type: application/json');
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database connection error.']);
    exit;
}

header('Content-Type: application/json');

$response = [
    'success' => false,
    'message' => 'An unknown error occurred.',
    'cart_total' => 0,
    'cart_item_count' => 0
];

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $response['message'] = 'Invalid request method.';
    echo json_encode($response);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['items']) || !is_array($data['items'])) {
    $response['message'] = 'Invalid data received.';
    echo json_encode($response);
    exit;
}

if (!isset($_SESSION['cart'])) {
    $_SESSION['cart'] = [];
}

foreach ($data['items'] as $item) {
    $itemId = isset($item['id']) ? intval($item['id']) : 0;
    $variantId = isset($item['variant_id']) ? intval($item['variant_id']) : 0;
    $quantity = isset($item['quantity']) ? intval($item['quantity']) : 0;

    if ($itemId <= 0 || $quantity <= 0) continue;

    $db_price = null;
    $db_name = null;

    if ($variantId > 0) {
        $stmt = $conn->prepare("SELECT VariantName, Price FROM Product_Variants WHERE VariantID = ? AND ItemID = ?");
        $stmt->bind_param("ii", $variantId, $itemId);
    } else {
        $stmt = $conn->prepare("SELECT Name, Price FROM Item_List WHERE ItemID = ?");
        $stmt->bind_param("i", $itemId);
    }
    
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($db_item = $result->fetch_assoc()) {
        $db_price = floatval($db_item['Price']);
        $db_name = $variantId > 0 ? $db_item['VariantName'] : $db_item['Name'];
    } else {
        continue;
    }
    $stmt->close();
    
    $cartKey = $itemId . ($variantId > 0 ? '_' . $variantId : '');

    if (isset($_SESSION['cart'][$cartKey])) {
        $_SESSION['cart'][$cartKey]['quantity'] += $quantity;
    } else {
        $_SESSION['cart'][$cartKey] = [
            'name'       => $db_name,
            'price'      => $db_price,
            'quantity'   => $quantity,
            'item_id'    => $itemId,
            'variant_id' => $variantId
        ];
    }
}

// Recalculate total and item count
$total = 0;
$item_count = 0;
foreach ($_SESSION['cart'] as $cartItem) {
    $total += $cartItem['price'] * $cartItem['quantity'];
    $item_count++;
}
$_SESSION['cart_total'] = $total;

$response['success'] = true;
$response['message'] = 'Cart updated successfully!';
$response['cart_total'] = $total;
$response['cart_item_count'] = $item_count;

$conn->close();
echo json_encode($response);
?>
