-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2025-09-02 13:34:25
-- 服务器版本： 5.7.26
-- PHP 版本： 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `mswd1`
--

-- --------------------------------------------------------

--
-- 表的结构 `access_logs`
--

CREATE TABLE `access_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `request_method` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `access_logs`
--

INSERT INTO `access_logs` (`id`, `ip_address`, `request_url`, `user_agent`, `request_method`, `created_at`) VALUES
(423, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:38:55'),
(422, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:38:52'),
(421, '10.125.239.33', '/StudyMaterialsWeb1/index.php?download=13', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'GET', '2025-09-01 15:38:38'),
(420, '172.18.69.86', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:38:29'),
(419, '10.125.244.167', '/StudyMaterialsWeb1/index.php?download=48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36 EdgA/139.0.0.0', 'GET', '2025-09-01 15:38:25'),
(418, '10.125.244.167', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36 EdgA/139.0.0.0', 'GET', '2025-09-01 15:38:19'),
(417, '10.125.239.33', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'GET', '2025-09-01 15:38:03'),
(416, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:37:22'),
(415, '121.192.164.173', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:35:28'),
(414, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:35:04'),
(413, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:35:04'),
(412, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:34:57'),
(411, '10.26.4.40', '/StudyMaterialsWeb1/index.php?logout=true', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:34:57'),
(410, '10.30.90.169', '/StudyMaterialsWeb1/index.php?download=46', 'Mozilla/5.0 (Linux; Android 15; V2408A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/26.0.0.0', 'GET', '2025-09-01 15:33:46'),
(409, '10.30.90.169', '/StudyMaterialsWeb1/index.php?download=47', 'Mozilla/5.0 (Linux; Android 15; V2408A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/26.0.0.0', 'GET', '2025-09-01 15:33:46'),
(408, '10.30.90.169', '/StudyMaterialsWeb1/index.php?download=48', 'Mozilla/5.0 (Linux; Android 15; V2408A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/26.0.0.0', 'GET', '2025-09-01 15:33:45'),
(407, '10.30.90.169', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; V2408A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.200 Mobile Safari/537.36 VivoBrowser/26.0.0.0', 'GET', '2025-09-01 15:33:42'),
(406, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:33:38'),
(405, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:33:36'),
(404, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:33:20'),
(403, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:32:00'),
(402, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:31:58'),
(401, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:31:57'),
(400, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:31:24'),
(399, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:31:21'),
(398, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:29:04'),
(397, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:29:02'),
(396, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:29:01'),
(395, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:29:00'),
(394, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:28:58'),
(393, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:27:21'),
(392, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:27:19'),
(391, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:27:15'),
(390, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:26:54'),
(389, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:24:05'),
(388, '10.26.4.40', '/StudyMaterialsWeb1/index.php?download=31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:23:58'),
(387, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=%E5%86%9B%E7%90%86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:23:56'),
(386, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:23:40'),
(385, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:23:37'),
(384, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:23:37'),
(383, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:23:35'),
(382, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=5&categories%5B%5D=12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:21:32'),
(381, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:21:23'),
(380, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:21:18'),
(379, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:21:12'),
(378, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:21:04'),
(377, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:20:15'),
(376, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:20:14'),
(375, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:20:13'),
(374, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:20:12'),
(373, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:20:09'),
(372, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:20:05'),
(371, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:19:46'),
(370, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:19:41'),
(369, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:18:23'),
(368, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:18:18'),
(367, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:18:17'),
(366, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:18:16'),
(365, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:18:09'),
(364, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:18:05'),
(363, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:17:42'),
(362, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:17:39'),
(361, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:15:40'),
(360, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:15:33'),
(359, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:15:32'),
(358, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:15:31'),
(356, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:15:23'),
(357, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:15:29'),
(355, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:15:14'),
(354, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:15:11'),
(353, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:14:31'),
(352, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:14:24'),
(351, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:14:23'),
(350, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:14:21'),
(349, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:14:20'),
(348, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:14:18'),
(347, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:14:01'),
(346, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:13:58'),
(345, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:13:43'),
(344, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:13:39'),
(343, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:13:07'),
(342, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:13:04'),
(341, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:11:50'),
(340, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:11:44'),
(339, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:11:42'),
(338, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:10:52'),
(337, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:10:49'),
(336, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:09:07'),
(335, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:09:04'),
(334, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:09:02'),
(333, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:07:33'),
(332, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:07:30'),
(331, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:06:21'),
(330, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:06:19'),
(329, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:06:18'),
(328, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:06:17'),
(327, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:06:16'),
(326, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:06:14'),
(325, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:06:13'),
(324, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:06:09'),
(323, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:05:26'),
(322, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:05:23'),
(321, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:05:10'),
(320, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:05:07'),
(319, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:03:27'),
(318, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 15:03:24'),
(317, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:59:45'),
(316, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:59:38'),
(315, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:35'),
(314, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:35'),
(313, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:34'),
(312, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:33'),
(311, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:33'),
(310, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:32'),
(309, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:31'),
(308, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:31'),
(307, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:30'),
(306, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:59:29'),
(305, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:59:26'),
(304, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:58:59'),
(303, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:58:56'),
(302, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:57:51'),
(301, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:57:48'),
(300, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:57:31'),
(299, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:57:27'),
(298, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:57:05'),
(297, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:56:59'),
(296, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:56:14'),
(295, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:56:11'),
(294, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:55:41'),
(293, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:55:38'),
(292, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:54:52'),
(291, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:54:47'),
(290, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:54:21'),
(289, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:53:47'),
(288, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:53:44'),
(287, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:53:09'),
(286, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:53:06'),
(285, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:52:47'),
(284, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:52:43'),
(283, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:50:22'),
(282, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:50:20'),
(281, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:50:18'),
(280, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:50:13'),
(279, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:50:10'),
(278, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:50:00'),
(277, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:49:35'),
(276, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:49:31'),
(275, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:44:54'),
(274, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:44:45'),
(273, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:44:40'),
(272, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:44:38'),
(271, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:44:37'),
(270, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:44:36'),
(269, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:44:35'),
(268, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:44:33'),
(267, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:44:22'),
(266, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:44:18'),
(265, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:42:26'),
(264, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:42:23'),
(263, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:42:10'),
(262, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:42:06'),
(261, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:41:21'),
(260, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:41:18'),
(259, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:39:25'),
(258, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:39:24'),
(257, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:39:22'),
(256, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:39:21'),
(255, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:39:20'),
(254, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:39:19'),
(253, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:39:18'),
(252, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:39:16'),
(250, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:38:39'),
(251, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:38:43'),
(249, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:37:31'),
(248, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:37:27'),
(247, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:37:07'),
(246, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:36:46'),
(245, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:33:53'),
(244, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:33:50'),
(243, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:32:54'),
(242, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:32:50'),
(241, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:30:31'),
(240, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:30:27'),
(239, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:25:58'),
(238, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:25:57'),
(237, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:25:53'),
(236, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:25:53'),
(235, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:43'),
(234, '10.26.4.40', '/StudyMaterialsWeb1/index.php?logout=true', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:43'),
(233, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:40'),
(232, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:24:40'),
(231, '10.26.4.40', '/StudyMaterialsWeb1/index.php?check_username=222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:24'),
(230, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:21'),
(229, '10.26.4.40', '/StudyMaterialsWeb1/index.php?logout=true', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:21'),
(228, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:14'),
(227, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-01 14:24:14'),
(226, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:03'),
(225, '10.26.4.40', '/StudyMaterialsWeb1/index.php?logout=true', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 14:24:03'),
(424, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:38:57'),
(425, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:38:59'),
(426, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:39:02'),
(427, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:39:03'),
(428, '10.125.239.33', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'GET', '2025-09-01 15:39:09'),
(429, '10.125.239.33', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'GET', '2025-09-01 15:39:12'),
(430, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:39:47'),
(431, '10.125.183.210', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'GET', '2025-09-01 15:39:51'),
(432, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:39:57'),
(433, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:40:02'),
(434, '10.26.4.40', '/StudyMaterialsWeb1/admin_blacklist.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:40:33'),
(435, '10.125.239.33', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'POST', '2025-09-01 15:40:42'),
(436, '10.125.239.33', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'GET', '2025-09-01 15:40:42'),
(437, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:40:50'),
(438, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:40:52'),
(439, '10.26.4.40', '/StudyMaterialsWeb1/admin_blacklist.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:40:53'),
(440, '10.125.239.33', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'GET', '2025-09-01 15:40:58'),
(441, '10.26.4.40', '/StudyMaterialsWeb1/admin_blacklist.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:41:07'),
(442, '10.125.239.33', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-CN; 23113RKC6C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 Quark/7.13.6.861 Mobile Safari/537.36', 'GET', '2025-09-01 15:41:08'),
(443, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:45:37'),
(444, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:45:46'),
(445, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:45:52');
INSERT INTO `access_logs` (`id`, `ip_address`, `request_url`, `user_agent`, `request_method`, `created_at`) VALUES
(446, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:45:58'),
(447, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:46:12'),
(448, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:48:03'),
(449, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:48:21'),
(450, '10.26.4.40', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:48:37'),
(451, '10.125.141.239', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'GET', '2025-09-01 15:51:10'),
(452, '10.32.39.183', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; 23127PN0CC Build/AQ3A.240627.003; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/15.25 SP-engine/3.51.0 bd_dvt/0 baiduboxapp/15.26.0.10 (Baidu; P1 15) NABar/1.0', 'GET', '2025-09-01 15:51:30'),
(453, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(454, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(455, '172.18.69.86', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(456, '172.18.69.86', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(457, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(458, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(459, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(460, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:32'),
(461, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:33'),
(462, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:33'),
(463, '172.18.69.86', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:48'),
(464, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 15:56:55'),
(465, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:19'),
(466, '10.125.153.47', '/StudyMaterialsWeb1/index.php?logout=true', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:29'),
(467, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:30'),
(468, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:30'),
(469, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'POST', '2025-09-01 15:58:46'),
(470, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:46'),
(471, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:47'),
(472, '10.125.153.47', '/StudyMaterialsWeb1/admin_blacklist.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:54'),
(473, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:57'),
(474, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:58'),
(475, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:58:59'),
(476, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 15:59:00'),
(477, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=4', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:01:25'),
(478, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:01:26'),
(479, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:02:46'),
(480, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:02:47'),
(481, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 16:03:06'),
(482, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:03:19'),
(483, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:03:28'),
(484, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:03:28'),
(485, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 16:05:50'),
(486, '172.18.69.86', '/StudyMaterialsWeb1/index.php?download=22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-01 16:05:50'),
(487, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:07:40'),
(488, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:07:50'),
(489, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:07:51'),
(490, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:07:51'),
(491, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:07:52'),
(492, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:07:58'),
(493, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:07:59'),
(494, '10.125.153.47', '/StudyMaterialsWeb1/index.php?logout=true', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:01'),
(495, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:01'),
(496, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:01'),
(497, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'POST', '2025-09-01 16:08:06'),
(498, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:06'),
(499, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:07'),
(500, '10.125.153.47', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:14'),
(501, '10.125.153.47', '/StudyMaterialsWeb1/index.php?download=33', 'okhttp/3.14.9', 'HEAD', '2025-09-01 16:08:15'),
(502, '10.125.153.47', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:17'),
(503, '10.125.153.47', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:23'),
(504, '10.125.153.47', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:24'),
(505, '10.125.153.47', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:26'),
(506, '10.125.153.47', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:08:34'),
(507, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 16:09:48'),
(508, '10.125.129.137', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Mobile/15E148 Safari/604.1', 'GET', '2025-09-01 22:35:59'),
(509, '10.125.248.119', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2410DPN6CC Build/AQ3A.240812.002) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.3.70417', 'GET', '2025-09-01 23:07:04'),
(510, '10.125.42.175', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; FIN-AL60; HMSCore 6.15.0.332) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 HuaweiBrowser/16.0.7.301 Mobile Safari/537.36', 'GET', '2025-09-01 23:07:37'),
(511, '10.125.42.175', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; FIN-AL60; HMSCore 6.15.0.332) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 HuaweiBrowser/16.0.7.301 Mobile Safari/537.36', 'GET', '2025-09-01 23:07:38'),
(512, '10.125.42.175', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; FIN-AL60; HMSCore 6.15.0.332) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 HuaweiBrowser/16.0.7.301 Mobile Safari/537.36', 'GET', '2025-09-01 23:08:06'),
(513, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 23:12:41'),
(514, '10.125.153.47', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 23:12:49'),
(515, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 23:12:50'),
(516, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=pending&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 23:12:52'),
(517, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 23:12:52'),
(518, '10.125.153.47', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 23:12:54'),
(519, '10.125.153.47', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-01 23:12:55'),
(520, '10.27.8.143', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; PHK110 Build/AP3A.240617.008; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/15.25 SP-engine/3.50.0 bd_dvt/0 baiduboxapp/15.25.0.11 (Baidu; P1 15) NABar/1.0', 'GET', '2025-09-01 23:40:41'),
(521, '10.27.13.102', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2410DPN6CC Build/AQ3A.240812.002) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.3.70417', 'GET', '2025-09-01 23:41:15'),
(522, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:53:17'),
(523, '10.125.244.167', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36 EdgA/139.0.0.0', 'GET', '2025-09-01 23:53:17'),
(524, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:53:18'),
(525, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:53:45'),
(526, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:53:46'),
(527, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:53:51'),
(528, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:53:51'),
(529, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-01 23:54:30'),
(530, '10.30.45.211', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Mobile/15E148 Safari/604.1', 'GET', '2025-09-01 23:55:00'),
(531, '10.30.46.118', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; PKB110 Build/AP3A.240617.008) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/115.0.5790.168 Mobile Safari/537.36 HeyTapBrowser/40.10.1.1', 'GET', '2025-09-01 23:57:02'),
(532, '10.30.46.118', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; PKB110 Build/AP3A.240617.008) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/115.0.5790.168 Mobile Safari/537.36 HeyTapBrowser/40.10.1.1', 'GET', '2025-09-01 23:57:03'),
(533, '10.30.46.118', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; PKB110 Build/AP3A.240617.008) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/115.0.5790.168 Mobile Safari/537.36 HeyTapBrowser/40.10.1.1', 'GET', '2025-09-01 23:57:04'),
(534, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:57:43'),
(535, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:57:44'),
(536, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'POST', '2025-09-01 23:58:17'),
(537, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:58:17'),
(538, '10.32.51.145', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:58:22'),
(539, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-01 23:58:26'),
(540, '10.30.32.250', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) EdgiOS/139.0.3405.111 Version/18.0 Mobile/15E148 Safari/604.1', 'GET', '2025-09-02 00:01:14'),
(541, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:02:54'),
(542, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:02:56'),
(543, '10.32.51.145', '/StudyMaterialsWeb1/index.php?logout=true', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:17'),
(544, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:17'),
(545, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:18'),
(546, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'POST', '2025-09-02 00:03:24'),
(547, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:24'),
(548, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(549, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(550, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(551, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(552, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(553, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(554, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(555, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:03:37'),
(556, '10.30.45.160', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; HBN-AL80; HMSCore 6.15.0.332) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 HuaweiBrowser/16.0.7.301 Mobile Safari/537.36', 'GET', '2025-09-02 00:04:25'),
(557, '10.30.45.160', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; HBN-AL80; HMSCore 6.15.0.332) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 HuaweiBrowser/16.0.7.301 Mobile Safari/537.36', 'GET', '2025-09-02 00:04:49'),
(558, '10.30.45.160', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; HBN-AL80; HMSCore 6.15.0.332) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 HuaweiBrowser/16.0.7.301 Mobile Safari/537.36', 'GET', '2025-09-02 00:04:50'),
(559, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:09:19'),
(560, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:09:32'),
(561, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=36', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:09:48'),
(562, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=36', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:09:51'),
(563, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=34', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:09:55'),
(564, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=34', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:09:57'),
(565, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:10:01'),
(566, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=33', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:10:02'),
(567, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:10:39'),
(568, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:10:41'),
(569, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(570, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(571, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(572, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(573, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(574, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(575, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(576, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(577, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(578, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(579, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(580, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(581, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(582, '10.30.76.36', '/StudyMaterialsWeb1/index.php?download=13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(583, '10.30.76.36', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:19:49'),
(584, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 00:23:02'),
(585, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 00:23:20'),
(586, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 00:23:21'),
(587, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=pending', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 00:23:27'),
(588, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:23:43'),
(589, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:24:17'),
(590, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:24:17'),
(591, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:24:17'),
(592, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:24:17'),
(593, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:24:17'),
(594, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:24:17'),
(595, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:29:18'),
(596, '10.30.88.126', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:29:45'),
(597, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=35', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:30:35'),
(598, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=35', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:30:37'),
(599, '10.32.51.145', '/StudyMaterialsWeb1/index.php?download=47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:30:45'),
(600, '10.32.51.145', '/StudyMaterialsWeb1/index.php?download=47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:30:46'),
(601, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=30', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:30:46'),
(602, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=30', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:30:48'),
(603, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=29', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:30:58'),
(604, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=29', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:00'),
(605, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=27', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:05'),
(606, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=27', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:06'),
(607, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:31:10'),
(608, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=25', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:11'),
(609, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=22', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:19'),
(610, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=25', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:22'),
(611, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=19', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:26'),
(612, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:31'),
(613, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=22', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:33'),
(614, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:40'),
(615, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=19', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:46'),
(616, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=15', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:48'),
(617, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=14', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:52'),
(618, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=13', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:55'),
(619, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=12', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:31:59'),
(620, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=11', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:32:02'),
(621, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:32:26'),
(622, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:32:40');
INSERT INTO `access_logs` (`id`, `ip_address`, `request_url`, `user_agent`, `request_method`, `created_at`) VALUES
(623, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=15', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:33:32'),
(624, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=14', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:35:13'),
(625, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=13', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:35:13'),
(626, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=12', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:35:28'),
(627, '10.30.88.126', '/StudyMaterialsWeb1/index.php?download=11', 'Mozilla/5.0 (Linux; Android 15; ELI-AN00 Build/HONORELI-AN00;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/13.38 SP-engine/2.76.0 languageType/0 bdh_dvt/0 bdh_de/0 bdh_ds/0 bdapp/1.0 (bdhonorbrowser; bdhonorbrowser) bdhonorbrowser/9.3.0.3 (P1 15) NABar/1.0', 'GET', '2025-09-02 00:35:53'),
(628, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 00:38:25'),
(629, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 01:03:00'),
(630, '10.30.88.157', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 12; DBR-W10 Build/HUAWEIDBR-W10; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/15.19 BDOS/1.0 (HarmonyOS 3.0.0) SP-engine/3.48.0 bd_dvt/1 baiduboxapp/15.22.0.10 (Baidu; P1 12) NABar/1.0', 'GET', '2025-09-02 02:06:03'),
(631, '10.32.51.145', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', 'GET', '2025-09-02 02:16:16'),
(632, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:35'),
(633, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:36'),
(634, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:45'),
(635, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:46'),
(636, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'POST', '2025-09-02 02:40:56'),
(637, '10.30.81.2', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:56'),
(638, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:57'),
(639, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=pending&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:58'),
(640, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:40:59'),
(641, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:41:00'),
(642, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 02:41:00'),
(643, '10.32.48.231', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; V2243A Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/97.0.4692.98 Mobile Safari/537.36 T7/15.25 SP-engine/3.51.0 bd_dvt/0 baiduboxapp/15.26.0.10 (Baidu; P1 15) NABar/1.0', 'GET', '2025-09-02 03:07:54'),
(644, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:14:49'),
(645, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:14:53'),
(646, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:14:55'),
(647, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=4', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:15:19'),
(648, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:15:19'),
(649, '10.30.81.2', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:16:04'),
(650, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:16:05'),
(651, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=pending&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:16:05'),
(652, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:16:06'),
(653, '10.30.81.2', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:16:07'),
(654, '10.30.81.2', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 03:16:07'),
(655, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:22:05'),
(656, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 04:22:19'),
(657, '10.26.4.40', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 04:22:23'),
(658, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:22:26'),
(659, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 04:22:51'),
(660, '10.26.4.40', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 04:22:52'),
(661, '10.26.4.40', '/StudyMaterialsWeb1/index.php?status=approved&search=', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 04:22:53'),
(662, '10.26.4.40', '/StudyMaterialsWeb1/index.php?check_username=2244823654%40qq.com', 'Mozilla/5.0 (Linux; U; Android 15; zh-cn; 2211133C Build/AQ3A.240912.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.119 Mobile Safari/537.36 XiaoMi/MiuiBrowser/19.9.500725', 'GET', '2025-09-02 04:22:54'),
(663, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:22:55'),
(664, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:22:56'),
(665, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:22:57'),
(666, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:23:09'),
(667, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:23:09'),
(668, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'POST', '2025-09-02 04:23:20'),
(669, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:23:20'),
(670, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:36:24'),
(671, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; 2211133C Build/AQ3A.240912.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/121.0.6167.71 MQQBrowser/6.2 TBS/047907 Mobile Safari/537.36 V1_AND_SQ_9.2.10_11310_YYB_D QQ/9.2.10.29175 NetType/WIFI WebP/0.3.0 AppId/537309843 Pixel/1080 StatusBarHeight/104 SimpleUISwitch/0 QQTheme/1103 StudyMode/0 CurrentMode/0 CurrentFontScale/1.0 GlobalDensityScale/0.9818182 AllowLandscape/false InMagicWin/0', 'GET', '2025-09-02 04:40:45'),
(672, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Linux; Android 15; 2211133C Build/AQ3A.240912.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/121.0.6167.71 MQQBrowser/6.2 TBS/047907 Mobile Safari/537.36 V1_AND_SQ_9.2.10_11310_YYB_D QQ/9.2.10.29175 NetType/WIFI WebP/0.3.0 AppId/537309843 Pixel/1080 StatusBarHeight/104 SimpleUISwitch/0 QQTheme/1103 StudyMode/0 CurrentMode/0 CurrentFontScale/1.0 GlobalDensityScale/0.9818182 AllowLandscape/false InMagicWin/0', 'GET', '2025-09-02 04:40:50'),
(673, '10.26.4.40', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 04:41:29'),
(674, '10.125.43.177', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36 QuarkPC/4.3.5.483', 'GET', '2025-09-02 05:19:31'),
(675, '10.125.43.177', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:19:37'),
(676, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:19:48'),
(677, '10.125.43.177', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:21:20'),
(678, '10.32.75.217', '/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:21:22'),
(679, '10.125.43.177', '/StudyMaterialsWeb1/index.php?status=approved', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:21:30'),
(680, '10.125.43.177', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:21:31'),
(681, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:21:49'),
(682, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:21:58'),
(683, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:22:00'),
(684, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:22:15'),
(685, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:22:18'),
(686, '10.125.43.177', '/StudyMaterialsWeb1/index.php?status=approved&search=&categories%5B%5D=4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:22:26'),
(687, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:22:32'),
(688, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(689, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(690, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(691, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(692, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(693, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(694, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(695, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(696, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(697, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(698, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(699, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(700, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(701, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(702, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(703, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(704, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(705, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(706, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(707, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(708, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:25:57'),
(709, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:26:22'),
(710, '10.27.194.125', '/StudyMaterialsWeb1/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:29'),
(711, '10.27.194.125', '/StudyMaterialsWeb1/index.php?check_username=xia', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:34'),
(712, '10.27.194.125', '/StudyMaterialsWeb1/index.php?check_username=xiao', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:34'),
(713, '10.27.194.125', '/StudyMaterialsWeb1/index.php?check_username=xiao%27x', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:34'),
(714, '10.27.194.125', '/StudyMaterialsWeb1/index.php?check_username=xiao%27xi', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:34'),
(715, '10.27.194.125', '/StudyMaterialsWeb1/index.php?check_username=xiao%27xia', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:35'),
(716, '10.27.194.125', '/StudyMaterialsWeb1/index.php?check_username=xiao%27xian', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:35'),
(717, '10.27.194.125', '/StudyMaterialsWeb1/index.php?check_username=xiao%27xiang', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:35'),
(718, '10.27.194.125', '/StudyMaterialsWeb1/index.php?download=18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', 'GET', '2025-09-02 05:28:59'),
(719, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(720, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(721, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(722, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(723, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(724, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(725, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(726, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(727, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52'),
(728, '10.125.43.177', '/StudyMaterialsWeb1/index.php?download=20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'GET', '2025-09-02 05:30:52');

-- --------------------------------------------------------

--
-- 表的结构 `categories`
--

CREATE TABLE `categories` (
  `id` int(6) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`) VALUES
