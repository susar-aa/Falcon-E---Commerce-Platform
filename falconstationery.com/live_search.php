<?php
// Start the session
session_start();

// Database connection details - use the same constants as other files
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');

// Attempt to connect to MySQL database
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check connection
if($conn === false){
    // Return a 500 Internal Server Error status code and a JSON error message
    http_response_code(500);
    echo json_encode(['error' => 'Could not connect to the database.']);
    exit;
}

// Set the content type to JSON
header('Content-Type: application/json');

// Get the search query from the GET request
$query = isset($_GET['query']) ? $_GET['query'] : '';

// Ensure the query is a string and not empty
if (empty($query)) {
    echo json_encode([]); // Return an empty array if no query is provided
    exit;
}

// Sanitize the query to prevent SQL injection
$search_query_safe = "%" . $conn->real_escape_string($query) . "%";

// SQL query to search for products. The live search in stationeries.php is for stationery only.
// This query is designed to be general, so the client-side JavaScript can filter as needed.
$sql = "SELECT ItemID, Name, ProductPhoto, Price, CategoryID FROM Item_List 
        WHERE (Name LIKE ? OR Description LIKE ?) AND AvailabilityStatus = 'Available' 
        LIMIT 10";

$stmt = $conn->prepare($sql);

if ($stmt) {
    // Bind parameters to the statement
    $stmt->bind_param("ss", $search_query_safe, $search_query_safe);
    
    // Execute the statement
    $stmt->execute();
    
    // Get the result set
    $result = $stmt->get_result();
    
    $items = [];
    while ($row = $result->fetch_assoc()) {
        // Use the getDirectImageUrl function logic to handle the image URL
        if (!empty($row['ProductPhoto']) && preg_match('/(?:d\/|id=)([a-zA-Z0-9_-]+)/', $row['ProductPhoto'], $matches)) {
            $fileId = $matches[1];
            $row['ProductPhoto'] = "https://drive.google.com/thumbnail?id=" . $fileId . "&sz=w100-h100";
        } else {
            $row['ProductPhoto'] = "https://placehold.co/100x100/e5e7eb/7f8c8d?text=No+Image";
        }
        
        // Add the item to the array
        $items[] = $row;
    }
    
    // Return the results as a JSON array
    echo json_encode($items);

    $stmt->close();
} else {
    // Return a 500 Internal Server Error if the statement preparation fails
    http_response_code(500);
    echo json_encode(['error' => 'Database query preparation failed.']);
}

$conn->close();
?>
