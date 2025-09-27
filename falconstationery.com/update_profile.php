<?php
// Start the session to access and store session variables
session_start();

// Check if the user is logged in. If not, redirect to the login page.
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header("location: login.php");
    exit;
}

// Check if the form was submitted using the POST method
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // Include database connection details.
    // In a real application, this should be a shared file to avoid duplication.
    define('DB_SERVER', 'localhost');
    define('DB_USERNAME', 'falcon');
    define('DB_PASSWORD', 'falcon@12369');
    define('DB_NAME', 'falcon_stationary');

    // Attempt to connect to the database
    $conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

    // Check connection
    if ($conn === false) {
        // Log the error and redirect with an error message
        error_log("Database connection error: " . $conn->connect_error);
        $_SESSION['profile_message'] = "A server error occurred. Please try again.";
        $_SESSION['profile_message_type'] = "error";
        header("location: profile.php");
        exit;
    }

    // Get the user ID from the session
    $userId = $_SESSION['user_id'];

    // Sanitize and validate the form inputs
    $fullName = trim($_POST['full_name'] ?? '');
    $shopName = trim($_POST['shop_name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $phone = trim($_POST['phone'] ?? '');
    $address = trim($_POST['address'] ?? '');
    $city = trim($_POST['city'] ?? '');
    $district = trim($_POST['district'] ?? '');
    $newPassword = trim($_POST['new_password'] ?? ''); // Optional password field

    // Prepare an update statement
    $sql = "UPDATE users SET full_name = ?, shop_name = ?, email = ?, phone = ?, address = ?, city = ?, district = ? WHERE user_id = ?";

    // Initialize an array to hold the parameters for binding
    $params = [$fullName, $shopName, $email, $phone, $address, $city, $district, $userId];
    $param_types = "sssssssi";

    // Check if a new password was provided. If so, update the SQL query and parameters.
    if (!empty($newPassword)) {
        $hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
        $sql = "UPDATE users SET full_name = ?, shop_name = ?, email = ?, phone = ?, address = ?, city = ?, district = ?, password = ? WHERE user_id = ?";
        // Prepend the new password to the parameters array and its type to the type string
        array_splice($params, 7, 0, [$hashedPassword]);
        $param_types = "ssssssssi";
    }

    // Use a prepared statement to prevent SQL injection
    if ($stmt = $conn->prepare($sql)) {
        // Bind parameters to the prepared statement
        $stmt->bind_param($param_types, ...$params);

        // Attempt to execute the prepared statement
        if ($stmt->execute()) {
            $_SESSION['profile_message'] = "Profile updated successfully!";
            $_SESSION['profile_message_type'] = "success";
        } else {
            error_log("Profile update error: " . $stmt->error);
            $_SESSION['profile_message'] = "Error updating profile. Please try again.";
            $_SESSION['profile_message_type'] = "error";
        }

        // Close the statement
        $stmt->close();
    } else {
        error_log("SQL prepare error: " . $conn->error);
        $_SESSION['profile_message'] = "A server error occurred. Please try again.";
        $_SESSION['profile_message_type'] = "error";
    }

    // Close the database connection
    $conn->close();

    // Redirect back to the profile page to show the status message
    header("location: profile.php");
    exit;

} else {
    // If the request method is not POST, redirect to the profile page
    header("location: profile.php");
    exit;
}
?>