(1, '大一上', '2025-08-29 00:58:01'),
(2, '大一下', '2025-08-29 00:58:01'),
(3, '大一小学期', '2025-08-29 00:58:01'),
(4, '大二上', '2025-08-29 00:58:01'),
(5, '大二下', '2025-08-29 00:58:01'),
(6, '大二小学期', '2025-08-29 00:58:01'),
(7, '大三上', '2025-08-29 00:58:01'),
(8, '大三下', '2025-08-29 00:58:01'),
(9, '大三小学期', '2025-08-29 00:58:01'),
(10, '大四上', '2025-08-29 00:58:01'),
(11, '大四下', '2025-08-29 00:58:01'),
(12, '电科', '2025-08-29 00:58:01'),
(13, '电工', '2025-08-29 00:58:01'),
(14, '微电子', '2025-08-29 00:58:01'),
(15, '集成', '2025-08-29 00:58:01'),
(16, '电磁', '2025-08-29 00:58:01'),
(17, '生活', '2025-08-29 00:58:01'),
(18, '其它', '2025-08-29 00:58:01'),
(19, '妙妙工具', '2025-08-29 00:58:01'),
(20, '竞赛', '2025-08-29 00:58:01'),
(21, '软件', '2025-08-29 00:58:01'),
(22, '硬件', '2025-08-29 00:58:01'),
(23, 'PCB', '2025-08-29 00:58:01'),
(24, 'HDL', '2025-08-29 00:58:01'),
(25, '编程', '2025-08-29 00:58:01'),
(26, '合集', '2025-08-29 00:58:01');

