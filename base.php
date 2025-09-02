<?php
session_start();
$servername = "******";
$username = "******";
$password = "******";
$dbname = "******";

// 创建数据库连接
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}

// 设置字符集
$conn->set_charset("utf8");

// 获取客户端IP地址
function getClientIP() {
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        return $_SERVER['HTTP_CLIENT_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        return $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else {
        return $_SERVER['REMOTE_ADDR'];
    }
}

$client_ip = getClientIP();

// 创建必要的数据库表（如果不存在）
$sql = "CREATE TABLE IF NOT EXISTS users (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";

if (!$conn->query($sql)) {
    die("创建用户表错误: " . $conn->error);
}

// 创建分类表
$sql = "CREATE TABLE IF NOT EXISTS categories (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";

if (!$conn->query($sql)) {
    die("创建分类表错误: " . $conn->error);
}

$sql = "CREATE TABLE IF NOT EXISTS materials (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    filename VARCHAR(255) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    file_size BIGINT,
    uploader_id INT(6) UNSIGNED,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    download_count INT DEFAULT 0,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_at TIMESTAMP NULL,
    reviewer_id INT(6) UNSIGNED NULL,
    FOREIGN KEY (uploader_id) REFERENCES users(id),
    FOREIGN KEY (reviewer_id) REFERENCES users(id)
)";

if (!$conn->query($sql)) {
    die("创建资料表错误: " . $conn->error);
}

// 创建资料分类关联表
$sql = "CREATE TABLE IF NOT EXISTS material_categories (
    material_id INT(6) UNSIGNED,
    category_id INT(6) UNSIGNED,
    PRIMARY KEY (material_id, category_id),
    FOREIGN KEY (material_id) REFERENCES materials(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
)";

if (!$conn->query($sql)) {
    die("创建资料分类关联表错误: " . $conn->error);
}

// 创建IP黑名单表
$sql = "CREATE TABLE IF NOT EXISTS ip_blacklist (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ip_address VARCHAR(45) NOT NULL UNIQUE,
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NULL
)";

if (!$conn->query($sql)) {
    die("创建IP黑名单表错误: " . $conn->error);
}

// 创建访问日志表
$sql = "CREATE TABLE IF NOT EXISTS access_logs (
    id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ip_address VARCHAR(45) NOT NULL,
    request_url VARCHAR(255) NOT NULL,
    user_agent TEXT,
    request_method VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_ip (ip_address),
    INDEX idx_created (created_at)
)";

if (!$conn->query($sql)) {
    die("创建访问日志表错误: " . $conn->error);
}

// 检查IP是否在黑名单中
function isIPBlacklisted($ip, $conn) {
    $stmt = $conn->prepare("SELECT id, expires_at FROM ip_blacklist WHERE ip_address = ? AND (expires_at IS NULL OR expires_at > NOW())");
    $stmt->bind_param("s", $ip);
    $stmt->execute();
    $result = $stmt->get_result();
    $is_blacklisted = $result->num_rows > 0;
    $stmt->close();
    
    return $is_blacklisted;
}

