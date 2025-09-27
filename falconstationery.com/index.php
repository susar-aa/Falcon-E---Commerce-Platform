<?php
// Start the session
session_start();

// Enable error reporting for debugging
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Database connection details
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'falcon');
define('DB_PASSWORD', 'falcon@12369');
define('DB_NAME', 'falcon_stationary');

// Attempt to connect to MySQL database
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check connection
if($conn->connect_error){
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

// --- QUERIES for the page ---

// 1. Fetch images from the 'banners' folder for the Hero Slider
$banner_images = glob('banners/*.{jpg,jpeg,png,gif}', GLOB_BRACE);

// 2. Fetch subcategories for the new "Shop by Category" section - now fetching 8
$sql_subcategories_showcase = "SELECT SubCategoryID, CategoryID, SubCategoryName, IconPath FROM SubCategory WHERE AvailabilityStatus = 'Available' ORDER BY RAND() LIMIT 8";
$result_subcategories_showcase = $conn->query($sql_subcategories_showcase);
$subcategories = [];
if ($result_subcategories_showcase && $result_subcategories_showcase->num_rows > 0) {
    while ($row = $result_subcategories_showcase->fetch_assoc()) {
        $subcategories[] = $row;
    }
}


// 3. SQL query for New Arrivals section (limit 8, for horizontal scroll)
$sql_new_arrivals = "
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
    LIMIT 8
";
$result_new_arrivals = $conn->query($sql_new_arrivals);

// 4. SQL query to select up to 8 featured items
$sql_featured_items = "
    SELECT 
        i.ItemID, 
        i.Name, 
        i.ProductPhoto, 
        MIN(COALESCE(v.Price, i.Price)) AS min_price,
        MAX(COALESCE(v.Price, i.Price)) AS max_price
    FROM Item_List AS i
    LEFT JOIN Product_Variants AS v ON i.ItemID = v.ItemID
    WHERE i.AvailabilityStatus = 'Available'
    GROUP BY i.ItemID
    ORDER BY RAND()
    LIMIT 8
";
$result_featured_items = $conn->query($sql_featured_items);

?>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Falcon Stationery PVT LTD - Wholesale Partner</title>
    <meta property="og:title" content="Falcon Stationery PVT LTD - Your Wholesale Partner">
    <meta property="og:description" content="Leading wholesale suppliers of high-quality stationery and cosmetic products in Sri Lanka. Partner with us for competitive pricing and a wide selection.">
    <meta property="og:image" content="https://falconstationery-pvt-ltd.lionsgoldencircle.com/images/falcon-og-image.png">
    <meta property="og:url" content="https://falconstationery-pvt-ltd.lionsgoldencircle.com">
    <meta property="og:type" content="website">
    
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
        body { font-family: 'Inter', sans-serif; }
        
        /* -- Custom Styles for Slider -- */
        .slider-container { position: relative; overflow: hidden; }
        .slider-wrapper { display: flex; transition: transform 0.5s ease-in-out; }
        .slider-slide { min-width: 100%; box-sizing: border-box; }
        .slider-slide img { width: 100%; height: 100%; object-fit: cover; }
        .slider-dots { position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%); display: flex; gap: 8px; }
        .slider-dot { width: 12px; height: 12px; border-radius: 50%; background-color: rgba(255, 255, 255, 0.5); cursor: pointer; transition: background-color 0.3s; }
        .slider-dot.active { background-color: white; }

        /* -- Styles for Add to Cart Modal and Message Box -- */
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.6); justify-content: center; align-items: center; }
        .modal-content { background-color: #fefefe; padding: 2rem; border-radius: 0.5rem; width: 90%; max-width: 500px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); position: relative; animation: slide-down 0.3s ease-out; }
        @keyframes slide-down { from { transform: translateY(-30px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .close-button { color: #aaa; position: absolute; top: 10px; right: 15px; font-size: 28px; font-weight: bold; cursor: pointer; }
        .message-box { position: fixed; bottom: 20px; right: 20px; z-index: 1050; padding: 1rem 1.5rem; border-radius: 0.5rem; color: white; opacity: 0; transform: translateY(20px); transition: opacity 0.3s ease, transform 0.3s ease; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        .message-box.show { opacity: 1; transform: translateY(0); }
        .loader { border: 4px solid #f3f3f3; border-top: 4px solid #3b82f6; border-radius: 50%; width: 24px; height: 24px; animation: spin 1s linear infinite; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        /* -- Custom scrollbar for product carousels -- */
        .scroll-container::-webkit-scrollbar { height: 8px; }
        .scroll-container::-webkit-scrollbar-thumb { background-color: #d1d5db; border-radius: 4px; }
        .scroll-container::-webkit-scrollbar-track { background-color: #f3f4f6; }

        /* -- Scroll Reveal Animation Styles -- */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.6s ease-out, transform 0.6s ease-out;
        }
        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* -- Professional Hero Text Animations -- */
        @keyframes fade-in-down {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fade-in-up {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in-down {
            animation: fade-in-down 0.8s ease-out forwards;
        }
        .animate-fade-in-up {
            animation: fade-in-up 0.8s ease-out 0.4s forwards; /* Added delay */
            opacity: 0; /* Start hidden */
        }
        
        /* -- Professional Order Now Button -- */
        .pro-button {
            display: inline-flex;
            align-items: center;
            background-color: #3b82f6; /* Tailwind's blue-500 */
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 9999px; /* pill shape */
            font-weight: 600; /* semibold */
            text-transform: uppercase;
            letter-spacing: 0.05em;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .pro-button:hover {
            background-color: #2563eb; /* Tailwind's blue-600 */
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(0, 0, 0, 0.1);
        }
        .pro-button .icon {
            margin-left: 0.5rem;
            transition: transform 0.3s ease;
        }
        .pro-button:hover .icon {
            transform: translateX(4px);
        }

    </style>
</head>
<body class="bg-gray-50">

    <header class="bg-white shadow-md sticky top-0 z-50">
        <div class="container mx-auto px-4">
            <!-- Top bar with logo and user actions -->
            <div class="py-4 flex items-center justify-between">
                <a href="index.php" class="flex items-center space-x-2"><img src="./images/logo.png" alt="Logo" class="h-10"></a>
                <div class="flex items-center space-x-4">
                    <a href="cart.php" class="text-gray-600 hover:text-blue-600 transition relative">
                        <i class="fas fa-shopping-cart text-2xl"></i>
                        <span id="cart-item-count" class="absolute -top-2 -right-2 bg-blue-600 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center"><?php echo isset($_SESSION['cart']) ? count($_SESSION['cart']) : 0; ?></span>
                    </a>
                     <?php if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true): ?>
                        <div class="hidden md:block text-gray-600">Welcome, <span class="font-semibold"><?php echo $loggedInUserName; ?></span></div>
                        <a href="profile.php" class="text-gray-600 hover:text-blue-600 transition"><i class="fas fa-user-circle text-3xl"></i></a>
                    <?php else: ?>
                        <a href="login.php" class="text-white bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg font-medium transition">Login</a>
                    <?php endif; ?>
                </div>
            </div>
            <!-- Search and Navigation bar -->
            <div class="py-3 flex items-center justify-between gap-4 border-t">
                 <nav class="hidden md:flex items-center space-x-6">
                    <a href="index.php" class="text-blue-600 font-semibold border-b-2 border-blue-600">Home</a>
                    <a href="stationeries.php" class="text-gray-600 hover:text-blue-600 transition">Stationeries</a>
                    <a href="cosmetics.php" class="text-gray-600 hover:text-blue-600 transition">Cosmetics</a>
                    <a href="new_arrivals.php" class="text-gray-600 hover:text-blue-600 transition">New Arrivals</a>
                    <a href="contact.php" class="text-gray-600 hover:text-blue-600 transition">Contact Us</a>
                </nav>
                <div class="flex-grow relative">
                    <form action="search.php" method="GET" class="relative">
                        <input type="text" name="query" id="search-input" placeholder="Search for products..." class="w-full p-3 pl-12 border border-gray-300 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500" autocomplete="off">
                        <button type="submit" class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-500 hover:text-blue-600">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                    <div id="search-results-container" class="absolute top-full left-0 right-0 mt-2 bg-white border border-gray-200 rounded-lg shadow-lg z-50 overflow-y-auto max-h-96 hidden">
                        <!-- Live search results will be injected here -->
                    </div>
                </div>
            </div>
        </div>
    </header>

    <main>
        <!-- Hero Section with Automatic Slider -->
        <section class="slider-container w-full h-96 md:h-[600px] bg-gray-900">
            <div class="slider-wrapper h-full">
                <!-- 1. Dedicated Welcome Banner -->
                <div class="slider-slide h-full relative">
                    <img src="images/banner.png" alt="Welcome to Falcon Stationery" class="h-full w-full object-cover opacity-50">
                    <div class="absolute inset-0 flex items-center justify-center text-center p-4">
                        <div class="flex flex-col items-center">
                            <h1 class="text-white text-4xl md:text-7xl font-extrabold leading-tight animate-fade-in-down" style="text-shadow: 2px 2px 8px rgba(0,0,0,0.5);">Falcon Stationery PVT LTD</h1>
                            <p class="text-gray-200 mt-4 text-lg md:text-2xl max-w-2xl mx-auto animate-fade-in-up" style="text-shadow: 1px 1px 4px rgba(0,0,0,0.5);">Pay Less, Get More, Delivered Fast</p>
                            <div class="mt-10 animate-fade-in-up" style="animation-delay: 0.8s;">
                                <a href="stationeries.php" class="pro-button">
                                    Order Now
                                    <span class="icon"><i class="fas fa-arrow-right"></i></span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 2. Banners from the folder -->
                <?php
                if (!empty($banner_images)) {
                    foreach($banner_images as $image_path) {
                        echo '<div class="slider-slide h-full relative">';
                        echo '<img src="' . htmlspecialchars($image_path) . '" alt="Promotional Banner" class="h-full w-full object-cover">';
                        // Adding a subtle overlay for consistency, but no text
                        echo '<div class="absolute inset-0 bg-black/20"></div>';
                        echo '</div>';
                    }
                }
                ?>
            </div>
            <div class="slider-dots"></div>
        </section>

        <!-- Shop By Category Section -->
        <section class="py-16 bg-white fade-in">
            <div class="container mx-auto px-4">
                <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Shop By Category</h2>
                <div class="grid grid-cols-2 md:grid-cols-4 md:grid-rows-3 gap-4 h-[800px] md:h-[750px]">
                   <?php if (count($subcategories) >= 8): ?>
                        <?php
                        $grid_classes = [
                            'md:col-span-2 md:row-span-2', // Item 1 (Large)
                            'md:col-span-1 md:row-span-2', // Item 2 (Medium Vertical)
                            '',                            // Item 3 (Small)
                            '',                            // Item 4 (Small)
                            '',                            // Item 5 (Small)
                            '',                            // Item 6 (Small)
                            '',                            // Item 7 (Small)
                            ''                             // Item 8 (Small)
                        ];
                        foreach ($subcategories as $index => $subcategory) {
                            $sub_id = htmlspecialchars($subcategory['SubCategoryID']);
                            $sub_name = htmlspecialchars($subcategory['SubCategoryName']);
                            $main_cat_id = htmlspecialchars($subcategory['CategoryID']);
                            $icon_path = !empty($subcategory['IconPath']) ? htmlspecialchars($subcategory['IconPath']) : 'https://placehold.co/600x600/a78bfa/ffffff?text=' . urlencode($sub_name);
                            
                            $page_link = '#';
                            if ($main_cat_id == 1) {
                                $page_link = 'stationeries.php';
                            } elseif ($main_cat_id == 2) {
                                $page_link = 'cosmetics.php';
                            }
                            $link = "{$page_link}?sub_cat_id={$sub_id}";
                            
                            $item_class = 'relative rounded-lg overflow-hidden group shadow-lg hover:shadow-2xl transition-all duration-300 ' . ($grid_classes[$index] ?? '');
                        ?>
                        <a href="<?= $link ?>" class="<?= $item_class ?>">
                            <img src="<?= $icon_path ?>" alt="<?= $sub_name ?>" class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
                            <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent"></div>
                            <div class="relative h-full flex flex-col justify-between p-4 md:p-6 text-white">
                                <h3 class="text-xl md:text-2xl font-bold drop-shadow-lg"><?= $sub_name ?></h3>
                                <div class="mt-auto bg-white/20 backdrop-blur-sm rounded-full h-10 w-10 md:h-12 md:w-12 flex items-center justify-center group-hover:bg-white transition-colors duration-300">
                                    <i class="fas fa-arrow-right text-white group-hover:text-black transition-colors duration-300"></i>
                                </div>
                            </div>
                        </a>
                        <?php } ?>
                    <?php else: ?>
                        <p class='col-span-full text-center text-gray-500'>Not enough categories to display this layout (requires 8).</p>
                    <?php endif; ?>
                </div>
            </div>
        </section>


        <!-- New Arrivals Section -->
        <section class="py-16 bg-gray-50 fade-in">
            <div class="container mx-auto px-4">
                <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">New Arrivals</h2>
                <div class="flex overflow-x-auto space-x-6 pb-4 scroll-container">
                     <?php
                    if ($result_new_arrivals && $result_new_arrivals->num_rows > 0) {
                        while($item = $result_new_arrivals->fetch_assoc()) {
                    ?>
                    <div class="flex-none w-64 bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow overflow-hidden group product-item flex flex-col relative">
                        <a href="product_detail.php?ItemID=<?php echo htmlspecialchars($item['ItemID']); ?>" class="block flex-grow">
                            <img src="<?php echo htmlspecialchars(getDirectImageUrl($item['ProductPhoto'])); ?>" alt="<?php echo htmlspecialchars($item['Name']); ?>" class="w-full h-48 object-cover group-hover:scale-105 transition-transform">
                            <div class="p-4">
                                <h3 class="text-md font-semibold text-gray-900 truncate"><?php echo htmlspecialchars($item['Name']); ?></h3>
                                <p class="text-gray-500 mt-1 text-sm">
                                    <?php if ($item['min_price'] != $item['max_price']): ?>
                                        LKR <?php echo number_format($item['min_price'], 2); ?> - <?php echo number_format($item['max_price'], 2); ?>
                                    <?php else: ?>
                                        LKR <?php echo number_format($item['min_price'], 2); ?>
                                    <?php endif; ?>
                                </p>
                            </div>
                        </a>
                        <button class="add-to-cart-btn absolute top-3 right-3 bg-blue-600 text-white p-2 rounded-full shadow-lg hover:bg-blue-700 transition-all opacity-0 group-hover:opacity-100 focus:outline-none" data-item-id="<?php echo htmlspecialchars($item['ItemID']); ?>">
                             <i class="fas fa-cart-plus"></i>
                        </button>
                    </div>
                    <?php
                        }
                    }
                    ?>
                     <a href="new_arrivals.php" class="flex-none w-64 bg-gray-200 rounded-lg shadow-md hover:shadow-xl transition-shadow flex items-center justify-center text-center p-4">
                        <div>
                            <h3 class="text-xl font-bold text-gray-700">View All</h3>
                            <i class="fas fa-arrow-right text-2xl text-gray-600 mt-4"></i>
                        </div>
                    </a>
                </div>
            </div>
        </section>
        
        <!-- Featured Products Section -->
        <section class="py-16 bg-white fade-in">
            <div class="container mx-auto px-4">
                <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Featured Products</h2>
                <div class="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-4 gap-6">
                    <?php
                    if ($result_featured_items && $result_featured_items->num_rows > 0) {
                        while($item = $result_featured_items->fetch_assoc()) {
                    ?>
                    <div class="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow overflow-hidden group product-item flex flex-col relative">
                        <a href="product_detail.php?ItemID=<?php echo htmlspecialchars($item['ItemID']); ?>" class="block flex-grow">
                            <img src="<?php echo htmlspecialchars(getDirectImageUrl($item['ProductPhoto'])); ?>" alt="<?php echo htmlspecialchars($item['Name']); ?>" class="w-full h-48 object-cover group-hover:scale-105 transition-transform">
                            <div class="p-4">
                                <h3 class="text-md font-semibold text-gray-900 truncate"><?php echo htmlspecialchars($item['Name']); ?></h3>
                                 <p class="text-gray-500 mt-1 text-sm">
                                    <?php if ($item['min_price'] != $item['max_price']): ?>
                                        LKR <?php echo number_format($item['min_price'], 2); ?> - <?php echo number_format($item['max_price'], 2); ?>
                                    <?php else: ?>
                                        LKR <?php echo number_format($item['min_price'], 2); ?>
                                    <?php endif; ?>
                                </p>
                            </div>
                        </a>
                        <button class="add-to-cart-btn absolute top-3 right-3 bg-blue-600 text-white p-2 rounded-full shadow-lg hover:bg-blue-700 transition-all opacity-0 group-hover:opacity-100 focus:outline-none" data-item-id="<?php echo htmlspecialchars($item['ItemID']); ?>">
                             <i class="fas fa-cart-plus"></i>
                        </button>
                    </div>
                     <?php
                        }
                    } else {
                        echo "<p class='col-span-full text-center text-gray-500'>No featured products available.</p>";
                    }
                    ?>
                </div>
            </div>
        </section>
        
        <!-- Why Choose Us Section -->
        <section class="py-16 bg-blue-700 text-white fade-in">
            <div class="container mx-auto px-4 text-center">
                <h2 class="text-3xl font-bold mb-2">Why Partner With Us?</h2>
                <p class="text-blue-200 max-w-3xl mx-auto mb-12">We are more than a supplier; we are the foundation for your business's success.</p>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="bg-blue-800 p-8 rounded-lg transform hover:scale-105 transition-transform duration-300"><i class="fas fa-boxes text-4xl mb-4"></i><h3 class="text-xl font-bold mb-2">Extensive Product Range</h3><p class="text-blue-200">Our diverse catalog meets all your retail needs.</p></div>
                    <div class="bg-blue-800 p-8 rounded-lg transform hover:scale-105 transition-transform duration-300"><i class="fas fa-hand-holding-usd text-4xl mb-4"></i><h3 class="text-xl font-bold mb-2">Competitive Wholesale Pricing</h3><p class="text-blue-200">Maximize your profit margins with our bulk pricing.</p></div>
                    <div class="bg-blue-800 p-8 rounded-lg transform hover:scale-105 transition-transform duration-300"><i class="fas fa-truck-fast text-4xl mb-4"></i><h3 class="text-xl font-bold mb-2">Reliable Island-wide Delivery</h3><p class="text-blue-200">Efficient logistics ensure timely delivery, every time.</p></div>
                </div>
            </div>
        </section>
        
    </main>

    <footer class="bg-gray-800 text-white">
        <div class="container mx-auto px-4 py-12">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div><h3 class="text-xl font-bold mb-4">Falcon Stationery</h3><p class="text-gray-400">Your trusted partner for wholesale supplies in Sri Lanka.</p></div>
                <div><h3 class="text-lg font-semibold mb-4">Quick Links</h3><ul class="space-y-2"><li><a href="stationeries.php" class="hover:text-blue-400 transition">Stationeries</a></li><li><a href="cosmetics.php" class="hover:text-blue-400 transition">Cosmetics</a></li><li><a href="login.php" class="hover:text-blue-400 transition">Account Login</a></li></ul></div>
                <div><h3 class="text-lg font-semibold mb-4">Contact Info</h3><p class="text-gray-400">No 79, Dambakanda Estate, Boyagane, Kurunegala</p><p class="text-gray-400 mt-2">Phone: 077 862 8023</p><p class="text-gray-400">Email: falconstationary@gmail.com</p></div>
                <div><h3 class="text-lg font-semibold mb-4">Follow Us</h3><div class="flex space-x-4"><a href="#" class="text-gray-400 hover:text-white transition"><i class="fab fa-facebook-f fa-lg"></i></a><a href="#" class="text-gray-400 hover:text-white transition"><i class="fab fa-instagram fa-lg"></i></a><a href="#" class="text-gray-400 hover:text-white transition"><i class="fab fa-whatsapp fa-lg"></i></a></div></div>
            </div>
            <div class="mt-8 border-t border-gray-700 pt-6 text-center text-gray-500"><p>&copy; <?php echo date("Y"); ?> Falcon Stationery PVT LTD. All Rights Reserved.</p></div>
        </div>
    </footer>

    <!-- Modal for Add to Cart -->
    <div id="addToCartModal" class="modal">
        <div class="modal-content">
            <span class="close-button">&times;</span>
            <div id="modal-loader" class="flex justify-center items-center h-64"><div class="loader"></div></div>
            <div id="modal-dynamic-content" class="hidden">
                <h2 id="modal-product-name" class="text-2xl font-bold mb-4 text-left"></h2>
                <p class="text-gray-600 mb-6 text-left">Please enter the quantity for each variant.</p>
                <form id="add-to-cart-form">
                    <div id="modal-variants-container" class="space-y-4 max-h-64 overflow-y-auto pr-2 text-left"></div>
                    <div class="mt-6 flex justify-end space-x-4">
                        <button type="button" class="modal-cancel-btn bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-6 rounded-lg transition-colors">Cancel</button>
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition-colors">Add to Cart</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Message Box -->
    <div id="message-box" class="message-box"></div>

    <script>
    document.addEventListener('DOMContentLoaded', () => {
        // --- Landing Page Animations ---
        const observerOptions = {
            root: null,
            rootMargin: '0px',
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });

        // --- Live Search Logic ---
        const searchInput = document.getElementById('search-input');
        const searchResultsContainer = document.getElementById('search-results-container');
        let searchTimeout;

        searchInput.addEventListener('input', () => {
            clearTimeout(searchTimeout);
            const query = searchInput.value.trim();

            if (query.length < 2) {
                searchResultsContainer.innerHTML = '';
                searchResultsContainer.classList.add('hidden');
                return;
            }

            searchTimeout = setTimeout(() => {
                fetch(`live_search.php?query=${encodeURIComponent(query)}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(data => {
                        searchResultsContainer.innerHTML = ''; // Clear previous results
                        if (data.length > 0) {
                            data.forEach(item => {
                                const resultLink = document.createElement('a');
                                resultLink.href = `product_detail.php?ItemID=${item.ItemID}`;
                                resultLink.className = 'flex items-center p-3 hover:bg-gray-100 transition-colors border-b last:border-b-0';
                                
                                resultLink.innerHTML = `
                                    <img src="${item.ProductPhoto}" alt="${item.Name}" class="w-12 h-12 object-cover rounded-md mr-4">
                                    <div class="flex-grow">
                                        <p class="font-semibold text-gray-800">${item.Name}</p>
                                    </div>
                                `;
                                searchResultsContainer.appendChild(resultLink);
                            });
                            searchResultsContainer.classList.remove('hidden');
                        } else {
                            searchResultsContainer.innerHTML = '<p class="text-gray-500 p-4 text-center">No products found.</p>';
                            searchResultsContainer.classList.remove('hidden');
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching search results:', error);
                        searchResultsContainer.innerHTML = '<p class="text-red-500 p-4 text-center">Error loading results.</p>';
                        searchResultsContainer.classList.remove('hidden');
                    });
            }, 300); // Debounce for 300ms
        });

        // Hide results when clicking outside
        document.addEventListener('click', (e) => {
            if (!searchInput.contains(e.target) && !searchResultsContainer.contains(e.target)) {
                searchResultsContainer.classList.add('hidden');
            }
        });


        // --- Hero Slider Logic ---
        const sliderWrapper = document.querySelector('.slider-wrapper');
        const slides = document.querySelectorAll('.slider-slide');
        const dotsContainer = document.querySelector('.slider-dots');
        if (slides.length > 1) {
            let currentIndex = 0;
            let slideInterval;

            slides.forEach((_, i) => {
                const dot = document.createElement('div');
                dot.classList.add('slider-dot');
                if (i === 0) dot.classList.add('active');
                dot.addEventListener('click', () => {
                    goToSlide(i);
                    resetInterval();
                });
                dotsContainer.appendChild(dot);
            });
            const dots = document.querySelectorAll('.slider-dot');

            const goToSlide = (index) => {
                sliderWrapper.style.transform = `translateX(-${index * 100}%)`;
                dots.forEach(dot => dot.classList.remove('active'));
                dots[index].classList.add('active');
                currentIndex = index;
            };

            const nextSlide = () => {
                const newIndex = (currentIndex + 1) % slides.length;
                goToSlide(newIndex);
            };

            const startInterval = () => {
                slideInterval = setInterval(nextSlide, 5000);
            };

            const resetInterval = () => {
                clearInterval(slideInterval);
                startInterval();
            };
            
            startInterval();
        }

        // --- Add to Cart Modal Logic ---
        const modal = document.getElementById('addToCartModal');
        const modalLoader = document.getElementById('modal-loader');
        const modalDynamicContent = document.getElementById('modal-dynamic-content');
        const modalProductName = document.getElementById('modal-product-name');
        const modalVariantsContainer = document.getElementById('modal-variants-container');
        const modalForm = document.getElementById('add-to-cart-form');
        const messageBox = document.getElementById('message-box');
        const cartItemCountElement = document.getElementById('cart-item-count');

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
                                    <p class="text-sm text-gray-600">LKR ${Number(variant.Price).toFixed(2)}</p>
                                </div>
                                <input type="number" data-variant-id="${variant.VariantID}" min="0" value="0" class="quantity-input w-20 px-2 py-1 text-center border border-gray-300 rounded-lg">
                            </div>`;
                    });
                } else {
                    modalVariantsContainer.innerHTML += `
                        <div class="flex items-center justify-between p-3 bg-gray-100 rounded-lg">
                            <div>
                                <p class="font-semibold text-gray-900">${data.product.Name}</p>
                                <p class="text-sm text-gray-600">LKR ${Number(data.product.Price).toFixed(2)}</p>
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

        document.body.addEventListener('click', (e) => {
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
                showMessage('Please enter a quantity for at least one item.', 'error');
                submitButton.disabled = false;
                submitButton.textContent = 'Add to Cart';
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
                submitButton.textContent = 'Add to Cart';
                closeModal();
            }
        });

        modal.addEventListener('click', (e) => {
            if (e.target === modal || e.target.classList.contains('close-button') || e.target.classList.contains('modal-cancel-btn')) {
                closeModal();
            }
        });

        document.addEventListener('keydown', (e) => {
             if (e.key === "Escape" && modal.style.display === 'flex') {
                closeModal();
            }
        });
    });
    </script>
</body>
</html>

