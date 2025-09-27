<?php
// Start the session
session_start();

// --- Database Connection and Helper Functions ---
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
if ($conn->connect_error) {
    die("ERROR: Could not connect. " . $conn->connect_error);
}

function formatCurrency($value) {
    return number_format(floatval($value), 2);
}

function getDirectImageUrl($url, $size = "w200-h200") {
    if (!empty($url) && preg_match('/(?:d\/|id=)([a-zA-Z0-9_-]+)/', $url, $matches)) {
        $fileId = $matches[1];
        return "https://drive.google.com/thumbnail?id=" . $fileId . "&sz=" . $size;
    }
    return "https://placehold.co/200x200/e5e7eb/7f8c8d?text=No+Image";
}

// Get logged-in user's name from the session if it exists
$loggedInUserName = isset($_SESSION['full_name']) ? htmlspecialchars($_SESSION['full_name']) : '';
$cart = isset($_SESSION['cart']) && is_array($_SESSION['cart']) ? $_SESSION['cart'] : [];

// --- Recalculate cart total on every page load to ensure accuracy ---
$cart_total = 0;
foreach ($cart as $item) {
    $cart_total += (floatval($item['price']) * intval($item['quantity']));
}
$_SESSION['cart_total'] = $cart_total;


// --- Optimized Data Fetching for Cart Items ---
$item_ids_from_cart = [];
$variant_ids_from_cart = [];
if (!empty($cart)) {
    foreach ($cart as $cart_item) {
        $item_ids_from_cart[] = intval($cart_item['item_id']);
        if ($cart_item['variant_id'] > 0) {
            $variant_ids_from_cart[] = intval($cart_item['variant_id']);
        }
    }
}

$products_data = [];
$variants_data = [];

// Fetch all main product data in one query
if (!empty($item_ids_from_cart)) {
    $item_ids_unique = array_unique($item_ids_from_cart);
    $in_clause = implode(',', array_fill(0, count($item_ids_unique), '?'));
    $types = str_repeat('i', count($item_ids_unique));
    
    $stmt = $conn->prepare("SELECT ItemID, Name, ProductPhoto FROM Item_List WHERE ItemID IN ($in_clause)");
    if ($stmt) {
        $stmt->bind_param($types, ...$item_ids_unique);
        $stmt->execute();
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $products_data[$row['ItemID']] = $row;
        }
        $stmt->close();
    }
}

