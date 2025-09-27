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

/**
 * Function to convert Google Drive URL to a direct thumbnail link.
 */
function getDirectImageUrl($url, $size = "w400-h300") {
    if (!empty($url) && preg_match('/(?:d\/|id=)([a-zA-Z0-9_-]+)/', $url, $matches)) {
        $fileId = $matches[1];
        return "https://drive.google.com/thumbnail?id=" . $fileId . "&sz=" . $size;
    }
    return "https://placehold.co/400x300/e5e7eb/7f8c8d?text=No+Image";
}

// Get logged-in user's name from the session if it exists
$loggedInUserName = isset($_SESSION['full_name']) ? htmlspecialchars($_SESSION['full_name']) : '';

// SQL query to fetch all new arrival items with their price range
$sql_all_items = "
    SELECT
        i.ItemID,
        i.Name,
        i.ProductPhoto,
        MIN(COALESCE(v.Price, i.Price)) AS min_price,
        MAX(COALESCE(v.Price, i.Price)) AS max_price
    FROM Item_List AS i
    LEFT JOIN Product_Variants AS v ON i.ItemID = v.ItemID
    WHERE i.AvailabilityStatus = 'Available' AND i.NewArrival = 1
    GROUP BY i.ItemID
    ORDER BY i.ItemID DESC
";
$result_all_items = $conn->query($sql_all_items);

