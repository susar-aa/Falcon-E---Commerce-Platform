-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 27, 2025 at 04:51 PM
-- Server version: 5.5.68-MariaDB
-- PHP Version: 8.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `falcon_stationary`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `shop_name` varchar(255) NOT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  `address` text,
  `route_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `shop_name`, `contact_number`, `address`, `route_id`, `user_id`) VALUES
(10, 'Test Book Shop', '0769638569', 'Test Customer , 000000', 8, 4),
(11, 'Test Without Connection', '0769853366', 'No connection, 000000', 7, 4),
(13, 'E Store', '8764059768', 'Sri lanka', 4, 4),
(16, 'Lanka Shop', '07611946766', 'ubwsywbyzby', 8, 4),
(20, 'Kurunegala Shop', '424386', 'gxgc', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `daily_route_summaries`
--

CREATE TABLE `daily_route_summaries` (
  `summary_id` int(11) NOT NULL,
  `rep_id` int(11) NOT NULL,
  `route_id` int(11) DEFAULT NULL,
  `route_date` date NOT NULL,
  `meter_start` int(11) NOT NULL,
  `meter_end` int(11) NOT NULL,
  `total_sales` decimal(12,2) NOT NULL,
  `total_bills` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `daily_route_summaries`
--

INSERT INTO `daily_route_summaries` (`summary_id`, `rep_id`, `route_id`, `route_date`, `meter_start`, `meter_end`, `total_sales`, `total_bills`) VALUES
(8, 4, 4, '2025-09-26', 12500, 12580, 15882.45, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Item_List`
--