// Fetch all variant data in one query
if (!empty($variant_ids_from_cart)) {
    $variant_ids_unique = array_unique($variant_ids_from_cart);
    $in_clause = implode(',', array_fill(0, count($variant_ids_unique), '?'));
    $types = str_repeat('i', count($variant_ids_unique));
    
    $stmt = $conn->prepare("SELECT VariantID, ItemID, VariantName, ProductPhoto FROM Product_Variants WHERE VariantID IN ($in_clause)");
    if ($stmt) {
        $stmt->bind_param($types, ...$variant_ids_unique);
        $stmt->execute();
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $variants_data[$row['VariantID']] = $row;
        }
        $stmt->close();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Falcon Stationery PVT LTD</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; background-color: #f3f4f6; }
        .message-box { position: fixed; top: 20px; left: 50%; z-index: 1050; padding: 1rem 2rem; border-radius: 0.5rem; color: white; opacity: 0; transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out; transform: translateY(-20px) translateX(-50%); }
        .message-box.show { opacity: 1; transform: translateY(0) translateX(-50%); }
        .loader { border: 4px solid #f3f3f3; border-top: 4px solid #3498db; border-radius: 50%; width: 20px; height: 20px; animation: spin 2s linear infinite; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        .modal-overlay { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0, 0, 0, 0.5); display: flex; justify-content: center; align-items: center; z-index: 1040; opacity: 0; transition: opacity 0.3s ease; visibility: hidden; }
        .modal-overlay.visible { opacity: 1; visibility: visible; }
        .modal-content { background: white; padding: 2rem; border-radius: 0.5rem; max-width: 400px; width: 90%; text-align: center; transform: scale(0.95); transition: transform 0.3s ease; }
        .modal-overlay.visible .modal-content { transform: scale(1); }
    </style>
</head>
<body class="bg-gray-50 text-gray-800">

    <!-- Header -->
    <header class="bg-white shadow-md flex-shrink-0">
        <div class="container mx-auto px-4 py-4 flex items-center justify-between">
            <a href="index.php" class="flex items-center space-x-2"><img src="./images/logo.png" alt="Logo" class="h-10"></a>
            <nav class="hidden md:flex items-center space-x-6">
                <a href="index.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Home</a>
                <a href="stationeries.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Stationeries</a>
                <a href="cosmetics.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Cosmetics</a>
                <a href="new_arrivals.php" class="text-gray-600 hover:text-blue-600 transition duration-300">New Arrivals</a>
                <a href="contact.php" class="text-gray-600 hover:text-blue-600 transition duration-300">Contact Us</a>
            </nav>
            <div class="flex items-center space-x-4">
                <a href="cart.php" class="text-blue-600 font-semibold border-b-2 border-blue-600 transition duration-300 relative">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" /></svg>
                    <span id="cart-item-count" class="absolute -top-2 -right-2 bg-blue-600 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center"><?php echo count($cart); ?></span>
                </a>
                <div class="flex items-center space-x-2 md:space-x-4">
                    <?php if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true): ?>
                        <div class="hidden md:block text-gray-600">Welcome, <span class="font-semibold"><?php echo $loggedInUserName; ?></span></div>
                        <a href="profile.php" class="text-gray-600 hover:text-blue-600 transition duration-300"><svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg></a>
                    <?php else: ?>
                        <a href="login.php" class="text-white bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg font-medium transition duration-300">Login</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </header>

    <div class="container mx-auto px-4 py-12">
        <h1 class="text-4xl font-bold text-gray-900 mb-8 text-center">Your Shopping Cart</h1>
        <?php if (!empty($cart)): ?>
            <div class="bg-white rounded-lg shadow-xl p-6 mb-8">
                <div class="hidden md:grid grid-cols-6 gap-4 items-center border-b pb-4 text-gray-500 font-semibold uppercase tracking-wide text-sm">
                    <div class="col-span-2">Product</div>
                    <div class="text-center">Price</div>
                    <div class="text-center">Quantity</div>
                    <div class="text-right">Subtotal</div>
                    <div></div> <!-- Empty header for remove button -->
                </div>
                <?php foreach ($cart as $cart_key => $item):
                    $item_id = intval($item['item_id']);
                    $variant_id = intval($item['variant_id']);

                    $main_product = $products_data[$item_id] ?? null;
                    if (!$main_product) continue; 

                    $display_name = $main_product['Name'];
                    $display_photo = $main_product['ProductPhoto'];
                    
                    if ($variant_id > 0 && isset($variants_data[$variant_id])) {
                        $variant_info = $variants_data[$variant_id];
                        $display_name = $main_product['Name'] . ' - ' . htmlspecialchars($item['name']);
                        if (!empty($variant_info['ProductPhoto'])) {
                            $display_photo = $variant_info['ProductPhoto'];
                        }
                    }
                ?>
                <div class="grid grid-cols-1 md:grid-cols-6 gap-4 items-center py-4 border-b last:border-b-0" data-cart-key="<?php echo htmlspecialchars($cart_key); ?>">
                    <div class="col-span-2 flex items-center space-x-4">
                        <img src="<?php echo htmlspecialchars(getDirectImageUrl($display_photo)); ?>" alt="<?php echo htmlspecialchars($display_name); ?>" class="w-20 h-20 rounded-lg object-cover shadow-md">
                        <span class="font-semibold text-gray-900"><?php echo htmlspecialchars($display_name); ?></span>
                    </div>
                    <div class="text-center text-gray-600" data-item-price="<?php echo htmlspecialchars($item['price']); ?>">LKR <?php echo formatCurrency($item['price']); ?></div>
                    <div class="text-center">
                        <input type="number" value="<?php echo htmlspecialchars($item['quantity']); ?>" min="0" class="quantity-input w-20 text-center border rounded-lg py-1 px-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="text-right font-semibold text-gray-900" data-subtotal-display>LKR <?php echo formatCurrency($item['price'] * $item['quantity']); ?></div>
                    <div class="text-right">
                        <button type="button" class="remove-item-btn text-red-500 hover:text-red-700 transition-colors font-semibold" data-cart-key="<?php echo htmlspecialchars($cart_key); ?>">Remove</button>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>

            <div class="flex flex-col md:flex-row justify-between items-center mt-8 gap-4">
                <a href="index.php" class="bg-gray-200 text-gray-800 py-3 px-6 rounded-lg font-semibold hover:bg-gray-300 transition-colors w-full md:w-auto text-center">Continue Shopping</a>
                <div class="flex flex-col items-end w-full md:w-auto">
                    <div class="flex justify-end items-center mb-4">
                        <p class="text-2xl font-bold text-gray-900">Grand Total:</p>
                        <p id="grand-total-display" class="text-2xl font-bold text-blue-600 ml-4">LKR <?php echo formatCurrency($cart_total); ?></p>
                    </div>
                    <!-- MODIFIED BUTTON -->
                    <a href="complete_order.php" class="bg-green-600 text-white py-3 px-6 rounded-lg font-semibold hover:bg-green-700 transition-colors w-full md:w-auto text-center">
                        Complete Order
                    </a>
                </div>
            </div>
            
        <?php else: ?>
            <div class="bg-white rounded-lg shadow-xl p-12 text-center">
                <p class="text-2xl text-gray-500">Your cart is empty.</p>
                <a href="index.php" class="mt-6 inline-block bg-blue-600 text-white py-3 px-6 rounded-lg font-semibold hover:bg-blue-700 transition-colors">Start Shopping</a>
            </div>
        <?php endif; ?>
    </div>
    
    <div id="message-box" class="message-box bg-blue-500"></div>

    <!-- Confirmation Modal -->
    <div id="confirmation-modal" class="modal-overlay">
        <div class="modal-content">
            <h2 class="text-xl font-bold mb-4" id="modal-title">Are you sure?</h2>
            <p class="text-gray-600 mb-6" id="modal-body">Do you really want to remove this item?</p>
            <div class="flex justify-center space-x-4">
                <button id="modal-cancel-btn" class="bg-gray-300 text-gray-800 font-bold py-2 px-6 rounded-lg hover:bg-gray-400">Cancel</button>
                <button id="modal-confirm-btn" class="bg-red-600 text-white font-bold py-2 px-6 rounded-lg hover:bg-red-700">Yes, Remove</button>
            </div>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; <?php echo date("Y"); ?> Falcon Stationery PVT LTD. All Rights Reserved.</p>
        </div>
    </footer>

    <?php $conn->close(); ?>
    <script>
    document.addEventListener('DOMContentLoaded', () => {
        const grandTotalDisplay = document.getElementById('grand-total-display');
        const messageBox = document.getElementById('message-box');
        const modal = document.getElementById('confirmation-modal');
        const modalConfirmBtn = document.getElementById('modal-confirm-btn');
        const modalCancelBtn = document.getElementById('modal-cancel-btn');
        let updateTimeout = null;
        let cartKeyToRemove = null;

        const formatCurrencyJS = (value) => {
            return parseFloat(value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        };

        const showMessage = (message, type = 'success') => {
            messageBox.textContent = message;
            messageBox.className = 'message-box show ';
            if (type === 'error') {
                messageBox.classList.add('bg-red-500');
            } else {
                messageBox.classList.add('bg-green-500');
            }
            setTimeout(() => messageBox.classList.remove('show'), 3000);
        };

        const updateCart = async (cartKey, quantity, action = 'update') => {
            const itemRow = document.querySelector(`[data-cart-key="${cartKey}"]`);
            if (!itemRow) return;

            const subtotalDisplay = itemRow.querySelector('[data-subtotal-display]');
            const originalSubtotal = subtotalDisplay.innerHTML;
            subtotalDisplay.innerHTML = '<div class="loader ml-auto"></div>';

            try {
                const response = await fetch('update_cart_quantity.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ cartKey, quantity, action })
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                
                const result = await response.json();

                if (result.success) {
                    if (action === 'remove' || quantity === 0) {
                        itemRow.style.transition = 'opacity 0.5s';
                        itemRow.style.opacity = '0';
                        setTimeout(() => {
                           itemRow.remove();
                           if (document.querySelectorAll('[data-cart-key]').length === 0) {
                               window.location.reload();
                           }
                        }, 500);
                    } else {
                        subtotalDisplay.textContent = `LKR ${formatCurrencyJS(result.item_subtotal)}`;
                    }
                    grandTotalDisplay.textContent = `LKR ${formatCurrencyJS(result.cart_total)}`;
                    document.getElementById('cart-item-count').textContent = result.cart_item_count;
                } else {
                    showMessage(result.message, 'error');
                    subtotalDisplay.innerHTML = originalSubtotal;
                }
            } catch (error) {
                console.error('Error updating cart:', error);
                showMessage('An error occurred. Please try again.', 'error');
                subtotalDisplay.innerHTML = originalSubtotal;
            }
        };
        
        const openModal = (cartKey) => {
            cartKeyToRemove = cartKey;
            modal.classList.add('visible');
        };
        const closeModal = () => {
            cartKeyToRemove = null;
            modal.classList.remove('visible');
        };

        modalConfirmBtn.addEventListener('click', () => {
            if (cartKeyToRemove) {
                updateCart(cartKeyToRemove, 0, 'remove');
            }
            closeModal();
        });
        modalCancelBtn.addEventListener('click', closeModal);
        modal.addEventListener('click', (e) => {
            if (e.target === modal) closeModal();
        });


        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('change', (e) => {
                const cartKey = e.target.closest('[data-cart-key]').dataset.cartKey;
                const quantity = parseInt(e.target.value);
                
                clearTimeout(updateTimeout);
                
                if (isNaN(quantity)) {
                    e.target.value = 1;
                    return;
                }
                
                updateTimeout = setTimeout(() => {
                    updateCart(cartKey, quantity, quantity === 0 ? 'remove' : 'update');
                }, 500);
            });
        });

        document.querySelectorAll('.remove-item-btn').forEach(button => {
            button.addEventListener('click', (e) => {
                const cartKey = e.target.dataset.cartKey;
                openModal(cartKey);
            });
        });
    });
    </script>
</body>
</html>

