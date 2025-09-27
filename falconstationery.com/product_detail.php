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

// Initialize variables
$item = null;
$allImages = []; // This will now hold ALL image URLs
$variants = []; // This will hold all variants from Product_Variants
$imageSrc = "https://placehold.co/800x600/e5e7eb/7f8c8d?text=No+Image"; // Default placeholder for main image
$selectedVariantId = null; // To store the ID of the initially selected variant
$itemId = isset($_GET['ItemID']) ? intval($_GET['ItemID']) : 0;

// Get the current cart total from the session. Initialize to 0 if it doesn't exist.
$cart_total = isset($_SESSION['cart_total']) ? $_SESSION['cart_total'] : 0;

// Get logged-in user's name from the session if it exists
$loggedInUserName = isset($_SESSION['full_name']) ? htmlspecialchars($_SESSION['full_name']) : '';

// Helper function to format currency
function formatCurrency($value) {
    if ($value === null || !is_numeric($value)) return '0.00';
    return number_format(floatval($value), 2);
}

/**
 * Function to convert Google Drive URL to a direct thumbnail link.
 * @param string $url The Google Drive URL.
 * @return string The direct thumbnail URL or a placeholder.
 */
function getDirectImageUrl($url, $size = "w800-h600") {
    if (!empty($url) && preg_match('/(?:d\/|id=)([a-zA-Z0-9_-]+)/', $url, $matches)) {
        $fileId = $matches[1];
        return "https://drive.google.com/thumbnail?id=" . $fileId . "&sz=" . $size;
    }
    return "https://placehold.co/800x600/e5e7eb/7f8c8d?text=No+Image";
}

// Fetch the main item details
if ($itemId > 0) {
    $sql = "SELECT ItemID, Name, ProductPhoto, Price, Description, BulkPrice, Bulk_Description FROM Item_List WHERE ItemID = ?";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $itemId);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows == 1) {
            $item = $result->fetch_assoc();
            $imageSrc = getDirectImageUrl($item['ProductPhoto']);
        }
        $stmt->close();
    }
}

// If item is found, fetch its variants and all images
if ($item) {
    $sql_variants = "SELECT VariantID, VariantName, Price, BulkPrice, ProductPhoto FROM Product_Variants WHERE ItemID = ? ORDER BY VariantName";
    if ($stmt_variants = $conn->prepare($sql_variants)) {
        $stmt_variants->bind_param("i", $itemId);
        $stmt_variants->execute();
        $result_variants = $stmt_variants->get_result();
        while ($row = $result_variants->fetch_assoc()) {
            $row['ProductPhotoProcessed'] = getDirectImageUrl($row['ProductPhoto'], "w800-h600");
            $variants[] = $row;
        }
        $stmt_variants->close();
    }

    $sql_images = "SELECT ImageURL FROM Product_Images WHERE ItemID = ?";
    if ($stmt_images = $conn->prepare($sql_images)) {
        $stmt_images->bind_param("i", $itemId);
        $stmt_images->execute();
        $result_images = $stmt_images->get_result();
        while ($row = $result_images->fetch_assoc()) {
            $allImages[] = getDirectImageUrl($row['ImageURL'], "w800-h600");
        }
        $stmt_images->close();
    }
}

$conn->close();

if (!$item) {
    echo "<div class='container mx-auto px-4 py-12 text-center'><h1 class='text-4xl font-bold text-red-500'>Item Not Found</h1><p class='mt-4 text-gray-600'>The item you are looking for does not exist.</p><a href='index.php' class='mt-8 inline-block bg-blue-600 text-white font-bold py-2 px-6 rounded-lg hover:bg-blue-700 transition-colors'>Go Back to Home</a></div>";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($item['Name']); ?> | Falcon Stationery</title>
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
        .thumbnail-image {
            cursor: pointer;
            border: 2px solid transparent;
            transition: border-color 0.2s;
        }
        .thumbnail-image.active {
            border-color: #2563eb;
        }
        #message-box {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            border-radius: 0.5rem;
            color: white;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.3s ease, transform 0.3s ease;
            z-index: 1000;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        #message-box.show {
            opacity: 1;
            transform: translateY(0);
        }
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fefefe;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            position: relative;
        }
        .close-button {
            color: #aaa;
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 28px;
            font-weight: bold;
        }
        .close-button:hover,
        .close-button:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        /* New styles for square image and zoom */
        .main-image-container {
            position: relative;
            width: 100%;
            padding-bottom: 100%; /* This creates a square aspect ratio */
            overflow: hidden;
        }
        #main-product-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: contain;
            cursor: zoom-in;
        }
        .enlarged-image-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.9);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .enlarged-image-container {
            max-width: 90%;
            max-height: 90%;
        }
        .enlarged-image {
            max-width: 100%;
            max-height: 90vh;
            object-fit: contain;
        }
        .close-enlarged {
            position: absolute;
            top: 20px;
            right: 20px;
            color: white;
            font-size: 30px;
            cursor: pointer;
        }
        @media (max-width: 640px) {
            .main-image-container {
                padding-bottom: 100%; /* Keep square on mobile */
            }
        }
    </style>