// 记录访问日志
function logAccess($ip, $conn) {
    $url = $_SERVER['REQUEST_URI'];
    $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? '';
    $method = $_SERVER['REQUEST_METHOD'];
    
    $stmt = $conn->prepare("INSERT INTO access_logs (ip_address, request_url, user_agent, request_method) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $ip, $url, $user_agent, $method);
    $stmt->execute();
    $stmt->close();
}

// 检测异常行为
function detectAbnormalBehavior($ip, $conn) {
    $abnormal = false;
    $reason = '';
    
    // 检查过去5分钟内同一IP的注册尝试次数
    $stmt = $conn->prepare("SELECT COUNT(*) as attempt_count FROM access_logs 
                           WHERE ip_address = ? 
                           AND request_url LIKE '%register%' 
                           AND created_at > DATE_SUB(NOW(), INTERVAL 5 MINUTE)");
    $stmt->bind_param("s", $ip);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $stmt->close();
    
    if ($row['attempt_count'] > 5) { // 5分钟内超过5次注册尝试
        $abnormal = true;
        $reason = "5分钟内注册尝试次数过多: " . $row['attempt_count'] . "次";
    }
    
    // 检查过去1分钟内同一IP的请求频率
    $stmt = $conn->prepare("SELECT COUNT(*) as request_count FROM access_logs 
                           WHERE ip_address = ? 
                           AND created_at > DATE_SUB(NOW(), INTERVAL 1 MINUTE)");
    $stmt->bind_param("s", $ip);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $stmt->close();
    
    if ($row['request_count'] > 60) { // 1分钟内超过60次请求
        $abnormal = true;
        $reason = "1分钟内请求频率过高: " . $row['request_count'] . "次";
    }
    
    return ['abnormal' => $abnormal, 'reason' => $reason];
}

// 将IP加入黑名单
function addToBlacklist($ip, $reason, $conn, $hours = 24) {
    $expires = date('Y-m-d H:i:s', strtotime("+{$hours} hours"));
    
    $stmt = $conn->prepare("INSERT INTO ip_blacklist (ip_address, reason, expires_at) VALUES (?, ?, ?)
                           ON DUPLICATE KEY UPDATE reason = ?, expires_at = ?");
    $stmt->bind_param("sssss", $ip, $reason, $expires, $reason, $expires);
    $stmt->execute();
    $stmt->close();
}

// 获取黑名单IP列表
function getBlacklistIPs($conn) {
    $blacklist = [];
    $sql = "SELECT * FROM ip_blacklist ORDER BY created_at DESC";
    $result = $conn->query($sql);
    
    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $blacklist[] = $row;
        }
    }
    
    return $blacklist;
}

// 从黑名单中移除IP
function removeFromBlacklist($ip, $conn) {
    $stmt = $conn->prepare("DELETE FROM ip_blacklist WHERE ip_address = ?");
    $stmt->bind_param("s", $ip);
    $result = $stmt->execute();
    $stmt->close();
    
    return $result;
}

// 处理解禁请求
if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') {
    if (isset($_POST['unban_ip'])) {
        $ip_to_unban = trim($_POST['ip_address']);
        if (filter_var($ip_to_unban, FILTER_VALIDATE_IP)) {
            if (removeFromBlacklist($ip_to_unban, $conn)) {
                $unban_message = "IP地址 {$ip_to_unban} 已成功解禁";
            } else {
                $unban_message = "解禁失败，请重试";
            }
        } else {
            $unban_message = "无效的IP地址";
        }
    }
}

// 获取黑名单列表
$blacklist_ips = [];
if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') {
    $blacklist_ips = getBlacklistIPs($conn);
}

// 记录访问日志
logAccess($client_ip, $conn);

// 检查IP是否在黑名单中
if (isIPBlacklisted($client_ip, $conn)) {
    http_response_code(403);
    die("您的IP已被封禁，如有疑问请联系管理员。");
}

// 检测异常行为（仅在关键操作时检测，如注册、登录等）
$should_check_abnormal = false;
if ($_SERVER['REQUEST_METHOD'] == 'POST' && 
    (isset($_POST['register']) || isset($_POST['login']) || isset($_POST['upload']))) {
    $should_check_abnormal = true;
}

if ($should_check_abnormal) {
    $abnormal_check = detectAbnormalBehavior($client_ip, $conn);
    if ($abnormal_check['abnormal']) {
        addToBlacklist($client_ip, $abnormal_check['reason'], $conn, 24);
        http_response_code(403);
        die("检测到异常行为，您的IP已被暂时封禁。");
    }
}


// 处理用户登录
$login_error = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['login'])) {
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);
    
    $stmt = $conn->prepare("SELECT id, username, password, role FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['role'] = $user['role'];
            header("Location: " . $_SERVER['PHP_SELF']);
            exit();
        } else {
            $login_error = "邮箱不存在或密码错误";
        }
    } else {
        $login_error = "邮箱不存在或密码错误";
    }
    $stmt->close();
}