?>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Arrivals - Falcon Stationery PVT LTD</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.6); justify-content: center; align-items: center; }
        .modal-content { background-color: #fefefe; padding: 2rem; border-radius: 0.5rem; width: 90%; max-width: 500px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); position: relative; animation: slide-down 0.3s ease-out; }
        @keyframes slide-down { from { transform: translateY(-30px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .close-button { color: #aaa; position: absolute; top: 10px; right: 15px; font-size: 28px; font-weight: bold; cursor: pointer; }
        .message-box { position: fixed; bottom: 20px; right: 20px; z-index: 1050; padding: 1rem 1.5rem; border-radius: 0.5rem; color: white; opacity: 0; transform: translateY(20px); transition: opacity 0.3s ease, transform 0.3s ease; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        .message-box.show { opacity: 1; transform: translateY(0); }
        .loader { border: 4px solid #f3f3f3; border-top: 4px solid #3498db; border-radius: 50%; width: 24px; height: 24px; animation: spin 1s linear infinite; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
    </style>
</head>
<body class="bg-gray-50">

    <header class="bg-white shadow-md sticky top-0 z-50">
        <div class="container mx-auto px-4 py-4 flex items-center justify-between">
            <a href="index.php" class="flex items-center space-x-2"><img src="./images/logo.png" alt="Logo" class="h-10"></a>
            <nav class="hidden md:flex items-center space-x-6">
                <a href="index.php" class="text-gray-600 hover:text-blue-600 transition">Home</a>
                <a href="stationeries.php" class="text-gray-600 hover:text-blue-600 transition">Stationeries</a>
                <a href="cosmetics.php" class="text-gray-600 hover:text-blue-600 transition">Cosmetics</a>
                <a href="new_arrivals.php" class="text-blue-600 font-semibold border-b-2 border-blue-600">New Arrivals</a>
                <a href="contact.php" class="text-gray-600 hover:text-blue-600 transition">Contact Us</a>
            </nav>
            <div class="flex items-center space-x-4">
                <a href="cart.php" class="text-gray-600 hover:text-blue-600 transition relative">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" /></svg>
                    <span id="cart-item-count" class="absolute -top-2 -right-2 bg-blue-600 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center"><?php echo isset($_SESSION['cart']) ? count($_SESSION['cart']) : 0; ?></span>
                </a>
                <div class="flex items-center space-x-2 md:space-x-4">
                    <?php if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true): ?>
                        <div class="hidden md:block text-gray-600">Welcome, <span class="font-semibold"><?php echo $loggedInUserName; ?></span></div>
                        <a href="profile.php" class="text-gray-600 hover:text-blue-600 transition"><svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg></a>
                    <?php else: ?>
                        <a href="login.php" class="text-white bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg font-medium transition">Login</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </header>

    <main class="container mx-auto px-4 py-12">
        <h1 class="text-4xl font-bold text-gray-800 mb-8 text-center">Our Latest Arrivals</h1>
        <div id="product-list" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
            <?php
            if ($result_all_items && $result_all_items->num_rows > 0) {
                while($item = $result_all_items->fetch_assoc()) {
            ?>
            <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow overflow-hidden group product-item flex flex-col relative">
                <a href="product_detail.php?ItemID=<?php echo htmlspecialchars($item['ItemID']); ?>" class="block flex-grow">
                    <img src="<?php echo htmlspecialchars(getDirectImageUrl($item['ProductPhoto'])); ?>" alt="<?php echo htmlspecialchars($item['Name']); ?>" class="w-full object-cover group-hover:scale-105 transition-transform">
                    <div class="p-4">
                        <h3 class="text-lg font-semibold text-gray-900 truncate"><?php echo htmlspecialchars($item['Name']); ?></h3>
                        <p class="text-gray-500 mt-1">
                            <?php if ($item['min_price'] != $item['max_price']): ?>
                                LKR <?php echo number_format($item['min_price'], 2); ?> - LKR <?php echo number_format($item['max_price'], 2); ?>
                            <?php else: ?>
                                LKR <?php echo number_format($item['min_price'], 2); ?>
                            <?php endif; ?>
                        </p>
                    </div>
                </a>
                <button class="add-to-cart-btn absolute top-4 right-4 bg-blue-600 text-white p-3 rounded-full shadow-lg hover:bg-blue-700 transition-all duration-300 md:opacity-0 md:group-hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-blue-500" data-item-id="<?php echo htmlspecialchars($item['ItemID']); ?>">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
                </button>
            </div>
            <?php
                }
            } else {
                echo "<p class='col-span-full text-center text-gray-500 text-lg py-12'>No new arrivals at the moment. Please check back later!</p>";
            }
            ?>
        </div>
    </main>

    <footer class="bg-gray-800 text-white mt-12">
        <div class="container mx-auto px-4 py-6 text-center">
            <p>&copy; <?php echo date("Y"); ?> Falcon Stationery PVT LTD. All Rights Reserved.</p>
        </div>
    </footer>

    <!-- Modal for Add to Cart -->
    <div id="addToCartModal" class="modal">
        <div class="modal-content">
            <span class="close-button">&times;</span>
            <div id="modal-loader" class="flex justify-center items-center h-64"><div class="loader"></div></div>
            <div id="modal-dynamic-content" class="hidden">
                <h2 id="modal-product-name" class="text-2xl font-bold mb-4 text-left"></h2>
                <p class="text-gray-600 mb-6 text-left">Please enter the quantity for each item variant you wish to add.</p>
                <form id="add-to-cart-form">
                    <div id="modal-variants-container" class="space-y-4 max-h-64 overflow-y-auto pr-2 text-left"></div>
                    <div class="mt-6 flex justify-end space-x-4">
                        <button type="button" class="modal-cancel-btn bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-6 rounded-lg transition-colors">Cancel</button>
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition-colors">Finalize Add to Cart</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Message Box -->
    <div id="message-box" class="message-box"></div>

    <script>
    document.addEventListener('DOMContentLoaded', () => {
        const modal = document.getElementById('addToCartModal');
        const modalLoader = document.getElementById('modal-loader');
        const modalDynamicContent = document.getElementById('modal-dynamic-content');
        const modalProductName = document.getElementById('modal-product-name');
        const modalVariantsContainer = document.getElementById('modal-variants-container');
        const modalForm = document.getElementById('add-to-cart-form');
        const messageBox = document.getElementById('message-box');
        const cartItemCountElement = document.getElementById('cart-item-count');

        const formatCurrencyJS = (value) => parseFloat(value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");

        const showMessage = (message, type = 'success') => {
            messageBox.textContent = message;
            messageBox.className = 'message-box show ';
            messageBox.classList.add(type === 'error' ? 'bg-red-500' : 'bg-green-500');
            setTimeout(() => { messageBox.classList.remove('show'); }, 3000);
        };

        const closeModal = () => {
            modal.style.display = 'none';
            modalDynamicContent.classList.add('hidden');
            modalLoader.style.display = 'flex';
        };

        const openModal = async (itemId) => {
            modal.style.display = 'flex';
            modalForm.dataset.currentItemId = itemId;
            try {
                const response = await fetch(`get_product_variants.php?ItemID=${itemId}`);
                if (!response.ok) throw new Error('Network response was not ok');
                const data = await response.json();

                modalProductName.textContent = data.product.Name;
                modalVariantsContainer.innerHTML = '';

                if (data.variants.length > 0) {
                    data.variants.forEach(variant => {
                        modalVariantsContainer.innerHTML += `
                            <div class="flex items-center justify-between p-3 bg-gray-100 rounded-lg">
                                <div>
                                    <p class="font-semibold text-gray-900">${variant.VariantName}</p>
                                    <p class="text-sm text-gray-600">LKR ${formatCurrencyJS(variant.Price)}</p>
                                </div>
                                <input type="number" data-variant-id="${variant.VariantID}" min="0" value="0" class="quantity-input w-20 px-2 py-1 text-center border border-gray-300 rounded-lg">
                            </div>`;
                    });
                } else {
                    modalVariantsContainer.innerHTML += `
                        <div class="flex items-center justify-between p-3 bg-gray-100 rounded-lg">
                            <div>
                                <p class="font-semibold text-gray-900">${data.product.Name}</p>
                                <p class="text-sm text-gray-600">LKR ${formatCurrencyJS(data.product.Price)}</p>
                            </div>
                            <input type="number" min="0" value="0" class="quantity-input w-20 px-2 py-1 text-center border border-gray-300 rounded-lg">
                        </div>`;
                }
                modalLoader.style.display = 'none';
                modalDynamicContent.classList.remove('hidden');
            } catch (error) {
                console.error('Failed to fetch product variants:', error);
                showMessage('Could not load product details. Please try again.', 'error');
                closeModal();
            }
        };

        document.getElementById('product-list').addEventListener('click', (e) => {
            const cartButton = e.target.closest('.add-to-cart-btn');
            if (cartButton) {
                const itemId = cartButton.dataset.itemId;
                openModal(itemId);
            }
        });

        modalForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const submitButton = e.target.querySelector('button[type="submit"]');
            submitButton.disabled = true;
            submitButton.innerHTML = '<div class="loader mx-auto"></div>';

            const itemsToAdd = [];
            const quantityInputs = modalVariantsContainer.querySelectorAll('.quantity-input');
            const currentItemId = modalForm.dataset.currentItemId;

            quantityInputs.forEach(input => {
                const quantity = parseInt(input.value, 10);
                if (quantity > 0) {
                    const variantId = input.dataset.variantId || null;
                    itemsToAdd.push({ id: currentItemId, variant_id: variantId, quantity });
                }
            });

            if (itemsToAdd.length === 0) {
                showMessage('Please select a quantity for at least one item.', 'error');
                submitButton.disabled = false;
                submitButton.textContent = 'Finalize Add to Cart';
                return;
            }

            try {
                const response = await fetch('add_to_cart.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ items: itemsToAdd })
                });
                const result = await response.json();
                if (result.success) {
                    showMessage('Items added to cart successfully!');
                    cartItemCountElement.textContent = result.cart_item_count;
                } else {
                    showMessage(result.message || 'Could not add items to cart.', 'error');
                }
            } catch (error) {
                console.error('Error adding to cart:', error);
                showMessage('An error occurred. Please try again.', 'error');
            } finally {
                submitButton.disabled = false;
                submitButton.textContent = 'Finalize Add to Cart';
                closeModal();
            }
        });

        modal.addEventListener('click', (e) => {
            if (e.target === modal || e.target.classList.contains('close-button') || e.target.classList.contains('modal-cancel-btn')) {
                closeModal();
            }
        });
    });
    </script>
</body>
</html>