CREATE TABLE `Item_List` (
  `ItemID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `SubCategoryID` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `ProductPhoto` varchar(255) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Description` text,
  `BrandName` varchar(100) DEFAULT NULL,
  `QtyPerBox` int(11) DEFAULT NULL,
  `NewArrival` tinyint(1) DEFAULT '0',
  `BulkPrice` decimal(10,2) DEFAULT NULL,
  `CartoonPcs` varchar(50) DEFAULT NULL,
  `Bulk_Description` text,
  `AvailabilityStatus` enum('Available','Not Available') DEFAULT 'Available',
  `LastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT NULL,
  `SKU` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Item_List`
--

INSERT INTO `Item_List` (`ItemID`, `CategoryID`, `SubCategoryID`, `Name`, `ProductPhoto`, `Price`, `Description`, `BrandName`, `QtyPerBox`, `NewArrival`, `BulkPrice`, `CartoonPcs`, `Bulk_Description`, `AvailabilityStatus`, `LastUpdated`, `created_at`, `SKU`) VALUES
(967, 1, 14, 'Manila Envelop', 'https://drive.google.com/uc?export=download&id=10KgejfjuKufL41Um44t7d4uyjmKntWpE', 3.00, 'Good Envelop', NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:19:33', '0000-00-00 00:00:00', 'ENV'),
(968, 1, 14, 'Kangaroo Stapler Pin 369', 'https://drive.google.com/uc?export=download&id=11H6X-JsIW-aiuAWoTZE3K7B23eAeI8UO', 170.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-24 05:01:02', '0000-00-00 00:00:00', '2'),
(969, 1, 14, 'Paper Fastener 50s', 'https://drive.google.com/uc?export=download&id=11094mXtDimhqK0jVmkvsogkxYslGKenD', 170.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-24 05:00:14', '0000-00-00 00:00:00', '3'),
(970, 1, 11, 'ID Code', 'https://drive.google.com/uc?export=download&id=12uJ8eLgTHCICsteALhbV6luPeD6--W0z', 50.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-24 05:00:30', '0000-00-00 00:00:00', '4'),
(971, 1, 11, 'ID Clip Plastic', 'https://drive.google.com/uc?export=download&id=130RYXUNHNS03buxLbTTSG91W2jYV5ued', 15.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:30:24', '0000-00-00 00:00:00', '5'),
(972, 1, 11, 'ID Pouch', 'https://drive.google.com/uc?export=download&id=12y7OuOoArWbTPq7LBqG2rXcIgjZQ5EVU', 20.00, NULL, NULL, 10, 0, NULL, '', '', 'Available', '2025-08-13 03:47:26', '0000-00-00 00:00:00', '6'),
(973, 1, 14, 'Staple Pin NO 369 10Pcs', 'https://drive.google.com/uc?export=download&id=12-46p54zXDzM1JEdImPqoG5ia44wKFTE', 375.00, NULL, NULL, 0, 0, NULL, '50', '', 'Available', '2025-09-23 16:49:53', '0000-00-00 00:00:00', '7'),
(974, 1, 14, 'Puncher DL 8230', 'https://drive.google.com/uc?export=download&id=1bl-RPu523X0VcwwkbtO3Iyl2ivu86BPD', 420.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:03:36', '0000-00-00 00:00:00', '8'),
(975, 1, 26, '76x76 Stickey Note Single Colour', 'https://drive.google.com/uc?export=download&id=11SpfHG0LbWgwTyRc-YNdCbLXdYhtsHKd', 52.00, NULL, NULL, 12, 0, NULL, '', '', 'Available', '2025-08-13 03:47:27', '0000-00-00 00:00:00', '9'),
(976, 1, 14, 'Pad Ink', 'https://drive.google.com/uc?export=download&id=10Yyd65T3K9t5JuLQ5xLzJ_c-pV-XIxtm', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:27', '0000-00-00 00:00:00', '10'),
(977, 1, 14, 'Kangaro Stapler Machine HD45', 'https://drive.google.com/uc?export=download&id=15owDFA8cgxzEjXToBM27gKIEyb8YZmSB', 600.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:27', '0000-00-00 00:00:00', '11'),
(978, 1, 9, 'Water Glue 50ml', 'https://drive.google.com/uc?export=download&id=12XM_qwvtdBIbfhPE3Okt3z21UBTFOLOm', 55.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-12 08:33:22', '0000-00-00 00:00:00', '12'),
(979, 1, 9, 'White Glue Two Way 50ml', 'https://drive.google.com/uc?export=download&id=1TMm_OJtv75aZmpoqCLVPScOI3oo3akX6', 130.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:16:47', '0000-00-00 00:00:00', '13'),
(980, 1, 9, 'Stenzer Clear Glue 100g', 'https://drive.google.com/uc?export=download&id=12Q6z70mZltN5ic4BfcZUVJp6QRVtbv4f', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:30', '0000-00-00 00:00:00', '14'),
(981, 1, 9, 'Glue Stick 4pcs 10g', 'https://drive.google.com/uc?export=download&id=1b_JHh60VGPcjYBzLwN_i7YPyRYc7KsiS', 155.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:59:38', '0000-00-00 00:00:00', '15'),
(982, 1, 9, 'Bobo Clear Glue 50g', 'https://drive.google.com/uc?export=download&id=12deg2a-jZ5ny3U3xkgFlLyXHb94Qomwd', 130.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '16'),
(983, 1, 9, 'Ready Binder Gum 60ml', 'https://drive.google.com/uc?export=download&id=1ACY_MXK2NhbbVoGCBTqbxq7wewIcg09f', 55.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:53:19', '0000-00-00 00:00:00', '17'),
(984, 1, 9, 'White School Glue 120ml', 'https://drive.google.com/uc?export=download&id=12JO3cysySN1xRJ1MEJ4FqaC6KO-5JkBs', 120.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:31', '0000-00-00 00:00:00', '18'),
(985, 1, 20, 'Rainbow Colour Pen', 'https://drive.google.com/uc?export=download&id=1-wTCeavQ0ts8Mt1Cg4F0O_EQLnAphfxS', 105.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '19'),
(986, 1, 20, 'Ten Plus Pen 50pcs', 'https://drive.google.com/uc?export=download&id=1Rc6MEWrz1mBgqGgFWhBgaD1Vkrvtc6gh', 825.00, NULL, NULL, 50, 0, NULL, '2000', '', 'Available', '2025-09-13 06:59:25', '0000-00-00 00:00:00', '20'),
(987, 1, 20, 'Cello Sign Pen', 'https://drive.google.com/uc?export=download&id=1043Ik_MzKnUH1qrcUTKt9ODUz3wfzsk5', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '21'),
(988, 1, 20, '3 Colour Pen', 'https://drive.google.com/uc?export=download&id=1-vhiRVU6iVC8JUDnoJGSokOAKWQWQosU', 120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '22'),
(989, 1, 17, 'Colour Pen Rabbit', 'https://drive.google.com/uc?export=download&id=1-uW1qvI08UqwZmxu0uv7gffwhrGH8G-P', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:31', '0000-00-00 00:00:00', '23'),
(990, 1, 18, 'HB Pencil 6 pcs', 'https://drive.google.com/uc?export=download&id=1SPrq0bIO03jcSMpc80AhB9Mp4ZJTmCuG', 130.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:31', '0000-00-00 00:00:00', '24'),
(991, 1, 18, 'Flamingo HB Pencil 12 pcs', 'https://drive.google.com/uc?export=download&id=1MxQtI-EujqCubVOLzgzlMeIb5F4PXEPZ', 350.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:46:25', '0000-00-00 00:00:00', '25'),
(992, 1, 18, 'Design Pencil 211-22 48pcs', 'https://drive.google.com/uc?export=download&id=1QPP_VRWjTMvOlmmbH8VXK8sr6x-xbupy', 3015.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '26'),
(993, 1, 18, 'Yellow Trangle Pencil 12pcs', 'https://drive.google.com/uc?export=download&id=1UwBjVwa61kgZuylcYqtLyMKMR6xTpozG', 408.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:33', '0000-00-00 00:00:00', '27'),
(994, 1, 18, 'DOMS Pencil 72pcs', 'https://drive.google.com/uc?export=download&id=1nyhtK0Z5dJ--bPx1LM-HjaDvCv1drfvC', 2415.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:46:14', '0000-00-00 00:00:00', '28'),
(995, 1, 18, 'Black Triangle HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1UwBjVwa61kgZuylcYqtLyMKMR6xTpozG', 264.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:34', '0000-00-00 00:00:00', '29'),
(996, 1, 18, 'Fusion HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1yzU8XP_xHx0ftzmnu75RDwc2ydGYbRCf', 265.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:58:17', '0000-00-00 00:00:00', '30'),
(997, 1, 18, 'Mummas Boy HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1cr88ObuW9x5SuCzJbN44gH-st-j8ILHr', 265.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:35', '0000-00-00 00:00:00', '31'),
(998, 1, 18, 'Black Peps HB Pencils 12Pcs', 'https://drive.google.com/uc?export=download&id=1Oy0OfxE7EhvmaVZhqmgb5V0_BeJusycA', 270.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:35', '0000-00-00 00:00:00', '32'),
(999, 1, 7, 'Master Eraser 30pcs, 60pcs', 'https://drive.google.com/uc?export=download&id=14Rt-plAkVCaX964utroVZgXe5MlTMIRM', 865.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '33'),
(1001, 1, 7, 'Smile Eraser 36pcs', 'https://drive.google.com/uc?export=download&id=14dOM78bLwabL7b7rXS4FqRB5RZYq6FM1', 815.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:25:08', '0000-00-00 00:00:00', '35'),
(1002, 1, 7, 'Stedtler Eraser 20pcs,30pcs', 'https://drive.google.com/uc?export=download&id=14YRN17RTm0ndb44bbZyDd3Rtp_nFPcpr', 740.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:37', '0000-00-00 00:00:00', '36'),
(1003, 1, 21, 'Ruller Plastic 12pcs', 'https://drive.google.com/uc?export=download&id=1628pdLJpEB0ZnBHFeg07i21WF5jfVReT', 560.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:20:28', '0000-00-00 00:00:00', '37'),
(1004, 1, 21, 'Rotating Ruler 15cm', 'https://drive.google.com/uc?export=download&id=1fDb9uNmSO3i4IBCM4trFC9eoynMWIb0_', 45.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:22:48', '0000-00-00 00:00:00', '38'),
(1005, 1, 6, 'Clay Card with Mold 12 Colours 0961', 'https://drive.google.com/uc?export=download&id=15_CGqGE7o9uOQ58CfN4FBuGPqU4D3jlV', 296.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:23:21', '0000-00-00 00:00:00', '39'),
(1006, 1, 6, 'Super Light Clay - 12 Colors Small', 'https://drive.google.com/uc?export=download&id=1kmytfBe2ROKcLffjKD3eafYa9z9KQKyJ', 135.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-28 07:03:19', '0000-00-00 00:00:00', '40'),
(1007, 1, 6, 'Super Light Clay -12 Colours Large', 'https://drive.google.com/uc?export=download&id=15MTKixUv_DPQLhGZcu1E2rbwcz5LXXby', 270.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:23:59', '0000-00-00 00:00:00', '41'),
(1008, 1, 13, 'Gxin CD Marker', 'https://drive.google.com/uc?export=download&id=1UCZBwYHMLj5y8qC56Ti0qRZdvmO6IaOC', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:39', '0000-00-00 00:00:00', '42'),
(1009, 1, 13, 'Gxin Permanent Marker', 'https://drive.google.com/uc?export=download&id=1hQfcEGtV-DNeZvlpS436Mjc2k5LKn7_W', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:39', '0000-00-00 00:00:00', '43'),
(1010, 1, 13, 'Gxin Whiteboard Marker', 'https://drive.google.com/uc?export=download&id=1XJQ54dxJnZeiIIK6MbaUCJ5p9nSBliNB', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:39', '0000-00-00 00:00:00', '44'),
(1011, 1, 46, 'Artistic Highlighter', 'https://drive.google.com/uc?export=download&id=1z-OqHVkZuP2yT6d-aJFErejN3XLC2zNR', 105.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:05:19', '0000-00-00 00:00:00', '45'),
(1012, 1, 46, 'Highlighter Smile', 'https://drive.google.com/uc?export=download&id=1Bl8-pYLIInxpXfsaLcNCIaM93h9pfgSs', 295.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:43:39', '0000-00-00 00:00:00', '46'),
(1013, 1, 46, 'Highlighter Pen Set 5pcs', 'https://drive.google.com/uc?export=download&id=15eMdIGFa4VUrKY1wA-dce7Wj8xTcA-IK', 400.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:40', '0000-00-00 00:00:00', '47'),
(1014, 1, 1, 'Master WB Ink', 'https://drive.google.com/uc?export=download&id=10XwPrcUQDEYSu3HnKzMXcQ5jDziUhwLh', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:18:00', '0000-00-00 00:00:00', '48'),
(1015, 1, 46, 'Highlighter Rabbit 6Pcs', 'https://drive.google.com/uc?export=download&id=1LOne30LdUMTKkeot_7zIrrvfFKCIo9er', 380.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:41', '0000-00-00 00:00:00', '49'),
(1016, 1, 14, 'SOFTA WB Marker', 'https://drive.google.com/uc?export=download&id=1Iq5Q3OEo_EReZhohl7H_aCL6ajJRIv-a', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:41', '0000-00-00 00:00:00', '50'),
(1018, 1, 13, 'Horse WB Ink', 'https://drive.google.com/uc?export=download&id=1d20ZQhYOnup_yHngkkZF9-jVIVY4Op1W', 170.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '52'),
(1019, 1, 13, 'Gxin White Board Ink', 'https://drive.google.com/uc?export=download&id=1eURea98hq7-ewx7woln2Xl2vJkGT8KKe', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:17:49', '0000-00-00 00:00:00', '53'),
(1020, 1, 8, 'File Separate A4 1 To 10', 'https://drive.google.com/uc?export=download&id=13EvB7aaUzSXJlRdiNET1HzDGUMIHRt_r', 175.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:42', '0000-00-00 00:00:00', '54'),
(1021, 1, 8, 'Magazine Holder', 'https://drive.google.com/uc?export=download&id=11ZzChfpbNV--U9dIBmUXlc6Kw1_S6Kmp', 325.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:36:01', '0000-00-00 00:00:00', '55'),
(1022, 1, 8, 'Box File 3 Inch', 'https://drive.google.com/uc?export=download&id=18BTcvbumq1Diefs4EfL_zwemc8BzfeoO', 456.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:44', '0000-00-00 00:00:00', '56'),
(1023, 1, 29, 'Water Bottle 1500ml 3 IN 1', 'https://drive.google.com/uc?export=download&id=1r2JsxzsQ3gRbWqOaJ37Mzx7st1c4nAck', 1350.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:36:59', '0000-00-00 00:00:00', '57'),
(1024, 1, 2, 'Fabric Paint 6 Colour', 'https://drive.google.com/uc?export=download&id=1ZPB9PdQe0L1C3lt127Sunw9gcFdYTj4a', 520.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:44', '0000-00-00 00:00:00', '58'),
(1025, 1, 2, 'Panda Water Colour Tube 5ml', 'https://drive.google.com/uc?export=download&id=18FzALoxWd8ZuMPf_dGTEgexu-D-DwdNe', 275.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '59'),
(1027, 1, 2, 'Artist Brushes 6Pcs Round 715', 'https://drive.google.com/uc?export=download&id=1M0x094Tw9dQJVbW8jBa2ZxBk9WZYsutg', 475.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:24:48', '0000-00-00 00:00:00', '61'),
(1028, 1, 2, 'Cosmo Colour Pencil', 'https://drive.google.com/uc?export=download&id=1zGTImtRP0aonxmV_VJbahuLqPifW8YVq', 280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 15:47:56', '0000-00-00 00:00:00', '62'),
(1031, 1, 19, 'Magnet Box 2013', 'https://drive.google.com/uc?export=download&id=1sbupc3btj2bgdhkD8Jhv-mLanNXeibSm', 425.01, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '65'),
(1032, 1, 19, 'Pencil Box 5772', 'https://drive.google.com/uc?export=download&id=1L6Irsa1DaOHjTsk7TJVPa60sT1pCJVlv', 850.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:06:36', '0000-00-00 00:00:00', '66'),
(1033, 1, 19, 'Magnet Box 6891', 'https://drive.google.com/uc?export=download&id=1sIoHZLnqiQ1X_xjHKRYlttMZ9TEqeCUG', 1285.92, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '67'),
(1034, 1, 19, 'Magnet Box 0002', 'https://drive.google.com/uc?export=download&id=1soR3OtIx1lQ9PvUx9E9KS-OPiPUwxiQ9', 435.90, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '68'),
(1035, 1, 19, 'Metal Pencil Box 1761', 'https://drive.google.com/uc?export=download&id=1sMLrhuAhJxwfTsqoF5hRpnuhrG61NvnB', 410.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '69'),
(1036, 1, 19, 'Pencil Purse 1137', 'https://drive.google.com/uc?export=download&id=1rl8ehB6tUZvuQSimxnetd7GyYVvevmrh', 440.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '70'),
(1037, 1, 19, 'Pencil Purse 1130', 'https://drive.google.com/uc?export=download&id=1rqo_8UsrjTjAAlmpxBNiKxvC4wqWw7QH', 460.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '71'),
(1038, 1, 19, 'Pencil Purse 1133', 'https://drive.google.com/uc?export=download&id=1rrbHEoQhYZ8ggLdVK_9PGO333I1pJiaS', 460.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '72'),
(1039, 1, 19, 'Pencil Purse 1180', 'https://drive.google.com/uc?export=download&id=1s2jiJQiF4u5z68nIMz8VKi0MGjkvWRDr', 460.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:47:04', '0000-00-00 00:00:00', '73'),
(1040, 1, 19, 'Pencil Purse V6', 'https://drive.google.com/uc?export=download&id=1tgnqfAw2EJdNHlVX3oUpPpg33GUqCROt', 300.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '74'),
(1041, 1, 19, 'Metal Pencil Box 179', 'https://drive.google.com/uc?export=download&id=1sCZsaCqeDbFUxqskQacwrwlRdwPwguoM', 420.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '75'),
(1042, 1, 11, 'Book Binding Machine', 'https://drive.google.com/uc?export=download&id=13YcC72n7y8r5WIPLezpnZP9CWZyTdBZC', 13800.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:47', '0000-00-00 00:00:00', '76'),
(1043, 1, 11, 'Laminating Machine', 'https://drive.google.com/uc?export=download&id=13UJAhEf5gnQEQuDvkzTmuoVg73Fc4WWd', 16500.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:49', '0000-00-00 00:00:00', '77'),
(1044, 1, 3, 'Envelop Clear Bag', 'https://drive.google.com/uc?export=download&id=18tPX86K1EK6vTbzb5T8zV7bMZGwxjMAL', 140.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:19:39', '0000-00-00 00:00:00', '78'),
(1045, 1, 25, 'Star Sticker Small 10pcs', 'https://drive.google.com/uc?export=download&id=106Fijmosta_tsbr_j8t63PcTie_a8AMD', 120.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:49', '0000-00-00 00:00:00', '79'),
(1046, 1, 25, 'Sticker A4', 'https://drive.google.com/uc?export=download&id=10Jh1We1WqiC2iY-PbLXZb3iYKbsSnzoI', 25.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:49', '0000-00-00 00:00:00', '80'),
(1047, 1, 25, 'Name Sticker Normal', 'https://drive.google.com/uc?export=download&id=10EzOHySw2u2cbumDQIUn7TygSczWZtDD', 155.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:50', '0000-00-00 00:00:00', '81'),
(1048, 1, 25, 'Name Sticker Shine', 'https://drive.google.com/uc?export=download&id=10GREreBYJTQ-uyKsgUMl5G4TxyBKrUl_', 195.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:50', '0000-00-00 00:00:00', '82'),
(1049, 1, 25, 'Sticker Sheet A4 Mat', 'https://drive.google.com/uc?export=download&id=1y-kBtrJ1-0IW3nJcuSi0Rq8pvjvVHJJm', 1310.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:50', '0000-00-00 00:00:00', '83'),
(1050, 1, 1, 'Stencil 1Pcs', 'https://drive.google.com/uc?export=download&id=14l41fzxiXXKNneWKM0SqkfHzumai-pXc', 80.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:50', '0000-00-00 00:00:00', '84'),
(1051, 1, 1, 'Stencil 2pcs', 'https://drive.google.com/uc?export=download&id=15AqutYOFqjakza4840fWcTVEFLbGulXi', 210.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:51', '0000-00-00 00:00:00', '85'),
(1052, 1, 1, 'Compass Single', 'https://drive.google.com/uc?export=download&id=1hp9Q3XDr9nBcP6waziPXOP5eAgYZR4ZY', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:04:49', '0000-00-00 00:00:00', '86'),
(1054, 1, 2, 'Water Colour Tray Large 12Pcs', 'InvalidURL', 1020.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:11:01', '0000-00-00 00:00:00', '88'),
(1055, 1, 1, 'Magnifying Glass', 'https://drive.google.com/uc?export=download&id=127dwk9cqf3p6PAG5xhqaEYEkJMZEDXjG', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 15:18:43', '0000-00-00 00:00:00', '89'),
(1056, 1, 1, 'Marshal Instrument Box', 'https://drive.google.com/uc?export=download&id=1yN6gfKyWPROIkMkcLlKFb6CBbMYoF0_S', 270.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:53', '0000-00-00 00:00:00', '90'),
(1057, 1, 14, 'Glass Socket', 'https://drive.google.com/uc?export=download&id=15B3ekX1AfvNwg5RhhAUlpZ1mu_TkSjjH', 175.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '91'),
(1058, 1, 10, 'Drawing Board A4', 'https://drive.google.com/uc?export=download&id=1-0amlo6R81PFXgORv_iT8KIk7vN_ZMp4', 88.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-28 05:26:53', '0000-00-00 00:00:00', 'KLDB'),
(1059, 1, 10, 'Chess Roll Large', 'https://drive.google.com/uc?export=download&id=13K2rrhAs5IAOHnGS71A07WCDw61D2mho', 2350.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:45:31', '0000-00-00 00:00:00', '93'),
(1060, 1, 16, 'Continuou Paper 9.5x 11-1 Ply - 1000 Sets', 'InvalidURL', 4150.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:55', '0000-00-00 00:00:00', '94'),
(1061, 1, 16, 'Colour A4  100 sheets', 'InvalidURL', 605.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:56', '0000-00-00 00:00:00', '95'),
(1062, 1, 1, 'Glitter paper', 'https://drive.google.com/uc?export=download&id=1-_95n1SxOy7Jem3fysn7ZxRdLcwLv7mb', 405.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:56', '0000-00-00 00:00:00', '96'),
(1063, 1, 14, 'Continuous Paper 5.5x 11-3Ply - CHP -  500 Sets', 'InvalidURL', 6325.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:56', '0000-00-00 00:00:00', '97'),
(1064, 1, 16, 'Continuou Paper 15', 'InvalidURL', 6070.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:56', '0000-00-00 00:00:00', '98'),
(1065, 1, 16, 'JK Legal Copy Paper 80 GSM', 'InvalidURL', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '99'),
(1067, 1, 16, 'Copy Paper B4 75 gsm', 'Invalid URL', 2890.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '101'),
(1068, 1, 14, 'Continuou Paper 5.5 x 11-1 Ply - 1000 Sets', 'Invalid URL', 2800.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:31', '0000-00-00 00:00:00', '102'),
(1069, 1, 14, 'Continuou Paper 5.5 x 11-1 Ply - CHP - 1000 Sets', 'Invalid URL', 2860.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:32', '0000-00-00 00:00:00', '103'),
(1070, 1, 16, 'Copy Paper A4 70 gsm', 'InvalidURL', 1000.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '104'),
(1072, 1, 16, 'Copy Paper B5 75 gsm', 'Invalid URL', 1440.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:33', '0000-00-00 00:00:00', '106'),
(1073, 1, 16, 'J K Copy Paper A4 80 gsm', 'Invalid URL', 1460.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '107'),
(1074, 1, 16, 'A4 Paper 100 Sheets', 'Invalid URL', 250.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:34', '0000-00-00 00:00:00', '108'),
(1075, 1, 16, 'Luminer Colour A4 Mix 100 Sheets', 'InvalidURL', 405.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:34', '0000-00-00 00:00:00', '109'),
(1076, 1, 16, 'Rainbow Colour A4 100 Sheets', 'Invalid URL', 435.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:35', '0000-00-00 00:00:00', '110'),
(1078, 1, 4, '40556 Desighn Number Candles', 'https://drive.google.com/uc?export=download&id=1uh5DmKUyu8Dv1GMsyVSs19yhG7K7zAPJ', 55.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:35', '0000-00-00 00:00:00', '112'),
(1079, 1, 4, 'Party Strow 25Pcs', 'https://drive.google.com/uc?export=download&id=1vCrwArwZQ9h0Qa_BlaTzqhO65lIxD57y', 165.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:22:55', '0000-00-00 00:00:00', '113'),
(1080, 1, 11, 'Polythene Sealer 200mm ', 'https://drive.google.com/uc?export=download&id=13VJegqQa2NUfSvovKrIwh5QcNI8Ku0ef', 4875.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:37', '0000-00-00 00:00:00', '114'),
(1081, 1, 10, 'Tennis Ball 3pcs', 'https://drive.google.com/uc?export=download&id=122rND9WF4cbkj96OMYH_38zPaX_lOGxv', 500.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '115'),
(1082, 1, 15, 'Polythene', 'InvalidURL', 700.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-23 16:17:19', '0000-00-00 00:00:00', '116'),
(1083, 1, 1, 'Round Stamp 4Pcs', 'https://drive.google.com/uc?export=download&id=10rdciyQBUfw7BedDeRwDn1Jbj2tflBen', 150.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '117'),
(1084, 1, 9, 'Glue Gun Stick 1000g', 'https://drive.google.com/uc?export=download&id=1apPNichJqjYqMe1pqO3onBzD7L1nXd0b', 1250.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-12 20:15:46', '0000-00-00 00:00:00', 'DCGGS'),
(1085, 1, 4, 'Birthday Knife Candle Card', 'Invalid URL', 200.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '119'),
(1086, 1, 14, '369 Stapler Machine Mini', 'https://drive.google.com/uc?export=download&id=1Rq9KWqthZbHmWiAoDAd3Sl6ZKF__fgZl', 200.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-06 03:30:07', '0000-00-00 00:00:00', '120'),
(1087, 1, 19, 'Pencil Box Barbie', 'https://drive.google.com/uc?export=download&id=1sPB5sMYIkRmAS9Ay2HgnOEl_4HVJTWHN', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '121'),
(1090, 1, 1, 'Stapler Pin NO 10 10Pcs', 'https://drive.google.com/uc?export=download&id=11e3gghyLP3nxIuA0u6t0Bc5rKvYRQPuv', 250.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:48:53', '0000-00-00 00:00:00', '124'),
(1091, 1, 14, 'Falcon Paper Cutter', 'https://drive.google.com/uc?export=download&id=11F6l76w4hL_OXuXzlDNAeHo97C8EJqjt', 275.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 13:30:42', '0000-00-00 00:00:00', '125'),
(1092, 1, 14, 'Drawing Pin', 'https://drive.google.com/uc?export=download&id=1gqz04oHRnqVVuCxpO3dOEcq5PGdhIui6', 280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:04:15', '0000-00-00 00:00:00', '126'),
(1093, 1, 8, 'Two Ring File', 'https://drive.google.com/uc?export=download&id=1q7yKKT_Z01PLQuTrg5aMOfSWkb9eXuWo', 330.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:05', '0000-00-00 00:00:00', '127'),
(1094, 1, 9, 'Glue Tack', 'https://drive.google.com/uc?export=download&id=12gEx2RSo4X2Go6dV1x6yYfhpFiENXrYk', 340.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:06', '0000-00-00 00:00:00', '128'),
(1095, 1, 14, 'One Hole Puncher Steel', 'https://drive.google.com/uc?export=download&id=1rVC-bGIvxlo-zDbAZQUoJJLGUnHvEFff', 350.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:17:16', '0000-00-00 00:00:00', '129'),
(1096, 1, 18, 'Alisun 2B Pencil 10Pcs', 'https://drive.google.com/uc?export=download&id=1Q_iMl2nCoxtv1rHX71ypxERsrQJc--dy', 370.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:06', '0000-00-00 00:00:00', '130'),
(1097, 1, 18, 'Glory HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1FLF3BW8F5i7vlDyKBAaJk0Z5g1pik6tf', 370.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:06', '0000-00-00 00:00:00', '131'),
(1098, 1, 12, 'Lunch Box 656', 'https://drive.google.com/uc?export=download&id=1tFujZaZjhOW_2K5x5bSXqGIRcJETMcVf', 640.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:08', '0000-00-00 00:00:00', '132'),
(1100, 1, 14, 'Tape Dispenser DL20051', 'https://drive.google.com/uc?export=download&id=10x708Fa33Axb_fSN3WiS50FsY9khquSn', 490.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:08', '0000-00-00 00:00:00', '134'),
(1101, 1, 19, 'Metal Pencil Box 6612', 'https://drive.google.com/uc?export=download&id=1sQMJH0tp_-racK-mXX_7Wg5TkCf9MwZ3', 490.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '135'),
(1102, 1, 14, 'Paper Clip Squar 10Pcs', 'https://drive.google.com/uc?export=download&id=11lRiEnGLSOO2KySQ7bY-AQgL5KFqM4GM', 490.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:08', '0000-00-00 00:00:00', '136'),
(1103, 1, 14, '369 Stapler Machine DL 0316', 'https://drive.google.com/uc?export=download&id=1r4gNU3OaJMKg6qYFV9-rxSbApukBoix2', 525.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-06 03:20:57', '0000-00-00 00:00:00', '137'),
(1104, 1, 14, '369 Stapler Machine DL 0579', 'https://drive.google.com/uc?export=download&id=10QV_avykQFHR_2PYc3kneVekAa_CmFEX', 525.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:09', '0000-00-00 00:00:00', '138'),
(1105, 1, 2, 'Water Colour Painting Card 2pcs', 'https://drive.google.com/uc?export=download&id=1aZP2GurA6J7oyP01PvJMKxlZ0JWonutx', 150.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:25:47', '0000-00-00 00:00:00', '139'),
(1106, 1, 18, 'USA Gold Pencil 6Pcs', 'https://drive.google.com/uc?export=download&id=1okjWugtK06MEIPpNKEyazLzPNhCDRAt5', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:09', '0000-00-00 00:00:00', '140'),
(1107, 1, 18, 'Karbon HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1MOk56SuuvXtKBKHjdAmKndu_ynG6tIAJ', 300.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:58:28', '0000-00-00 00:00:00', '141'),
(1108, 1, 18, 'Vneed Yellow HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1eVhGdR05hYAWOrKsem-N_VnHFnoCz1dK', 225.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:58:46', '0000-00-00 00:00:00', '142'),
(1109, 1, 18, 'X1 HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1tpyam3RCqlzSIB5-kJDyGyhDqtKdhQSp', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:58:57', '0000-00-00 00:00:00', '143'),
(1110, 1, 18, 'Hero Echo Pencil', 'https://drive.google.com/uc?export=download&id=17O-SRvldNj3YL5zNaNUtgkDhsj-9E_bT', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:11', '0000-00-00 00:00:00', '144'),
(1111, 1, 20, 'Glitter Pen 6 pcs ', 'https://drive.google.com/uc?export=download&id=1Bs3ONj7HyGJYa6w6OCLjLrf1-TUn_XpL', 540.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '145'),
(1112, 1, 14, 'Push Pin', 'https://drive.google.com/uc?export=download&id=15ZxObqXJ1iBg625PmdlpdCctNVzMweq5', 185.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:57:07', '0000-00-00 00:00:00', '146'),
(1113, 1, 14, 'Kangaro Puncher DP600', 'https://drive.google.com/uc?export=download&id=127QVG9X9b0gPxa4HJG4G6t0vK7yEzq51', 700.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '147'),
(1114, 1, 26, 'Stickey Note Multy Colour', 'https://drive.google.com/uc?export=download&id=11yJI8IhU8B-_b4Qh9e1YNpV4udycqXLX', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:06:38', '0000-00-00 00:00:00', '14811'),
(1115, 1, 14, 'Office Pin 10Pcs', 'https://drive.google.com/uc?export=download&id=1ZKfn_FeQ4_CkGhEEkGd4YKEO6BN8Kgor', 490.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:03:11', '0000-00-00 00:00:00', '149'),
(1116, 1, 26, '76x76 Stickey Note Strip', 'https://drive.google.com/uc?export=download&id=11Wwa_Ggb8J-gOHaYxgIAQeNW-Y6Y2ust', 100.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:12', '0000-00-00 00:00:00', '150'),
(1117, 1, 26, 'Desighn Stickey Note', 'https://drive.google.com/uc?export=download&id=11T7K64RKEd9TYvhf5hSiStnDaYqVSASe', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:12', '0000-00-00 00:00:00', '151'),
(1118, 1, 14, 'Paper Clip Colour 10Pcs', 'https://drive.google.com/uc?export=download&id=11MeoHbqasjAE2VqLW1NuUlpvKD2A5NLd', 700.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:13', '0000-00-00 00:00:00', '152'),
(1119, 1, 14, 'NO 10 Stapler Machine DL 0102', 'https://drive.google.com/uc?export=download&id=1nrEW6hQnGQImSy07EDP_16arWikUJc9t', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:03:53', '0000-00-00 00:00:00', '153'),
(1120, 1, 14, 'NO 10 Stapler Machine DL 0258', 'https://drive.google.com/uc?export=download&id=10KkW2qnJn6d8N83bXZPJH8-OyEYjSqIu', 295.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:14', '0000-00-00 00:00:00', '154'),
(1121, 1, 14, 'Ink Pad Medium', 'https://drive.google.com/uc?export=download&id=11BwCxvLyV1CUOr1tK5ZzMbIntutBbkiw', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:14', '0000-00-00 00:00:00', '155'),
(1122, 1, 7, 'Maggi Eraser 30Pcs', 'https://drive.google.com/uc?export=download&id=14foUCs9wqn0rw-RRV1qZd-r0OJQpetUF', 1190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:14', '0000-00-00 00:00:00', '156'),
(1123, 1, 7, 'Design Eraser 30pcs', 'https://drive.google.com/uc?export=download&id=14YthcYENuzdwdRncQs_alqD5Z3015KJo', 875.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:15', '0000-00-00 00:00:00', '157'),
(1124, 1, 7, 'Touch Eraser Pen 24Pcs', 'https://drive.google.com/uc?export=download&id=1_wkh0TJWAl5bP4L4vqqfFGPwqlU1Nfwy', 1500.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:01:03', '0000-00-00 00:00:00', '158'),
(1125, 1, 9, 'Ready Clear Glue ', 'https://drive.google.com/uc?export=download&id=17kdZMlcUZYc8I8O-YwrVQFKyI2tOmGpw', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:15:35', '0000-00-00 00:00:00', 'GLCG'),
(1126, 1, 9, 'Ready Binder Gum 200ml', 'https://drive.google.com/uc?export=download&id=12IOeAVOCq2wZROkZ6st1jyyfvKVcmqmG', 88.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:42:42', '0000-00-00 00:00:00', '160'),
(1127, 1, 9, 'Glitter Glue Pen 6Pcs', 'https://drive.google.com/uc?export=download&id=12qm-w0LsLNLkaOc2CiueYbzrzEhdUPpT', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:16', '0000-00-00 00:00:00', '161'),
(1128, 1, 6, 'Modeling Clay 6 Colour 2023', 'https://drive.google.com/uc?export=download&id=15nYhcw0o03MHUa4oWlx44-VXzON5gP4O', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:17', '0000-00-00 00:00:00', '162'),
(1129, 1, 6, 'Clay Card With Mold 12 Clour 0962', 'https://drive.google.com/uc?export=download&id=15RWLap2qV4K6TlqetDUq1uZt4rCuT_Eb', 296.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:23:20', '0000-00-00 00:00:00', '163'),
(1130, 1, 21, 'Steel Rullers 15cm', 'https://drive.google.com/uc?export=download&id=15Aw2uJbCUygoSwBjZEa7uMlCuhKPuDlB', 45.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:17', '0000-00-00 00:00:00', '164'),
(1131, 1, 18, '7004 HB Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1zEhv_A4-07CtKfTBvyVMK4UFcNaIShot', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:46:06', '0000-00-00 00:00:00', '165'),
(1132, 2, 41, 'FA Deodorant Roll On', 'https://drive.google.com/uc?export=download&id=1o93gOz9OVTgTKDgw9d59rCrFZTpXQHvY', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '166'),
(1133, 1, 24, 'Design Sharpner 304 45Pcs', 'https://drive.google.com/uc?export=download&id=14OKxLzivZFE9kkcF2-GIdmUuGGadEM4A', 3095.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:19', '0000-00-00 00:00:00', '167'),
(1134, 1, 24, 'Design Sharpner 391 36Pcs', 'https://drive.google.com/uc?export=download&id=14O0mPPjQTjVgEMD8ldVidU2Ha7ZUrzVX', 2025.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:20', '0000-00-00 00:00:00', '168'),
(1135, 1, 24, 'Design Sharpner 105 72Pcs', 'https://drive.google.com/uc?export=download&id=14Kttk7ItNsysg7Pdco8wYn_TrEF2oy99', 1215.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:20', '0000-00-00 00:00:00', '169'),
(1136, 1, 24, 'Double Sharpner 811', 'https://drive.google.com/uc?export=download&id=14GPEH0QtV-wuBPA_Zf-JwMKUGdgq2L2E', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:20', '0000-00-00 00:00:00', '170'),
(1137, 1, 24, 'Double Sharpner 3070', 'https://drive.google.com/uc?export=download&id=14DpLYsNI9Bv1r4t_ET8a9JVud4geGUx3', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:50:08', '0000-00-00 00:00:00', '171'),
(1138, 1, 24, 'Doms Sharpner 2109 48 Pcs', 'https://drive.google.com/uc?export=download&id=148xIxgu8MjoHLKzbeIDJuEaOcXlxAsMx', 1115.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:50:02', '0000-00-00 00:00:00', '172'),
(1139, 1, 24, 'Design Sharpner 393 36Pcs', 'https://drive.google.com/uc?export=download&id=13z6MAngxbaPQPo8PTejnBQdbzMmmB3j9', 2025.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:21', '0000-00-00 00:00:00', '173'),
(1140, 1, 24, 'Design Sharpner 239 60Pcs', 'https://drive.google.com/uc?export=download&id=13wTu6NbrtPdWXBwQsNC1Noi5a2DVYrK1', 1010.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:21', '0000-00-00 00:00:00', '174'),
(1141, 1, 24, 'Double Sharpner Jar 48pcs', 'https://drive.google.com/uc?export=download&id=13fShe_7zNcCO_A0BCysbUzMiOfwA4gsV', 3750.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:22', '0000-00-00 00:00:00', '175'),
(1142, 1, 24, 'Sharpner Drum 72Pcs', 'https://drive.google.com/uc?export=download&id=13eZKFcWYYaz_idgPJTZis3aH4nml0XVj', 580.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '176'),
(1143, 1, 24, 'Doms Sharpner 2115 60Pcs', 'https://drive.google.com/uc?export=download&id=13d-efmlNxLQV8sJgR-vlOHmau2RjHK8d', 1690.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:23', '0000-00-00 00:00:00', '177'),
(1144, 1, 24, 'Design Sharpner 239 72Pcs', 'https://drive.google.com/uc?export=download&id=13UW3Vw5c7-iq1ayP_Z8Qhn0z8kSxi234', 1215.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:23', '0000-00-00 00:00:00', '178'),
(1145, 1, 24, 'Design Sharpner 502 48Pcs', 'https://drive.google.com/uc?export=download&id=1eapmWXOermGEijaSXPHmjyUzsWNitCec', 2700.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:08:32', '0000-00-00 00:00:00', '179'),
(1146, 1, 19, 'Pencil  Purse 8970 ', 'https://drive.google.com/uc?export=download&id=1reZz4adi8bZtoMu1k_MVMSrvYqfDfHYl', 740.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:24', '0000-00-00 00:00:00', '180'),
(1147, 1, 19, 'Pencil Purse 2689', 'https://drive.google.com/uc?export=download&id=1rfjkgsl496iCql__AEBvjb1UdfUFgx8r', 565.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:47:13', '0000-00-00 00:00:00', '181'),
(1148, 1, 19, 'Pencil  Purse 2609 ', 'https://drive.google.com/uc?export=download&id=1rj79mPM3nirXvYh7cOAagZXQPstiN9h4', 565.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:46:48', '0000-00-00 00:00:00', '182'),
(1149, 1, 19, 'Pencil  Purse 6827 ', 'https://drive.google.com/uc?export=download&id=1rqEeJ-JpUkyekPZxElSAIXpGMIDaW6om', 740.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:25', '0000-00-00 00:00:00', '183'),
(1150, 1, 19, 'Pencil  Purse 7809 ', 'https://drive.google.com/uc?export=download&id=1rrgD2YHVQAgOZRmDXhybq_j3OEU0PzAL', 740.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:46:54', '0000-00-00 00:00:00', '184'),
(1151, 1, 19, 'Pencil  Purse 6006 ', 'https://drive.google.com/uc?export=download&id=1rvY9YlVdXE5_6p5d5YkpYO6c1nEFnxXv', 740.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '185'),
(1152, 1, 19, 'Pencil  Purse 2694 ', 'https://drive.google.com/uc?export=download&id=1rwfQaWd6Cu34MLvSujTcGhohkoxBjE1X', 565.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '186'),
(1153, 1, 19, 'Pencil  Purse 5790 ', 'https://drive.google.com/uc?export=download&id=1sGkbGCEWI5mlFjM4rUN7PqW-juPkXI2v', 475.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '187'),
(1154, 1, 19, 'Magnette Box QY31', 'https://drive.google.com/uc?export=download&id=1sAOV9rmLqLmgjfyXw81AAXQkQv-hG-IR', 460.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:46:41', '0000-00-00 00:00:00', '188'),
(1155, 1, 19, 'Magnette Box 8066', 'https://drive.google.com/uc?export=download&id=1sKnjopB71ooWCk7OMeqt0e0qJqr84321', 625.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '189'),
(1156, 1, 19, 'Magnette Box 399', 'https://drive.google.com/uc?export=download&id=1soTfzF5E-15HCvOyghPa-exZ5dzB5ks7', 618.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '190'),
(1157, 1, 19, 'Magnette Box 992', 'https://drive.google.com/uc?export=download&id=1sP2pw-fiEoaE0Kg1VDK6nz7unEri9UlZ', 625.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '191'),
(1158, 1, 19, 'Pencil Purse Round', 'https://drive.google.com/uc?export=download&id=1srCYqajMPWiL6KCV5NLKMUghB0AWDEAT', 375.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '192'),
(1159, 1, 19, 'Pencil Purse Big Ziper', 'https://drive.google.com/uc?export=download&id=1sx12DBGkV5VSPvTec2qmZzvAaNNAYcmJ', 650.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:27', '0000-00-00 00:00:00', '193'),
(1160, 1, 12, 'Lunch Box 9876', 'https://drive.google.com/uc?export=download&id=1tS_uQ_eLz6t_DKKpZrUl5rNjZVdSn8fs', 690.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '194'),
(1161, 1, 12, 'Lunch Box 6714', 'https://drive.google.com/uc?export=download&id=1tbAFYLiOEcfwBY38BRVZgUGNvJPGhHmB', 695.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:27', '0000-00-00 00:00:00', '195'),
(1162, 1, 12, 'Lunch Box 6718', 'https://drive.google.com/uc?export=download&id=1yrqnS0fiupatLGm8RDGFfwUbpTJZF5I4', 730.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:47:47', '0000-00-00 00:00:00', '196'),
(1163, 1, 12, 'Lunch Box 6717', 'https://drive.google.com/uc?export=download&id=1uqOTONNmJq5pmbf60Fcuoy7iOkzHiiNT', 785.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:47:27', '0000-00-00 00:00:00', '197'),
(1164, 1, 12, 'Lunch Box 6713', 'https://drive.google.com/uc?export=download&id=15ZJIsgPznzVSANwYNaom8S7v-h1MJjf_', 730.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:47:09', '0000-00-00 00:00:00', '198'),
(1165, 1, 12, 'Lunch Box 2099', 'https://drive.google.com/uc?export=download&id=1szC0eFX7BpJCD0NN5BSTk81BEJLNBu2Q', 1140.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '199'),
(1166, 1, 12, 'Lunch Box Panda', 'https://drive.google.com/uc?export=download&id=1CrF8pE62a8OXWssUjZU5brKE_uPNI3aZ', 1690.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '200'),
(1167, 2, 39, 'Veet Hair Removel Cream', 'https://drive.google.com/uc?export=download&id=1o2muaOefUR_DgxJWBhbgm8mJAZ09cvKB', 620.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '201'),
(1168, 2, 39, 'Wokali Wax', 'https://drive.google.com/uc?export=download&id=1o2BRA0nUkpjciwtqKYRDhSLmZgAa-O86', 455.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '202'),
(1169, 2, 39, 'Lip Bam ', 'https://drive.google.com/uc?export=download&id=1nsw5dXDSdHiC8brH4fIKrO3TSyZmC-Am', 320.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '203'),
(1170, 2, 31, 'Ladies Body Spray Yardley 150ml', 'https://drive.google.com/uc?export=download&id=1npbhv4vzqbjeOudfhiwcJU4guBUajA1j', 1150.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '204'),
(1171, 2, 30, 'FASMC Body Lotion Almond Oil 500ml', 'https://drive.google.com/uc?export=download&id=1ndHtVKHSrT-bDhzGABku6JaoZExYXAFb', 987.50, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '205'),
(1172, 2, 30, 'FASMC Body Lotion Cocoa Butter 500ml', 'https://drive.google.com/uc?export=download&id=1nl-fIaRBM81UuPyOyrQlCHhqDXiheTkn', 987.50, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '206'),
(1173, 2, 40, 'VIP Perfum Ladies, Gents 100ml', 'https://drive.google.com/uc?export=download&id=1na8kIvWy-gLzi_SufjCrhBZi80Bx2okH', 1000.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:29', '0000-00-00 00:00:00', '207'),
(1174, 2, 31, 'Body Spray Engage 120ml', 'https://drive.google.com/uc?export=download&id=1mwn2ErXUoYUdYULiA_7fcS8v_vdBsuXF', 1120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '208'),
(1175, 2, 31, 'Ladies Perfum Engage 150ml', 'https://drive.google.com/uc?export=download&id=1nZ2G2JcxzP77diEXCCuzsZgZFezzSfaQ', 1030.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '209'),
(1176, 2, 31, 'Body Spray Denver 165ml', 'https://drive.google.com/uc?export=download&id=1nTem2YOMU-mOP-e1EjWsMMKevdKw9Bbn', 1150.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '210'),
(1177, 2, 31, 'Body Spray Fogg 120ml', 'https://drive.google.com/uc?export=download&id=1nQ8-l9SAzvAQ6rPZqFaegVz8CCXnSUZh', 1100.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '211'),
(1178, 2, 31, 'Body Spray Rovena 200ml', 'https://drive.google.com/uc?export=download&id=1nBd9SOproKKeqYOA3pqx4PqEnotPWk21', 1120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '212'),
(1179, 2, 31, 'Body Spray IPG 200ml', 'https://drive.google.com/uc?export=download&id=1n9VpLxedgGofPsHoYXHK3x5q4oudNlYD', 1120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '213'),
(1180, 2, 31, 'Body Spray Space 200ml', 'https://drive.google.com/uc?export=download&id=1n4p_ULG0c3ZfSKS6muiklyUxQbMSLhaJ', 1120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '214'),
(1181, 2, 33, 'Dr.Rashel Aloe Sun Cream', 'https://drive.google.com/uc?export=download&id=1_TH18SjupHGDxvS721Ci5eEqvVjw3tnA', 1100.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '215'),
(1182, 2, 33, 'Dr. Rashel Vitamin C Night Cream ', 'https://drive.google.com/uc?export=download&id=1gFMICPcfOXjn9HguDW9dfQwXs-mL-w4L', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '216'),
(1183, 2, 34, 'Dr.Rashel White Skin Serum', 'https://drive.google.com/uc?export=download&id=1LdKpq_PCV07J00BWDZaZWPU9pDU0Jysl', 937.50, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '217'),
(1184, 2, 33, 'Dr.Rashel Aloe Moisture Cream', 'https://drive.google.com/uc?export=download&id=14-_M-7x2npUcB-LGiZpm79JxKZjN_CBK', 987.50, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '218'),
(1185, 2, 23, 'Dr.Rashel Aloe Scrub', 'https://drive.google.com/uc?export=download&id=1xIKQMuaprZ-QjfFmmJZTbmGgqi6iG0Ee', 1050.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '219'),
(1186, 2, 34, 'Dr. Rashel Vitamin C Serum', 'https://drive.google.com/uc?export=download&id=11oyosG8uaFK61ULo7JgQDkncryR1qRak', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '220'),
(1187, 2, 23, 'Wokali Scrub 300ml', 'https://drive.google.com/uc?export=download&id=19YPsralcf9bgQ4mu4yA5uEjnRqnSoHqg', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '221'),
(1188, 2, 39, 'Hudabeauty Soothing Gel Vitamin C, Honey', 'https://drive.google.com/uc?export=download&id=1YZ8zo_GcWwqr0FqHllE1lwor9Qh8OF5k', 750.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '222'),
(1189, 2, 30, 'Carotone Body Lotion 350ml', 'https://drive.google.com/uc?export=download&id=1iuVHaAxdGHhyjy85Cn-bnxkMG8Yar4Eq', 1862.50, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '223'),
(1190, 2, 33, 'Vaseline', 'https://drive.google.com/uc?export=download&id=1hSV_j5bpkJ2-afR5jlz5fa5TyAqCdrJ6', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '224'),
(1191, 2, 38, 'Wokali White Gold Mask', 'https://drive.google.com/uc?export=download&id=1TOg3JtcSmk7CCDYKvCroLwOrc5heIYif', 897.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '225'),
(1192, 2, 38, 'Wokali Olive Black Mask', 'https://drive.google.com/uc?export=download&id=1RlyqV6Dm8f2_Yg_crJC9sme7tlVEym7s', 897.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '226'),
(1193, 2, 38, 'Wokali Charcoal Black Mask', 'https://drive.google.com/uc?export=download&id=1Ght9Q5HTI5eZm6enXTTD9V-RYcVx9VU9', 840.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '227'),
(1194, 2, 35, 'Junsui Face Wash', 'https://drive.google.com/uc?export=download&id=1UcpFIr154ZCmDd1bEaxNYt09uat5xw1b', 931.25, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '228'),
(1195, 2, 39, 'Alove Vera 99% 150ml', 'https://drive.google.com/uc?export=download&id=1PZFIysrycJRkQA5Y-qkRY4i4rVf2CR26', 620.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '229'),
(1196, 2, 35, 'Dr.Rashel Face Wash ', 'https://drive.google.com/uc?export=download&id=1EIEHwALJJMKL3yNuRTlHw-C8GT0DvLtB', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '230'),
(1197, 2, 30, 'Roushun Body Lotion 24 Gold', 'https://drive.google.com/uc?export=download&id=1U_GZVmQuSK8C0V1B86YDn5--HszP9JGW', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '231'),
(1198, 2, 30, 'Roushun Body Lotion Carrot, Papaya', 'https://drive.google.com/uc?export=download&id=1v8q53fD1Nv-9Z19ZKFbXUwsnDAmJuve1', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '232'),
(1199, 2, 30, 'Roushun Body Lotion', 'https://drive.google.com/uc?export=download&id=1pL6dJjiZlagXWmstNHvZ7D78yHCETmaX', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '233'),
(1200, 2, 23, 'Natural Scrub ', 'https://drive.google.com/uc?export=download&id=14Jx6cbk_GRw4Uv7WsaIbldZKEW0dOHbO', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '234');
INSERT INTO `Item_List` (`ItemID`, `CategoryID`, `SubCategoryID`, `Name`, `ProductPhoto`, `Price`, `Description`, `BrandName`, `QtyPerBox`, `NewArrival`, `BulkPrice`, `CartoonPcs`, `Bulk_Description`, `AvailabilityStatus`, `LastUpdated`, `created_at`, `SKU`) VALUES
(1201, 2, 36, 'Roushun Shampoo & Conditioner ', 'https://drive.google.com/uc?export=download&id=1lCtqd7HiMWjMq4DP2IUAvCwcBwMkyebH', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '235'),
(1202, 2, 36, 'Roushun Shampoo, Conditioner ', 'https://drive.google.com/uc?export=download&id=1Q_0vWXF6oKE-PFbw4s78vxTrT_Qzs5zz', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '236'),
(1203, 2, 36, 'Wokali Shower Gel ', 'https://drive.google.com/uc?export=download&id=1D17ZXOx-75XB3l4jJpd1p9x3F0aqd2tn', 1270.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '237'),
(1204, 2, 39, 'Hudabeauty Soothing Gel Aloe Vera..', 'https://drive.google.com/uc?export=download&id=15bPF6eMRQId3E8gnGHFtpD9H3mqgX1Dn', 770.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '238'),
(1205, 1, 10, 'Ice Stick Pack White', 'https://drive.google.com/uc?export=download&id=11NE-tlmMNFZyR8NyUnRJGy6rKXqaEDCH', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '239'),
(1206, 1, 1, 'Glue Gun', 'https://drive.google.com/uc?export=download&id=1-B1REHnWD4qxXjxD_7RtpNFRku06Oq4F', 586.69, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:34', '0000-00-00 00:00:00', '240'),
(1207, 1, 14, 'Chalk White 100Pcs', 'https://drive.google.com/uc?export=download&id=1nwkaOEANwDgk6ntSic0brNM8jXI01jN2', 210.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:17:28', '0000-00-00 00:00:00', '241'),
(1208, 1, 10, 'Umbrella Kids', 'https://drive.google.com/uc?export=download&id=1zp0b7fQKnV3tZqrOuCOmys5OjS_Eq_X0', 680.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '242'),
(1209, 1, 2, 'Pastal Pentium', 'https://drive.google.com/uc?export=download&id=1zntBg8lp7XlyDYL9XLUpcogGPpCY4mRf', 82.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:39:53', '0000-00-00 00:00:00', '243'),
(1210, 1, 18, 'Camlin Pencil Lead (0.7 mm)', 'https://drive.google.com/uc?export=download&id=1zBxGmqyvd38BPGSgPML_ZU0cfBrTupHy', 250.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:35', '0000-00-00 00:00:00', '244'),
(1212, 2, 35, 'YC Face Wash Lemon', 'https://drive.google.com/uc?export=download&id=1ezRwz2llRbouQVbXZVCZBEvgy9mn_StZ', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '246'),
(1213, 2, 40, 'Royal Jesmine Perfum Ladies 100ml', 'https://drive.google.com/uc?export=download&id=16I3aWzlJoTzo_whmYGqvL1cXLI72m2LR', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '247'),
(1214, 2, 33, 'Carotone Cream 30ml', 'https://drive.google.com/uc?export=download&id=1GiCYNe5pcQGGUTBvBb7KsHiSjbtlj3Q4', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '248'),
(1215, 2, 35, 'Dr.Rashel Face Wash Aloe Vera', 'https://drive.google.com/uc?export=download&id=1BkasQLoj6fXraseRy0y4vbbfLOGIw2Lo', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '249'),
(1216, 1, 29, 'OutDoor Water Bottle 300 ml', 'https://drive.google.com/uc?export=download&id=1s9wdmqMW7D-AiIYXzmJKCskDoYVTsgym', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '250'),
(1218, 1, 10, 'Chess Board 5 In 1', 'https://drive.google.com/uc?export=download&id=12soujIYIvyQVXqJOfVBC5pdwTamqKLNF', 1225.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '252'),
(1219, 1, 4, 'Pink Desighn Number Candles', 'https://drive.google.com/uc?export=download&id=1ucdyXkeZqx7TGOeF5IbcjD3js18Qb5uf', 50.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:36', '0000-00-00 00:00:00', '253'),
(1220, 1, 14, 'Correction Tape Large TR 204', 'https://drive.google.com/uc?export=download&id=1yvgjFSoMt4xfHowox_E-bFcVtBwySD0O', 120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '254'),
(1221, 1, 1, 'Max Instrument Box', 'https://drive.google.com/uc?export=download&id=1ybR15ZZ0laEszhVFkWMSxea-C-Ugz466', 345.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '255'),
(1222, 1, 22, 'Scissor 210mm			', 'https://drive.google.com/uc?export=download&id=1y0DhaJxvPhFThBX1cksmQEmicSUT38WH', 487.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:47:42', '0000-00-00 00:00:00', '256'),
(1223, 1, 22, 'Scissor Kangaroo 185mm', 'https://drive.google.com/uc?export=download&id=1xo24zHX-JVecU69FFpCHxSlgKvs3DQBl', 810.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:37', '0000-00-00 00:00:00', '257'),
(1224, 1, 14, 'Price Tag 10Pcs	', 'https://drive.google.com/uc?export=download&id=1x_1ICX1Oh2E_T7au3JkbRAoW1jnYQx2S', 690.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:37', '0000-00-00 00:00:00', '258'),
(1225, 1, 14, 'Premium Tipex Bottle 15ml', 'https://drive.google.com/uc?export=download&id=1wTMskNMHwPY7OL-pI-ZJglGGAevQKbZX', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:37', '0000-00-00 00:00:00', '259'),
(1226, 1, 1, 'Compass Single 90279', 'https://drive.google.com/uc?export=download&id=1BBilJ9sKjkuMNiOVtHD7BgLF7QE8fzjA', 325.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:05:01', '0000-00-00 00:00:00', '260'),
(1227, 1, 14, 'Price Tag Machine', 'https://drive.google.com/uc?export=download&id=1y-9VbUGSkYlNfLTN4GIATPUFjlKDSrko', 1190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:38', '0000-00-00 00:00:00', '261'),
(1228, 1, 15, 'Candle', 'https://drive.google.com/uc?export=download&id=1xicnsw-tPKMIvDs4C2fwjSoTOh_Nw9Qk', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '262'),
(1229, 1, 1, 'Magnette Box 6605', 'https://drive.google.com/uc?export=download&id=12q2QfJt4dqnjdUNOTc2inCiKPJXQyM1M', 544.88, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '263'),
(1230, 1, 15, 'Stationery Set 18101', 'https://drive.google.com/uc?export=download&id=1PSrN-fRDezzdD70OXylgBY_5AXhGVNYH', 235.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:40:08', '0000-00-00 00:00:00', '264'),
(1232, 1, 15, 'Stationery Set 6608', 'https://drive.google.com/uc?export=download&id=12ZOX2uHJRLkTIfi6V68EwqoQ19B4FBu2', 235.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:39', '0000-00-00 00:00:00', '266'),
(1233, 1, 2, 'Painting Book Small', 'https://drive.google.com/uc?export=download&id=1zLix0DIrHWeLZALwBDL6es4YNCBZ--Uf', 210.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:47:19', '0000-00-00 00:00:00', '267'),
(1234, 1, 2, 'Painting Book Large', 'https://drive.google.com/uc?export=download&id=11KcZyuiGF2H9hZWqr5ojqavk3wPNCUQS', 265.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:47:02', '0000-00-00 00:00:00', '268'),
(1235, 1, 2, 'Water Color Cake 16pcs', 'https://drive.google.com/uc?export=download&id=1zEOYNgrmGw2NbWMdqXyR5wfHkOYRA7qs', 235.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:40', '0000-00-00 00:00:00', '269'),
(1236, 1, 2, 'Zippy Platinum 2 Color 12Pcs', 'https://drive.google.com/uc?export=download&id=1nB1OW_jmfk7yqxIUHh0TLWqIeKtk_wFu', 690.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:56:46', '0000-00-00 00:00:00', '270'),
(1237, 1, 2, 'Crayon Pen 12 Colors', 'https://drive.google.com/uc?export=download&id=1wxeOD126A_Ps3mBRU1_gRcfc128SU1ym', 665.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:38', '0000-00-00 00:00:00', '271'),
(1238, 1, 2, 'Platignum Yalong 6 Colours', 'https://drive.google.com/uc?export=download&id=14IMEXLIZ0qPknlXPSS2Y-Qd2Fi86HeOs', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:01:32', '0000-00-00 00:00:00', '272'),
(1239, 1, 2, 'Master Water ColourTube 6ml', 'https://drive.google.com/uc?export=download&id=1wkKzZbIsgIRZHn0got2cTw45wMzX69sr', 310.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '273'),
(1240, 1, 2, 'Platignum 12Pcs', 'https://drive.google.com/uc?export=download&id=1wjpt9wA5DOzJY88gSifM_KkDlrlM0XuL', 350.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:42', '0000-00-00 00:00:00', '274'),
(1241, 1, 2, 'Yalong Water Colors Cake', 'https://drive.google.com/uc?export=download&id=1wh9D9GDVA0UK5sdvlaU-atoM1CMRf6Nb', 365.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:11:13', '0000-00-00 00:00:00', '275'),
(1243, 1, 2, 'Platignum 6Pcs', 'https://drive.google.com/uc?export=download&id=1wA0PuIVk_2OXS0TD8aoS3HshvAEkahc0', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:42', '0000-00-00 00:00:00', '277'),
(1244, 1, 6, 'Plastilina Clay 10 Colors	', 'https://drive.google.com/uc?export=download&id=15oOkKqndmbo82VWunZRCdbElcFJZVr2a', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:42', '0000-00-00 00:00:00', '278'),
(1245, 1, 46, 'Highlighter 959 6pcs', 'https://drive.google.com/uc?export=download&id=1WHakVw_kAzGIHHLuVk9g11D06lghbX1Z', 445.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:43', '0000-00-00 00:00:00', '279'),
(1246, 1, 46, 'Cluch Highlighter 5pcs', 'https://drive.google.com/uc?export=download&id=13hZq0QTOhP89o4D-qNR7nLktjxCyOmSw', 1920.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '280'),
(1247, 1, 19, 'Hello Kity Purse', 'https://drive.google.com/uc?export=download&id=11Lw1XYL-eyRyFdvcZjUFz_sZSvPcyKeZ', 740.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:46:34', '0000-00-00 00:00:00', '281'),
(1248, 1, 14, 'Cutter Knife Heavy Duty Large', 'https://drive.google.com/uc?export=download&id=10OR4nkfbE2otvDgmDK9PLqHwbv2xj5Kd', 175.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '282'),
(1249, 1, 14, 'DL Utility Knife 3081 Small', 'https://drive.google.com/uc?export=download&id=10RYtKLQGEW7rg7zMvIKFD1f-9gLx5kMy', 75.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:43', '0000-00-00 00:00:00', '283'),
(1250, 1, 14, 'Cutter Knife Heavy Duty Medium', 'https://drive.google.com/uc?export=download&id=10RnzlKIbOvvAtyBrZexYlA-a-62aMA_w', 185.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:44', '0000-00-00 00:00:00', '284'),
(1251, 1, 29, 'Water Bottle 1500ml 4 IN 1', 'https://drive.google.com/uc?export=download&id=1bp02I_h529HO61wldnfqPjXVqSgilLjk', 1680.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:27:26', '0000-00-00 00:00:00', '285'),
(1252, 1, 20, 'Table Pen', 'https://drive.google.com/uc?export=download&id=10W6DDL6mtJr7Skt62H8CYH_EfwsxeF6E', 150.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '286'),
(1253, 1, 29, 'Vacuum Water Bottle FS15 800ml', 'https://drive.google.com/uc?export=download&id=1qxRV_ktuUPl9gYy1beV6qB9f1S4LVe-0', 1385.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '287'),
(1254, 1, 29, 'Water Bottle 6101', 'https://drive.google.com/uc?export=download&id=1r6Bxiqlr-uGDcyb_GArmqigsO_4zkvL5', 215.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:45', '0000-00-00 00:00:00', '288'),
(1255, 1, 29, 'Water Bottle JC 13', 'https://drive.google.com/uc?export=download&id=1rHU7P1Rg_O2i96bQRMqwPvvzfnG3vmi0', 490.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:05', '0000-00-00 00:00:00', '289'),
(1256, 1, 29, 'Water Bottle JC 15', 'https://drive.google.com/uc?export=download&id=1rIWtiFrN2SNNhs3OYD4in9tBPnycSnWz', 425.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:03', '0000-00-00 00:00:00', '290'),
(1257, 1, 29, 'Water Bottle 6628', 'https://drive.google.com/uc?export=download&id=1rLFpZhlubT7qP8dHSZfGTUMhy2u16eTg', 315.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 08:40:04', '0000-00-00 00:00:00', '291'),
(1258, 1, 29, 'Water Bottle JC 12', 'https://drive.google.com/uc?export=download&id=1rYicCk-BIKETvAyAuiem69IvQY-qRGvO', 425.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:04', '0000-00-00 00:00:00', '292'),
(1259, 1, 27, 'Glitter Tape 60Pcs ', 'https://drive.google.com/uc?export=download&id=11EoXu-p4t8nIAcQOpvmoby10omHfXFDj', 1050.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:47', '0000-00-00 00:00:00', '293'),
(1260, 1, 27, 'Foil Tape 60 Pcs', 'https://drive.google.com/uc?export=download&id=11Eb1kLn-11FWnVI-B8va5itY_Pr9rV-F', 1050.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:48', '0000-00-00 00:00:00', '294'),
(1261, 1, 25, 'Sticker Card 61 Butterfly', 'https://drive.google.com/uc?export=download&id=1-pXOd-Sh1F3pGqVxJA3Vh_Nr46lC9wgd', 60.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:48', '0000-00-00 00:00:00', '295'),
(1262, 1, 25, 'Sticker Card 67 Mix', 'https://drive.google.com/uc?export=download&id=1-qNskpqE3kxDcdY7nRTDb8CoXIFo6tIb', 80.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '296'),
(1263, 1, 25, 'Sticker Card 66 Mix', 'https://drive.google.com/uc?export=download&id=1-qluXZKz6g8B0BHyrdHNTJrIUU_G2QG2', 60.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:48', '0000-00-00 00:00:00', '297'),
(1264, 1, 25, 'Room Decor Butterfly Large	', 'https://drive.google.com/uc?export=download&id=1-ssJQrF0iEZKEhL-Af_1bmYd0Ur3dcc4', 285.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:49', '0000-00-00 00:00:00', '298'),
(1265, 1, 25, 'Room Decor Dogs	', 'https://drive.google.com/uc?export=download&id=1-tjdzptdVVYurM4WuVg7r4bCODx4Ol74', 145.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '299'),
(1266, 1, 25, 'Room Decor Butterfly Medium', 'https://drive.google.com/uc?export=download&id=1-uwxlBQMKDeYrlO6QLcssU6JrtPzvTzj', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:49', '0000-00-00 00:00:00', '300'),
(1267, 1, 25, 'Room Decor Butterfly Small	', 'https://drive.google.com/uc?export=download&id=1-yVuSU3qIx_gyfm23JHBzdl8umV-O13-', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:49', '0000-00-00 00:00:00', '301'),
(1268, 1, 25, 'Room Decor Butterfly X Small', 'https://drive.google.com/uc?export=download&id=105vkT2IwZ28yRJA15GbaSka0S2omhHZK', 170.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:49', '0000-00-00 00:00:00', '302'),
(1269, 1, 25, 'Sticker Card Smile 34', 'https://drive.google.com/uc?export=download&id=10EnMi9zxad96NjHR7xIoOxDYUbW5YYKY', 80.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:50', '0000-00-00 00:00:00', '303'),
(1270, 1, 25, 'Sticker Card 68 Mix', 'https://drive.google.com/uc?export=download&id=10NKczYH1TwozUsge4ZLZ0w7wMUPwe4xE', 165.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '304'),
(1271, 1, 11, 'Laminating Pouch', 'https://drive.google.com/uc?export=download&id=13L76uI12HsaVOE_Jg9bN-1YHEU8Q0sZA', 1.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:33:36', '0000-00-00 00:00:00', '305'),
(1272, 1, 11, 'Binding Back Cover 50 Sheet', 'https://drive.google.com/uc?export=download&id=13N3mf_BPfI0vcHiQBjXqOizzWxLMiinx', 1450.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 15:30:30', '0000-00-00 00:00:00', '306'),
(1273, 1, 11, 'Binding Front Cover 100pcs', 'https://drive.google.com/uc?export=download&id=13MzePGXuzmQDANNyFxW_6_L57Kh_DxIm', 1450.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 15:31:24', '0000-00-00 00:00:00', '307'),
(1274, 1, 6, 'Slime 7872', 'https://drive.google.com/uc?export=download&id=1xlX7iUNu5JiXx71FHWiLHZsFO8ja9813', 265.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '308'),
(1275, 1, 6, 'Slime 7767', 'https://drive.google.com/uc?export=download&id=1xsoJfUblu4QQUPP5AFYNNWr9Fu_ps2sT', 215.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '309'),
(1276, 1, 10, 'Magic Cube Red 6Pcs', 'https://drive.google.com/uc?export=download&id=1y9xCTBYpvh41y6YZN0DVF725CgDjBBTn', 995.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:45:43', '0000-00-00 00:00:00', '310'),
(1277, 1, 10, 'Magic Cube White 6Pcs	', 'https://drive.google.com/uc?export=download&id=1yENKHcrna39BP5iTYiEcIfz10klyODyR', 1610.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:52', '0000-00-00 00:00:00', '311'),
(1279, 1, 10, 'Magic Cube Pyramid	', 'https://drive.google.com/uc?export=download&id=1ygRTWol2cs6iiMG-hMSgpYztWJwW5wWJ', 505.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:52', '0000-00-00 00:00:00', '313'),
(1280, 1, 10, 'Magic Cube Singals 655	', 'https://drive.google.com/uc?export=download&id=1ypP8LCBvSiNRWNFBN4mHy9y5HhHWg5u2', 310.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:53', '0000-00-00 00:00:00', '314'),
(1281, 1, 10, 'Magic Cube 357 12Pcs	', 'https://drive.google.com/uc?export=download&id=1yqI1J7AYVr8gZwXRxX4b6M1qvD2R9g6b', 3500.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:53', '0000-00-00 00:00:00', '315'),
(1282, 1, 10, 'Magnet Set Box Small', 'https://drive.google.com/uc?export=download&id=1ztAT9FscSlaKC44GteD4tylWKpJA8D0a', 332.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:33:06', '0000-00-00 00:00:00', '316'),
(1283, 1, 28, '3D Puzzele MS 1690', 'https://drive.google.com/uc?export=download&id=10dsJYFQ2wrvGLB7VmCCFjqQJsZuNCCdS', 164.48, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '317'),
(1284, 1, 10, 'Puzzles Small 3Pcs	', 'https://drive.google.com/uc?export=download&id=10fZqNxfA7JNk8G2r8q_teIvsDTFlIW-S', 74.40, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '318'),
(1285, 1, 10, 'Building Block 24Pcs	', 'https://drive.google.com/uc?export=download&id=1s1MESzLXrWK_u_Ma3H92N150AICCn3wg', 150.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:56:06', '0000-00-00 00:00:00', '319'),
(1286, 1, 10, 'Letter Bag English	', 'https://drive.google.com/uc?export=download&id=10hxc4TRHDRGGLg6z6Fq_tIA8Wj-wzfmg', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '320'),
(1287, 1, 10, 'Building Block 40Pcs	', 'https://drive.google.com/uc?export=download&id=1eYkAX8V7uuSiLrIc82zOX5E7knqF_Cu4', 200.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:56:17', '0000-00-00 00:00:00', '321'),
(1288, 1, 10, 'Letter Bag Numbers	', 'https://drive.google.com/uc?export=download&id=118TvbwAu2kLVYSnjxFiMCRf3mU1qcfxO', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '322'),
(1289, 1, 10, '3D Puzzule MS 2611', 'https://drive.google.com/uc?export=download&id=11Gj9FAbyX1C1HfsCZYrC2RC3F35R-_VW', 95.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '323'),
(1290, 1, 10, '3D Puzzele 1689', 'https://drive.google.com/uc?export=download&id=11NW7o7sacQk1LE7-3o2gfsZ48A2HJekz', 135.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '324'),
(1291, 1, 10, 'Shapes 24Pcs', 'https://drive.google.com/uc?export=download&id=12e2YRJK7lD8KaTdWd9Lu1DP7e79dCL9i', 75.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:54:21', '0000-00-00 00:00:00', '325'),
(1292, 1, 10, 'Solid Set 9Pcs	', 'https://drive.google.com/uc?export=download&id=11wX5PkNvcNf-xDW7V43-B-q5XD_OccOG', 200.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:49:56', '0000-00-00 00:00:00', '326'),
(1293, 1, 10, 'Building Blocks Jumbo', 'https://drive.google.com/uc?export=download&id=120SoIRh9Mn5b56Q95KuouoWznEBzrTGJ', 390.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '327'),
(1294, 1, 10, ' Magic Cube Singals 927 ', 'https://drive.google.com/uc?export=download&id=12Vs4y03xBGtIU_yBVz2h-q4aj_yC63b-', 415.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '328'),
(1295, 1, 10, 'Chess Board Medium 2029', 'https://drive.google.com/uc?export=download&id=12tL6zqap0irHLGpN3w_3SAu8P8vklQT5', 990.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '329'),
(1296, 1, 1, 'Key Tag 2015', 'https://drive.google.com/uc?export=download&id=15oiFzovMACe81KVrfQuZ3LrE1vE-nclE', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:34', '0000-00-00 00:00:00', '330'),
(1297, 1, 1, 'Key Tag 2017', 'https://drive.google.com/uc?export=download&id=16QBSOi-XE4eIlJKDV1QSRLsEme7j0GLQ', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:19', '0000-00-00 00:00:00', '331'),
(1298, 1, 1, 'Key Tag 2007', 'https://drive.google.com/uc?export=download&id=16LYjO6myRmPofZwDbC_Ai8X1fCcX7jTX', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:32', '0000-00-00 00:00:00', '332'),
(1299, 1, 1, 'Key Tag 2012', 'https://drive.google.com/uc?export=download&id=16GJ8Ymv4A2Ufq1mbGmi0RMpH4yh6SEu-', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:31', '0000-00-00 00:00:00', '333'),
(1300, 1, 1, 'Key Tag 2005', 'https://drive.google.com/uc?export=download&id=16AaXLdkg0XEOWlWHqCXExweyzXC2iZma', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:30', '0000-00-00 00:00:00', '334'),
(1301, 1, 1, 'Key Tag 2001', 'https://drive.google.com/uc?export=download&id=1o9vzv7P19dtaMx8coojmPckXR2XAxCqH', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:13:28', '0000-00-00 00:00:00', '335'),
(1302, 1, 1, 'Key Tag 2009', 'https://drive.google.com/uc?export=download&id=15sgLBxFc-fy5hrf6_Ahd1XRGeroHkNQy', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:37', '0000-00-00 00:00:00', '336'),
(1303, 1, 1, 'Key Tag 2010', 'https://drive.google.com/uc?export=download&id=15j3vtjTtNwzvZPxNTdp3tpnByRD37wxu', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:39', '0000-00-00 00:00:00', '337'),
(1304, 1, 1, 'Key Tag 2004', 'https://drive.google.com/uc?export=download&id=15im8g-ihNJjiwL_uvgUtb9kQNLt5AMaM', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:40', '0000-00-00 00:00:00', '338'),
(1305, 1, 1, 'Key Tag 2003', 'https://drive.google.com/uc?export=download&id=15fhKDFEXKe1HMKrvy-qDtg-EK9nXaQ32', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:42', '0000-00-00 00:00:00', '339'),
(1306, 1, 1, 'Key Tag 2008', 'https://drive.google.com/uc?export=download&id=15Sx2PtbiwZbvUv4egmMjGx7t8bh94hTh', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:42', '0000-00-00 00:00:00', '340'),
(1307, 1, 1, 'Key Tag 2002', 'https://drive.google.com/uc?export=download&id=15DhJyKecGeo6N5M7b-a9mPQHXAGjI62Z', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:44', '0000-00-00 00:00:00', '341'),
(1308, 1, 1, 'Key Tag 2006', 'https://drive.google.com/uc?export=download&id=15BdHZeFnEgUTvQMBuap5hUU9aF8YfSTW', 720.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 07:13:45', '0000-00-00 00:00:00', '342'),
(1309, 1, 1, 'Key Tag Duck 12Pcs', 'https://drive.google.com/uc?export=download&id=15C-Bygcxfxh_c-SCQ5rqkAZMY5broMV6', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:25', '0000-00-00 00:00:00', '343'),
(1310, 1, 1, 'Key Tag Hello Kitty 10Pcs', 'https://drive.google.com/uc?export=download&id=1-WtDK7Lb09dINaqvUa_COlbu_xMndSXE', 900.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:27', '0000-00-00 00:00:00', '344'),
(1311, 1, 10, 'Magic Cube Black 6Pcs', 'https://drive.google.com/uc?export=download&id=16g6IQrvrlFMV0YH9dwCjK8i22C9Sk1ld', 1740.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:02', '0000-00-00 00:00:00', '345'),
(1312, 1, 1, 'Key Tag Dolphin 12Pcs', 'https://drive.google.com/uc?export=download&id=16iA75QbpVuTLcnulXGT8pvbdB28sRnDu', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:28', '0000-00-00 00:00:00', '346'),
(1315, 1, 4, 'Birthday Foil Baloon 5026', 'https://drive.google.com/uc?export=download&id=1IoOAFzC_TytFIxY0bIoHXPy1EeunfY0M', 380.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:23:16', '0000-00-00 00:00:00', '349'),
(1316, 1, 4, 'Spark Candle 6Pcs', 'https://drive.google.com/uc?export=download&id=1v8A6Bjk9qIntACd0dOYxFSzGiHoox6vk', 300.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 13:50:55', '0000-00-00 00:00:00', '350'),
(1317, 1, 4, 'Birthday Letter Candle 0556', 'https://drive.google.com/uc?export=download&id=1_Yta9B4EH3ThgegLHVJSfTDKoxyLiVad', 170.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:12:08', '0000-00-00 00:00:00', '351'),
(1318, 1, 4, 'Party Candle 8760', 'https://drive.google.com/uc?export=download&id=1un2uTLxF6exgRqAtVCa0WviNLFtHqpFS', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:22:42', '0000-00-00 00:00:00', '352'),
(1319, 1, 4, 'Party Candle 1126', 'https://drive.google.com/uc?export=download&id=1vRYCLTXDjIELGm_ucvAJ6jA8p2tjtIKk', 95.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:05', '0000-00-00 00:00:00', '353'),
(1320, 1, 4, 'Birthday Music Candle 4015', 'https://drive.google.com/uc?export=download&id=1v9-lQ6wkii3aSesV-_-z2nvyoGRS_wxl', 280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:06', '0000-00-00 00:00:00', '354'),
(1321, 1, 4, 'Bow Design Number Candles ', 'https://drive.google.com/uc?export=download&id=1ucdyXkeZqx7TGOeF5IbcjD3js18Qb5uf', 65.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:06', '0000-00-00 00:00:00', '355'),
(1322, 1, 4, 'Birthday Music Candle 1202', 'https://drive.google.com/uc?export=download&id=1vSmfwMOUhLXiMDQYqLkdCwVqqDr77HE9', 225.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:06', '0000-00-00 00:00:00', '356'),
(1323, 1, 4, 'Number Candles ', 'https://drive.google.com/uc?export=download&id=1v32sZ4NRejDqk2LI5t45BExXdx9KgIlq', 28.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:38:58', '0000-00-00 00:00:00', '357'),
(1324, 1, 8, 'Double Clip File A4', 'https://drive.google.com/uc?export=download&id=1qGxeRfNnauHPxE9Hesz4ajV-mBKgajAk', 315.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:07', '0000-00-00 00:00:00', '358'),
(1326, 1, 8, 'Campus File FC 6016', 'https://drive.google.com/uc?export=download&id=1q1uCCT0meizI4MHQTTAHuk63ahS0rfSM', 375.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:43:56', '0000-00-00 00:00:00', '360'),
(1327, 1, 8, 'Business File', 'https://drive.google.com/uc?export=download&id=1pv3g6AJ8IUcY0xAXUCU5K0XJ9slEimCa', 75.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 15:42:22', '0000-00-00 00:00:00', '361'),
(1328, 1, 8, 'Campus File Side Clip 8811', 'https://drive.google.com/uc?export=download&id=1pt_cwccI2OXNuHNNDfzycZmzlAeaUR1R', 375.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:43:36', '0000-00-00 00:00:00', '362'),
(1329, 1, 8, 'Campus File Side Clip 8812', 'https://drive.google.com/uc?export=download&id=1poo8jVLHUj_AY8k4OTI1eA9lgUBkabXl', 375.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:43:41', '0000-00-00 00:00:00', '363'),
(1330, 1, 3, 'Desighn Clear Bag FC 223F', 'https://drive.google.com/uc?export=download&id=1pontSoJ0xcrD-GbPF7qCbaKzdVm5Mzjs', 70.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:09', '0000-00-00 00:00:00', '364'),
(1331, 1, 3, 'Zipper Bag - 2150', 'https://drive.google.com/uc?export=download&id=1piYtpX9Hn6PppLB-6SMXbXmotxxQ-cja', 175.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:09', '0000-00-00 00:00:00', '365'),
(1333, 1, 3, 'Ring Zipper Clear Bag', 'https://drive.google.com/uc?export=download&id=17x1_YCRVBDyidOg8fWA61wKeEcfs9gLJ', 1.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:10:19', '0000-00-00 00:00:00', '367'),
(1334, 1, 8, 'Pocket File', 'https://drive.google.com/uc?export=download&id=1pQs3dD8nyV8O4C8H50TC1RqryKKGrwuV', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:10', '0000-00-00 00:00:00', '368'),
(1335, 1, 3, 'Master Clear Bag FC', 'https://drive.google.com/uc?export=download&id=1pGCeCMSJlzDgu-JZ2Ot1L1OzC7kGdyHY', 55.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:11:41', '0000-00-00 00:00:00', '369'),
(1336, 1, 3, 'My Clear Bag FC', 'https://drive.google.com/uc?export=download&id=1B6fTur4blBasZ4sFIhNcY-pwyj21twG3', 50.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:10:25', '0000-00-00 00:00:00', '370'),
(1337, 1, 3, 'Bar File 10Pcs', 'https://drive.google.com/uc?export=download&id=1pDjc9OHHqSN9KyZSIPg_SmHOfm-X8yvG', 525.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:14', '0000-00-00 00:00:00', '371'),
(1338, 1, 3, 'Fabric Zipper Bag FC 1027', 'https://drive.google.com/uc?export=download&id=197o6rOUyyDetxve1BcURa4zV1E0XOvk0', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 06:03:06', '0000-00-00 00:00:00', '372'),
(1339, 1, 3, 'Fabric Zipper Bag FC 1028', 'https://drive.google.com/uc?export=download&id=18nI0v115k9H02BoMM2Es2uVSxVMw7ZEQ', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 06:03:08', '0000-00-00 00:00:00', '373'),
(1340, 1, 3, 'Fabric Zipper Bag FC 1026', 'https://drive.google.com/uc?export=download&id=18lZxoLkWErUAeiILZ_pTQQp7XH7FzwP8', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 06:03:09', '0000-00-00 00:00:00', '374'),
(1341, 1, 3, 'Fabric Zipper Bag FC 1031', 'https://drive.google.com/uc?export=download&id=19E_qM_rouDcb3sqN-bAeMQHBNGiSbZDE', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 06:03:10', '0000-00-00 00:00:00', '375'),
(1342, 1, 3, 'Fabric Zipper Bag FC 1025', 'https://drive.google.com/uc?export=download&id=18_fyuZHfbmTHR3rkU4GFQpijVYEjXioi', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 06:03:12', '0000-00-00 00:00:00', '376'),
(1343, 1, 3, 'Fabric Zipper Bag A5', 'https://drive.google.com/uc?export=download&id=18roDc5gPvFnNTnPwWPYESPk1J9MTi9RT', 160.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 06:03:14', '0000-00-00 00:00:00', '377'),
(1344, 1, 19, 'Pencil Purse 1084', 'https://drive.google.com/uc?export=download&id=19796H5PodUfHz9UaqPUZFipYHy4TgQAp', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '378'),
(1345, 1, 3, 'My Clear Bag FC-White', 'https://drive.google.com/uc?export=download&id=19L0P3HBccLGQN12iLEGRJcCwYDRbWWLs', 50.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:44:57', '0000-00-00 00:00:00', '379'),
(1346, 1, 4, 'Birthday Balloon 7Pcs', 'https://drive.google.com/uc?export=download&id=1-2-Wnyu7kMYD6S1lG7jsUWSfQvZHv7L8', 280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:11:19', '0000-00-00 00:00:00', '380'),
(1347, 1, 4, 'Birthday Foil Banner 1316	', 'https://drive.google.com/uc?export=download&id=1xCjBoOTY00EzEfQK-kaEl-fcgZi18DJ-', 280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:21', '0000-00-00 00:00:00', '381'),
(1348, 1, 4, 'Balloon', 'https://drive.google.com/uc?export=download&id=1x-WEcdb_qWZ6Q9u9VOl_VHdPXyj70acg', 160.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 15:28:42', '0000-00-00 00:00:00', '382'),
(1349, 1, 4, 'Birthday Balloon 32Pcs	', 'https://drive.google.com/uc?export=download&id=1x8qNMDR_Ik7Wr3mTepLQBewF5aFW-1WZ', 505.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '383'),
(1350, 1, 4, 'Birthday Banner 7857	', 'https://drive.google.com/uc?export=download&id=1x0YkMrPw5SwKdQBWfU8ldXvHzZHE-HK1', 215.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:23', '0000-00-00 00:00:00', '384'),
(1351, 1, 4, 'Balloon No 07 100Pcs', 'https://drive.google.com/uc?export=download&id=1wetHX36jUVOBs4j6n8Rie-yfHd6X2RLb', 410.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:24', '0000-00-00 00:00:00', '385'),
(1352, 1, 4, 'Snow Spray - LARGE', 'https://drive.google.com/uc?export=download&id=1wUscR94kzo1A7flixc1WE8CYTE81vxbF', 315.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '386'),
(1353, 1, 4, 'Birthday Foil Banner	', 'https://drive.google.com/uc?export=download&id=1wE_qCoWDaNfL1wCy8MNWX-EXvwFOhS15', 440.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:25', '0000-00-00 00:00:00', '387'),
(1354, 1, 4, 'Party Candle 46-04	', 'https://drive.google.com/uc?export=download&id=1wCKqBqRv83TO7hq6_0_xVnvevGPKQlAj', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:22:27', '0000-00-00 00:00:00', '388'),
(1355, 1, 4, 'Birthday Knife Candle Card	', 'https://drive.google.com/uc?export=download&id=1vbStXpgMAkLmljksjjpZgMgzPPHIL0hn', 200.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '389'),
(1356, 1, 4, 'Birthday Letter Candle 0698	', 'https://drive.google.com/uc?export=download&id=1vbEl5OQ7jXdPb2H0gXx9y4d5H112_xiI', 145.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:25', '0000-00-00 00:00:00', '390'),
(1357, 1, 4, 'Birthday Candle 3538	', 'https://drive.google.com/uc?export=download&id=1vYirghloaQi32w90XJMVxrVzA7fBAj5A', 135.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '391'),
(1358, 1, 4, 'Party Candle', 'https://drive.google.com/uc?export=download&id=1v78q15OHaA-umhPbFe4YBwIACMhBQhg4', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:26', '0000-00-00 00:00:00', '392'),
(1359, 1, 4, 'Party Candle 46-07	', 'https://drive.google.com/uc?export=download&id=1uxEAINXz4fD9rt_Igoh6nb_7aBRP2MwT', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:27', '0000-00-00 00:00:00', '393'),
(1360, 1, 4, 'Party Candle 46-06	', 'https://drive.google.com/uc?export=download&id=1uqg2UI9kt6XUK6hiN7Gfs8OrsQgZayN7', 240.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:22:25', '0000-00-00 00:00:00', '394'),
(1361, 1, 4, '9 Animals Balloon Card 40Pcs', 'https://drive.google.com/uc?export=download&id=1uTJHsIDfWxWjKrNgIOB2E5qLStUH26JX', 450.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:27', '0000-00-00 00:00:00', '395'),
(1362, 1, 4, 'Jumbo Balloon Card 20Pcs	', 'https://drive.google.com/uc?export=download&id=1uFVcB_o37ha-sFXqZ8I3CtwBHFGBCP9t', 1075.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '396'),
(1363, 1, 4, 'Birthday Cake Topper 1329 (Small)', 'https://drive.google.com/uc?export=download&id=19MJPUNk53xGvW1h5KQDUvAVfUgbMGYGW', 70.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:28', '0000-00-00 00:00:00', '397'),
(1364, 1, 4, 'Birthday Cake Topper 1330	', 'https://drive.google.com/uc?export=download&id=19OtvSKBjcMvxYMu641ROVhsJ1fGuSAZK', 145.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:28', '0000-00-00 00:00:00', '398'),
(1365, 1, 4, 'Heart Baloon Red 10Pcs', 'https://drive.google.com/uc?export=download&id=1dFVosTrUAcXzhl7ROHImrQqwZ8fUYA-B', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:21:57', '0000-00-00 00:00:00', '399'),
(1366, 1, 5, 'EX Books', 'InvalidURL', 85.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:29', '0000-00-00 00:00:00', '400'),
(1367, 1, 5, 'CR Books', 'InvalidURL', 75.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:29', '0000-00-00 00:00:00', '401'),
(1368, 1, 5, 'CR Graph Book 80 Pages', 'InvalidURL', 105.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '402'),
(1369, 1, 5, 'CR Bottany Book 80 Pgs			', 'InvalidURL', 105.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '403'),
(1370, 1, 5, 'CR Plain Book 120 Pgs', 'InvalidURL', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '404'),
(1371, 1, 5, '5 Rulle Book', 'InvalidURL', 45.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '405'),
(1372, 1, 5, 'EX Book 80 Pages Blank', 'InvalidURL', 60.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '406'),
(1373, 1, 5, 'Drawing Book 40 Pgs', 'InvalidURL', 135.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:31', '0000-00-00 00:00:00', '407'),
(1374, 1, 5, 'Spiral Note Book A5			', 'InvalidURL', 320.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '408'),
(1375, 1, 5, 'Scrap Book 40pages', 'InvalidURL', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '409'),
(1376, 2, 34, 'Huda Beauty Face Serum', 'Invalid URL', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '410'),
(1377, 1, 29, 'Water Bottle Kids 3308', 'https://drive.google.com/uc?export=download&id=1QMx4gNPCb8D9N63uyk4vE_ktiGjtJsPJ', 1728.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:51:28', '0000-00-00 00:00:00', '411'),
(1378, 1, 27, 'Binding Tape', 'https://drive.google.com/uc?export=download&id=19gfCx2glV-knkYNVUVQ7Ya03g3zPwQ0q', 140.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-28 13:39:52', '0000-00-00 00:00:00', '412'),
(1379, 1, 27, 'Easy Tear Tape', 'https://drive.google.com/uc?export=download&id=1xbf_kCFjOoX1C4mOOm_PKnGs2RMKUs5L', 175.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:11:07', '0000-00-00 00:00:00', 'CTET'),
(1381, 1, 27, 'Color Cello Tape 48mm * 50 mt', 'https://drive.google.com/uc?export=download&id=19ifX8-spz6gTM0wJ9EwwhIOUthhSJ276', 215.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 09:01:03', '0000-00-00 00:00:00', '415'),
(1382, 1, 27, 'Tane Tape', 'https://drive.google.com/uc?export=download&id=1eac_N7EzjToJqDGzx56tN6LY2ekcgGXx', 62.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-28 14:06:23', '0000-00-00 00:00:00', 'CTT'),
(1383, 1, 27, 'Double Side Tape', 'https://drive.google.com/uc?export=download&id=1BCPI0NN-lG7nuNHAp4cudQXSSpqoq6u8', 45.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-29 13:46:13', '0000-00-00 00:00:00', 'CTD'),
(1384, 1, 27, 'Masking Tape', 'https://drive.google.com/uc?export=download&id=14a_WncEve5opcnLAKH0JuYpSPZKdrHAz', 88.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-28 14:44:24', '0000-00-00 00:00:00', 'CTMT'),
(1386, 2, 32, 'Eua De Perfume 22ml ', 'https://drive.google.com/uc?export=download&id=1AWCRp36oqhk_GqlBGB09bNICHyBomuWq', 280.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '420'),
(1387, 2, 32, 'Eua De Parfum 50ml Ladies', 'https://drive.google.com/uc?export=download&id=1A_x6o1sevMGSugXi9MfQjS5btsZIl23-', 550.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '421'),
(1388, 2, 32, 'Eua De Parfum 50ml Gents', 'https://drive.google.com/uc?export=download&id=1AgyK-2Z2COy-eMtUF_NYCJ7OqQDF6rlu', 550.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '422'),
(1389, 2, 32, 'Eua De  Perfum 100ml ', 'https://drive.google.com/uc?export=download&id=1Atc-JrNxgF2TLz8kclUEqP1Qrl9TMHC7', 1000.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '423'),
(1390, 2, 32, 'Attar Roll On 6ml', 'https://drive.google.com/uc?export=download&id=1B2rxdz_bochaflsKAPCmAdQtFatg-iYW', 235.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '424'),
(1391, 2, 39, 'Lipstick 5 in 1', 'https://drive.google.com/uc?export=download&id=1B4pBnvJelpWem8KXM3AKY_Nnzf3p4wl9', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '425'),
(1392, 2, 31, 'Body Mist BN 250ml', 'https://drive.google.com/uc?export=download&id=1B4tD8y8H2YZj6WSLcwGVknW4_lN19rh1', 1065.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '426'),
(1393, 2, 31, 'Body Spray Brut 200ml', 'https://drive.google.com/uc?export=download&id=1BBk-UlKuAO-iVLjb7BZBPpKSEKfYHNi5', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '427'),
(1394, 2, 31, 'Body Spray TD 200ml', 'https://drive.google.com/uc?export=download&id=1BDYzys1Cls463p5gXbiAj4kLPTv36x2Y', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '428'),
(1395, 1, 24, 'Double Sharpner Jar 48pcs			', 'https://drive.google.com/uc?export=download&id=1Un0ShEaJ_qFCho87KJsWzvrL4LzUWmid', 3750.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:36', '0000-00-00 00:00:00', '429'),
(1396, 1, 7, 'Desighn  Eraser Smile 8406 18Pcs', 'https://drive.google.com/uc?export=download&id=1c7MXtBZhip5X5qNPwwa40DvM3iy4nGS3', 2995.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:24:40', '0000-00-00 00:00:00', '430'),
(1397, 1, 7, 'Desighn  Eraser Lipstick 1229 36Pcs ', 'https://drive.google.com/uc?export=download&id=1XY9SpcZXnGPRrR_koye-oXjiFXU1BsKr', 1335.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:24:11', '0000-00-00 00:00:00', '431'),
(1398, 1, 7, 'Desighn  Eraser 2208 48Pcs', 'https://drive.google.com/uc?export=download&id=1o7xJ8UUu5CsrGdTGd4F22dh6UyXHcCJC', 1595.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:37', '0000-00-00 00:00:00', '432'),
(1399, 1, 7, 'Desighn Eraser 5342 24Pcs ', 'https://drive.google.com/uc?export=download&id=1756G5uSKLho3HJU4P2Yftes49FeGLWcQ', 3995.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:24:54', '0000-00-00 00:00:00', '433'),
(1400, 1, 7, 'Desighn Eraser 5216 48Pcs ', 'https://drive.google.com/uc?export=download&id=1Eh0-O7xBwV6Jd5yqAXD0xSJVBIa7Xvtx', 1600.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:38', '0000-00-00 00:00:00', '434'),
(1401, 1, 29, 'Water Bottle Kids 3309 ', 'https://drive.google.com/uc?export=download&id=1-QJRZA2_8hXsRK9yhSz8JPguh6mVssxJ', 1795.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:51:45', '0000-00-00 00:00:00', '435'),
(1402, 1, 29, 'Vacuum Water Bottle 0800 800ml', 'https://drive.google.com/uc?export=download&id=1I23QG4vZt1EeGj1U-k_pleQW3rtu9-Ve', 2050.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:39', '0000-00-00 00:00:00', '436'),
(1403, 1, 29, 'Vacuum WB 8006 800 ml (FS40-38) ', 'https://drive.google.com/uc?export=download&id=1bU8joEr6dJNUJHBJoelKByTwgAFvRK3i', 2175.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:40', '0000-00-00 00:00:00', '437'),
(1404, 1, 29, 'Water Bottle (FS 33-54)', 'https://drive.google.com/uc?export=download&id=1QjCR-MVkbDV6VNXfKuBF7Z0BKm8NyMfp', 885.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:57:08', '0000-00-00 00:00:00', '438'),
(1405, 1, 29, 'Water Bottle Kids 4022', 'https://drive.google.com/uc?export=download&id=1TMsdBz4u_dgNjChmjIrfL1xRqt3c8BJL', 630.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:10:11', '0000-00-00 00:00:00', '439'),
(1406, 1, 29, 'Vacuum Water Bottle 4017 500ml', 'https://drive.google.com/uc?export=download&id=16TYB5C8Jkw8DTXBh7XB7U6jslSAg_euo', 1740.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:40', '0000-00-00 00:00:00', '440'),
(1408, 1, 29, 'Vacuum Water Bottle 4026', 'https://drive.google.com/uc?export=download&id=13w00wJPyhagm-LxMuoax6rzT0lryalz1', 1280.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '442'),
(1409, 1, 29, 'Water Bottle 4032', 'https://drive.google.com/uc?export=download&id=1AbIcnkvjE3uGzti9BbcRnupZ-OrNLuPG', 795.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:09:23', '0000-00-00 00:00:00', '443'),
(1410, 1, 29, 'Water Bottle 4031', 'https://drive.google.com/uc?export=download&id=1cSbXSVvTvj9nPxkkdk4qcBffMS3gKei0', 1050.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:31:39', '0000-00-00 00:00:00', '444'),
(1411, 1, 29, 'Water Bottle 4054', 'https://drive.google.com/uc?export=download&id=1rQTrDI5cD1Vae6ShfbSWMrygO8LbCDEk', 770.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:09:51', '0000-00-00 00:00:00', '445'),
(1412, 1, 29, 'Vacuum Water Bottle 4006', 'https://drive.google.com/uc?export=download&id=1ENoeEm-S8CJMStn3fLi796nL0VTLwmTO', 1790.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '446'),
(1413, 1, 29, 'Vacuum Water Bottle 4003 ( 550ml )', 'https://drive.google.com/uc?export=download&id=1kLqMMy1JkxBIRQq4Xm_Gn4jFUmyiDX-i', 1215.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:43', '0000-00-00 00:00:00', '447'),
(1414, 1, 29, 'Vacuum Water Bottle 40-35 (750ml)', 'https://drive.google.com/uc?export=download&id=1wud7vTHQoaZ_Bx_rPKPjpyODYMOoSEMj', 1280.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '448'),
(1415, 1, 29, 'Vacuum Water Bottle 4018', 'https://drive.google.com/uc?export=download&id=1Ug6RrGnCwZWbj1ad1iR49ZALSKu8Uhj6', 1920.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:32:39', '0000-00-00 00:00:00', '449'),
(1416, 1, 29, 'Vacuum Water Bottle 8822 (550ml) ', 'https://drive.google.com/uc?export=download&id=1yXLlOUwLpWgC7B3hrEhzrDq1vQmcMLnY', 2305.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '450'),
(1417, 1, 6, 'Slime Small', 'https://drive.google.com/uc?export=download&id=10GcNezTqxTEVQv6C0wcn7jE0sROEjOf_', 65.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 07:01:01', '0000-00-00 00:00:00', '451'),
(1418, 1, 2, 'Fabric Paint 12 Colours ', 'https://drive.google.com/uc?export=download&id=1xseBvRmo0JnrJFLDmHmyX1_Pyl6BYVpu', 1235.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '452'),
(1422, 1, 19, 'Pencil  Purse  V4', 'https://drive.google.com/uc?export=download&id=1JIVwBec3F2fn808SX665s5GjrBcLOdpP', 300.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '456'),
(1423, 1, 10, 'Magnet Set Box Mini ', 'https://drive.google.com/uc?export=download&id=1xC--7KCdQcCIKDxq4C6Q6cRiJnWt__Yb', 215.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:33:57', '0000-00-00 00:00:00', '457'),
(1424, 1, 6, 'Slime Small ', 'https://drive.google.com/uc?export=download&id=1b0-4Nz5Z0zExrLjOPgmVFgwKlD038VF_', 65.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '458'),
(1425, 1, 7, 'Rocket Erazer ', 'https://drive.google.com/uc?export=download&id=1JnRLkfR88BCHHJswNj0wGnghNdlCPcTe', 40.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-28 06:59:54', '0000-00-00 00:00:00', '459'),
(1426, 1, 20, 'Glitter Pen ', 'https://drive.google.com/uc?export=download&id=1Bs3ONj7HyGJYa6w6OCLjLrf1-TUn_XpL', 540.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:46', '0000-00-00 00:00:00', '460'),
(1427, 1, 4, 'Snow Spray Normal ', 'https://drive.google.com/uc?export=download&id=1GMfcaVkb6JgqX06dcTQbRsMeOMh3_I-f', 300.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '461'),
(1428, 1, 4, ' Party Popper Small', 'https://drive.google.com/uc?export=download&id=1dKGDJQXGi29VseT0Mb1Td5VHIE_ekYvZ', 195.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '462'),
(1429, 2, 36, 'Head & Shoulders Shampoo 400ml ', 'https://drive.google.com/uc?export=download&id=1v5jkWECJrL8ui49Qegb2-a-5gFRtCnkS', 1677.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '463'),
(1430, 2, 36, 'Argan Oil Shampoo, Conditioner 300ml ', 'https://drive.google.com/uc?export=download&id=1scXcRZaXLlx4D3Rfpya-v19PiRhgFkOX', 1430.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '464'),
(1431, 2, 40, 'Black Jesmine Perfume 50ml ', 'https://drive.google.com/uc?export=download&id=1pqI0hcWd2GiQJEfPa6ZqH9oxMujWjtYs', 580.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '465'),
(1432, 2, 40, 'Green Jesmine Perfume 50ml ', 'https://drive.google.com/uc?export=download&id=1HCRH8Odq8ZyBHy4kGdYX5vhc3xSIU7K1', 580.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '466'),
(1433, 2, 30, 'Enchantur Body Lotion 250ml ', 'https://drive.google.com/uc?export=download&id=1kxNH69MqpuuMA0CVR389CIodM9vqMI3J', 1430.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '467'),
(1434, 2, 30, 'Nivea Body Lotion 400ml ', 'https://drive.google.com/uc?export=download&id=1xXdbi1DzfJ0jzwhcyG4_e3hlu5dS7vvY', 2327.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '468'),
(1435, 2, 31, 'Body Spray Fa 150ml ', 'https://drive.google.com/uc?export=download&id=1K5LXX4FaAY5CwfSItDpSmFy9wUVAtjuG', 1268.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '469');
INSERT INTO `Item_List` (`ItemID`, `CategoryID`, `SubCategoryID`, `Name`, `ProductPhoto`, `Price`, `Description`, `BrandName`, `QtyPerBox`, `NewArrival`, `BulkPrice`, `CartoonPcs`, `Bulk_Description`, `AvailabilityStatus`, `LastUpdated`, `created_at`, `SKU`) VALUES
(1436, 2, 35, 'Jovees Face Wash 120ml', 'https://drive.google.com/uc?export=download&id=1CV4TxMvMidJWr6FQwqCL6q_CN2bHjYnb', 1120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '470'),
(1437, 2, 37, 'Love Spnge  ', 'https://drive.google.com/uc?export=download&id=1ipyqgOBEq4ytgmm9_XeeMo7-p4DyUQOx', 169.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '471'),
(1438, 2, 36, 'Dye Brush Small ', 'https://drive.google.com/uc?export=download&id=18jmTPVP8Oc4lXGfVQU5KAjWXx-HoP73P', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '472'),
(1439, 2, 36, 'Dye Brush Large ', 'https://drive.google.com/uc?export=download&id=1uRFDQFtqCVdpniFzaEI3l3VsW5Llav_U', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '473'),
(1440, 2, 36, 'Dye Brush 2 In 1 ', 'https://drive.google.com/uc?export=download&id=1LbyfN0wGyA6-PwZYrq9Vqu9J5A0NpsYS', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '474'),
(1441, 2, 37, 'Make Up Brush Small ', 'https://drive.google.com/uc?export=download&id=1p-R0kiwRRWVsXL32nXhrf0YlRqNI3aJk', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '475'),
(1442, 2, 37, 'Make Up Brush Large', 'https://drive.google.com/uc?export=download&id=1P60ony91jkOHGbtCEgMOEBjIO7wV6hCP', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '476'),
(1443, 2, 37, 'Make Up Brush Flat', 'https://drive.google.com/uc?export=download&id=1Iwl4TjJARUaPWFS4_bvx2ptkyoSytE8q', 195.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '477'),
(1444, 2, 37, 'Eyebrow Razor  ', 'https://drive.google.com/uc?export=download&id=1Uou7YqNDC25S9WvSxUBCtvTpCIij52A4', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '478'),
(1445, 2, 37, 'Powder Sponge 4 In 2 ', 'https://drive.google.com/uc?export=download&id=1sHLwfN7s1b15cExVJdJaDzsoSGwtSeF0', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '479'),
(1446, 2, 37, 'Puff Sponge 12pcs  ', 'https://drive.google.com/uc?export=download&id=1wFnb_4jCa_dPDOZTorNGgFj5VjAud3oD', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '480'),
(1447, 2, 37, 'Scrub Sponge 4 In 1 ', 'https://drive.google.com/uc?export=download&id=1Jc8XP20kLMmDUBASfmLUhu0BqNUbaqLV', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '481'),
(1448, 2, 37, 'Powder Sponge Singles ', 'https://drive.google.com/uc?export=download&id=1ToOJ--zQKeMAYbBAURSGqRfrhMy3qYcq', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '482'),
(1449, 2, 38, 'Wokali White Black Mask', 'https://drive.google.com/uc?export=download&id=1U8Z4Ux1GpX7WI6H5r_8HUAXZbjubRhUx', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '483'),
(1450, 2, 38, 'Dr Rachel Sheet Mask ', 'https://drive.google.com/uc?export=download&id=1X5RRDwXgz-a9xAO2_sk8VxZP0_ZJnyUY', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '484'),
(1451, 2, 34, 'Banjaras Rose Water 60ml ', 'https://drive.google.com/uc?export=download&id=1T_SlZhyJOJuSaeXR2FTMLWHkzWqY2nRU', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '485'),
(1452, 2, 34, 'Banjaras Face Pack 5pcs  ', 'https://drive.google.com/uc?export=download&id=1UikY2c0iGudGjThDLWRwbDoQm3y9Reds', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '486'),
(1453, 2, 34, 'Yardley Powder 100g ', 'https://drive.google.com/uc?export=download&id=1R3mWf15ronsVAf-W1azqc7HcH0fLShJM', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '487'),
(1454, 2, 34, 'Saffron Fairness Cream 50ml ', 'https://drive.google.com/uc?export=download&id=1cZOFnGjoemlZGjgBnJ4xiCfEAzgBTHZn', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '488'),
(1455, 2, 34, 'Enchanter Powder 125g ', 'https://drive.google.com/uc?export=download&id=1GAvqopysXO7mmjtyNV4xLUc7VT4mrF5t', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '489'),
(1456, 2, 34, 'Kojie San Soap 135g ', 'https://drive.google.com/uc?export=download&id=1Btq7Y0YUAx44LQWIGlWPxSUPBZNcsBqA', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '490'),
(1457, 2, 34, 'Banjaras Rose Water 60ml ', 'https://drive.google.com/uc?export=download&id=1T_SlZhyJOJuSaeXR2FTMLWHkzWqY2nRU', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '491'),
(1458, 2, 34, 'Banjaras Face Pack 5pcs  ', 'https://drive.google.com/uc?export=download&id=1UikY2c0iGudGjThDLWRwbDoQm3y9Reds', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '492'),
(1459, 2, 34, 'Yardley Powder 100g ', 'https://drive.google.com/uc?export=download&id=1R3mWf15ronsVAf-W1azqc7HcH0fLShJM', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '493'),
(1460, 2, 34, 'Saffron Fairness Cream 50ml ', 'https://drive.google.com/uc?export=download&id=1cZOFnGjoemlZGjgBnJ4xiCfEAzgBTHZn', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '494'),
(1461, 2, 39, 'Enchanter Powder 125g ', 'https://drive.google.com/uc?export=download&id=1GAvqopysXO7mmjtyNV4xLUc7VT4mrF5t', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '495'),
(1462, 2, 39, 'Kojie San Soap 135g ', 'https://drive.google.com/uc?export=download&id=1Btq7Y0YUAx44LQWIGlWPxSUPBZNcsBqA', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '496'),
(1463, 2, 39, 'Lakme Kajal Pencil ', 'https://drive.google.com/uc?export=download&id=1Gb8iGjv0z8IWlMW5l5hwtGeEW1GDouZ-', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '497'),
(1464, 2, 37, ' Nail Polish 12Pcs  ', 'https://drive.google.com/uc?export=download&id=1TXFRbPXI6HXkAW-IcfEUH9Hs9K3SMvZ8', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '498'),
(1465, 2, 37, 'Nail Polish Remover 26ml ', 'https://drive.google.com/uc?export=download&id=168JdBUrOnAnHjzhmlaWLQQ-nf93CJYa-', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '499'),
(1466, 2, 39, ' LUX Body Wash 450ML', 'https://drive.google.com/uc?export=download&id=1pS9K7oeoqVak63x2wNfIB0jXYNLt1qKZ', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '500'),
(1467, 2, 32, 'Royal Air Freshner ', 'https://drive.google.com/uc?export=download&id=1QrVBR2Ie1I96LqwlaL-h-M2Jp8AJqcFX', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '501'),
(1468, 2, 36, 'Best Powder Mix  ', 'https://drive.google.com/uc?export=download&id=1mFAoVYOI7Cfa954-IeQeYTzBCKoYfE1J', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '502'),
(1469, 1, 17, 'Pen Holders Bunny', 'https://drive.google.com/uc?export=download&id=1Y1HvPhmezj3kvSPATtDUGRB6DY_9RUXZ', 140.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:58:45', '0000-00-00 00:00:00', '503'),
(1470, 1, 17, 'Pen Holders Ovel ', 'https://drive.google.com/uc?export=download&id=1HWOTvwWfn_hGwQhBiiY97tLJJL8Ugjyr', 230.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:54:26', '0000-00-00 00:00:00', '504'),
(1471, 1, 17, 'Pen Holders Heart Devided', 'https://drive.google.com/uc?export=download&id=14KXlq_c9O8_xjUd6HSMgjbuaMhh3qPaE', 295.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:53:45', '0000-00-00 00:00:00', '505'),
(1472, 1, 17, 'Pen Holders Vase Devided', 'https://drive.google.com/uc?export=download&id=1FOjgShwAXxkpNRiBynOYILS7r1tYWAlD', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:53', '0000-00-00 00:00:00', '506'),
(1473, 1, 17, 'Pen Holders Kity ', 'https://drive.google.com/uc?export=download&id=1Ffsm9seRNiz07YD2g5gd1HSe7M9Ccji1', 170.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:54', '0000-00-00 00:00:00', '507'),
(1474, 1, 17, 'Pen Holders Design ', 'https://drive.google.com/uc?export=download&id=1Fjvg5jDr-VhcxqfKwabbbbezq7pduZj3', 150.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:54', '0000-00-00 00:00:00', '508'),
(1475, 1, 17, 'Pen Holders Vase', 'https://drive.google.com/uc?export=download&id=1wLVIju-OxBB59w9bziNGWdvTK0ebMddm', 130.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:58:21', '0000-00-00 00:00:00', '509'),
(1476, 1, 17, 'Pen Holders 8179', 'https://drive.google.com/uc?export=download&id=1mjwpV5cEPYercGWmC3Xo4p8XKvr2zzB3', 140.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:58:00', '0000-00-00 00:00:00', '510'),
(1477, 1, 17, 'Pen Holders 8189', 'https://drive.google.com/uc?export=download&id=1Fh9GGFWWw-WcB3SBacYaqnP6c1eZm8Zz', 140.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:55', '0000-00-00 00:00:00', '511'),
(1479, 1, 12, 'Lunch Box (FS 33-14)', 'https://drive.google.com/uc?export=download&id=1CtTfiMmh9TzLpYEp6aGaSX4q1nlVThIL', 564.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '513'),
(1480, 1, 12, 'Lunch Box (FS 33-15)', 'https://drive.google.com/uc?export=download&id=1DCgUnIcZZ84eUC6kgYzA0Le3dCTrtrgs', 602.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '514'),
(1481, 1, 12, 'Lunch Box (FS 33-76)', 'https://drive.google.com/uc?export=download&id=1CPHoRdlqoTd7icLz_qgKeaJ0BJc7RXuw', 400.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '515'),
(1482, 1, 12, 'Lunch Box (FS 33-21)', 'https://drive.google.com/uc?export=download&id=1Ch80Ggaz21i_MEQq62M2pYr9hM26iS-P', 575.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:56', '0000-00-00 00:00:00', '516'),
(1483, 1, 12, 'Lunch Box (FS 33-20)', 'https://drive.google.com/uc?export=download&id=1Pov5ynTrAYbmlTFwOAHZ8xW1PDzrIiff', 550.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:44:34', '0000-00-00 00:00:00', '517'),
(1484, 1, 12, 'Lunch Box (FS 33-19)', 'https://drive.google.com/uc?export=download&id=1L4K6GWC11I94LK8qAJH_gmedBq8TKDzn', 295.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:44:12', '0000-00-00 00:00:00', '518'),
(1485, 1, 12, 'Steel Lunch Box (FS 33-74)', 'https://drive.google.com/uc?export=download&id=1DW6ca0xYOjJjCVL1ZwkvggTwvlaPcEgb', 1325.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '519'),
(1486, 1, 12, 'Lunch Box (FS 33-22)', 'https://drive.google.com/uc?export=download&id=1-aof5-fjrJRzxunw1yeuZ6V4GDKAeeQl', 590.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:50:08', '0000-00-00 00:00:00', '520'),
(1487, 1, 12, 'Lunch Box (FS 33-23)', 'https://drive.google.com/uc?export=download&id=18spfV39DpCTjbGiT9qGslxDQo3ebnFxv', 345.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:57:03', '0000-00-00 00:00:00', '521'),
(1488, 1, 12, 'Lunch Box (FS 33-17)', 'https://drive.google.com/uc?export=download&id=1DQOoUXRnGtBfaPQQVGK-cvUoq0g-Q1Kn', 575.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '522'),
(1489, 1, 12, 'Lunch Box (FS 33-79)', 'https://drive.google.com/uc?export=download&id=1dyz1yf9tPXbl_2_F_hv_Z9L2XxGRDh1Y', 460.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:48:14', '0000-00-00 00:00:00', '523'),
(1490, 1, 12, 'Lunch Box (FS 33-5)', 'https://drive.google.com/uc?export=download&id=1725MtLAomI4TO_hDvXm4I-7fi8LDNQ5k', 550.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:49:37', '0000-00-00 00:00:00', '524'),
(1491, 1, 12, 'Lunch Box (FS 33-24)', 'https://drive.google.com/uc?export=download&id=1D2yWG3XTjgI6LdwFCQsFEe6skoC75r6k', 575.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:50:58', '0000-00-00 00:00:00', '525'),
(1492, 1, 12, 'Steel Lunch Box (FS 33-75)', 'https://drive.google.com/uc?export=download&id=1CtRvYAKlpju54TVLiQFMSJa0fVYGT7Ge', 1295.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '526'),
(1493, 1, 12, 'Lunch Box (FS 33-16)', 'https://drive.google.com/uc?export=download&id=1CrF8pE62a8OXWssUjZU5brKE_uPNI3aZ', 400.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '527'),
(1494, 1, 12, 'Lunch Box (FS 33-25)', 'https://drive.google.com/uc?export=download&id=1GWhQgKaGera97ajtA4bylYpuzNs_i-u8', 385.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:22:03', '0000-00-00 00:00:00', '528'),
(1495, 1, 12, 'Lunch Box (FS 33-18)', 'https://drive.google.com/uc?export=download&id=11UB2YsrI0trB2quBe3uqkKjmHeHdIiXa', 295.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:43:54', '0000-00-00 00:00:00', '529'),
(1496, 1, 12, 'Lunch Box (FS 33-77)', 'https://drive.google.com/uc?export=download&id=1QVJt_MSo7-CMB6uZ3lXPrfiInCWsgLpY', 615.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:49:19', '0000-00-00 00:00:00', '530'),
(1497, 1, 17, 'Photo Frame ', 'https://drive.google.com/uc?export=download&id=1GFU2lENGaMscMwbNSlEOY29I8HLLIv-z', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:02', '0000-00-00 00:00:00', '531'),
(1498, 1, 17, 'Pen Holder (FS 7-9)', 'https://drive.google.com/uc?export=download&id=1FGQq9N_4vSPL5fl5PIj473vwkBY0JPrM', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:02', '0000-00-00 00:00:00', '532'),
(1499, 1, 17, 'Pen Holder (FS 7-4)', 'https://drive.google.com/uc?export=download&id=1Dvp2fHkfabptQZBrIMPHByW7QO_Ab1SS', 190.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:02', '0000-00-00 00:00:00', '533'),
(1500, 1, 17, 'Pen Holder (FS 7-12)', 'https://drive.google.com/uc?export=download&id=1DvXGe43G2_q7DgwwCgrrtAYzUiJ3UFCQ', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:03', '0000-00-00 00:00:00', '534'),
(1501, 1, 17, 'Pen Holder (FS 7-10)', 'https://drive.google.com/uc?export=download&id=1DuzNqyNC2f4Ig43BNrXdx5pw4APDyttT', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:03', '0000-00-00 00:00:00', '535'),
(1502, 1, 17, 'Pen Holder (FS 7-15)', 'https://drive.google.com/uc?export=download&id=1DpzqDhcY4lgOxA_n7BDgpThfGd8Y2640', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:03', '0000-00-00 00:00:00', '536'),
(1503, 1, 17, 'Pen Holder (FS 7-13)', 'https://drive.google.com/uc?export=download&id=1Do_mUuTq6zXvngJGQ-IfNqCeW_2vovPp', 215.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:03', '0000-00-00 00:00:00', '537'),
(1504, 1, 26, 'Sticky  Notes Liner', 'https://drive.google.com/uc?export=download&id=1tIMGAh1Ds83E2-cifIpHzyVND6XmHbA-', 122.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:02:22', '0000-00-00 00:00:00', '538'),
(1505, 1, 26, 'Sticky Notes Arrow (FS 2-8)', 'https://drive.google.com/uc?export=download&id=1YHYSwunY2h1rlQmAEoExcssVeDvknTAA', 75.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:04', '0000-00-00 00:00:00', '539'),
(1506, 1, 26, 'Sticky  Notes Transperant 75*75 ', 'https://drive.google.com/uc?export=download&id=1yg39LEFO8g6tfEGPmFsP8a5FsjDnxiiU', 170.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:06', '0000-00-00 00:00:00', '540'),
(1507, 1, 26, 'Picture Sticky  Notes 76*76 ', 'https://drive.google.com/uc?export=download&id=1-JyPJFhPDUhCJuPknFabYhyD4B6_OsBj', 77.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:06', '0000-00-00 00:00:00', '541'),
(1508, 1, 26, 'Sticky Notes Design (F S2-20)', 'https://drive.google.com/uc?export=download&id=1Rrde9Ko-mRL51prWyp0qlhDDNhkzDrZy', 115.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:06', '0000-00-00 00:00:00', '542'),
(1509, 1, 26, 'Sticky  Notes Multy Colour', 'https://drive.google.com/uc?export=download&id=1KTXdV8AyS1BVGT5y-u3LBx1exsQLRfdx', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:06', '0000-00-00 00:00:00', '543'),
(1510, 1, 26, 'Design Stickey Note			', 'https://drive.google.com/uc?export=download&id=1_qkgRlo2KTXgWvso5BaRGa1Ad-XYcJGx', 112.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:07', '0000-00-00 00:00:00', '544'),
(1511, 1, 26, 'Sticky  Notes Heart  ', 'https://drive.google.com/uc?export=download&id=1ZxCS4eMcIuy6SoZ9stdvTYLKcRctp8dH', 105.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:07', '0000-00-00 00:00:00', '545'),
(1512, 1, 26, 'Sticky  Note Card 12Pcs ', 'https://drive.google.com/uc?export=download&id=19A2_BgtPsp1l_1ohJ4cQEnWzxwOfuNUA', 704.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:07', '0000-00-00 00:00:00', '546'),
(1513, 1, 26, 'Stickey Smile 12Pcs', 'https://drive.google.com/uc?export=download&id=1sYVY_cZXxTqR6XKEm0TpgMgOz23bAaBU', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:08', '0000-00-00 00:00:00', '547'),
(1514, 1, 26, 'Sticky Note Book JX 010 (FS 2-30)', 'https://drive.google.com/uc?export=download&id=1h4vMmwyzlGDBRjnCxCgC58o6nzkVnLqK', 245.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:09', '0000-00-00 00:00:00', '548'),
(1515, 1, 26, 'Sticky Note Book JX 005 (FS 2-31)', 'https://drive.google.com/uc?export=download&id=1coIpF0E4PqB3yvseFgErKKZD4hczS-yD', 270.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '549'),
(1516, 1, 5, 'Stickey Note Book  JX 010 (FS2-30)', 'https://drive.google.com/uc?export=download&id=1VLZ3IAOXMV9BMQxgmJclzjujYfumKgpD', 244.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '550'),
(1517, 1, 5, 'Fancy Note Book (FS 2-38)', 'https://drive.google.com/uc?export=download&id=1ZjmgEBriP3GtRR6jGDuKA0q5OwOr8Y9V', 320.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:09', '0000-00-00 00:00:00', '551'),
(1518, 1, 1, 'Paper Quilling', 'https://drive.google.com/uc?export=download&id=1u81OXAC6DuH58vejK2JFNux6PubKPh_k', 230.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:59:11', '0000-00-00 00:00:00', '552'),
(1519, 1, 10, 'Embossed Painting Card with Platignum', 'https://drive.google.com/uc?export=download&id=1VmAELyVgP4lge_IejQLIlDgV1xFIlN_E', 135.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:26:43', '0000-00-00 00:00:00', '553'),
(1520, 1, 10, 'Water Colour painting Card', 'https://drive.google.com/uc?export=download&id=1jVc34svzl8wC_odyBKZYXO9g2MPCYWO1', 90.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:10', '0000-00-00 00:00:00', '554'),
(1521, 1, 5, 'Scrach Book', 'https://drive.google.com/uc?export=download&id=1ZLLbguEr_g9K1SpL46j5J7qb72MnRVQc', 135.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:24:36', '0000-00-00 00:00:00', 'KLSBS'),
(1522, 1, 10, 'Painting Card With Sand', 'https://drive.google.com/uc?export=download&id=1nFwX7Y8g7gFdG_sjqsSCcieRcW-BzFgu', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:26:19', '0000-00-00 00:00:00', 'KLPCS'),
(1523, 1, 10, 'Painting Card with WC Cup ', 'https://drive.google.com/uc?export=download&id=1qC1sqGiAuyu0IU2AQuh2aQktlT4Dq5vM', 100.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:54:15', '0000-00-00 00:00:00', '557'),
(1524, 1, 10, 'Painting Card With Platignum', 'https://drive.google.com/uc?export=download&id=1pgu0rstJ1AFSGoGLDsphxgWmL82vglFU', 75.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:11', '0000-00-00 00:00:00', '558'),
(1525, 1, 10, 'Kids Lerning Clock', 'https://drive.google.com/uc?export=download&id=1JQ2XX0MFUcT7kqQ-kOaU0srOoFxuBBcX', 140.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 16:30:37', '0000-00-00 00:00:00', '559'),
(1526, 1, 10, 'Wooden  Number Bag ', 'https://drive.google.com/uc?export=download&id=1EOzdtmLv3IIF7aS4SK7-scw-bTfAP0E5', 310.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:14', '0000-00-00 00:00:00', '560'),
(1528, 1, 29, 'Water Bottle (FS 33-32)', 'https://drive.google.com/uc?export=download&id=1CfBsfJkR5OR2Uzwkvq5ow_a_FyX6mDWB', 310.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '562'),
(1529, 1, 29, 'Water Bottle (FS 33-47)', 'https://drive.google.com/uc?export=download&id=1CN9pwIi4eRT4WjGtvuS39Oi1RsXTZH_L', 1123.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:06:12', '0000-00-00 00:00:00', '563'),
(1530, 1, 19, 'Plastic Pencil Box Shishang (FS 33-63)', 'https://drive.google.com/uc?export=download&id=1FZcxx1UzdhLhecvRSAyMYHiqKAwVY7Vn', 195.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:47:18', '0000-00-00 00:00:00', '564'),
(1531, 1, 19, 'Plastic Pencil Box', 'https://drive.google.com/uc?export=download&id=1qdRmqs25H5DKL4slDYBmXSJT3lYItXde', 310.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 13:25:18', '0000-00-00 00:00:00', '565'),
(1532, 1, 29, 'Water Bottle (FS 33-51)', 'https://drive.google.com/uc?export=download&id=1lgSTn4oorGsNudND8UskSCV87JCPnJ38', 730.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:04:57', '0000-00-00 00:00:00', '566'),
(1533, 1, 2, 'Painting Book 3+', 'https://drive.google.com/uc?export=download&id=1f9cnpZj_dBihZzWpRk1fY88xujXrf_aC', 205.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:47:08', '0000-00-00 00:00:00', '567'),
(1534, 1, 29, 'Water Bottle (FS 33-6)', 'https://drive.google.com/uc?export=download&id=1IOxvtfG_xYU2_nZx2SGERDPqb42BcGDS', 390.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:01', '0000-00-00 00:00:00', '568'),
(1535, 1, 29, 'Water Bottle (FS 33-12)', 'https://drive.google.com/uc?export=download&id=1HSmhIIg13nI-rIvR1QDVRXzPPTFLvMvN', 480.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '569'),
(1536, 1, 29, 'Water Bottle (FS 33-13)', 'https://drive.google.com/uc?export=download&id=1HnuYbVS7EFhA6CTWNY-YRREDcnuYHj1O', 640.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 05:29:12', '0000-00-00 00:00:00', '570'),
(1537, 1, 29, 'Water Bottle (FS 40-57)', 'https://drive.google.com/uc?export=download&id=1H3sjAgr0oSGkgbB6H7roYKMVWZc7ICng', 910.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:08:43', '0000-00-00 00:00:00', '571'),
(1538, 1, 22, 'Baby Scissors 508B', 'https://drive.google.com/uc?export=download&id=1NXgz4SwnmOdOI-ClV2mVMe12aXObcpyB', 108.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:18', '0000-00-00 00:00:00', '572'),
(1539, 1, 22, 'Scissors (FS 28-8)', 'https://drive.google.com/uc?export=download&id=10VqABrH76KEgwSIwB1x8WEL6gTgm0Sqm', 340.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:18', '0000-00-00 00:00:00', '573'),
(1540, 1, 22, 'Manicure Scissors AD 112(FS 28-7)', 'https://drive.google.com/uc?export=download&id=1JjyThmmT4o4wp2La5ZKVDTXkv-7BM3I_', 120.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '574'),
(1541, 1, 22, 'Scissors (FS 28-6)', 'https://drive.google.com/uc?export=download&id=1HzHmaflGS0tAozNA5lsROlixWvzFuxnk', 103.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:19', '0000-00-00 00:00:00', '575'),
(1542, 1, 22, 'Scissors  9mm			', 'https://drive.google.com/uc?export=download&id=1N3xgFD2-231kJKm6wNjPQ0Y2kMXefMWU', 245.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:20', '0000-00-00 00:00:00', '576'),
(1543, 1, 22, 'Scissors 175mm (FS 28-4)', 'https://drive.google.com/uc?export=download&id=19le6f8Wkb-fAFpilr-k93X1UwI5SxXKj', 220.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:20', '0000-00-00 00:00:00', '577'),
(1544, 1, 22, 'Scissors 215mm (FS 27-7)', 'https://drive.google.com/uc?export=download&id=1wMCr7ojwGnnNKY_B_OK0JUN5awfOEvPC', 307.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:20', '0000-00-00 00:00:00', '578'),
(1545, 1, 22, 'Smart Scissors ', 'https://drive.google.com/uc?export=download&id=19nDSaMPrdzP4UvRR22GkPUg5L3oIumJ5', 436.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '579'),
(1546, 1, 17, 'White Board Pen Holder penguin, bud, bear', 'https://drive.google.com/uc?export=download&id=1V1yLHYstW20rOEi0O0rpkTvO86BGoK9t', 285.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:22:20', '0000-00-00 00:00:00', '580'),
(1547, 1, 7, 'Design Eraser 6011 (FS 17-3)', 'https://drive.google.com/uc?export=download&id=13q45hxrWirCXjhjgrHPaWtEJs4C1tvyQ', 680.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:22', '0000-00-00 00:00:00', '581'),
(1548, 1, 18, 'Non Sharpening Pencil 4Pcs (FS 21-1)', 'https://drive.google.com/uc?export=download&id=1apJBpX7Z3lnM-_GkHFxG8IFWcgTwpz4v', 102.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '582'),
(1549, 1, 18, 'Brick Pencil Ovel Small (FS22-4)			', 'https://drive.google.com/uc?export=download&id=1Z58G6wRdla8uU0TQJrw2-YwMHARzNZpc', 123.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:17:21', '0000-00-00 00:00:00', '583'),
(1550, 1, 18, 'Brick Pencil Heart (FS 21-10)', 'https://drive.google.com/uc?export=download&id=14MCeVwZjOVnMGAqhykIL74jmrP6OX1cw', 205.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:42:10', '0000-00-00 00:00:00', '584'),
(1551, 1, 19, 'Brick Pencil Card QY 17 (FS 22-5)', 'https://drive.google.com/uc?export=download&id=19sEdr5KtS8o64PosmV6diFzwJvOllIMI', 250.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:40:43', '0000-00-00 00:00:00', '585'),
(1552, 1, 18, 'Brick 3 In 1 Pencil 178 (FS 21-8)', 'https://drive.google.com/uc?export=download&id=1SXdbVCRv-5ffvedtzS5dcFV9tQPRSyrN', 200.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:42:29', '0000-00-00 00:00:00', '586'),
(1553, 1, 21, 'Wooden Ruler', 'https://drive.google.com/uc?export=download&id=1h7OZdWqhHfhCsYVwgVTZcnoVikqJUcn0', 25.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:07:58', '0000-00-00 00:00:00', '587'),
(1554, 1, 7, 'White Board Eraser Bird', 'https://drive.google.com/uc?export=download&id=1Qzt3fwlY5VbC2JEgUu-UKDE6W9aY7luW', 81.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:01:45', '0000-00-00 00:00:00', '588'),
(1555, 1, 7, 'White Board Eraser 3D Smile (FS 13-5)', 'https://drive.google.com/uc?export=download&id=1uz4rGSy1K4l8JKH5ZL8hshFx0rx_c8nP', 100.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:08:58', '0000-00-00 00:00:00', '589'),
(1556, 1, 7, 'White Board Eraser Smile 1pcs (FS 13-1)', 'https://drive.google.com/uc?export=download&id=1E-6amuzgHtyswOpoX55XPfn6iPyQYWaR', 45.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:25', '0000-00-00 00:00:00', '590'),
(1558, 1, 8, 'Box Clip Board BJ8032 (FS 10-1)', 'https://drive.google.com/uc?export=download&id=1EHyi3A9w8rKf5uGP8bI4hsxVJu8Hm8wY', 896.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:25:16', '0000-00-00 00:00:00', '592'),
(1559, 1, 8, 'Campus File', 'https://drive.google.com/uc?export=download&id=1aOyG4JG3aItn4XxSubH0YjPm3YtjTBup', 375.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-09-13 06:53:52', '0000-00-00 00:00:00', '593'),
(1560, 1, 3, 'Plan Clear Bag WA1064 (FS 10-21)', 'https://drive.google.com/uc?export=download&id=1EG_odq7DKEX6dQs7VLid8lWTOdv-fFN2', 60.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:26', '0000-00-00 00:00:00', '594'),
(1561, 1, 3, 'Plan Clear Bag FC 803 (FS 10-18)', 'https://drive.google.com/uc?export=download&id=1EBHDxicsmTY-6G1S8jcNcOa6gRSJmfxr', 85.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:26', '0000-00-00 00:00:00', '595'),
(1562, 1, 8, 'Document File (FS 10-20)', 'https://drive.google.com/uc?export=download&id=1EAVBLXE4hIPK8j8A7p27tI87ao2CTWej', 270.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:26', '0000-00-00 00:00:00', '596'),
(1563, 1, 8, 'Campus File Normal (FS 10-5)', 'https://drive.google.com/uc?export=download&id=1E8B8413BTOdFDYFFdq_0pGHmENbW0CJc', 231.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:27', '0000-00-00 00:00:00', '597'),
(1564, 1, 3, 'Name Clear Bag F10066 (FS 10-17)', 'https://drive.google.com/uc?export=download&id=1E492MNGkxv_Lshx6naZr6fJY9oOdVLaj', 125.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:27', '0000-00-00 00:00:00', '598'),
(1565, 1, 3, 'Design Clear Bag B221F (FS 10-7)', 'https://drive.google.com/uc?export=download&id=1DzpmUNQKkjfmpekeeguHhp74ywNjqQU3', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:11:24', '0000-00-00 00:00:00', '599'),
(1566, 1, 8, 'Tick File (FS 10-19)', 'https://drive.google.com/uc?export=download&id=1DxgvzcBxpUbQ4NnEndZme4aoRPwuAzWV', 218.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:28', '0000-00-00 00:00:00', '600'),
(1567, 1, 10, 'Wooden Alphabat Bag  (FS7-17)', 'https://drive.google.com/uc?export=download&id=1D9cZJNrCf00c_N2fzySvRhRz6oBjQZCo', 500.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:28', '0000-00-00 00:00:00', '601'),
(1568, 1, 7, 'White Board Eraser LF 501 (FS13-4)', 'https://drive.google.com/uc?export=download&id=1BwdghmUSjaDa0Bcve5xOLQLybMJeWWiB', 100.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-06 03:25:51', '0000-00-00 00:00:00', '602'),
(1569, 1, 29, 'Water Bottle (FS 33-55)', 'https://drive.google.com/uc?export=download&id=1Cr9LH-t9ncx81SbYiS5gYBQf_SOigWW-', 1242.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:29', '0000-00-00 00:00:00', '603'),
(1570, 1, 29, 'Water Bottle (FS 33-49)', 'https://drive.google.com/uc?export=download&id=1H4PmRfswJqW35y0XUvxMTSq1uZiBr3cD', 1101.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:06:20', '0000-00-00 00:00:00', '604'),
(1571, 1, 29, 'Water Bottle (FS 33-60)', 'https://drive.google.com/uc?export=download&id=1nZVUTDpAyZSWJk6tlcc3lU16dHXB6Kuc', 244.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:36:21', '0000-00-00 00:00:00', '605'),
(1572, 1, 29, 'Water Bottle (FS 40-30)', 'https://drive.google.com/uc?export=download&id=1HXDT5WtfueOUL6fmIzsAxh4w-VsyfjWK', 695.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '606'),
(1573, 1, 29, 'Water Bottle (FS 40-33)', 'https://drive.google.com/uc?export=download&id=1L1OMzLd2KG71nMQpgP6GRNfELP02k_uf', 795.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:57:50', '0000-00-00 00:00:00', '607'),
(1574, 1, 29, 'Water Bottle (FS 40-56)', 'https://drive.google.com/uc?export=download&id=1He32ImeyXoshfUOion-dIKp9GoQlB8_E', 550.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:08:31', '0000-00-00 00:00:00', '608'),
(1575, 1, 29, 'Water Bottle (FS 40-28)', 'https://drive.google.com/uc?export=download&id=1HU8NPsj5FulpIAoD5qCvxSsoABeJ_U8U', 998.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:31', '0000-00-00 00:00:00', '609'),
(1576, 1, 29, 'Water Bottle (FS 40-29)', 'https://drive.google.com/uc?export=download&id=1INdeiykZnj8f581w52xKwn0myhTXzOon', 998.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:25', '0000-00-00 00:00:00', '610'),
(1577, 1, 29, 'Water Bottle (FS 33-10)', 'https://drive.google.com/uc?export=download&id=1HEZW9HVZmAmDDt6xKrr4KDDlrOYkP3d4', 896.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:50:56', '0000-00-00 00:00:00', '611'),
(1578, 1, 29, 'Water Bottle (FS 33-57)', 'https://drive.google.com/uc?export=download&id=1nZVUTDpAyZSWJk6tlcc3lU16dHXB6Kuc', 1024.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:59:13', '0000-00-00 00:00:00', '612'),
(1579, 1, 29, 'Water Bottle (FS 40-34)', 'https://drive.google.com/uc?export=download&id=1HhQCtZ-xVMyM7X7P1-XFyRxH6a1PiiaA', 832.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:30', '0000-00-00 00:00:00', '613'),
(1580, 1, 29, ' Water Bottle Plastic (FS 40-25) ', 'https://drive.google.com/uc?export=download&id=1nZVUTDpAyZSWJk6tlcc3lU16dHXB6Kuc', 1025.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:34:28', '0000-00-00 00:00:00', '614'),
(1581, 1, 29, 'Water Bottle (FS 33-33)', 'https://drive.google.com/uc?export=download&id=1It2FTlrCRLxW-TuJ0U6ir6Jfn3HKHt4f', 1382.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '615'),
(1582, 1, 10, 'Ice Stick Colour', 'https://drive.google.com/uc?export=download&id=1i_4EqEjMQoWufxQ7_eeZfDLqYK2RV8La', 110.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-27 13:39:36', '0000-00-00 00:00:00', '616'),
(1583, 1, 17, 'Pen Holder (FS 7-1)', 'InvalidURL', 186.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:51:34', '0000-00-00 00:00:00', '617'),
(1584, 1, 14, 'Design Paper Clip', 'https://drive.google.com/uc?export=download&id=1twmNEZF4noaaog-J-NL1EoM58p12OwlY', 167.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 13:03:00', '0000-00-00 00:00:00', '618'),
(1585, 1, 4, 'Red Rose Flower', 'InvalidURL', 269.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '619'),
(1586, 1, 4, 'Pink Rose Flower', 'InvalidURL', 186.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:17', '0000-00-00 00:00:00', '620'),
(1587, 1, 8, 'Clip Board Plastic  A4', 'https://drive.google.com/uc?export=download&id=1X9uyOShZyLlcIjK4frDxH_le9Cjd5LkI', 250.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-23 15:43:41', '0000-00-00 00:00:00', '621'),
(1588, 1, 3, 'Rainbow Mesh Bag', 'https://drive.google.com/uc?export=download&id=1iHHzzfdBWPy8getNSQq3B3QQ6hhZyMCp', 0.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:02:35', '0000-00-00 00:00:00', '622'),
(1589, 1, 8, 'Swing File 10 Pcs', 'https://drive.google.com/uc?export=download&id=1P_2-2tMrDZUge3yMzxUta4wi2tIF5PlI', 1080.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:16:36', '0000-00-00 00:00:00', '623'),
(1590, 1, 14, 'Smile Hook 9Pcs (FS33-1)', 'https://drive.google.com/uc?export=download&id=1Vy63M4pj9s9DMAk-YLthuFv43w6Ycehv', 295.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 12:56:22', '0000-00-00 00:00:00', '624'),
(1591, 1, 14, 'Smile Hook Small  9Pcs P28', 'https://drive.google.com/uc?export=download&id=1DhDO5v0jKAAN5Bpuflea5maxGDP8vB9_', 235.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 12:56:39', '0000-00-00 00:00:00', '625'),
(1594, 1, 29, 'Water Bottle (FS33-29) ', 'https://drive.google.com/uc?export=download&id=1HkYii5-db4sdeM6-b4Irmv_oTILqU18I', 308.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '628'),
(1595, 1, 29, 'Water Bottle (FS33-27) ', 'https://drive.google.com/uc?export=download&id=1HSmhIIg13nI-rIvR1QDVRXzPPTFLvMvN', 308.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '629'),
(1596, 1, 29, 'Water Bottle (FS33-43) ', 'https://drive.google.com/uc?export=download&id=1Hh3uPJSiyxMPYT4zVUWSN50Qg42BrSWe', 1383.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '630'),
(1598, 1, 29, 'Water Bottle (FS33-53) ', 'https://drive.google.com/uc?export=download&id=1IcC3Wb3thDfNvFjdUfeGWuRHibZXyFaq', 1178.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:16', '0000-00-00 00:00:00', '632'),
(1599, 1, 29, 'Water Bottle (FS33-34) ', 'https://drive.google.com/uc?export=download&id=1HfyrTeHFSxSfGKByzz1O7lvu4MsrtCPh', 1152.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '633'),
(1600, 1, 29, 'Water Bottle (FS33-59) ', 'https://drive.google.com/uc?export=download&id=1HKJTSivgN6nI5t6IS53RfSNqSyOde0zI', 768.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:09:14', '0000-00-00 00:00:00', '634'),
(1601, 1, 29, 'Water Bottle (FS 33-28)', 'InvalidURL', 308.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:03:49', '0000-00-00 00:00:00', '635'),
(1602, 1, 29, 'Water Bottle (FS 33-30)', 'https://drive.google.com/uc?export=download&id=1HAniDs70FuD3hlDf_vs6OO6-Yr899va6', 308.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '636'),
(1603, 1, 29, 'Water Bottle (FS 33-31)', 'InvalidURL', 308.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '637'),
(1604, 1, 29, 'Water Bottle (FS 33-35)', 'InvalidURL', 1357.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:04:01', '0000-00-00 00:00:00', '638'),
(1605, 1, 29, 'Water Bottle (FS 33-38)', 'InvalidURL', 315.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:04:16', '0000-00-00 00:00:00', '639'),
(1606, 1, 29, 'Water Bottle (FS 33-39)', 'InvalidURL', 1345.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:11', '0000-00-00 00:00:00', '640'),
(1607, 1, 29, 'Water Bottle (FS 33-40)', 'https://drive.google.com/uc?export=download&id=1n4y5spyEIAhLh21oCJXGZa5HagZ8kszA', 830.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '641'),
(1608, 1, 29, 'Water Bottle (FS 33-41)', 'https://drive.google.com/uc?export=download&id=1ZMA6rUw26NIMHCTgg7-G3rkdAPcKNpw1', 640.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:00:29', '0000-00-00 00:00:00', '642'),
(1609, 1, 29, 'Water Bottle (FS 33-42)', 'https://drive.google.com/uc?export=download&id=1H4TYTCSZg8WdX6CrFg-WtAlAHhjXT-eN', 794.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:04:32', '0000-00-00 00:00:00', '643'),
(1610, 1, 29, 'Water Bottle (FS 33-44)', 'InvalidURL', 1127.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:05:19', '0000-00-00 00:00:00', '644'),
(1611, 1, 29, 'Water Bottle (FS 33-45)', 'https://drive.google.com/uc?export=download&id=1jBJH4z056g7ANTO4deXo717a0VOV7d7F', 845.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:38:46', '0000-00-00 00:00:00', '645'),
(1613, 1, 29, 'Water Bottle (FS 33-48)', 'InvalidURL', 999.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:08', '0000-00-00 00:00:00', '647'),
(1614, 1, 29, 'Water Bottle (FS 33-50)', 'InvalidURL', 999.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:06:31', '0000-00-00 00:00:00', '648'),
(1615, 1, 29, 'Water Bottle (FS 33-52)', 'InvalidURL', 858.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:06:35', '0000-00-00 00:00:00', '649'),
(1616, 1, 29, 'Water Bottle (FS 33-56)', 'https://drive.google.com/uc?export=download&id=1I-fDiF4zyXTQQBEBMcNeEZRTLFfkB8Fl', 935.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:06:39', '0000-00-00 00:00:00', '650'),
(1617, 1, 29, 'Water Bottle (FS 33-58)', 'https://drive.google.com/uc?export=download&id=1HershyaSlFWwyD-KlIsox6_aki5xh5NG', 950.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:06:43', '0000-00-00 00:00:00', '651'),
(1618, 1, 29, 'Water Bottle (FS 40-39)', 'https://drive.google.com/uc?export=download&id=1UrANJ-vkweAoX1FlAUI_rJ4bZx3SDDFl', 1920.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:40', '0000-00-00 00:00:00', '652'),
(1619, 1, 29, 'Water Bottle (FS 40-53)', 'https://drive.google.com/uc?export=download&id=1UnRN_PRQH3tYg4mJ_91rotczFKNQ-29X', 1752.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:47:03', '0000-00-00 00:00:00', '653'),
(1620, 1, 29, 'Water Bottle (FS 40-8)', 'https://drive.google.com/uc?export=download&id=1set-dnwd-GHKMK0gOkU0kE6gl312mcSF', 1680.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:04:29', '0000-00-00 00:00:00', '654'),
(1621, 1, 29, 'Water Bottle (FS 40-9)', 'https://drive.google.com/uc?export=download&id=1dcCv_rJVC2hTEV-VY6qtGtSK937UUktu', 1860.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:04:07', '0000-00-00 00:00:00', '655'),
(1622, 1, 29, 'Water Bottle (FS 40-10)', 'https://drive.google.com/uc?export=download&id=1UTRIeMYyRetyLhSwXQqFWIYJVDh8GyQX', 1740.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '656'),
(1623, 1, 29, 'Water Bottle (FS 40-17)', 'https://drive.google.com/uc?export=download&id=1uCD2FjMWbHnqlO537JgTgqEAeRybrkfM', 1740.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:30:58', '0000-00-00 00:00:00', '657'),
(1625, 1, 29, 'Water Bottle (FS 40-40) 1000ml', 'https://drive.google.com/uc?export=download&id=1Ti7hrZeebhAAL7H3T0L8yHOdY0EIq_Kc', 2560.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '659'),
(1626, 1, 29, 'Water Bottle (FS 40-36) 800ml', 'https://drive.google.com/uc?export=download&id=18nsan8SHrb-XlU_q-j_CHCClZMGFLY-S', 2520.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:28:56', '0000-00-00 00:00:00', '660'),
(1627, 1, 29, 'Water Bottle (FS 40-5)', 'https://drive.google.com/uc?export=download&id=1UI1J1YoPDDq-UXNLjbo7XSbkfk-UCADr', 1560.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:46:59', '0000-00-00 00:00:00', '661'),
(1628, 1, 29, 'Water Bottle (FS 40-21)', 'https://drive.google.com/uc?export=download&id=1TFXQoJ6GdTDiHAdf8oHDOWqPVuGUEZc9', 1920.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:56:45', '0000-00-00 00:00:00', '662'),
(1629, 1, 29, 'Water Bottle (FS 40-41)', 'https://drive.google.com/uc?export=download&id=1Y5WlmjPcUQYWdkwSsQobcdGej4p3IFAI', 1680.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:29:43', '0000-00-00 00:00:00', '663'),
(1630, 1, 29, 'Water Bottle (FS 40-27)', 'https://drive.google.com/uc?export=download&id=1U9PkrN7nM1lbxCsFYwIe1viXIDjeciPe', 1260.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '664'),
(1631, 1, 29, 'Water Bottle (FS 40-51)', 'https://drive.google.com/uc?export=download&id=1FxCAdRji5RawFzOKAhL2E0Xjlxg8N7-c', 1740.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 08:01:27', '0000-00-00 00:00:00', '665'),
(1632, 1, 29, 'Water Bottle (FS 40-37)', 'https://drive.google.com/uc?export=download&id=1U23y8CRfta2NjkKBCF59LVIz5wQ07QN0', 2432.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:34', '0000-00-00 00:00:00', '666'),
(1633, 1, 29, 'Water Bottle (FS 40-15)', 'https://drive.google.com/uc?export=download&id=1DaJYwPaPJSk1TFA6RG-yLhfrwBgPICZr', 1860.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:30:34', '0000-00-00 00:00:00', '667'),
(1634, 1, 29, 'Water Bottle (FS 40-45)', 'https://drive.google.com/uc?export=download&id=1Tq1x0dtvktzkoWSVeJXaQT_rZALQQUi9', 1236.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:57', '0000-00-00 00:00:00', '668'),
(1635, 1, 29, 'Water Bottle (FS 40-43)', 'https://drive.google.com/uc?export=download&id=1TnYNfNfUFCQOhur57xYOnL7aY32CTidz', 1236.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:47', '0000-00-00 00:00:00', '669'),
(1636, 1, 29, 'Water Bottle (FS 40-16)', 'https://drive.google.com/uc?export=download&id=1TaN_30cXhJ_hJpuImJtdbKHexlnTLTap', 1116.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:18', '0000-00-00 00:00:00', '670'),
(1637, 1, 29, 'Water Bottle (FS 40-44)', 'https://drive.google.com/uc?export=download&id=1TWHScRkZB0sIP64x_Ugj6gtuahZgt0ag', 1116.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:07:52', '0000-00-00 00:00:00', '671'),
(1638, 1, 29, 'Water Bottle (FS 40-46)', 'https://drive.google.com/uc?export=download&id=1TW9blXiPwj0d3vCsU0J1oNsKmPCZ6fYz', 1152.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '672'),
(1639, 1, 29, 'Water Bottle (FS 40-50)', 'https://drive.google.com/uc?export=download&id=1TTu2Z2z9nlLEVrODfhjwopymdNWDWwY1', 1860.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:08:06', '0000-00-00 00:00:00', '673'),
(1640, 1, 29, 'Water Bottle (FS 40-1)', 'https://drive.google.com/uc?export=download&id=1TPeXgdzh_xr0JglT1yZV58yfdWB4gqcK', 1440.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '674'),
(1641, 1, 29, 'Water Bottle (FS 40-48)', 'https://drive.google.com/uc?export=download&id=1TMijOKB9-VcYaUoLPFgk5wdkco6q3v8z', 1152.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:08:01', '0000-00-00 00:00:00', '675'),
(1642, 1, 29, 'Water Bottle (FS 40-42)', 'https://drive.google.com/uc?export=download&id=1TKc3WM2rE3ill4TGbwJk7CHq5pLZ04fH', 1190.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '676'),
(1643, 1, 29, 'Water Bottle (FS 40-20)', 'https://drive.google.com/uc?export=download&id=1TKGZEehUCoYF18p0qyDMd_O66mfMCS5l', 2940.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '677'),
(1644, 1, 29, 'Water Bottle (FS 33-11)', 'https://drive.google.com/uc?export=download&id=1UW4E7Mn25tGJypheS94rW7OLJpzaDIKA', 800.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-28 06:50:59', '0000-00-00 00:00:00', '678'),
(1645, 1, 19, 'Magnet Box 6A31', 'https://drive.google.com/uc?export=download&id=1_QkgIHNTGFI5oAmlWyylYlqlqUvGUaqD', 470.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:39:38', '0000-00-00 00:00:00', '679'),
(1646, 1, 19, 'Magnet Box 6363', 'https://drive.google.com/uc?export=download&id=1Wye31mq0YSnSFiC0SXo7uBYBQCYn3udQ', 485.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:46:41', '0000-00-00 00:00:00', '680'),
(1647, 1, 19, 'Magnet Box 1230', 'https://drive.google.com/uc?export=download&id=1WxGRWe-uZxWgknpX2BhmQQPYEJQTWwiC', 225.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:46:42', '0000-00-00 00:00:00', '681'),
(1648, 1, 19, 'Magnet Box 8142', 'https://drive.google.com/uc?export=download&id=1WwJt-vB4xtbweiw0HqH-Scl3zUI08jdt', 400.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:46:42', '0000-00-00 00:00:00', '682'),
(1649, 1, 19, 'Magnet Box HB45', 'https://drive.google.com/uc?export=download&id=1WvsWZc0iI5gTvgZYzFuYiIvkE13rMmwp', 395.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-13 03:46:43', '0000-00-00 00:00:00', '683'),
(1650, 1, 19, 'Magnet Box 286', 'https://drive.google.com/uc?export=download&id=1irLYlVM4OFSlkTpSll17OT1IuGPHfhgk', 540.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:53:00', '0000-00-00 00:00:00', '684'),
(1651, 1, 12, 'Steel Lunch Box 3520', 'https://drive.google.com/uc?export=download&id=1VrYVHn9-yFliqq4N5FGhmKj_ybaAL6va', 1380.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:46:51', '0000-00-00 00:00:00', '685'),
(1652, 1, 1, 'Tip Top Instrumental Box', 'https://drive.google.com/uc?export=download&id=1p95uPRydFAmqVs-sjdrBpuC7oUgMnciP', 400.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:09:21', '0000-00-00 00:00:00', '686'),
(1653, 1, 10, 'Skipping Rope Small', 'https://drive.google.com/uc?export=download&id=12LiDemv-VdLjM6pEEi8DDHuKwlSYxwdH', 200.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:55:02', '0000-00-00 00:00:00', '687'),
(1654, 1, 3, 'Gift Bag 12pcs', 'https://drive.google.com/uc?export=download&id=1oj9RphzortyhhGBpNTKjXJ64DGAnhDnY', 2280.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', '0000-00-00 00:00:00', '688'),
(1655, 1, 10, 'Skipping Rope Sponge', 'https://drive.google.com/uc?export=download&id=1ZOqa9AW1TWK1tVBXH1jYVuHEFrHjU443', 225.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:55:15', '0000-00-00 00:00:00', '689'),
(1660, 1, 29, 'Vaccum Water Bottle 4019', NULL, 1855.00, NULL, NULL, NULL, 0, NULL, NULL, NULL, 'Available', '2025-08-07 08:48:41', NULL, NULL),
(1661, 1, 5, 'Book Covers', 'https://drive.google.com/uc?export=download&id=1z06w5GsHlbtdwwD6f9crRS-PX3MrKD8n', 0.00, NULL, NULL, NULL, 0, NULL, NULL, NULL, 'Available', '2025-09-23 15:38:23', NULL, 'BCC'),
(1663, 1, 11, 'Polythene Sealer 250mm ', NULL, 5250.00, NULL, NULL, NULL, 0, NULL, NULL, NULL, 'Available', '2025-08-07 08:46:45', NULL, 'PS250'),
(1664, 1, 11, 'Polythene Sealer 300mm ', NULL, 5500.00, NULL, NULL, NULL, 0, NULL, NULL, NULL, 'Available', '2025-08-07 08:46:58', NULL, 'PS300'),
(1665, 1, 16, 'King Copy Paper', 'https://drive.google.com/uc?export=download&id=1RqZaCxKPQobHZ57WQsYQmgUBMSpZHMyr', 1090.00, NULL, NULL, NULL, 0, NULL, NULL, NULL, 'Available', '2025-08-28 13:18:34', NULL, 'PCPA4KI'),
(1666, 1, 16, 'Eco Print A3 Copy Paper', 'https://drive.google.com/uc?export=download&id=1A6pxNSrV9KwVYl05yQfJIlcsgIYHJ22n', 2050.00, NULL, NULL, NULL, 0, NULL, '1', NULL, 'Available', '2025-08-28 13:17:24', NULL, 'PCPA3'),
(1703, 1, 29, 'Vacuum Water Bottle 4014  700ml ( FS40-14)			', 'https://drive.google.com/uc?export=download&id=1ekMVw2XFiugzCBdSS4PtTU3LMo29ms1p', 2432.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:35:25', NULL, 'WBV8823		'),
(1733, 1, 25, 'Room Decor WD ', 'https://drive.google.com/uc?export=download&id=1qJnKs_LHCzXqrX39ItBWb2ZUf8fHRzs3', 420.00, NULL, NULL, 1, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'STRDWD01');
INSERT INTO `Item_List` (`ItemID`, `CategoryID`, `SubCategoryID`, `Name`, `ProductPhoto`, `Price`, `Description`, `BrandName`, `QtyPerBox`, `NewArrival`, `BulkPrice`, `CartoonPcs`, `Bulk_Description`, `AvailabilityStatus`, `LastUpdated`, `created_at`, `SKU`) VALUES
(1749, 1, 27, 'Mounting Tape', 'https://drive.google.com/uc?export=download&id=1ZoMpgiyMUHqUV-g93D8eGOz5LcL3asw7', 85.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:03:21', NULL, 'CTM1|2		'),
(1753, 1, 27, 'Nano Tape	', 'https://drive.google.com/uc?export=download&id=1CDX91mDG2sRmZ3VB0XgXp2LrwG8CkjQn', 210.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:02:56', NULL, 'CTNA		'),
(1755, 1, 27, 'Mesharing Tape (FS26-14)			', 'https://drive.google.com/uc?export=download&id=1w-1UxP0XlWiFget-1VCkn9rDP_PFY06h', 31.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'RRMT		'),
(1756, 1, 22, 'Scissors 140mm (FS27-5)			', 'https://drive.google.com/uc?export=download&id=1P6FP2fuGSpMoqiFaXDPsYhH6moxrom1E', 225.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 13:01:28', NULL, 'SS140		'),
(1757, 1, 22, 'Scissors 190mm (FS27-6)			', 'https://drive.google.com/uc?export=download&id=1FJ48gxX-YXA7MIGKSGrta3fc60H5nwXk', 305.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 13:01:59', NULL, 'SS190		'),
(1758, 1, 22, 'Scissors 160mm (FS28-2)			', 'https://drive.google.com/uc?export=download&id=1dzwIMESrWseK91Oy5xF-p3wf-4NoidrX', 195.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-18 13:02:32', NULL, 'SS160		'),
(1759, 1, 22, 'Scissor Small	', 'https://drive.google.com/uc?export=download&id=1W9CJGtfrbw8CbIYmi9YYvF4dn06XWMbD', 72.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:04:29', NULL, 'SSCS12		'),
(1760, 1, 26, 'Stickey Note Book JX406  (FS2-32)			', '', 269.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', NULL, 'STNB406		'),
(1761, 1, 26, 'Stickey Note Book JX002 (FS2-33)			', '', 384.00, NULL, NULL, 0, 0, NULL, '', '', 'Not Available', '2025-08-09 08:29:49', NULL, 'STNB002		'),
(1762, 1, 26, '76x76 Stickey Note Luminer			', 'https://drive.google.com/uc?export=download&id=1e85rWDTi974KHLFMdHCe1Ad5Q2XWi40Y', 67.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-28 07:05:03', NULL, 'STN7676LC		'),
(1763, 1, 18, 'Design Pencil 6003 ( 48pcs )', 'https://drive.google.com/uc?export=download&id=1PlC04kWDtcg0h38q_T8L2dgcgdRbt7L9', 2280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'DP6003'),
(1764, 1, 7, 'DOMS Coloured Eraser Jar', 'https://drive.google.com/uc?export=download&id=1Qfht-LVutoMxJtZjvl0a0s7EzqB0b4pw', 1500.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 06:55:25', NULL, 'DCEJ'),
(1765, 1, 46, 'Highlighter 4 in 1', 'https://drive.google.com/uc?export=download&id=1zeZHJhIDcItedVCq_QfXL9Z6A4w6ByAW', 275.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'H4I1'),
(1766, 1, 46, 'Highlighter 6 in 1', 'https://drive.google.com/uc?export=download&id=1uRpAzesxQoA32BrwtYGvM4A9DLWllM55', 435.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 05:33:41', NULL, 'H6I1'),
(1767, 1, 46, 'Highlighter 5 in 1', 'https://drive.google.com/uc?export=download&id=1LVwcLDs5AX1uQuLlyOI0XU3prsa0C72q', 435.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-09-13 07:02:13', NULL, 'H5I1'),
(1768, 1, 18, 'Design Pencil 6015-2', 'https://drive.google.com/uc?export=download&id=1WfpwBPwXb7iRRVsXC3QppA7FaP3kVX0d', 2280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'DP60152'),
(1769, 1, 18, 'Design Pencil 510', 'https://drive.google.com/uc?export=download&id=1dTCzYPJoSFtraHbjYz5pU9nx7rxN-JZo', 2280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'DP510'),
(1770, 1, 18, 'Design Pencil 2234', 'https://drive.google.com/uc?export=download&id=14hoonSqIY692xS6oc4ehsuY2QAri9-X6', 2280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'DP2234'),
(1771, 1, 18, 'Design Pencil 6001-3', 'https://drive.google.com/uc?export=download&id=1P3PogcrxpjKgqlp_xYDYp8J_sWxWzw3D', 2280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'DP60013'),
(1772, 1, 18, 'Design Pencil 506', 'https://drive.google.com/uc?export=download&id=1rb7nbIeAfTcE8B4NTrZLW5kLEPPVEpPa', 2280.00, NULL, NULL, 0, 0, NULL, '', '', 'Available', '2025-08-09 08:29:49', NULL, 'DP506'),
(1773, 1, 18, 'Design Pencil 7001', 'https://drive.google.com/thumbnail?id=1ttvbtG_YspPhnKqRJvOeNVsrpNjoxNOM', 2280.00, NULL, NULL, 0, 1, NULL, '', '', 'Available', '2025-08-09 11:20:29', NULL, 'DP7001'),
(1774, 1, 2, 'Erasable Colour Pencil 12Pcs', 'https://drive.google.com/uc?export=download&id=1DgpVqtqFN7lBbCbM92vPbqV24GL3ISee', 490.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 06:57:59', NULL, 'APPECP12'),
(1777, 1, 1, 'Math Set 4 pcs', 'https://drive.google.com/uc?export=download&id=14K3zHJJOl9yXmZgHqFOQggI8tSXQjXL9', 110.00, '4', NULL, NULL, 0, NULL, NULL, NULL, 'Available', '2025-09-13 07:39:30', NULL, 'AMS4'),
(1778, 1, 9, 'Ready Binder Gum 500ml', 'https://drive.google.com/uc?export=download&id=1OscGtLgvpd9B0h5GfKIY08EvHFIIzkqr', 138.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-12 19:40:05', NULL, 'GLBG500'),
(1779, 1, 9, 'Redy Fix Binder Glue', 'https://drive.google.com/uc?export=download&id=17MtjI2NjnSFQqLuZV-6WulrymdbTpRqj', 0.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 06:16:39', NULL, 'BGRF'),
(1780, 1, 6, 'Slime - 330', 'https://drive.google.com/uc?export=download&id=11R6JAUg9G92tRZwVmgvz5C8KVREwkYEx', 190.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-13 14:59:42', NULL, 'CLSL330'),
(1781, 1, 6, 'Slime - 328', 'https://drive.google.com/uc?export=download&id=18cK6JpXipHjgpWTMN2i2mCMgnHlfTuVD', 140.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:11:21', NULL, 'CLSL328'),
(1782, 1, 6, 'Slime - 329', 'https://drive.google.com/uc?export=download&id=1x7cf7-rEQvhSwnN8SCrsVq2jfjh0yQAD', 190.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-13 14:59:47', NULL, 'CLSL329'),
(1783, 1, 6, 'Slime - 327', 'https://drive.google.com/uc?export=download&id=1az-ru7AeGsz57-YducT9XiOZRHZgZQBK', 100.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-13 14:59:49', NULL, 'CLSL327'),
(1784, 1, 6, 'Slime - 326', 'https://drive.google.com/uc?export=download&id=1zD8iK9kZN5VVDCFFU1dg7y-RoqdR3ZPv', 190.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-13 14:59:52', NULL, 'CLSL326'),
(1785, 1, 6, 'Slime - 332', 'https://drive.google.com/uc?export=download&id=1ONCQwyxbubFJnJ284eurxlV412MjgsWA', 190.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-13 14:59:54', NULL, 'CLSL332'),
(1786, 1, 6, 'Slime - 331', 'https://drive.google.com/uc?export=download&id=1a576JHoqU3p0faWo44AhJy5liRfO6fb5', 190.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:11:35', NULL, 'CLSL331'),
(1787, 1, 14, 'Puncher DL8250', 'https://drive.google.com/uc?export=download&id=1BQQ8sHkPds4kxI0T1u51Lbyyle4z1eQ4', 590.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-08-13 02:41:06', NULL, 'OSPU8250'),
(1788, 1, 25, 'Punch Wall Sticker Large', 'https://drive.google.com/uc?export=download&id=1j3kWhVBEqrPGPTIGQXU5Rgy9KE0nzddj', 185.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-08-24 04:59:56', NULL, 'STPWL'),
(1789, 1, 25, 'Punch Wall Sticker Small', 'https://drive.google.com/uc?export=download&id=1G5Sd49Mzz2FKGWmRqQ8TwGGIVM1Av1IR', 60.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-09-13 08:17:46', NULL, 'STPWS'),
(1790, 1, 2, 'Acrylic Platignum', 'https://drive.google.com/uc?export=download&id=1xVTD0vCVp2xfhw6T4JganlPD1m-3wjak', 468.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-09-25 13:04:21', NULL, 'PPPLAC'),
(1791, 1, 14, 'Smile Hook 3 Pcs 9806', 'https://drive.google.com/uc?export=download&id=1_AR7fgpwcosPyPbPQnQrBu9wsnEXg2nz', 147.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-08-18 12:58:08', NULL, 'OSCPSH333'),
(1792, 1, 14, 'Smile Hook 2 Pcs 9807', 'https://drive.google.com/uc?export=download&id=1fC8u8HsXSMN0B_ptSVH4LJQvz37HJOVv', 167.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-18 12:59:10', NULL, 'OSCPSH334'),
(1793, 1, 24, 'Double Sharpner 8103', 'https://drive.google.com/uc?export=download&id=13NtlQyDYGtNhrzqnrSjXKNYT-3J8-GxR', 70.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 06:21:14', NULL, 'SHD8103'),
(1794, 1, 19, 'Pencil Purse Unicorn', 'https://drive.google.com/uc?export=download&id=1YVcnXR3qw2oPT6iNSzDSA0-OjEzW8Vgy', 30.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-20 10:20:15', NULL, 'PPU'),
(1795, 1, 20, 'Liner Color Pen 6 Pcs', 'https://drive.google.com/uc?export=download&id=1HIE4qXRwYBvfnuj6_df8Ot3c3ud4Y_d6', 435.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-27 09:59:30', NULL, 'PENCL'),
(1796, 1, 2, 'Painting Card 8 Pcs', 'https://drive.google.com/uc?export=download&id=1qC1sqGiAuyu0IU2AQuh2aQktlT4Dq5vM', 410.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:49:55', NULL, 'KLPCWC8'),
(1797, 1, 19, 'Pencil Purse 6655', 'https://drive.google.com/uc?export=download&id=1Ydgg-f_J3ooxFZ5oDR4QxsNIQa8DL1Go', 660.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 06:06:17', NULL, 'PP6655'),
(1798, 1, 10, 'Stationery Set 6010', 'https://drive.google.com/uc?export=download&id=16xb5U7iCnH6fgFDVI4to_CD_TlnG1V2V', 285.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 05:43:03', NULL, 'GISS6010'),
(1800, 1, 14, 'White Board Eraser Printed', 'https://drive.google.com/uc?export=download&id=1ZVHzYbJSvqHkjBEcNdFEadcuxWuis-Rj', 107.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-09-06 03:26:54', NULL, 'OSOAWBE4'),
(1801, 1, 14, 'White Board Eraser Heart', 'https://drive.google.com/uc?export=download&id=1d--18Ap9ldpt7FFDfcYdBHWiEtaaglyf', 96.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-09-06 03:24:10', NULL, 'OSOAWBE7'),
(1802, 1, 14, 'Rubber Band 1Kg', 'https://drive.google.com/uc?export=download&id=1W_jbKHPv244fzUhIa42gYPz0ehy8avpo', 1265.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-08-28 06:58:52', NULL, 'RB'),
(1803, 1, 6, 'Slime - 335', 'https://drive.google.com/uc?export=download&id=1rmkvI6I_zsuaVMpjh1Tm7IFAb9xQ7O5f', 315.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-28 07:01:54', NULL, 'S335'),
(1804, 1, 6, 'Slime 333 12 Pcs', 'https://drive.google.com/uc?export=download&id=1y7Pc0qOd2wgQo-jwO3aJVau7p_3VMIg_', 440.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-28 07:02:56', NULL, 'S33312'),
(1805, 1, 1, 'Round Stamp 10 Pcs', 'https://drive.google.com/uc?export=download&id=10L3UCbpEFPNwcXdrxic2Ql36bdZC7UAC', 300.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:05:38', NULL, 'RS10'),
(1806, 1, 16, 'Lake House Copy Paper A4 80gsm', 'https://drive.google.com/uc?export=download&id=17QlYNGAhyUp7wth4AcS39sZYwuSUWB1i', 1250.00, '', '', 0, 0, 0.00, '', '', 'Available', '2025-08-28 13:07:24', NULL, 'LHCPA480'),
(1807, 1, 16, 'Falcon Copy Paper 80gsm', 'https://drive.google.com/uc?export=download&id=1WFTku0meQ2hbCi_2sSgKSmrBBlLwyscC', 950.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:26:11', NULL, 'PCPA4FA80'),
(1808, 1, 27, 'Form Tape - 1 Inch', 'https://drive.google.com/uc?export=download&id=1vOigPfhrcsQW8QCOSRwY5uM53XEp6xyK', 82.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-08-28 14:13:53', NULL, 'CTF'),
(1809, 1, 27, 'Cello Tape', 'https://drive.google.com/uc?export=download&id=1SvFsS2PLkKQUxfG5eWqCRBbH0M6k44JS', 33.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:28:14', NULL, 'CT'),
(1810, 1, 10, 'Bubble Large 24 Pcs ', 'https://drive.google.com/uc?export=download&id=19tmq2Ayb1XWMPqFPfpT5Qn9UZVfcUP0M', 1795.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:23:34', NULL, 'TOBUBL'),
(1811, 1, 19, 'Pencil Purse 52', 'https://drive.google.com/uc?export=download&id=1DXzWBTqH-qu8D9tH_EAlweI3oMgBdDVy', 310.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:25:00', NULL, 'PP52'),
(1812, 1, 2, 'WC Artist Palette Large ', 'https://drive.google.com/uc?export=download&id=1jn4W_TnA_R7jfZ-QdNgvtw4YOdqrz_ef', 156.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:25:53', NULL, 'APWCAPL'),
(1813, 1, 15, 'Marshal Instrument Box ', '', 230.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:27:17', NULL, 'AIBM'),
(1814, 1, 6, 'Slime Glitter Sachet ', 'https://drive.google.com/uc?export=download&id=1FuYkImaPNhe0ECOmx2S2AKx9GzFwYxPa', 70.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:29:26', NULL, 'CLSLGS'),
(1815, 1, 6, 'Slime Sachet 6 Pcs', 'https://drive.google.com/uc?export=download&id=1AsdLDBO_kuYg-8uvwMJ-Z0TN_XPLMETH', 100.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:30:00', NULL, 'CLSLSA'),
(1816, 1, 6, 'Slime Mini', 'https://drive.google.com/uc?export=download&id=1K3ivi1-mdQmFSjEHjFeh3BCfdTUwjQ33', 48.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:30:46', NULL, 'CLSLM'),
(1817, 1, 7, 'Design Eraser Drum 36Pcs ', 'https://drive.google.com/uc?export=download&id=1iorZ_eX791mljqUeseTzHStbuV88F7di', 425.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:31:36', NULL, 'ERBD36'),
(1818, 1, 6, 'Slime Panda ', 'https://drive.google.com/uc?export=download&id=1sQEL2JdN9a-dtkR2EX3YBFpnKAmfdU9e', 82.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:32:36', NULL, 'CLSLPA'),
(1819, 1, 15, 'Air Fershner Ovel  ', 'https://drive.google.com/uc?export=download&id=1eltdjazoAmFYwhF_YQDx8xcO-_zWCzim', 300.00, '', '', 0, 1, 0.00, '', '', 'Not Available', '2025-09-23 15:19:40', NULL, 'AFOB'),
(1820, 1, 15, 'Air Fershner Desk Lamp ', 'https://drive.google.com/uc?export=download&id=1sOhe4G5KB2vu3luZuQ94GFpdoMc-bjpA', 345.00, '', '', 0, 1, 0.00, '', '', 'Not Available', '2025-09-23 15:19:39', NULL, 'AFDL'),
(1821, 1, 15, 'Air Freshener Flower Top 16510  ', 'https://drive.google.com/uc?export=download&id=12P11gAhvBU5MjC4ZxpK0K3IupisvDX58', 345.00, '', '', 0, 1, 0.00, '', '', 'Not Available', '2025-09-23 15:19:38', NULL, 'AFFC'),
(1822, 1, 15, 'Air Fershner Bird Cage 7021 ', 'https://drive.google.com/uc?export=download&id=1Dhc7aJRfiyoo-cGk8YdYd-dLLkgjxq-o', 300.00, '', '', 0, 1, 0.00, '', '', 'Not Available', '2025-09-23 15:19:37', NULL, 'AFBC'),
(1823, 1, 14, 'File Lase', 'https://drive.google.com/uc?export=download&id=1NlTGzb9WpG-blPLxDgYbFb7dVtJ5IGDw', 323.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 07:50:47', NULL, 'FFL'),
(1824, 1, 4, 'Birthday Balloon 72Pcs ', 'https://drive.google.com/uc?export=download&id=1DedKKZ70sx6Bfn_50cqiIP1471uJiGbp', 1345.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 08:05:47', NULL, 'BPBP2'),
(1825, 1, 18, 'Brick Pencil Round', 'https://drive.google.com/uc?export=download&id=1OKIgBdqY6IeLu6CFq2zzLaRnWen_QryB', 164.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-13 08:15:36', NULL, 'BPR'),
(1826, 1, 2, 'Fabric Paint Single Color 15ml 6pcs', '', 520.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:22:48', NULL, 'fpsc15ml6c'),
(1827, 1, 16, 'Laser Plus Copy Paper 80gsm', '', 1000.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:24:42', NULL, 'fcplp'),
(1828, 1, 16, 'Bristal Board', '', 26.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:52:41', NULL, 'bb'),
(1829, 1, 16, 'Poster Paper', '', 15.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:53:04', NULL, 'pp'),
(1830, 1, 16, 'Varnish paper', '', 13.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:53:45', NULL, 'vp'),
(1831, 1, 29, 'Steel Water Bottle 1L', '', 700.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:55:59', NULL, 'swb1l'),
(1832, 1, 16, 'Paper File Cover 100 Sheets', '', 1195.00, '', '', 0, 1, 0.00, '', '', 'Available', '2025-09-23 16:58:23', NULL, 'pfc100');

-- --------------------------------------------------------

--
-- Table structure for table `MainCategory`
--

CREATE TABLE `MainCategory` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(100) NOT NULL,
  `Description` text,
  `IconPath` varchar(255) DEFAULT NULL,
  `AvailabilityStatus` enum('Available','Not Available') DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `MainCategory`
--

INSERT INTO `MainCategory` (`CategoryID`, `CategoryName`, `Description`, `IconPath`, `AvailabilityStatus`) VALUES
(1, 'Stationary', '', '', 'Available'),
(2, 'Cosmetics', '', '', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `OrderItems`
--

CREATE TABLE `OrderItems` (
  `OrderItemID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `VariantID` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `OrderItems`
--

INSERT INTO `OrderItems` (`OrderItemID`, `OrderID`, `ItemID`, `VariantID`, `Name`, `Price`, `Quantity`) VALUES
(48, 22, 1808, 142, '', 82.00, 2),
(49, 22, 1808, 143, '', 82.00, 3),
(50, 23, 1808, 142, '', 82.00, 2),
(51, 23, 1808, 143, '', 82.00, 3),
(52, 24, 1226, NULL, '', 325.00, 1),
(53, 24, 1807, NULL, '', 1000.00, 20),
(54, 24, 1790, 105, '', 468.00, 1),
(55, 24, 1790, 106, '', 828.00, 2),
(56, 25, 1226, NULL, '', 325.00, 55);

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `OrderID` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `OrderDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TotalAmount` decimal(10,2) NOT NULL,
  `Status` enum('Pending','Processing','Canceled','Completed') NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`OrderID`, `user_id`, `OrderDate`, `TotalAmount`, `Status`) VALUES
(22, 2, '2025-09-10 12:05:29', 410.00, 'Pending'),
(23, 2, '2025-09-10 12:07:01', 410.00, 'Pending'),
(24, 2, '2025-09-10 12:22:10', 22449.00, 'Pending'),
(25, 23, '2025-09-22 04:52:39', 17875.00, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `Product_Images`
--

CREATE TABLE `Product_Images` (
  `ImageID` int(11) NOT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `VariantID` int(11) DEFAULT NULL,
  `ImageUrl` varchar(255) NOT NULL,
  `IsMain` tinyint(1) DEFAULT '0',
  `SortOrder` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Product_Variants`
--

CREATE TABLE `Product_Variants` (
  `VariantID` int(11) NOT NULL,
  `ItemID` int(11) NOT NULL,
  `ProductPhoto` varchar(255) DEFAULT NULL,
  `SKU` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Description` text,
  `BulkPrice` decimal(10,2) DEFAULT NULL,
  `Bulk_Description` text,
  `AvailabilityStatus` enum('Available','Not Available') NOT NULL DEFAULT 'Available',
  `VariantName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Product_Variants`
--

INSERT INTO `Product_Variants` (`VariantID`, `ItemID`, `ProductPhoto`, `SKU`, `Price`, `Description`, `BulkPrice`, `Bulk_Description`, `AvailabilityStatus`, `VariantName`) VALUES
(9, 1559, NULL, 'FS10-13', 410.00, NULL, NULL, NULL, 'Available', 'A4 801A (FS10-13)'),
(10, 1559, NULL, 'FS10-14', 487.00, NULL, NULL, NULL, 'Available', 'A4 802F (FS10-14)'),
(11, 967, NULL, '3 1/2 * 6', 1.20, 'Small Size', NULL, NULL, 'Available', '3 1/2*6'),
(30, 1003, 'https://drive.google.com/uc?export=download&id=1prl6WBD8Z5yyrnxffy0cH8LJ-epSStsP', NULL, 268.00, NULL, 268.00, NULL, 'Available', 'Ruller 15CM 12pcs'),
(32, 1553, 'https://drive.google.com/uc?export=download&id=10OcCVPHXW5IYmHQiC12bWqytb1s1uH01', 'WR30', 38.00, NULL, NULL, NULL, 'Available', '30 CM'),
(36, 1130, 'https://drive.google.com/uc?export=download&id=1btsBz3QIVhrtRRLWHNP9u4A3M7SjO4GX', NULL, 74.00, NULL, NULL, NULL, 'Available', 'Steel Rullers 30cm'),
(37, 1130, 'https://drive.google.com/uc?export=download&id=12zte0LiR2Fhns7wqRod8TvWbbC4ams2J', NULL, 47.00, NULL, NULL, NULL, 'Available', 'Steel Rullers 20cm'),
(38, 1733, 'https://drive.google.com/uc?export=download&id=1FGbqjMzOJooYWB6JxbRvn6PDdbDfw513', 'STRDWD02', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 02'),
(39, 1733, 'https://drive.google.com/uc?export=download&id=1li_w8n2UEPMh-2yso-wXhj2qXmVGfI0-', 'STRDWD01', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 01'),
(40, 1733, NULL, 'STRDWD03', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 03'),
(41, 1733, 'https://drive.google.com/uc?export=download&id=1gxHsX4DTPg7jQFFvsDa3ZjL-LKZ2Aocv', 'STRDWD04', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 04'),
(42, 1733, 'https://drive.google.com/uc?export=download&id=1IxEFYhuHu9-0eywij9UZfNlYxJ5VutGz', 'STRDWD05', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 05'),
(43, 1733, 'https://drive.google.com/uc?export=download&id=1EJcWXHxq-QkmEdLeqdk6I_diSKgqUJig', 'STRDWD06', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 06'),
(44, 1733, 'https://drive.google.com/uc?export=download&id=1qRWHOzOkvNiQiIiwyR5q_T5OMHxAdd-q', 'STRDWD07', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 07'),
(45, 1733, 'https://drive.google.com/uc?export=download&id=1rLi_u_kwBSql2MUU40sRquEjYHUA97G3', 'STRDWD08', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 08'),
(46, 1733, 'https://drive.google.com/uc?export=download&id=1qJnKs_LHCzXqrX39ItBWb2ZUf8fHRzs3', 'STRDWD09', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 09'),
(47, 1733, 'https://drive.google.com/uc?export=download&id=13227jCL9ZGxn4EQVYXCX8fP0qdxdwa9c', 'STRDWD10', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 10'),
(48, 1733, 'https://drive.google.com/uc?export=download&id=1GN15jcgC974AgzEgArmU2cYJJ-mPHWVr', 'STRDWD11', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 11'),
(49, 1733, 'https://drive.google.com/uc?export=download&id=1Z2Vc1vSDsUF9B_7CVichFjjWOYfL0fAd', 'STRDWD12', 420.00, NULL, NULL, NULL, 'Available', 'Room Decor WD 12'),
(51, 1378, 'https://drive.google.com/uc?export=download&id=1o7jzTqG1pOEGZ4ISs66qfVXpUf-yPK8V', 'CTBTB2520B', 140.00, NULL, NULL, NULL, 'Available', '25mm * 20mt BLUE'),
(52, 1378, 'https://drive.google.com/uc?export=download&id=1E7rBC-PfPnSyfgZEwMou33vIVevBXAHE', 'CTBTB2520BL', 140.00, NULL, NULL, NULL, 'Available', '25mm * 20mt BLACK'),
(53, 1378, 'https://drive.google.com/uc?export=download&id=14UjNwtPhhRCFslg5Ow7FNNDTyvtv3FGj', 'CTBTGR2520', 140.00, NULL, NULL, NULL, 'Available', '25mm * 20mt GREEN'),
(60, 1379, 'https://drive.google.com/uc?export=download&id=1hqDEC49Fbc_PHtzMPTn1Dmh4uP5ikF1j', 'CTET1230		', 200.00, NULL, NULL, NULL, 'Available', '1/2mm x 30 mt			'),
(61, 1382, 'https://drive.google.com/uc?export=download&id=1pBV52E6CGe5LgotTZt2QiqloogheVkM9', 'CTT48100		', 188.00, NULL, NULL, NULL, 'Available', '48mm * 100mt			'),
(62, 1382, 'https://drive.google.com/uc?export=download&id=1G11IS4aflgc8kKMimkT81auGL9PUPbpK', 'CTT4850', 125.00, NULL, NULL, NULL, 'Available', '48mm * 25mt			'),
(63, 1382, 'https://drive.google.com/uc?export=download&id=1Y8hczywDPoCBS30r8AsgALZKj8-v6KS9', 'CTT4825	', 64.00, NULL, NULL, NULL, 'Available', '48mm * 25mt			'),
(72, 1749, NULL, 'CTM1/23		', 253.00, NULL, NULL, NULL, 'Available', 'Mounting Tape 1/2&#039; 3Pcs			'),
(73, 1753, 'https://drive.google.com/uc?export=download&id=1ca3Enn0OowGnoGXW85MJ7yHwNFJFsTqm', 'CTNA25101		', 448.00, NULL, NULL, NULL, 'Available', '25*3M			'),
(74, 967, NULL, 'EM9*4', 2.75, NULL, NULL, NULL, 'Available', ' 9*4'),
(75, 1209, 'https://drive.google.com/uc?export=download&id=1Nm_2D9_FOZrZs7mX02NJSz1tmTFb0BmC', 'P6PCS', 82.00, NULL, NULL, NULL, 'Available', 'Pastal Pentium 6 pcs'),
(76, 1209, 'https://drive.google.com/uc?export=download&id=19NMwK99Myi-cs9ViE2_y0oKXmDzBlPN4', 'P10PCS', 168.00, NULL, NULL, NULL, 'Available', 'Pastal Pentium 13pcs'),
(77, 1209, NULL, 'P24PCS', 298.00, NULL, NULL, NULL, 'Available', 'Pastal Pentium 24pcs'),
(78, 1209, NULL, 'P36PCS', 472.00, NULL, NULL, NULL, 'Available', 'Pastal Pentium 36 Colours'),
(79, 1334, NULL, 'PF10', 220.00, NULL, NULL, NULL, 'Available', 'Pocket File 10'),
(80, 1334, NULL, 'PF20', 255.00, NULL, NULL, NULL, 'Available', 'Pocket File 20'),
(81, 1334, NULL, 'PF30', 325.00, NULL, NULL, NULL, 'Available', 'Pocket File 30'),
(82, 1334, NULL, 'PF40', 425.00, NULL, NULL, NULL, 'Available', 'Pocket File 40'),
(83, 1334, NULL, 'PF60', 495.00, NULL, NULL, NULL, 'Available', 'Pocket File 60'),
(84, 1334, NULL, 'PF80', 680.00, NULL, NULL, NULL, 'Available', 'Pocket File 80'),
(85, 1334, NULL, 'PF100', 770.00, NULL, NULL, NULL, 'Available', 'Pocket File 100'),
(86, 1661, 'https://drive.google.com/uc?export=download&id=10ppEtBYNtzp2HQ7kjM7pHBLPHzmcxHuT', 'BCC', 300.00, NULL, NULL, NULL, 'Available', 'Book Cover CR'),
(87, 1661, 'https://drive.google.com/uc?export=download&id=16S5eCtuvgNCTlVV9i7LVBSZy9zPEzL-g', 'BCB5', 250.00, NULL, NULL, NULL, 'Available', 'Book Cover B5'),
(88, 1661, 'https://drive.google.com/uc?export=download&id=1m5ULDx5c9QKmCea9koQFBVcabnHKvqFX', 'BCEX', 160.00, NULL, NULL, NULL, 'Available', 'Book Cover EX'),
(89, 1779, 'https://drive.google.com/uc?export=download&id=1NNUhBC5a5SGTKeCKyds5hc0AX6OWb9_j', 'BGRF250', 230.00, NULL, NULL, NULL, 'Available', 'Redy Fix Binder Glue 250g'),
(90, 1779, 'https://drive.google.com/uc?export=download&id=1-DsPUyZJLpTsURpMrKqyYc55QIStktsf', 'BGRF100', 105.00, NULL, NULL, NULL, 'Available', 'Redy Fix Binder Glue 100g'),
(91, 1779, 'https://drive.google.com/uc?export=download&id=11knQHsZd4jpTrypYwcLyvgk7ctabwXFC', 'BGRF500', 330.00, NULL, NULL, NULL, 'Available', 'Redy Fix Binder Glue 500g'),
(92, 1125, 'https://drive.google.com/uc?export=download&id=1SRZIm1Y2Y0Bc2wmgqhbnaouabuwxuWm7', 'GLCG500', 138.00, NULL, NULL, NULL, 'Available', 'Ready Clear Glue 500ml'),
(93, 1125, 'https://drive.google.com/uc?export=download&id=1EfZq0JZrm7BeT_mxGZ0jhRQFRSNNuVGX', 'GLCG200', 84.00, NULL, NULL, NULL, 'Available', 'Ready Clear Glue 200ml'),
(94, 1125, 'https://drive.google.com/uc?export=download&id=17hlExnwAHuIjexYf7aX4XHW1A8ZSS6FU', 'GLCG60', 50.00, NULL, NULL, NULL, 'Available', 'Ready Clear Glue 60ml'),
(95, 1788, 'https://drive.google.com/uc?export=download&id=1L83nHm9Na3198yuzbpVqWs-gdIpQuhrV', 'STPWLDO', 185.00, NULL, NULL, NULL, 'Available', 'Dog'),
(96, 1788, 'https://drive.google.com/uc?export=download&id=1s-CyC7ltZ4ju8uojKuUjrEy9QsK0b8Vw', 'STPWLF', 185.00, NULL, NULL, NULL, 'Available', 'Frog'),
(97, 1788, 'https://drive.google.com/uc?export=download&id=12_G4Lq6Juzc8CJhMVwBLgZBZ3In6LdMm', 'STPWLK', 185.00, NULL, NULL, NULL, 'Available', 'Kitty'),
(98, 1788, 'https://drive.google.com/uc?export=download&id=1j3kWhVBEqrPGPTIGQXU5Rgy9KE0nzddj', 'STPWLMI', 185.00, NULL, NULL, NULL, 'Available', 'Mickey'),
(99, 1788, 'https://drive.google.com/uc?export=download&id=1Bl8iUN6vRgPUxJ1pp7YttegtA522o9PT', 'STPWLPH', 185.00, NULL, NULL, NULL, 'Available', 'Poo'),
(100, 1788, 'https://drive.google.com/uc?export=download&id=1hYPXBwrD1seO5AimUxsuyzaLB7e4PH23', 'STPWLPR', 185.00, NULL, NULL, NULL, 'Available', 'Princess'),
(101, 1788, 'https://drive.google.com/uc?export=download&id=1sWCG3OwRD9cahav3454wMMp1A-A15Osc', 'STPWLPU', 185.00, NULL, NULL, NULL, 'Available', 'Puppy'),
(102, 1788, NULL, 'STPWLWW', 185.00, NULL, NULL, NULL, 'Available', 'Woodpecker'),
(103, 1521, 'https://drive.google.com/uc?export=download&id=1HfL_pvAJ1S2dp7OQmexrpYoMXrxySNAW', 'KLSBS', 135.00, NULL, NULL, NULL, 'Available', 'Small'),
(104, 1521, 'https://drive.google.com/uc?export=download&id=1FC5-jwYXH2YSQcheL9pmhX11RLlY5NDt', 'KLSBL', 218.00, NULL, NULL, NULL, 'Available', 'Large'),
(105, 1790, 'https://drive.google.com/uc?export=download&id=11ZMBwJHF_-d7ydF-pHrwE7y1irBJkDLP', 'PPPLAC12', 468.00, NULL, NULL, NULL, 'Available', '12Pcs'),
(106, 1790, 'https://drive.google.com/uc?export=download&id=1EzPG4xADCI0N7jaaPHD0-I4AoSjWSv5m', 'PPPLAC24', 828.00, NULL, NULL, NULL, 'Available', '24Pcs'),
(107, 1790, NULL, 'PPPLAC36', 1188.00, NULL, NULL, NULL, 'Available', '36Pcs'),
(108, 1316, NULL, 'BOCSS', 265.00, NULL, NULL, NULL, 'Available', 'Spark Candle 6Pcs Small 12CM'),
(109, 1316, 'https://drive.google.com/uc?export=download&id=1ihwoZoqM4zRkrcbUcQUnnavRlc6jmiKo', 'BOCSM', 265.00, NULL, NULL, NULL, 'Available', 'Spark Candle 6Pcs Medium 15CM'),
(110, 1316, 'https://drive.google.com/uc?export=download&id=1Aw4KIMJQYGoVP51MIJ1C7KS9Bgxy2jqZ', 'BOCSL', 300.00, NULL, NULL, NULL, 'Available', 'Spark Candle 6Pcs Large 18CM'),
(111, 1531, 'https://drive.google.com/uc?export=download&id=1Hhs0RvwuT8EBlWHtaGWHM2x5-U0QqnxG', 'PBX3363', 195.00, NULL, NULL, NULL, 'Available', 'Shichang'),
(112, 1531, 'https://drive.google.com/uc?export=download&id=1R5pY9S4P6fwllDCY8pu91aE19rKxVNMM', 'PBX33-61', 175.00, NULL, NULL, NULL, 'Available', 'Duck'),
(113, 1091, 'https://drive.google.com/uc?export=download&id=1oFHRuM7PE98v0WM5BEE_xmgQmXZ0Kmeb', 'OSOAPCS', 275.00, NULL, NULL, NULL, 'Available', 'Small'),
(114, 1091, 'https://drive.google.com/uc?export=download&id=1uu3PB3xS8HUQoLTm9J7T6dOrOSuy0dIz', 'OSOAPCL', 370.00, NULL, NULL, NULL, 'Available', 'Large'),
(115, 1588, 'https://drive.google.com/uc?export=download&id=1BXxkJMiIiDghkewMo2p89pJYpdLqjt0s', 'BOBRA4', 135.00, NULL, NULL, NULL, 'Available', 'Rainbow Mesh Bag A4'),
(116, 1588, 'https://drive.google.com/uc?export=download&id=1KvtG5f__ay1YuAp7GEHt6NgynwTyePql', 'BOBRA3', 185.00, NULL, NULL, NULL, 'Available', 'Rainbow Mesh Bag A3'),
(117, 1588, 'https://drive.google.com/uc?export=download&id=1PnPWdrTezynLyxTDsVoqL4K79_0Xwiq5', 'BOBRA5', 90.00, NULL, NULL, NULL, 'Available', 'Rainbow Mesh Bag A5'),
(118, 1588, 'https://drive.google.com/uc?export=download&id=1CLGAf6KmnRY1PMnH2X2QLWJip0plxJRa', 'BOBRA6', 70.00, NULL, NULL, NULL, 'Available', 'Rainbow Mesh Bag A6'),
(119, 1588, NULL, 'BOBRB4', 165.00, NULL, NULL, NULL, 'Available', 'Rainbow Mesh Bag B4'),
(120, 1522, 'https://drive.google.com/uc?export=download&id=1vVQYR1svbgabpnwIL0bEd-OhmZwdo7TK', 'KLPCSS', 75.00, NULL, NULL, NULL, 'Available', 'Painting Card with Sand Small'),
(121, 1522, 'https://drive.google.com/uc?export=download&id=1cKU3QmetSaYH7EHShKTR2Yjj1JKDMs4s', 'KLPCSL', 100.00, NULL, NULL, NULL, 'Available', 'Painting Card with Sand Large'),
(122, 1802, 'https://drive.google.com/uc?export=download&id=1W_jbKHPv244fzUhIa42gYPz0ehy8avpo', 'RB1', 1265.00, NULL, NULL, NULL, 'Available', '1 Inch'),
(123, 1802, 'https://drive.google.com/uc?export=download&id=1W_jbKHPv244fzUhIa42gYPz0ehy8avpo', 'RB12', 1265.00, NULL, NULL, NULL, 'Available', '1 / 2 Inch'),
(124, 1802, 'https://drive.google.com/uc?export=download&id=1W_jbKHPv244fzUhIa42gYPz0ehy8avpo', 'RB112', 1265.00, NULL, NULL, NULL, 'Available', '1 1/2 Inch'),
(125, 1802, 'https://drive.google.com/uc?export=download&id=1W_jbKHPv244fzUhIa42gYPz0ehy8avpo', 'RB2', 1265.00, NULL, NULL, NULL, 'Available', '2 Inch'),
(126, 1802, 'https://drive.google.com/uc?export=download&id=1W_jbKHPv244fzUhIa42gYPz0ehy8avpo', 'RB3', 1265.00, NULL, NULL, NULL, 'Available', '3 Inch'),
(127, 1665, 'https://drive.google.com/uc?export=download&id=160BLJEG3Uhp7TrVQl2Y2xiYKGFS45R37', 'PCPA4KI80', 1090.00, NULL, NULL, NULL, 'Available', '80 GSM'),
(128, 1665, 'https://drive.google.com/uc?export=download&id=1RzBp7neuc43GwpxUOXp4QgbnxR9gudsR', 'PCPA4KI70', 925.00, NULL, NULL, NULL, 'Available', '70 GSM'),
(129, 1666, 'https://drive.google.com/uc?export=download&id=14GBS9XgjgrM-aKUpwptk8vxngwCvz7t7', 'PCPA370', 2050.00, NULL, NULL, NULL, 'Available', '70 GSM'),
(130, 1666, 'https://drive.google.com/uc?export=download&id=1TjbEQq47EWnbDMqR4wJQLJ4Z_a8OdgDO', 'PCPA380', 2350.00, NULL, NULL, NULL, 'Available', '80 GSM'),
(131, 1378, 'https://drive.google.com/uc?export=download&id=1H1JXMfWO7RaITDVihPUfI0GVqMgQNklc', 'CTBTR2520', 140.00, NULL, NULL, NULL, 'Available', '25mm* 20mt RED'),
(132, 1378, NULL, 'CTBTS2520', 137.00, NULL, NULL, NULL, 'Available', '25mm * 20mt SILVER'),
(133, 1378, 'https://drive.google.com/uc?export=download&id=1abmSkfeFc8z-Tma6j9NsjCLnoa-AM8QU', 'CTBTY2520', 137.00, NULL, NULL, NULL, 'Available', '25mm * 20mt YELLOW'),
(134, 1378, 'https://drive.google.com/uc?export=download&id=1L0s3ltNni8wbT51cqjMCG_E03Bnhfvdc', 'CTBTDB4820', 205.00, NULL, NULL, NULL, 'Available', '48mm * 20mt BLUE'),
(135, 1378, 'https://drive.google.com/uc?export=download&id=1azSalEjkv_XGfiKiMayp2Fn1A7ALxC48', 'CTBTBL4820', 210.00, NULL, NULL, NULL, 'Available', 'Tape 48mm * 20mt BLACK'),
(136, 1378, 'https://drive.google.com/uc?export=download&id=1J0PAX-MFWoEf52qQSU3sQOp38lDiKOdY', 'CTBTGR4820', 205.00, NULL, NULL, NULL, 'Available', '48mm * 20mt GREEN'),
(137, 1378, 'https://drive.google.com/uc?export=download&id=1dTkSGCeN3Lingz7Sx7qVetjOOLY_DjlL', 'CTBTR4820', 216.00, NULL, NULL, NULL, 'Available', '48mm * 20mt RED'),
(138, 1378, 'https://drive.google.com/uc?export=download&id=1l0LbdYWy4pwRbQq-HVRaS_kb2bK89FqX', 'CTBTS4820', 216.00, NULL, NULL, NULL, 'Available', '48mm * 20mt SILVER'),
(139, 1378, NULL, 'CTBTY4820', 216.00, NULL, NULL, NULL, 'Available', '48mm * 20mt YELLOW'),
(140, 1753, 'https://drive.google.com/uc?export=download&id=1d1abc2vXHXWvRWApfas5TpJpcuIHyM0j', 'CTNA2525', 210.00, NULL, NULL, NULL, 'Available', '25*1M'),
(141, 1382, NULL, 'CTT2525', 63.00, NULL, NULL, NULL, 'Available', '25mm * 25mt'),
(142, 1808, 'https://drive.google.com/uc?export=download&id=1vOigPfhrcsQW8QCOSRwY5uM53XEp6xyK', 'CTFR', 82.00, NULL, NULL, NULL, 'Available', 'Red'),
(143, 1808, 'https://drive.google.com/uc?export=download&id=1xFGiOsXyQM5EI2YlZ6wvjKhVOLY2bhjz', 'CTFY', 82.00, NULL, NULL, NULL, 'Available', 'Yellow'),
(144, 1379, 'https://drive.google.com/uc?export=download&id=12ahKUtd7pwMKqeNOIeepIwUtzIH4SQN-', 'CTET1220', 165.00, NULL, NULL, NULL, 'Available', '1/2mm x 20 mt'),
(145, 1384, 'https://drive.google.com/uc?export=download&id=1zg-Um110vF5WdgrqxMQwk-DMUmeYlwIO', 'CTMT2520', 88.00, NULL, NULL, NULL, 'Available', '25*20M'),
(146, 1384, 'https://drive.google.com/uc?export=download&id=1xdW_zFLmrx1nLVYRCJnceJsR4qqv4DGR', 'CTMT4820', 169.00, NULL, NULL, NULL, 'Available', '48*20M'),
(147, 1809, 'https://drive.google.com/uc?export=download&id=12AVHL8yW_g_G0Iw45a9mu_YurVJsnQy3', 'CT2525', 33.00, NULL, NULL, NULL, 'Available', '25mm * 25 mt'),
(148, 1809, 'https://drive.google.com/uc?export=download&id=1JUI0arsYmXC4mWXMhEkLN3rh-hy0ldjq', 'CT2550', 60.00, NULL, NULL, NULL, 'Available', '25mm * 50 mt'),
(149, 1809, 'https://drive.google.com/uc?export=download&id=1axUwNe9fIrBK-xLXprzSdEyi4XhQ8Gx1', ' CT25100', 112.00, NULL, NULL, NULL, 'Available', '25mm* 100 mt'),
(150, 1809, 'https://drive.google.com/uc?export=download&id=1Zw1943ZIDprDINmabjve0t02eKAtyOuX', 'CT4825', 65.00, NULL, NULL, NULL, 'Available', '48mm * 25 mt'),
(151, 1809, 'https://drive.google.com/uc?export=download&id=1WZ0-pMFHJFAHG7fZWkHK8BOXhrIk96B7', 'CT4850', 140.00, NULL, NULL, NULL, 'Available', '48mm * 50 mt'),
(152, 1809, 'https://drive.google.com/uc?export=download&id=1ftM-MJ1ulTaQzDM04SS-ZwW_J8w_z8xO', 'CT48100', 250.00, NULL, NULL, NULL, 'Available', '48mm * 100mt'),
(153, 1809, NULL, 'CT48200', 600.00, NULL, NULL, NULL, 'Available', '48mm * 200mt'),
(154, 1809, 'https://drive.google.com/uc?export=download&id=1Px-KF-k4Ps6TQT90HfEms52qK-fPjl2K', 'CT48300', 450.00, NULL, NULL, NULL, 'Available', 'Jumbo'),
(155, 1383, NULL, 'CTD1210', 45.00, NULL, NULL, NULL, 'Available', '12mm * 10mt'),
(156, 1383, 'https://drive.google.com/uc?export=download&id=1pUDxrT1iXnXFtSgcGKlTBqCQtuI-Ska7', 'CTD2510', 107.00, NULL, NULL, NULL, 'Available', '25mm * 20mt'),
(157, 1383, 'https://drive.google.com/uc?export=download&id=1yLPJxpGFyncEQ7axv7DaWrOobsTTOsoz', 'CTD4810', 169.00, NULL, NULL, NULL, 'Available', '48mm * 10mt'),
(158, 1003, 'https://drive.google.com/uc?export=download&id=1MDIPA6dxvo9H_l1iQ7TEuTpfTWwfKXSa', 'RP30', 560.00, NULL, NULL, NULL, 'Available', '30 CM'),
(159, 1553, 'https://drive.google.com/uc?export=download&id=1v3Pb9ZIh3splNfvinbxeObfWcCdqPF5r', 'WR15', 25.00, NULL, NULL, NULL, 'Available', '15 CM'),
(160, 1055, 'https://drive.google.com/uc?export=download&id=1qQMjIUuBTXwcTRz7-N9xxzZ7X_nLMcEO', 'MG50', 90.00, NULL, NULL, NULL, 'Available', '50 MM'),
(161, 1055, 'https://drive.google.com/uc?export=download&id=1omxjLwEI8yhbMALKMAzwyDM3TJysYOqj', 'MG75', 160.00, NULL, NULL, NULL, 'Available', '75 MM'),
(162, 1012, 'https://drive.google.com/uc?export=download&id=1ozai4zMRJmyOszC1dhwSe-veMLumsdlp', 'HLS6', 400.00, NULL, NULL, NULL, 'Available', '6 PCS'),
(196, 1333, 'https://drive.google.com/uc?export=download&id=1tapdXwrWPgwcINZQRXpaI5anPoolo3X2', 'RZFC', 130.00, NULL, NULL, NULL, 'Available', 'FC'),
(197, 1333, 'https://drive.google.com/uc?export=download&id=1lsdsWjx-gA3kjgJyDkvg6EokkTz_jKdv', 'RZA5', 120.00, NULL, NULL, NULL, 'Available', 'A5'),
(198, 1333, 'https://drive.google.com/uc?export=download&id=153ehSfwlLMqDyi0Mr_ZBQCE72KHCfxR9', 'RZA6', 120.00, NULL, NULL, NULL, 'Available', 'A6'),
(199, 1825, 'https://drive.google.com/uc?export=download&id=1GOEVV4UCgIVtw_WtSOcohb06HxyGWsd5', 'BPRS', 164.00, NULL, NULL, NULL, 'Available', 'Small'),
(200, 1825, 'https://drive.google.com/uc?export=download&id=12xcgBDmyJCjuLL-B3dHGBid855glyPUq', 'BPRL', 231.00, NULL, NULL, NULL, 'Available', 'Large'),
(201, 1549, 'https://drive.google.com/uc?export=download&id=1Z58G6wRdla8uU0TQJrw2-YwMHARzNZpc', 'BPOS', 123.00, NULL, NULL, NULL, 'Available', 'Small'),
(202, 1549, 'https://drive.google.com/uc?export=download&id=11S1Q2fdYmkgB7iaRapf5z-JOBL_K0fNl', 'BPOL', 246.00, NULL, NULL, NULL, 'Available', 'Large'),
(203, 967, NULL, '9 1/2 x 4 1/2', 2.90, NULL, NULL, NULL, 'Available', '9 1/2 x 4 1/2'),
(204, 967, NULL, '10*8', 7.88, NULL, NULL, NULL, 'Available', '10*8'),
(205, 967, NULL, '12*10', 8.20, NULL, NULL, NULL, 'Available', '12*10'),
(206, 967, NULL, '15*10', 13.00, NULL, NULL, NULL, 'Available', '15*10'),
(207, 967, NULL, '16*12', 13.00, NULL, NULL, NULL, 'Available', '16*12'),
(208, 967, NULL, '10*7', 4.55, NULL, NULL, NULL, 'Available', '10*7'),
(209, 1055, NULL, 'MG60', 110.00, NULL, NULL, NULL, 'Available', '60MM'),
(210, 1055, NULL, 'MG90', 300.00, NULL, NULL, NULL, 'Available', '90MM'),
(211, 1055, NULL, 'MG100', 210.00, NULL, NULL, NULL, 'Available', '100MM'),
(212, 1348, NULL, 'BB1210', 160.00, NULL, NULL, NULL, 'Available', 'Birthday Baloon 12 10pcs'),
(213, 1348, NULL, 'bb910', 100.00, NULL, NULL, NULL, 'Available', 'Birthday Baloon 9 10pcs'),
(214, 1348, NULL, 'db1210', 160.00, NULL, NULL, NULL, 'Available', 'Dot Baloon 12 10pcs'),
(215, 1348, NULL, 'fb1210', 160.00, NULL, NULL, NULL, 'Available', 'Flower Baloon 12 10pcs'),
(216, 1348, NULL, 'mmb1210', 160.00, NULL, NULL, NULL, 'Available', 'Micky Mouse Baloon 12 10pcs'),
(217, 1348, NULL, 'b12100', 680.00, NULL, NULL, NULL, 'Available', 'Baloon No12 100pcs'),
(218, 1348, NULL, '9asb', 160.00, NULL, NULL, NULL, 'Available', '9 Assorted Baloon 20pcs'),
(219, 1348, NULL, 'pb20b', 160.00, NULL, NULL, NULL, 'Available', 'Plain Baloon 20pcs Colors'),
(220, 1348, NULL, 'pbg20', 185.00, NULL, NULL, NULL, 'Available', 'Plain Baloon 20pcs Gold'),
(221, 1348, NULL, 'no7100', 410.00, NULL, NULL, NULL, 'Available', 'Baloon No 7 100pcs'),
(222, 1348, NULL, 'no9100', 520.00, NULL, NULL, NULL, 'Available', 'Baloon No 9 100pcs'),
(223, 1348, NULL, 'nos100', 520.00, NULL, NULL, NULL, 'Available', 'Baloon No 9 Single Color 100pcs'),
(224, 1348, NULL, 'ab9', 450.00, NULL, NULL, NULL, 'Available', 'Baloon 9 Animal Card 40pcs'),
(225, 1348, NULL, 'hba10', 90.00, NULL, NULL, NULL, 'Available', 'Heart Baloon Assorted 10pcs'),
(226, 1348, NULL, 'hbr10', 115.00, NULL, NULL, NULL, 'Available', 'Heart Baloon Red 10pcs'),
(227, 1348, NULL, 'hbw10', 125.00, NULL, NULL, NULL, 'Available', 'Heart Baloon White 10pcs'),
(228, 1327, 'https://drive.google.com/uc?export=download&id=1pv3g6AJ8IUcY0xAXUCU5K0XJ9slEimCa', 'bf', 57.00, NULL, NULL, NULL, 'Available', 'A4'),
(229, 1327, 'https://drive.google.com/uc?export=download&id=1q6OdhmW8uGsgSXpQ8jbCM04N78mCx46C', 'bffc', 75.00, NULL, NULL, NULL, 'Available', 'FC'),
(230, 1028, NULL, 'ccp6', 150.00, NULL, NULL, NULL, 'Available', '6 Colors'),
(231, 1028, NULL, 'ccp12c', 298.00, NULL, NULL, NULL, 'Available', '12 Colors'),
(232, 1028, NULL, 'ccp12cj', 565.00, NULL, NULL, NULL, 'Available', '12 Color Jumbo'),
(233, 1028, NULL, 'ccp18c', 495.00, NULL, NULL, NULL, 'Available', '18 Colors'),
(234, 1028, NULL, 'ccp24c', 590.00, NULL, NULL, NULL, 'Available', '24 Colors'),
(235, 1028, NULL, 'ccp36c', 1190.00, NULL, NULL, NULL, 'Available', '36 Colors'),
(236, 1028, NULL, 'ccp48c', 1590.00, NULL, NULL, NULL, 'Available', '48 Colors'),
(237, 1028, NULL, 'ccp72c', 2290.00, NULL, NULL, NULL, 'Available', '72 Colors'),
(238, 1504, NULL, 'l76', 122.00, NULL, NULL, NULL, 'Available', '76*76'),
(239, 1504, NULL, 'lc7651', 109.00, NULL, NULL, NULL, 'Available', '76*51'),
(240, 1504, NULL, 'lc76127', 205.00, NULL, NULL, NULL, 'Available', '76*127'),
(241, 1504, NULL, 'lc101', 160.00, NULL, NULL, NULL, 'Available', '76*101'),
(242, 1504, NULL, '160220', 768.00, NULL, NULL, NULL, 'Available', '160*220'),
(243, 1504, NULL, '120191', 512.00, NULL, NULL, NULL, 'Available', '120*190'),
(244, 1504, NULL, '101152', 359.00, NULL, NULL, NULL, 'Available', '101*152'),
(252, 1114, NULL, '1602201', 692.00, NULL, NULL, NULL, 'Available', '160*220'),
(253, 1114, NULL, '1101521', 320.00, NULL, NULL, NULL, 'Available', '101*152'),
(254, 1114, NULL, '1201901', 436.00, NULL, NULL, NULL, 'Available', '120*190'),
(255, 1114, NULL, '7610101', 148.00, NULL, NULL, NULL, 'Available', '76*101'),
(256, 1114, NULL, '161271', 180.00, NULL, NULL, NULL, 'Available', '76*127'),
(257, 1114, NULL, '76511', 88.00, NULL, NULL, NULL, 'Available', '76*51'),
(258, 1379, NULL, 'et31230', 230.00, NULL, NULL, NULL, 'Available', '3/4mm x 30 mt			'),
(259, 1082, NULL, '5y', 85.00, NULL, NULL, NULL, 'Available', '5 Yard'),
(260, 1082, NULL, 'p1kg', 662.00, NULL, NULL, NULL, 'Available', '1 KG'),
(261, 1044, NULL, 'ecba4', 170.00, NULL, NULL, NULL, 'Available', 'A4'),
(262, 1044, NULL, 'ecba5', 140.00, NULL, NULL, NULL, 'Available', 'A5'),
(263, 1044, NULL, 'ecba6', 120.00, NULL, NULL, NULL, 'Available', 'A6'),
(264, 1044, NULL, 'ecbfc', 215.00, NULL, NULL, NULL, 'Available', 'FC'),
(265, 1525, NULL, 'klcs', 138.00, NULL, NULL, NULL, 'Available', 'Small'),
(266, 1525, NULL, 'clcl', 155.00, NULL, NULL, NULL, 'Available', 'Large'),
(267, 1271, NULL, 'id', 350.00, NULL, NULL, NULL, 'Available', 'ID - 65*95'),
(268, 1271, NULL, 'ipa4', 1570.00, NULL, NULL, NULL, 'Available', 'A4 - 216*303'),
(269, 1271, NULL, 'lpa3', 3875.00, NULL, NULL, NULL, 'Available', 'A3 - 303*426'),
(270, 1271, NULL, 'lpa5', 1450.00, NULL, NULL, NULL, 'Available', 'A5 - 154*216'),
(271, 1271, NULL, 'lpl', 2520.00, NULL, NULL, NULL, 'Available', 'Legal - 219*370'),
(272, 1021, NULL, 'mh3', 325.00, NULL, NULL, NULL, 'Available', '3 Inch'),
(273, 1021, NULL, 'mh4', 345.00, NULL, NULL, NULL, 'Available', '4 Inch'),
(274, 1021, NULL, 'mg6', 420.00, NULL, NULL, NULL, 'Available', '6 Inch');

-- --------------------------------------------------------

--
-- Table structure for table `Representors`
--

CREATE TABLE `Representors` (
  `RepID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `FullName` varchar(255) DEFAULT NULL,
  `route_name` varchar(50) DEFAULT NULL,
  `Status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Representors`
--

INSERT INTO `Representors` (`RepID`, `Username`, `Password`, `FullName`, `route_name`, `Status`, `CreatedAt`) VALUES
(2, 'KURU3', '12345678', 'Ruvinda Jayaweera', NULL, 'active', '2025-07-11 17:46:53'),
(3, 'Kushancy', '12345678', 'Kushan Senarathne', NULL, 'active', '2025-07-15 12:47:03'),
(4, 'susar.aa', '20060419', 'Susara Senarathne', 'KURU 1', 'active', '2025-07-15 12:47:23'),
(5, 'Roshan', '12345678', 'Roshan', NULL, 'active', '2025-07-15 12:48:19'),
(6, 'KURU4', '12345678', 'Susantha Senevirathne', NULL, 'active', '2025-07-16 02:50:41'),
(7, 'KURU2', '12345678', 'Madushanka', NULL, 'active', '2025-07-16 02:53:39'),
(8, 'KURU1', '12345678', 'Harsha', NULL, 'active', '2025-07-16 02:58:43'),
(9, 'MADUSHAN', '12345678', 'Madushan', NULL, 'active', '2025-08-09 04:16:36'),
(10, 'Falcon', '12345678', 'Falcon', NULL, 'active', '2025-09-06 03:17:43');

-- --------------------------------------------------------

--
-- Table structure for table `rep_bills`
--

CREATE TABLE `rep_bills` (
  `bill_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `rep_id` int(11) NOT NULL,
  `bill_date` datetime NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `bill_discount_percentage` decimal(5,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rep_bills`
--

INSERT INTO `rep_bills` (`bill_id`, `customer_id`, `rep_id`, `bill_date`, `total_amount`, `bill_discount_percentage`) VALUES
(36, 13, 4, '2025-09-26 07:55:27', 11562.45, 5.00),
(37, 20, 4, '2025-09-26 07:55:54', 4100.00, 0.00),
(38, 10, 4, '2025-09-26 07:56:05', 220.00, 0.00),
(39, 10, 4, '2025-09-27 10:32:28', 4226.55, 5.00);

-- --------------------------------------------------------

--
-- Table structure for table `rep_bill_items`
--

CREATE TABLE `rep_bill_items` (
  `bill_item_id` int(11) NOT NULL,
  `bill_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_per_unit` decimal(10,2) NOT NULL,
  `custom_price` decimal(10,2) DEFAULT NULL,
  `item_discount_percentage` decimal(5,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rep_bill_items`
--

INSERT INTO `rep_bill_items` (`bill_item_id`, `bill_id`, `variant_id`, `quantity`, `price_per_unit`, `custom_price`, `item_discount_percentage`) VALUES
(102, 36, 1580, 1, 1025.00, NULL, 0.00),
(103, 36, 106, 2, 828.00, NULL, 0.00),
(104, 36, 107, 1, 1188.00, NULL, 0.00),
(105, 36, 105, 3, 468.00, NULL, 0.00),
(106, 36, 1011, 5, 105.00, NULL, 0.00),
(107, 36, 1351, 4, 410.00, NULL, 0.00),
(108, 36, 219, 3, 160.00, NULL, 0.00),
(109, 36, 218, 3, 160.00, NULL, 0.00),
(110, 36, 221, 1, 410.00, NULL, 0.00),
(111, 36, 220, 2, 185.00, NULL, 0.00),
(112, 36, 1294, 3, 415.00, NULL, 0.00),
(113, 36, 78, 3, 472.00, NULL, 0.00),
(114, 36, 75, 2, 82.00, NULL, 0.00),
(115, 36, 76, 1, 168.00, NULL, 0.00),
(116, 37, 1580, 4, 1025.00, NULL, 0.00),
(117, 38, 1078, 4, 55.00, NULL, 0.00),
(118, 39, 1294, 4, 415.00, NULL, 0.00),
(119, 39, 1580, 1, 1025.00, NULL, 0.00),
(120, 39, 106, 1, 828.00, NULL, 0.00),
(121, 39, 105, 2, 468.00, NULL, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `route_id` int(11) NOT NULL,
  `route_name` varchar(100) NOT NULL,
  `route_code` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`route_id`, `route_name`, `route_code`) VALUES
(1, 'Kurunegala to kandy', 'K1'),
(2, 'Anurapura to kurunegala', 'K2'),
(3, 'Arahe to mehe', 'K3'),
(4, 'Galle to Colombo', 'K4'),
(5, 'KURU 5', 'K5'),
(6, 'KURU 6', 'K6'),
(7, 'KURU 7', 'K7'),
(8, 'KURU 8', 'K8');

-- --------------------------------------------------------

--
-- Table structure for table `SubCategory`
--

CREATE TABLE `SubCategory` (
  `SubCategoryID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `SubCategoryName` varchar(100) NOT NULL,
  `Description` text,
  `IconPath` varchar(255) DEFAULT NULL,
  `AvailabilityStatus` enum('Available','Not Available') DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `SubCategory`
--

INSERT INTO `SubCategory` (`SubCategoryID`, `CategoryID`, `SubCategoryName`, `Description`, `IconPath`, `AvailabilityStatus`) VALUES
(1, 1, 'Accessories', '', NULL, 'Available'),
(2, 1, 'Artist', '', 'images/Artist.png', 'Available'),
(3, 1, 'Bags', '', '', 'Available'),
(4, 1, 'Birthday Items', '', '', 'Available'),
(5, 1, 'Books', '', '', 'Available'),
(6, 1, 'Clay', '', '', 'Available'),
(7, 1, 'Eraser', '', 'images/Erasers.png', 'Available'),
(8, 1, 'Files', '', '', 'Available'),
(9, 1, 'Glue', '', 'images/Glues.png', 'Available'),
(10, 1, 'Kids', '', '', 'Available'),
(11, 1, 'Laminating', '', '', 'Available'),
(12, 1, 'Lunch Box', '', '', 'Available'),
(13, 1, 'Marker', '', '', 'Available'),
(14, 1, 'Office', '', '', 'Available'),
(15, 1, 'Other Stationary', '', '', 'Available'),
(16, 1, 'Paper', '', '', 'Available'),
(17, 1, 'Pen Holders', '', '', 'Available'),
(18, 1, 'Pencil', '', 'images/Pencils.png', 'Available'),
(19, 1, 'Pencil Box & Case', '', '', 'Available'),
(20, 1, 'Pens', '', 'images/Pens.png', 'Available'),
(21, 1, 'Ruller', '', '', 'Available'),
(22, 1, 'Scissor', '', '', 'Available'),
(23, 2, 'Scrub', '', '', 'Available'),
(24, 1, 'Sharpner', '', '', 'Available'),
(25, 1, 'Sticker', '', '', 'Available'),
(26, 1, 'Sticky', '', '', 'Available'),
(27, 1, 'Tapes', '', '', 'Available'),
(28, 1, 'Toys', '', '', 'Available'),
(29, 1, 'Water Bottle', '', 'images/WaterBottle.png', 'Available'),
(30, 2, 'Body Lotion', '', '', 'Available'),
(31, 2, 'Body Spray', '', '', 'Available'),
(32, 2, 'Cologne Spray', '', '', 'Available'),
(33, 2, 'Cream', '', '', 'Available'),
(34, 2, 'Face Care ', '', '', 'Available'),
(35, 2, 'Face Wash', '', '', 'Available'),
(36, 2, 'Hair Care', '', '', 'Available'),
(37, 2, 'Makeup Tools', '', '', 'Available'),
(38, 2, 'Masks', '', '', 'Available'),
(39, 2, 'Other Cosmetics', '', '', 'Available'),
(40, 2, 'Perfume', '', '', 'Available'),
(41, 2, 'Roll On', '', '', 'Available'),
(46, 1, 'Highlighter', NULL, 'images/Highlighters.png', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `shop_name` varchar(150) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` text,
  `city` varchar(100) DEFAULT NULL,
  `route_name` varchar(50) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `profile_image_url` text,
  `user_type` enum('shop_owner','admin') DEFAULT 'shop_owner',
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `shop_name`, `email`, `phone`, `password`, `address`, `city`, `route_name`, `district`, `profile_image_url`, `user_type`, `status`, `created_at`, `updated_at`) VALUES
(2, 'Susara Senarathne', 'Falcon E Store', 'suz.x2006@gmail.com', '0761407875', '$2y$10$.gFe2gxJdADGxe6586V89.XUb3Z7/0qxQ.Il85m74XrmJnW6cgU36', '79, Dambakanda Estate, Boyagane, Kurunegala', 'Kurunegala', '', 'Boyagane', NULL, 'shop_owner', 'active', '2025-07-22 02:40:22', '0000-00-00 00:00:00'),
(10, 'Harsha Kumara Dissanayake', NULL, 'Harshakumara6@gmail.com', '0719009209', '$2y$10$Gil3LBsNZLIWR7ZAv.frFOILvpf95wkUGAGumMqb6h5Zk62uxwXyu', NULL, NULL, NULL, NULL, NULL, 'shop_owner', 'active', '2025-08-14 06:23:06', '0000-00-00 00:00:00'),
(11, 'Anupama', NULL, 'anupamarusl@gmail.com', '0716426276', '$2y$10$ibhSN1zSvN7.tDLOpuI8puYs7WY3pdNW4vYMVi/AsDbt5pAzP.rqm', NULL, NULL, NULL, NULL, NULL, 'shop_owner', 'active', '2025-08-15 12:47:23', '0000-00-00 00:00:00'),
(12, 'Nafeel Mohamed Riskhan', NULL, 'rnmriskhan5752@gmail.com', '0769995752', '$2y$10$bOejWHztgJLo4Cvu27nvhOgeEJaN/d.tYdawnPoqfXQjKtCpkFNOm', NULL, NULL, NULL, NULL, NULL, 'shop_owner', 'active', '2025-08-19 05:52:11', '0000-00-00 00:00:00'),
(13, 'Kushan', NULL, 'kushancy@gmail.com', '0741741741', '$2y$10$Y1vdh9ojQiYWZtbXACAbheTEKfjb1mFcFUOVDqsVDrusWyo0sMFOi', NULL, NULL, NULL, NULL, NULL, 'shop_owner', 'active', '2025-09-02 14:15:44', '0000-00-00 00:00:00'),
(22, 'W.Nuwan Sajith Bandara', 'Shane Cafe', 'wnsbandara@gmail.com', '0703820382', '$2y$10$ptyrWezRk1WZ/So.SWeCWukJnKaQrLBO.ndR86B5ANexOB211FNaC', 'D 23,\r\nGalapitamada', 'Warakapola', NULL, 'Kegalle', NULL, 'shop_owner', 'active', '2025-09-08 07:42:45', '0000-00-00 00:00:00'),
(23, 'netherma', NULL, 'vogacyxy@fxzig.com', '0612345678', '$2y$10$SbcWzdV5hWeB4r7YRjN2/u4cTUeA8Blq3u83IkHXPRpLp/5squtd.', NULL, NULL, NULL, NULL, NULL, 'shop_owner', 'active', '2025-09-22 04:52:02', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `daily_route_summaries`
--
ALTER TABLE `daily_route_summaries`
  ADD PRIMARY KEY (`summary_id`);

--
-- Indexes for table `Item_List`
--
ALTER TABLE `Item_List`
  ADD PRIMARY KEY (`ItemID`),
  ADD UNIQUE KEY `SKU` (`SKU`),
  ADD KEY `CategoryID` (`CategoryID`),
  ADD KEY `SubCategoryID` (`SubCategoryID`);

--
-- Indexes for table `MainCategory`
--
ALTER TABLE `MainCategory`
  ADD PRIMARY KEY (`CategoryID`),
  ADD UNIQUE KEY `CategoryName` (`CategoryName`);

--
-- Indexes for table `OrderItems`
--
ALTER TABLE `OrderItems`
  ADD PRIMARY KEY (`OrderItemID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ItemID` (`ItemID`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Product_Images`
--
ALTER TABLE `Product_Images`
  ADD PRIMARY KEY (`ImageID`),
  ADD KEY `ItemID` (`ItemID`),
  ADD KEY `VariantID` (`VariantID`);

--
-- Indexes for table `Product_Variants`
--
ALTER TABLE `Product_Variants`
  ADD PRIMARY KEY (`VariantID`),
  ADD UNIQUE KEY `SKU` (`SKU`),
  ADD KEY `ItemID` (`ItemID`);

--
-- Indexes for table `Representors`
--
ALTER TABLE `Representors`
  ADD PRIMARY KEY (`RepID`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- Indexes for table `rep_bills`
--
ALTER TABLE `rep_bills`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `rep_bill_items`
--
ALTER TABLE `rep_bill_items`
  ADD PRIMARY KEY (`bill_item_id`),
  ADD KEY `bill_id` (`bill_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`route_id`);

--
-- Indexes for table `SubCategory`
--
ALTER TABLE `SubCategory`
  ADD PRIMARY KEY (`SubCategoryID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `daily_route_summaries`
--
ALTER TABLE `daily_route_summaries`
  MODIFY `summary_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Item_List`
--
ALTER TABLE `Item_List`
  MODIFY `ItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1833;

--
-- AUTO_INCREMENT for table `MainCategory`
--
ALTER TABLE `MainCategory`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `OrderItems`
--
ALTER TABLE `OrderItems`
  MODIFY `OrderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `Product_Images`
--
ALTER TABLE `Product_Images`
  MODIFY `ImageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `Product_Variants`
--
ALTER TABLE `Product_Variants`
  MODIFY `VariantID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=275;

--
-- AUTO_INCREMENT for table `Representors`
--
ALTER TABLE `Representors`
  MODIFY `RepID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `rep_bills`
--
ALTER TABLE `rep_bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `rep_bill_items`
--
ALTER TABLE `rep_bill_items`
  MODIFY `bill_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `SubCategory`
--
ALTER TABLE `SubCategory`
  MODIFY `SubCategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Item_List`
--
ALTER TABLE `Item_List`
  ADD CONSTRAINT `Item_List_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `MainCategory` (`CategoryID`),
  ADD CONSTRAINT `Item_List_ibfk_2` FOREIGN KEY (`SubCategoryID`) REFERENCES `SubCategory` (`SubCategoryID`);

--
-- Constraints for table `OrderItems`
--
ALTER TABLE `OrderItems`
  ADD CONSTRAINT `OrderItems_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`),
  ADD CONSTRAINT `OrderItems_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `Item_List` (`ItemID`);

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `Product_Images`
--
ALTER TABLE `Product_Images`
  ADD CONSTRAINT `Product_Images_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `Item_List` (`ItemID`),
  ADD CONSTRAINT `Product_Images_ibfk_2` FOREIGN KEY (`VariantID`) REFERENCES `Product_Variants` (`VariantID`);

--
-- Constraints for table `Product_Variants`
--
ALTER TABLE `Product_Variants`
  ADD CONSTRAINT `fk_item_id` FOREIGN KEY (`ItemID`) REFERENCES `Item_List` (`ItemID`) ON DELETE CASCADE;

--
-- Constraints for table `rep_bill_items`
--
ALTER TABLE `rep_bill_items`
  ADD CONSTRAINT `rep_bill_items_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `rep_bills` (`bill_id`) ON DELETE CASCADE;

--
-- Constraints for table `SubCategory`
--
ALTER TABLE `SubCategory`
  ADD CONSTRAINT `SubCategory_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `MainCategory` (`CategoryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