// 处理用户注册
$register_error = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['register'])) {
    $username = trim($_POST['username']);
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);
    $confirm_password = trim($_POST['confirm_password']);
    
    if ($password !== $confirm_password) {
        $register_error = "密码确认不匹配";
    } else {
        // 检查邮箱是否已存在
        $stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            $register_error = "邮箱已被注册";
        } else {
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $conn->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $username, $email, $hashed_password);
            
            if ($stmt->execute()) {
                // 自动登录
                $_SESSION['user_id'] = $stmt->insert_id;
                $_SESSION['username'] = $username;
                $_SESSION['role'] = 'user';
                header("Location: " . $_SERVER['PHP_SELF']);
                exit();
            } else {
                $register_error = "注册失败，请稍后再试";
            }
        }
        $stmt->close();
    }
}

// 处理文件上传
$upload_message = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['upload']) && isset($_SESSION['user_id'])) {
    $title = trim($_POST['title']);
    $description = trim($_POST['description']);
    $selected_categories = isset($_POST['categories']) ? $_POST['categories'] : [];
    
    if (!empty($title) && isset($_FILES['file']) && $_FILES['file']['error'] == UPLOAD_ERR_OK) {
        // 文件上传处理
        $upload_dir = "uploads/";
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);
        }
        
        $original_name = basename($_FILES['file']['name']);
        $file_ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
        $filename = uniqid() . '.' . $file_ext;
        $file_path = $upload_dir . $filename;
        $file_size = $_FILES['file']['size'];
        
        if (move_uploaded_file($_FILES['file']['tmp_name'], $file_path)) {
            // 保存到数据库
            $stmt = $conn->prepare("INSERT INTO materials (title, description, filename, original_name, file_size, uploader_id) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssssii", $title, $description, $filename, $original_name, $file_size, $_SESSION['user_id']);
            
            if ($stmt->execute()) {
                $material_id = $stmt->insert_id;
                
                // 保存分类信息
                if (!empty($selected_categories)) {
                    foreach ($selected_categories as $category_id) {
                        $category_stmt = $conn->prepare("INSERT INTO material_categories (material_id, category_id) VALUES (?, ?)");
                        $category_stmt->bind_param("ii", $material_id, $category_id);
                        $category_stmt->execute();
                        $category_stmt->close();
                    }
                }
                
                $upload_message = "文件上传成功，等待管理员审核";
            } else {
                $upload_message = "数据库保存失败";
                unlink($file_path); // 删除已上传的文件
            }
            $stmt->close();
        } else {
            $upload_message = "文件上传失败";
        }
    } else {
        $upload_message = "请填写标题并选择文件";
    }
}

// 处理文件下载
if (isset($_GET['download']) && is_numeric($_GET['download'])) {
    $material_id = $_GET['download'];
    
    // 管理员可以下载任何状态的文件，普通用户只能下载已审核的文件
    if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') {
        $stmt = $conn->prepare("SELECT filename, original_name FROM materials WHERE id = ?");
    } else {
        $stmt = $conn->prepare("SELECT filename, original_name FROM materials WHERE id = ? AND status = 'approved'");
    }
    
    $stmt->bind_param("i", $material_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows == 1) {
        $material = $result->fetch_assoc();
        $file_path = "uploads/" . $material['filename'];
        
        if (file_exists($file_path)) {
            // 更新下载次数
            $conn->query("UPDATE materials SET download_count = download_count + 1 WHERE id = $material_id");
            
            // 设置下载头
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . $material['original_name'] . '"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file_path));
            readfile($file_path);
            exit;
        }
    }
}

// 处理管理员审核操作
if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') {
    if (isset($_POST['approve'])) {
        $material_id = $_POST['material_id'];
        $conn->query("UPDATE materials SET status = 'approved', reviewed_at = NOW(), reviewer_id = {$_SESSION['user_id']} WHERE id = $material_id");
    } elseif (isset($_POST['reject'])) {
        $material_id = $_POST['material_id'];
        $conn->query("UPDATE materials SET status = 'rejected', reviewed_at = NOW(), reviewer_id = {$_SESSION['user_id']} WHERE id = $material_id");
    }
}

