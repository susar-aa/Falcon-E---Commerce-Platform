<?php
session_start();
header('Content-Type: application/json');

// --- Database Connection ---
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
if ($conn->connect_error) {
    echo json_encode(['error' => 'Database connection failed.']);
    exit;
}

$itemId = isset($_GET['ItemID']) ? intval($_GET['ItemID']) : 0;

if ($itemId <= 0) {
    echo json_encode(['error' => 'Invalid Item ID.']);
    exit;
}

$response = [
    'product' => null,
    'variants' => []
];

// --- Fetch Main Product Details ---
$stmt = $conn->prepare("SELECT ItemID, Name, Price FROM Item_List WHERE ItemID = ?");
$stmt->bind_param("i", $itemId);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $response['product'] = $result->fetch_assoc();
} else {
    echo json_encode(['error' => 'Product not found.']);
    $stmt->close();
    $conn->close();
    exit;
}
$stmt->close();

// --- Fetch Product Variants ---
$stmt = $conn->prepare("SELECT VariantID, VariantName, Price FROM Product_Variants WHERE ItemID = ? ORDER BY VariantName");
$stmt->bind_param("i", $itemId);
$stmt->execute();
$result = $stmt->get_result();

while ($row = $result->fetch_assoc()) {
    $response['variants'][] = $row;
}
$stmt->close();

$conn->close();

echo json_encode($response);
?>