</head>
<body class="bg-gray-100 text-gray-800">

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
    <main class="container mx-auto px-4 py-8">
        <!-- Back Button -->
        <div class="mb-4">
            <a href="javascript:void(0);" onclick="history.back();" class="flex items-center text-gray-600 hover:text-blue-600 transition duration-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Back to previous page
            </a>
        </div>
        <div class="bg-white p-4 md:p-8 rounded-xl shadow-lg">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 md:gap-10">
                <!-- Product Images Section -->
                <div class="flex flex-col items-center">
                    <div class="w-full main-image-container rounded-xl overflow-hidden shadow-md mb-4">
                        <img id="main-product-image" src="<?php echo htmlspecialchars($imageSrc); ?>" alt="<?php echo htmlspecialchars($item['Name']); ?>">
                    </div>
                    <?php if (!empty($allImages) || !empty($variants)): ?>
                    <div class="flex flex-wrap justify-center gap-2 mt-4">
                        <?php if ($item && !empty($item['ProductPhoto'])): ?>
                            <img src="<?php echo getDirectImageUrl($item['ProductPhoto'], "w200-h200"); ?>" data-full-src="<?php echo getDirectImageUrl($item['ProductPhoto']); ?>" alt="Product thumbnail" class="thumbnail-image w-20 h-20 object-cover rounded-lg active">
                        <?php endif; ?>
                        <?php foreach($allImages as $imageUrl): ?>
                            <img src="<?php echo htmlspecialchars($imageUrl); ?>" data-full-src="<?php echo htmlspecialchars($imageUrl); ?>" alt="Product thumbnail" class="thumbnail-image w-20 h-20 object-cover rounded-lg">
                        <?php endforeach; ?>
                        <?php foreach($variants as $variant): ?>
                            <?php if (!empty($variant['ProductPhoto'])): ?>
                                <img src="<?php echo htmlspecialchars($variant['ProductPhotoProcessed']); ?>" data-full-src="<?php echo getDirectImageUrl($variant['ProductPhoto']); ?>" alt="Variant thumbnail" class="thumbnail-image w-20 h-20 object-cover rounded-lg">
                            <?php endif; ?>
                        <?php endforeach; ?>
                    </div>
                    <?php endif; ?>
                </div>

                <!-- Product Details Section -->
                <div class="flex flex-col">
                    <h1 id="product-name" class="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 mb-2"><?php echo htmlspecialchars($item['Name']); ?></h1>
                    <p class="text-gray-500 text-sm sm:text-base mb-4">Item ID: <?php echo htmlspecialchars($item['ItemID']); ?></p>

                    <div class="flex items-baseline mb-6">
                        <span class="text-3xl sm:text-4xl font-bold text-blue-600">LKR <span id="product-price"><?php echo formatCurrency($item['Price']); ?></span></span>
                        <?php if (!empty($item['BulkPrice'])): ?>
                        <span class="text-lg sm:text-xl text-gray-400 ml-4 line-through">LKR <span id="bulk-price"><?php echo formatCurrency($item['BulkPrice']); ?></span></span>
                        <?php endif; ?>
                    </div>

                    <?php if (!empty($item['Description'])): ?>
                    <div id="description-section" class="mb-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-2">Description</h2>
                        <p class="text-gray-700"><?php echo htmlspecialchars($item['Description']); ?></p>
                    </div>
                    <?php endif; ?>
                    <?php if (!empty($item['Bulk_Description'])): ?>
                    <div id="bulk-description-section" class="mb-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-2">Bulk Description</h2>
                        <p class="text-gray-700" id="bulk-description"><?php echo htmlspecialchars($item['Bulk_Description']); ?></p>
                    </div>
                    <?php endif; ?>

                    <?php if (!empty($variants)): ?>
                        <div class="mb-6">
                            <h3 class="text-xl font-semibold text-gray-900 mb-2">Variants</h3>
                            <div class="flex flex-wrap gap-2">
                                <?php foreach($variants as $variant): ?>
                                    <button type="button" class="variant-button bg-gray-200 text-gray-800 font-semibold py-2 px-4 rounded-lg hover:bg-gray-300 transition-colors" data-variant-id="<?php echo htmlspecialchars($variant['VariantID']); ?>">
                                        <?php echo htmlspecialchars($variant['VariantName']); ?>
                                    </button>
                                <?php endforeach; ?>
                            </div>
                        </div>
                    <?php endif; ?>

                    <div class="flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4">
                        <button id="add-to-cart-modal-button" class="w-full sm:flex-1 bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg shadow-md transition-colors">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 inline-block mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                            </svg>
                            Add to Cart
                        </button>
                        <button class="w-full sm:flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-3 px-6 rounded-lg shadow-md transition-colors">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 inline-block mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                            </svg>
                            Add to Wishlist
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Modal for Add to Cart -->
    <div id="addToCartModal" class="modal">
        <div class="modal-content">
            <span class="close-button">&times;</span>
            <h2 class="text-2xl font-bold mb-4">Add to Cart</h2>
            <p class="text-gray-600 mb-6">Please enter the quantity for each item variant you wish to add.</p>
            
            <form id="add-to-cart-form">
                <div id="modal-variants-container" class="space-y-4 max-h-64 overflow-y-auto pr-2">
                    <!-- Variant inputs will be dynamically inserted here -->
                </div>
                <div class="mt-6 flex justify-end space-x-4">
                    <button type="button" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-6 rounded-lg transition-colors" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition-colors">Finalize Add to Cart</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Message Box -->
    <div id="message-box" class="bg-green-500">
        <p id="message-text">Item added to cart!</p>
    </div>

    <!-- Enlarged Image Overlay -->
    <div id="enlarged-image-overlay" class="enlarged-image-overlay">
        <span class="close-enlarged">&times;</span>
        <div class="enlarged-image-container">
            <img id="enlarged-image" class="enlarged-image" src="" alt="Enlarged product view">
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; <?php echo date("Y"); ?> Falcon Stationery PVT LTD. All Rights Reserved.</p>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const mainImage = document.getElementById('main-product-image');
            const thumbnails = document.querySelectorAll('.thumbnail-image');
            const variantsData = <?php echo json_encode($variants); ?>;
            const variantButtons = document.querySelectorAll('.variant-button');
            const productNameElement = document.getElementById('product-name');
            const productPriceElement = document.getElementById('product-price');
            const productDescriptionElement = document.getElementById('product-description');
            const descriptionSection = document.getElementById('description-section');
            const bulkPriceElement = document.getElementById('bulk-price');
            const bulkDescriptionElement = document.getElementById('bulk-description');
            const addToCartModalButton = document.getElementById('add-to-cart-modal-button');
            const messageBox = document.getElementById('message-box');
            const messageText = document.getElementById('message-text');
            const originalProductName = productNameElement.innerText.split(' - ')[0].trim();
            const itemId = <?php echo json_encode($item['ItemID']); ?>;
            const enlargedOverlay = document.getElementById('enlarged-image-overlay');
            const enlargedImage = document.getElementById('enlarged-image');
            const closeEnlarged = document.querySelector('.close-enlarged');

            // Modal elements
            const modal = document.getElementById('addToCartModal');
            const closeModalButton = document.querySelector('.close-button');
            const modalVariantsContainer = document.getElementById('modal-variants-container');
            const modalAddToCartForm = document.getElementById('add-to-cart-form');

            const formatCurrency = (value) => {
                if (value === null || typeof value === 'undefined') return '0.00';
                return parseFloat(value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            };

            const preloadImages = (urls) => {
                urls.forEach(url => {
                    const img = new Image();
                    img.src = url;
                });
            };

            const allImageUrls = [];
            thumbnails.forEach(thumbnail => allImageUrls.push(thumbnail.dataset.fullSrc));
            variantsData.forEach(variant => {
                if (variant.ProductPhotoProcessed) {
                    allImageUrls.push(variant.ProductPhotoProcessed);
                }
            });
            preloadImages(allImageUrls);

            if (mainImage && thumbnails.length > 0) {
                thumbnails.forEach(thumbnail => {
                    thumbnail.addEventListener('click', () => {
                        mainImage.src = thumbnail.dataset.fullSrc;
                        thumbnails.forEach(t => t.classList.remove('active'));
                        thumbnail.classList.add('active');
                        variantButtons.forEach(btn => btn.classList.remove('active'));
                    });
                });
            }

            // Enlarged image functionality
            if (mainImage) {
                mainImage.addEventListener('click', () => {
                    enlargedImage.src = mainImage.src;
                    enlargedOverlay.style.display = 'flex';
                });
            }

            if (closeEnlarged) {
                closeEnlarged.addEventListener('click', () => {
                    enlargedOverlay.style.display = 'none';
                });
            }

            enlargedOverlay.addEventListener('click', (e) => {
                if (e.target === enlargedOverlay) {
                    enlargedOverlay.style.display = 'none';
                }
            });

            if (variantsData.length > 0) {
                variantButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        const selectedVariantId = button.dataset.variantId;
                        const selectedVariant = variantsData.find(v => v.VariantID == selectedVariantId);

                        if (selectedVariant) {
                            productNameElement.innerHTML = `${originalProductName}<span id="variant-name-display"> - ${selectedVariant.VariantName}</span>`;
                            productPriceElement.innerText = formatCurrency(selectedVariant.Price);

                            if (bulkPriceElement) {
                                bulkPriceElement.innerText = formatCurrency(selectedVariant.BulkPrice);
                            }
                            if (bulkDescriptionElement) {
                                bulkDescriptionElement.textContent = selectedVariant.Bulk_Description || '';
                            }

                            if (selectedVariant.ProductPhotoProcessed) {
                                mainImage.src = selectedVariant.ProductPhotoProcessed;
                            }
                        
                            variantButtons.forEach(btn => btn.classList.remove('active'));
                            button.classList.add('active');
                            thumbnails.forEach(t => t.classList.remove('active'));
                        }
                    });
                });
            }

            window.showModal = () => {
                modalVariantsContainer.innerHTML = '';
                if (variantsData.length > 0) {
                    variantsData.forEach(variant => {
                        const variantElement = document.createElement('div');
                        variantElement.className = 'flex items-center justify-between p-4 mb-2 bg-gray-100 rounded-lg';
                        variantElement.innerHTML = `
                            <div class="flex-1">
                                <p class="font-semibold text-gray-900">${variant.VariantName}</p>
                                <p class="text-sm text-gray-600">LKR ${formatCurrency(variant.Price)}</p>
                            </div>
                            <input type="number" data-variant-id="${variant.VariantID}" min="0" value="0" class="quantity-input w-20 px-2 py-1 text-center border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        `;
                        modalVariantsContainer.appendChild(variantElement);
                    });
                } else {
                    const singleItemElement = document.createElement('div');
                    singleItemElement.className = 'flex items-center justify-between p-4 mb-2 bg-gray-100 rounded-lg';
                    singleItemElement.innerHTML = `
                        <div class="flex-1">
                            <p class="font-semibold text-gray-900">${originalProductName}</p>
                            <p class="text-sm text-gray-600">LKR ${productPriceElement.innerText.trim()}</p>
                        </div>
                        <input type="number" data-item-id="${itemId}" min="0" value="0" class="quantity-input w-20 px-2 py-1 text-center border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    `;
                    modalVariantsContainer.appendChild(singleItemElement);
                }
                modal.style.display = 'flex';
            };

            window.closeModal = () => {
                modal.style.display = 'none';
            };

            if (addToCartModalButton) {
                addToCartModalButton.addEventListener('click', showModal);
            }

            if (closeModalButton) {
                closeModalButton.addEventListener('click', closeModal);
            }

            modalAddToCartForm.addEventListener('submit', (e) => {
                e.preventDefault();

                const itemsToAdd = [];
                const quantityInputs = modalVariantsContainer.querySelectorAll('.quantity-input');
                let addedToCart = false;

                quantityInputs.forEach(input => {
                    const quantity = parseInt(input.value, 10);
                    if (quantity > 0) {
                        addedToCart = true;
                        const variantId = input.dataset.variantId || null;
                        const mainItemId = input.dataset.itemId || itemId;
                        
                        let selectedItem;
                        if (variantId) {
                            selectedItem = variantsData.find(v => v.VariantID == variantId);
                        } else {
                             // This is for a product without variants
                            selectedItem = {
                                'Name': originalProductName,
                                'Price': productPriceElement.innerText.trim().replace('LKR ', '').replace(/,/g, ''),
                                'ItemID': mainItemId
                            };
                        }

                        if (selectedItem) {
                            itemsToAdd.push({
                                id: mainItemId,
                                variant_id: variantId,
                                name: selectedItem.VariantName || selectedItem.Name,
                                price: selectedItem.Price,
                                quantity: quantity,
                            });
                        }
                    }
                });

                if (!addedToCart) {
                    showMessage('Please select a quantity of at least one item.', 'error');
                    return;
                }
                
                fetch('add_to_cart.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ items: itemsToAdd })
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        showMessage('Items added to cart successfully!');
                        closeModal();
                    } else {
                        showMessage(`Error: ${data.message}`, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showMessage('An unexpected error occurred.', 'error');
                });
            });

            function showMessage(message, type = 'success') {
                messageText.innerText = message;
                messageBox.classList.remove('bg-green-500', 'bg-red-500');
                if (type === 'success') {
                    messageBox.classList.add('bg-green-500');
                } else {
                    messageBox.classList.add('bg-red-500');
                }
                messageBox.classList.add('show');
                setTimeout(() => {
                    messageBox.classList.remove('show');
                }, 3000);
            }
        });
    </script>
</body>
</html>