// 处理管理员删除操作
if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') {
    if (isset($_POST['delete'])) {
        $material_id = $_POST['material_id'];
        
        // 获取文件信息以便删除物理文件
        $stmt = $conn->prepare("SELECT filename FROM materials WHERE id = ?");
        $stmt->bind_param("i", $material_id);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows == 1) {
            $material = $result->fetch_assoc();
            $file_path = "uploads/" . $material['filename'];
            
            // 删除数据库记录
            $delete_stmt = $conn->prepare("DELETE FROM materials WHERE id = ?");
            $delete_stmt->bind_param("i", $material_id);
            
            if ($delete_stmt->execute()) {
                // 删除物理文件
                if (file_exists($file_path)) {
                    unlink($file_path);
                }
                // 删除关联的分类记录
                $conn->query("DELETE FROM material_categories WHERE material_id = $material_id");
                
                // 刷新页面
                header("Location: " . $_SERVER['PHP_SELF']);
                exit();
            }
            $delete_stmt->close();
        }
        $stmt->close();
    }
}

// 获取搜索关键词
$search_keyword = "";
if (isset($_GET['search']) && !empty(trim($_GET['search']))) {
    $search_keyword = trim($_GET['search']);
}

// 获取类别筛选参数
$category_filter = [];
if (isset($_GET['categories']) && is_array($_GET['categories'])) {
    $category_filter = array_map('intval', $_GET['categories']);
}

// 获取所有可用类别
$categories = [];
$sql_categories = "SELECT id, name FROM categories ORDER BY name";
$result_categories = $conn->query($sql_categories);
if ($result_categories && $result_categories->num_rows > 0) {
    while ($row = $result_categories->fetch_assoc()) {
        $categories[] = $row;
    }
}

// 获取资料列表
$materials = [];
$status_filter = isset($_GET['status']) ? $_GET['status'] : 'approved';
$where_clause = "";

if ($status_filter == 'approved') {
    $where_clause = "WHERE m.status = 'approved'";
} elseif ($status_filter == 'pending' && isset($_SESSION['role']) && $_SESSION['role'] == 'admin') {
    $where_clause = "WHERE m.status = 'pending'";
}

// 添加搜索条件
$search_condition = "";
if (!empty($search_keyword)) {
    // 修改这里，添加对类别名的搜索
     $search_condition = " AND (m.title LIKE '%" . $conn->real_escape_string($search_keyword) . "%' 
                          OR m.description LIKE '%" . $conn->real_escape_string($search_keyword) . "%'
                          OR c.name LIKE '%" . $conn->real_escape_string($search_keyword) . "%'
                          OR u.username LIKE '%" . $conn->real_escape_string($search_keyword) . "%')";
    
    // 如果已经有WHERE子句，使用AND连接；如果没有，添加WHERE
    if (empty($where_clause)) {
        $where_clause = "WHERE m.status = 'approved'" . $search_condition;
    } else {
        $where_clause .= $search_condition;
    }
}

// 添加类别筛选条件
$category_condition = "";
if (!empty($category_filter)) {
    $category_ids = implode(",", $category_filter);
    $category_condition = " AND m.id IN (
        SELECT material_id FROM material_categories 
        WHERE category_id IN ($category_ids)
        GROUP BY material_id 
        HAVING COUNT(DISTINCT category_id) = " . count($category_filter) . "
    )";
    
    if (empty($where_clause)) {
        $where_clause = "WHERE m.status = 'approved'" . $category_condition;
    } else {
        $where_clause .= $category_condition;
    }
}

$sql = "SELECT m.*, u.username as uploader_name,
               GROUP_CONCAT(c.name SEPARATOR ', ') as category_names
        FROM materials m 
        LEFT JOIN users u ON m.uploader_id = u.id 
        LEFT JOIN material_categories mc ON m.id = mc.material_id
        LEFT JOIN categories c ON mc.category_id = c.id
        $where_clause 
        GROUP BY m.id
        ORDER BY m.uploaded_at DESC";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $materials[] = $row;
    }
}

// 获取待审核资料数量（管理员用）
$pending_count = 0;
if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') {
    $result = $conn->query("SELECT COUNT(*) as count FROM materials WHERE status = 'pending'");
    if ($result) {
        $row = $result->fetch_assoc();
        $pending_count = $row['count'];
    }
}

// 用户退出
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: " . $_SERVER['PHP_SELF']);
    exit();
}

?>