-- --------------------------------------------------------

--
-- 表的结构 `ip_blacklist`
--

CREATE TABLE `ip_blacklist` (
  `id` int(6) UNSIGNED NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `materials`
--

CREATE TABLE `materials` (
  `id` int(6) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `filename` varchar(255) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploader_id` int(6) UNSIGNED DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `download_count` int(11) DEFAULT '0',
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewer_id` int(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `materials`
--

INSERT INTO `materials` (`id`, `title`, `description`, `filename`, `original_name`, `file_size`, `uploader_id`, `status`, `download_count`, `uploaded_at`, `reviewed_at`, `reviewer_id`) VALUES
(10, 'MATLAB编程', '电科大二上的MATLAB必修课', '68b5ae03eb684.zip', 'matlab.zip', 321503655, 0, 'approved', 1, '2025-09-01 14:30:28', '2025-09-01 14:39:24', 0),
(11, '大物实验', '大物实验的实验报告', '68b5ae92d2a95.zip', '大物实验.zip', 221814714, 0, 'approved', 4, '2025-09-01 14:32:50', '2025-09-01 14:39:22', 0),
(12, '电气实训', '电气实训', '68b5aece0757a.zip', '电器实训.zip', 50221938, 0, 'approved', 4, '2025-09-01 14:33:50', '2025-09-01 14:39:21', 0),
(13, '大学物理（下）', '大学物理（下）', '68b5af7ec7b40.zip', '大学物理(下).zip', 34765739, 0, 'approved', 5, '2025-09-01 14:36:46', '2025-09-01 14:39:20', 0),
(14, '大物下答案', '大物下答案', '68b5afa767673.zip', '大物下答案.zip', 1233368, 0, 'approved', 4, '2025-09-01 14:37:27', '2025-09-01 14:39:19', 0),
(15, '电子线路', '电子线路', '68b5afefc0a0d.zip', '电子线路.zip', 174990559, 0, 'approved', 4, '2025-09-01 14:38:39', '2025-09-01 14:39:18', 0),
(16, '模电实验', '模电实验电科的哦', '68b5b08e37d78.zip', '模电实验.zip', 649110849, 0, 'approved', 8, '2025-09-01 14:41:18', '2025-09-01 14:44:38', 0),
(17, '数电', '数电', '68b5b0be8f824.zip', '数电.zip', 537063573, 0, 'approved', 8, '2025-09-01 14:42:06', '2025-09-01 14:44:37', 0),
(18, '数学物理方法', '数学物理方法', '68b5b0cf9b657.zip', '数学物理方法.zip', 52233660, 0, 'approved', 8, '2025-09-01 14:42:23', '2025-09-01 14:44:36', 0),
(19, '大二教材', '大二教材', '68b5b1427ccb4.zip', '大二教材.zip', 717288975, 0, 'approved', 7, '2025-09-01 14:44:18', '2025-09-01 14:44:35', 0),
(20, '电科大二各种实验报告', '电科大二各种实验报告', '68b5b27b9f97b.zip', '大二各种实验报告.zip', 1783152029, 0, 'approved', 10, '2025-09-01 14:49:32', '2025-09-01 14:50:20', 0),
(21, '大二上期中复习资料（办公室出品）', '大二上期中复习资料（办公室出品）', '68b5b2981b2b9.zip', '大二上期中复习资料（办公室出品）.zip', 178591030, 0, 'approved', 26, '2025-09-01 14:50:00', '2025-09-01 14:50:18', 0),
(22, '电子线路实验', '电子线路实验', '68b5b33b76e15.zip', '电子线路实验.zip', 287251398, 0, 'approved', 4, '2025-09-01 14:52:43', '2025-09-01 14:59:35', 0),
(23, '固体电子学', '固体电子学', '68b5b3525ea92.zip', '固体电子学.zip', 186728, 0, 'approved', 0, '2025-09-01 14:53:06', '2025-09-01 14:59:35', 0),
(24, '光学', '光学', '68b5b378edec3.zip', '光学.zip', 19864224, 0, 'approved', 0, '2025-09-01 14:53:44', '2025-09-01 14:59:34', 0),
(25, '电磁场与电磁波', '电磁场与电磁波', '68b5b3b765b64.zip', '电磁场与电磁波.zip', 213471434, 0, 'approved', 2, '2025-09-01 14:54:47', '2025-09-01 14:59:33', 0),
(26, '电磁场与电磁波实验', '电磁场与电磁波实验', '68b5b3eab3907.zip', '电磁场与电磁波实验.zip', 342445409, 0, 'approved', 0, '2025-09-01 14:55:38', '2025-09-01 14:59:33', 0),
(27, '电子设计实训', '电子设计实训', '68b5b40b5899e.zip', '电子设计实训.zip', 96159513, 0, 'approved', 2, '2025-09-01 14:56:11', '2025-09-01 14:59:32', 0),
(28, '电子线路实验2', '电子线路实验2 模电高频实验', '68b5b43bdc489.zip', '电子线路实验2.zip', 86096970, 0, 'approved', 0, '2025-09-01 14:56:59', '2025-09-01 14:59:31', 0),
(29, '概统', '概统', '68b5b457a97ae.zip', '概统.zip', 95222107, 0, 'approved', 7, '2025-09-01 14:57:27', '2025-09-01 15:23:37', 0),
(30, '金工实训', '金工实训', '68b5b46cafa2b.zip', '金工实训.zip', 208012, 0, 'approved', 6, '2025-09-01 14:57:48', '2025-09-01 14:59:30', 0),
(31, '军理', '军理', '68b5b4b0125c2.zip', '军理.zip', 65297735, 0, 'approved', 2, '2025-09-01 14:58:56', '2025-09-01 15:23:37', 0),
(32, '模电高频', '模电高频', '68b5b5bc32427.zip', '模电高频.zip', 1542417345, 0, 'approved', 2, '2025-09-01 15:03:24', '2025-09-01 15:06:19', 0),
(33, '数电实验', '数电实验', '68b5b623939eb.zip', '数电实验.zip', 1339126370, 0, 'approved', 9, '2025-09-01 15:05:07', '2025-09-01 15:06:18', 0),
(34, '习概', '习概', '68b5b63326a43.zip', '习概.zip', 53448086, 0, 'approved', 3, '2025-09-01 15:05:23', '2025-09-01 15:06:17', 0),
(35, '信号与系统', '信号与系统', '68b5b661bbab4.zip', '信号与系统.zip', 155490353, 0, 'approved', 2, '2025-09-01 15:06:09', '2025-09-01 15:06:16', 0),
(36, '信号与系统实验', '信号与系统实验', '68b5b6b29539d.zip', '信号与系统实验.zip', 544333171, 0, 'approved', 2, '2025-09-01 15:07:30', '2025-09-01 15:09:04', 0),
(37, 'C语言', 'C语言', '68b5b779e9482.zip', 'C语言.zip', 4243264, 0, 'approved', 0, '2025-09-01 15:10:49', '2025-09-01 15:11:44', 0),
(38, '创意电子', '创意电子', '68b5b800cda15.zip', '创意电子.zip', 1034858955, 0, 'approved', 0, '2025-09-01 15:13:05', '2025-09-01 15:14:23', 0),
(39, '大学物理上', '大学物理上', '68b5b8231db7a.zip', '大学物理.zip', 99633433, 0, 'approved', 0, '2025-09-01 15:13:39', '2025-09-01 15:14:21', 0),
(40, '电路分析', '电路分析', '68b5b8368d7bf.zip', '电路分析.zip', 60165176, 0, 'approved', 1, '2025-09-01 15:13:58', '2025-09-01 15:14:20', 0),
(41, '高数上', '高数上 微积分', '68b5b87fe8e50.zip', '高数.zip', 406359002, 0, 'approved', 1, '2025-09-01 15:15:12', '2025-09-01 15:15:33', 0),
(42, '高数强化校选', '高数强化校选', '68b5b88b55184.zip', '高数强化校选.zip', 33657273, 0, 'approved', 0, '2025-09-01 15:15:23', '2025-09-01 15:15:32', 0),
(43, '高数下', '高数下 微积分下', '68b5b9137bb6a.zip', '高数下.zip', 783584046, 0, 'approved', 0, '2025-09-01 15:17:39', '2025-09-01 15:18:18', 0),
(44, '机械制图', '机械制图', '68b5b92dea735.zip', '机械制图.zip', 69154296, 0, 'approved', 0, '2025-09-01 15:18:05', '2025-09-01 15:18:17', 0),
(45, '近现代史纲要', '近现代史纲要', '68b5b98d1c74d.zip', '近现代史纲要.zip', 946122020, 0, 'approved', 0, '2025-09-01 15:19:41', '2025-09-01 15:20:14', 0),
(46, '思修', '思修', '68b5b9a5a6e2f.zip', '思修.zip', 34928982, 0, 'approved', 1, '2025-09-01 15:20:05', '2025-09-01 15:20:13', 0),
(47, '线性代数', '线性代数', '68b5bb3ef155e.zip', '线性代数.zip', 111408939, 0, 'approved', 3, '2025-09-01 15:26:55', '2025-09-01 15:27:21', 0),
(48, '新生研讨课总结', '新生研讨课总结', '68b5bc4903409.zip', '新生研讨课总结.zip', 46024261, 0, 'approved', 3, '2025-09-01 15:31:21', '2025-09-01 15:31:58', 0);

-- --------------------------------------------------------

--
-- 表的结构 `material_categories`
--

CREATE TABLE `material_categories` (
  `material_id` int(6) UNSIGNED NOT NULL,
  `category_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `material_categories`
--

INSERT INTO `material_categories` (`material_id`, `category_id`) VALUES
(10, 4),
(10, 12),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 4),
(16, 12),
(17, 4),
(18, 4),
(19, 4),
(20, 4),
(20, 12),
(21, 4),
(22, 5),
(22, 13),
(22, 14),
(22, 15),
(23, 5),
(23, 14),
(24, 5),
(24, 13),
(25, 5),
(26, 5),
(26, 12),
(26, 16),
(27, 6),
(28, 5),
(28, 12),
(28, 16),
(29, 5),
(29, 12),
(29, 13),
(29, 14),
(29, 15),
(29, 16),
(30, 5),
(31, 5),
(31, 12),
(31, 13),
(31, 14),
(31, 15),
(31, 16),
(32, 5),
(33, 5),
(33, 12),
(33, 16),
(34, 5),
(35, 5),
(36, 5),
(37, 1),
(38, 1),
(39, 2),
(40, 1),
(41, 1),
(42, 2),
(43, 2),
(44, 1),
(45, 2),
(46, 1),
(47, 1),
(48, 1);

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` int(6) UNSIGNED NOT NULL,
  `username` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(0, '方智凡', '2244823654@qq.com', '$2y$10$sQkyf1glzm9qcyIY5BPsteXPXY8.FqtDLXbKTxWXvf11Eq/DzRzfa', 'admin', '2025-09-01 14:22:38'),
(138, '隐猫', '1580477671@qq.com', '$2y$10$W37C0Mo8wa8XpxGJvHKIxu6vYx779p9Eurob7BFIiUejPKM66NwR2', 'admin', '2025-09-01 15:40:42');

--
-- 转储表的索引
--

--
-- 表的索引 `access_logs`
--
ALTER TABLE `access_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ip` (`ip_address`),
  ADD KEY `idx_created` (`created_at`);

--
-- 表的索引 `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `ip_blacklist`
--
ALTER TABLE `ip_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip_address` (`ip_address`);

--
-- 表的索引 `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviewer_id` (`reviewer_id`),
  ADD KEY `idx_materials_status` (`status`),
  ADD KEY `idx_materials_uploader` (`uploader_id`),
  ADD KEY `idx_materials_uploaded_at` (`uploaded_at`);

--
-- 表的索引 `material_categories`
--
ALTER TABLE `material_categories`
  ADD PRIMARY KEY (`material_id`,`category_id`),
  ADD KEY `idx_material_categories_material` (`material_id`),
  ADD KEY `idx_material_categories_category` (`category_id`);

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `access_logs`
--
ALTER TABLE `access_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=729;

--
-- 使用表AUTO_INCREMENT `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- 使用表AUTO_INCREMENT `ip_blacklist`
--
ALTER TABLE `ip_blacklist`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- 限制导出的表
--

--
-- 限制表 `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`uploader_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `materials_ibfk_2` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- 限制表 `material_categories`
--
ALTER TABLE `material_categories`
  ADD CONSTRAINT `material_categories_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `material_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
