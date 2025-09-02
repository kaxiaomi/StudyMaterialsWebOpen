<?php
session_start();
$servername = "localhost";
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


// 处理AJAX用户名检查请求
if (isset($_GET['check_username']) && !empty($_GET['check_username'])) {
    $check_username = trim($_GET['check_username']);
    
    $stmt = $conn->prepare("SELECT id FROM users WHERE username = ?");
    $stmt->bind_param("s", $check_username);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        echo 'exists';
    } else {
        echo 'available';
    }
    $stmt->close();
    exit();
}

// 处理用户登录
$login_error = "";
// 保存登录表单数据
$login_email = isset($_POST['email']) ? $_POST['email'] : '';

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
            // 设置自动打开登录模态框的标志
            $_SESSION['show_login_modal'] = true;
            // 保存登录表单数据
            $login_email = $email;
        }
    } else {
        $login_error = "邮箱不存在或密码错误";
        $_SESSION['show_login_modal'] = true;
        $login_email = $email;
    }
    $stmt->close();
}

// 处理用户注册
$register_error = "";
// 保存注册表单数据
$register_username = isset($_POST['username']) ? $_POST['username'] : '';
$register_email = isset($_POST['email']) ? $_POST['email'] : '';

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['register'])) {
    $username = trim($_POST['username']);
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);
    $confirm_password = trim($_POST['confirm_password']);
    
    // 保存注册表单数据
    $register_username = $username;
    $register_email = $email;
    
    if (empty($username) || empty($email) || empty($password)) {
        $register_error = "请填写所有必填字段";
        $_SESSION['show_register_modal'] = true;
    } elseif ($password !== $confirm_password) {
        $register_error = "密码确认不匹配";
        $_SESSION['show_register_modal'] = true;
    } else {
        // 检查用户名是否已存在
        $stmt = $conn->prepare("SELECT id FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            $register_error = "用户名已被使用";
            $_SESSION['show_register_modal'] = true;
            $stmt->close();
        } else {
            $stmt->close();
            
            // 检查邮箱是否已存在
            $stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();
            
            if ($result->num_rows > 0) {
                $register_error = "邮箱已被注册";
                $_SESSION['show_register_modal'] = true;
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
                    $_SESSION['show_register_modal'] = true;
                }
            }
        }
        $stmt->close();
    }
}


// 处理AJAX上传请求
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['ajax_upload']) && isset($_SESSION['user_id'])) {
    // 开启输出缓冲
    ob_start();
    header('Content-Type: application/json');
    
    $title = trim($_POST['title']);
    $description = trim($_POST['description']);
    $selected_categories = isset($_POST['categories']) ? $_POST['categories'] : [];
    
    $response = ['success' => false, 'message' => '未知错误'];
    try {
        if (!empty($title) && isset($_FILES['file']) && $_FILES['file']['error'] == UPLOAD_ERR_OK) {
            // 文件大小检查 - 限制为2GB
            $max_file_size = 2 * 1024 * 1024 * 1024; // 2GB
            $file_size = $_FILES['file']['size'];
            
            if ($file_size > $max_file_size) {
                $response = ['success' => false, 'message' => "文件大小超过2GB限制"];
                ob_end_clean();
                echo json_encode($response);
                exit;
            }
            
            // 文件上传处理
            $upload_dir = "uploads/";
            if (!is_dir($upload_dir)) {
                mkdir($upload_dir, 0777, true);
            }
            
            $original_name = basename($_FILES['file']['name']);
            $file_ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
            $filename = uniqid() . '.' . $file_ext;
            $file_path = $upload_dir . $filename;
            
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
                    
                    $response = ['success' => true, 'message' => "文件上传成功，等待管理员审核"];
                } else {
                    $response = ['success' => false, 'message' => "数据库保存失败"];
                    unlink($file_path); // 删除已上传的文件
                }
                $stmt->close();
            } else {
                $response = ['success' => false, 'message' => "文件上传失败"];
            }
        } else {
            $response = ['success' => false, 'message' => "请填写标题并选择文件"];
        }
    } catch (Exception $e) {
        $response = ['success' => false, 'message' => '服务器错误: ' . $e->getMessage()];
    }
    
    // 清除所有输出缓冲，确保只输出JSON
    ob_end_clean();
    echo json_encode($response);
    exit;
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

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学习资料共享平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 80px 0;
            margin-bottom: 40px;
        }
        .material-card {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .material-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #2575fc;
        }
        .upload-area {
            border: 2px dashed #ccc;
            padding: 2rem;
            text-align: center;
            border-radius: 5px;
            margin-bottom: 1rem;
            transition: border-color 0.3s;
            cursor: pointer;
        }
        .upload-area:hover {
            border-color: #2575fc;
        }
        footer {
            background-color: #f8f9fa;
            padding: 2rem 0;
            margin-top: 3rem;
        }
        .file-size {
            font-size: 0.9rem;
            color: #6c757d;
        }
        .search-form {
            max-width: 500px;
        }
        .search-highlight {
            background-color: yellow;
            font-weight: bold;
        }
        .category-badge {
            cursor: pointer;
            margin: 2px;
        }
        .category-badge.active {
            background-color: #0d6efd !important;
        }
        .category-filter {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .select2-container--default .select2-selection--multiple {
            min-height: 38px;
            border: 1px solid #ced4da;
            border-radius: 0.375rem;
        }
        .category-tag {
            display: inline-block;
            background-color: #e9ecef;
            padding: 0.25em 0.4em;
            margin: 2px;
            border-radius: 0.25rem;
            font-size: 0.875em;
        }
        .file-preview {
            margin-top: 15px;
            padding: 15px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            background-color: #f8f9fa;
        }
        .file-icon {
            font-size: 3rem;
            margin-right: 15px;
            color: #6c757d;
        }
        .file-details {
            flex: 1;
        }
        .file-name {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .file-meta {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .upload-area.dragover {
            border-color: #0d6efd;
            background-color: rgba(13, 110, 253, 0.05);
        }
        .fixed-bottom-right {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }
        .btn-group-sm > .btn, .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
        }
        .material-description {
            display: inline;
            overflow: hidden;
            line-height: 1.5;
        }

        .show-more-link {
            color: #0d6efd;
            text-decoration: none;
            cursor: pointer;
            font-size: 0.9em;
            margin-left: 5px;
        }

        .show-more-link:hover {
            text-decoration: underline;
        }

        .material-description.truncated {
            display: -webkit-box;
            -webkit-line-clamp: 3; /* 限制显示3行 */
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        /* 添加用户名检查反馈样式 */
        .username-feedback {
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .username-available {
            color: #198754;
        }
        .username-taken {
            color: #dc3545;
        }
        .username-checking {
            color: #6c757d;
        }
        /* 上传进度窗口样式 */
        .progress-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }
        
        .progress-content {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            width: 80%;
            max-width: 500px;
            text-align: center;
        }
        
        .progress-bar-container {
            height: 30px;
            background-color: #e9ecef;
            border-radius: 5px;
            margin: 20px 0;
            overflow: hidden;
        }
        
        .progress-bar-fill {
            height: 100%;
            background-color: #0d6efd;
            width: 0%;
            transition: width 0.3s ease;
        }
        
        .progress-text {
            margin-bottom: 15px;
            font-weight: bold;
        }
        
        .progress-details {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .cancel-upload-btn {
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.php">学习资料共享平台</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.php">首页</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.php?status=approved">资料库</a></li>
                    <?php if (isset($_SESSION['user_id'])): ?>
                        <li class="nav-item"><a class="nav-link" href="#upload">上传资料</a></li>
                        <li class="nav-item"><a class="nav-link" href="user_center.php">用户中心</a></li>
                    <?php endif; ?>
                    <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin'): ?>
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="index.php?status=pending">
                                待审核
                                <?php if ($pending_count > 0): ?>
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                        <?php echo $pending_count; ?>
                                    </span>
                                <?php endif; ?>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin_blacklist.php">IP黑名单管理</a>
                        </li>
                    <?php endif; ?>
                </ul>
                
                <!-- 搜索表单 -->
                <form class="d-flex search-form me-3" action="index.php" method="GET">
                    <input type="hidden" name="status" value="<?php echo $status_filter; ?>">
                    <?php foreach ($category_filter as $cat_id): ?>
                        <input type="hidden" name="categories[]" value="<?php echo $cat_id; ?>">
                    <?php endforeach; ?>
                    <input class="form-control me-2" type="search" name="search" placeholder="搜索资料..." 
                           value="<?php echo htmlspecialchars($search_keyword); ?>" aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">搜索</button>
                </form>
                
                <div class="d-flex">
                    <?php if (isset($_SESSION['user_id'])): ?>
                        <span class="navbar-text me-3">欢迎, <?php echo $_SESSION['username']; ?></span>
                        <?php if ($_SESSION['role'] == 'admin'): ?>
                            <span class="navbar-text badge bg-warning me-3">管理员</span>
                        <?php endif; ?>
                        <a class="btn btn-outline-light" href="?logout=true">退出</a>
                    <?php else: ?>
                        <button class="btn btn-outline-light me-2" data-bs-toggle="modal" data-bs-target="#loginModal">登录</button>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerModal">注册</button>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </nav>

    <!-- 英雄区域 -->
    <section class="hero-section text-center">
        <div class="container">
            <h1 class="display-4 fw-bold">共享知识，共同成长</h1>
            <p class="lead">上传、下载、学习——一站式学习资料共享平台</p>
            
            <!-- 主搜索框 -->
            <div class="row justify-content-center mt-4">
                <div class="col-md-8">
                    <form action="index.php" method="GET">
                        <input type="hidden" name="status" value="<?php echo $status_filter; ?>">
                        <?php foreach ($category_filter as $cat_id): ?>
                            <input type="hidden" name="categories[]" value="<?php echo $cat_id; ?>">
                        <?php endforeach; ?>
                        <div class="input-group input-group-lg">
                            <input type="text" class="form-control" name="search" placeholder="搜索学习资料..." 
                                   value="<?php echo htmlspecialchars($search_keyword); ?>">
                            <button class="btn btn-light" type="submit">搜索</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="mt-3">
                <a href="#materials" class="btn btn-light btn-lg mt-3">浏览资料</a>
                <?php if (isset($_SESSION['user_id'])): ?>
                    <a href="#upload" class="btn btn-outline-light btn-lg mt-3">上传资料</a>
                <?php else: ?>
                    <button class="btn btn-outline-light btn-lg mt-3" data-bs-toggle="modal" data-bs-target="#loginModal">上传资料</button>
                <?php endif; ?>
            </div>
        </div>
    </section>

    <!-- 主要内容区 -->
    <div class="container">
        <!-- 显示搜索结果信息 -->
        <?php if (!empty($search_keyword) || !empty($category_filter)): ?>
            <div class="alert alert-info mb-4">
                <h5>
                    <?php if (!empty($search_keyword) && !empty($category_filter)): ?>
                        搜索: "<?php echo htmlspecialchars($search_keyword); ?>" 在选定的类别中
                    <?php elseif (!empty($search_keyword)): ?>
                        搜索: "<?php echo htmlspecialchars($search_keyword); ?>"
                    <?php elseif (!empty($category_filter)): ?>
                        类别筛选
                    <?php endif; ?>
                </h5>
                <p class="mb-0">找到 <?php echo count($materials); ?> 个匹配的资料</p>
                <a href="index.php" class="btn btn-sm btn-outline-info mt-2">清除所有筛选</a>
            </div>
        <?php endif; ?>

        <!-- 类别筛选 -->
        <div class="category-filter">
            <h4 class="mb-3">按类别筛选（按住ctrl多选）</h4>
            <form method="GET" id="categoryFilterForm">
                <input type="hidden" name="status" value="<?php echo $status_filter; ?>">
                <input type="hidden" name="search" value="<?php echo htmlspecialchars($search_keyword); ?>">
                
                <div class="row">
                    <div class="col-md-10">
                        <select class="form-select" id="categoryFilter" name="categories[]" multiple>
                            <?php foreach ($categories as $cat): ?>
                                <option value="<?php echo $cat['id']; ?>" <?php echo in_array($cat['id'], $category_filter) ? 'selected' : ''; ?>>
                                    <?php echo htmlspecialchars($cat['name']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">应用筛选</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- 状态筛选 -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 id="materials">
                <?php 
                if (!empty($search_keyword) && !empty($category_filter)) {
                    echo '搜索"' . htmlspecialchars($search_keyword) . '"的结果';
                } elseif (!empty($search_keyword)) {
                    echo '搜索"' . htmlspecialchars($search_keyword) . '"的结果';
                } elseif (!empty($category_filter)) {
                    echo '筛选后的资料';
                } elseif ($status_filter == 'approved') {
                    echo '最新学习资料';
                } else {
                    echo '待审核资料';
                }
                ?>
            </h2>
            <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin'): ?>
                <div class="btn-group">
                    <a href="?status=approved<?php echo !empty($category_filter) ? '&categories[]=' . implode('&categories[]=', $category_filter) : ''; ?>&search=<?php echo urlencode($search_keyword); ?>" 
                       class="btn btn-outline-primary <?php echo $status_filter == 'approved' ? 'active' : ''; ?>">已审核</a>
                    <a href="?status=pending<?php echo !empty($category_filter) ? '&categories[]=' . implode('&categories[]=', $category_filter) : ''; ?>&search=<?php echo urlencode($search_keyword); ?>" 
                       class="btn btn-outline-warning <?php echo $status_filter == 'pending' ? 'active' : ''; ?>">待审核</a>
                </div>
            <?php endif; ?>
        </div>

        <!-- 资料列表 -->
        <section class="mb-5">
            <div class="row">
                <?php if (count($materials) > 0): ?>
                    <?php foreach ($materials as $material): ?>
                        <div class="col-md-4 mb-4">
                            <div class="card material-card">
                                <span class="badge 
                                    <?php 
                                    if ($material['status'] == 'approved') echo 'bg-success';
                                    elseif ($material['status'] == 'pending') echo 'bg-warning';
                                    else echo 'bg-danger';
                                    ?> status-badge">
                                    <?php 
                                    if ($material['status'] == 'approved') echo '已审核';
                                    elseif ($material['status'] == 'pending') echo '审核中';
                                    else echo '已拒绝';
                                    ?>
                                </span>
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <?php if (!empty($search_keyword)): ?>
                                            <?php echo highlightKeywords(htmlspecialchars($material['title']), $search_keyword); ?>
                                        <?php else: ?>
                                            <?php echo htmlspecialchars($material['title']); ?>
                                        <?php endif; ?>
                                    </h5>
                                    <p class="card-text">
                                        <?php 
                                        $full_description = $material['description'];
                                        $short_description = substr($full_description, 0, 150);
                                        $is_long = strlen($full_description) > 150;
                                        
                                        // 处理高亮
                                        if (!empty($search_keyword)) {
                                            $short_display = highlightKeywords(htmlspecialchars($short_description), $search_keyword);
                                            $full_display = highlightKeywords(htmlspecialchars($full_description), $search_keyword);
                                        } else {
                                            $short_display = htmlspecialchars($short_description);
                                            $full_display = htmlspecialchars($full_description);
                                        }
                                        ?>
                                        
                                        <span class="material-description" id="desc-<?php echo $material['id']; ?>">
                                            <?php echo $is_long ? $short_display . '...' : $full_display; ?>
                                        </span>
                                        
                                        <?php if ($is_long): ?>
                                            <a href="javascript:void(0);" class="show-more-link" 
                                            data-full="<?php echo htmlspecialchars($full_display); ?>" 
                                            data-short="<?php echo htmlspecialchars($short_display); ?>..."
                                            data-target="desc-<?php echo $material['id']; ?>">
                                                查看更多
                                            </a>
                                        <?php endif; ?>
                                    </p>
                                    <div class="mb-2">
                                        <?php if (!empty($material['category_names'])): ?>
                                            <?php $cats = explode(', ', $material['category_names']); ?>
                                            <?php foreach ($cats as $cat): ?>
                                                <span class="category-tag"><?php echo htmlspecialchars($cat); ?></span>
                                            <?php endforeach; ?>
                                        <?php endif; ?>
                                    </div>
                                    <p class="text-muted">上传者: <?php echo htmlspecialchars($material['uploader_name']); ?></p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <small class="text-muted"><?php echo date('Y-m-d', strtotime($material['uploaded_at'])); ?></small>
                                            <span class="file-size">・<?php echo formatFileSize($material['file_size']); ?></span>
                                            <?php if ($material['status'] == 'approved'): ?>
                                                <span class="file-size">・下载: <?php echo $material['download_count']; ?>次</span>
                                            <?php endif; ?>
                                        </div>
                                        <div class="btn-group">
                                            <?php if ($material['status'] == 'approved'): ?>
                                                <a href="?download=<?php echo $material['id']; ?>" class="btn btn-sm btn-primary">下载</a>
                                            <?php elseif ($status_filter == 'pending' && isset($_SESSION['role']) && $_SESSION['role'] == 'admin'): ?>
                                                <a href="?download=<?php echo $material['id']; ?>" class="btn btn-sm btn-info">下载</a>
                                                <form method="POST" class="d-inline">
                                                    <input type="hidden" name="material_id" value="<?php echo $material['id']; ?>">
                                                    <button type="submit" name="approve" class="btn btn-sm btn-success">通过</button>
                                                    <button type="submit" name="reject" class="btn btn-sm btn-danger">拒绝</button>
                                                </form>
                                            <?php endif; ?>
                                            
                                            <!-- 添加删除按钮 -->
                                            <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin'): ?>
                                                <form method="POST" class="d-inline" onsubmit="return confirm('确定要删除这个资料吗？此操作不可恢复。');">
                                                    <input type="hidden" name="material_id" value="<?php echo $material['id']; ?>">
                                                    <button type="submit" name="delete" class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <div class="col-12 text-center py-5">
                        <div class="text-muted">
                            <i class="bi bi-search" style="font-size: 3rem;"></i>
                            <p class="mt-3">
                                <?php if (!empty($search_keyword) || !empty($category_filter)): ?>
                                    <?php if (!empty($search_keyword) && !empty($category_filter)): ?>
                                        没有找到与"<?php echo htmlspecialchars($search_keyword); ?>"相关的资料
                                    <?php elseif (!empty($search_keyword)): ?>
                                        没有找到与"<?php echo htmlspecialchars($search_keyword); ?>"相关的资料
                                    <?php else: ?>
                                        没有找到相关类别的资料
                                    <?php endif; ?>
                                <?php else: ?>
                                    <?php if ($status_filter == 'pending'): ?>
                                        没有待审核的资料
                                    <?php else: ?>
                                        还没有人上传资料，成为第一个上传者吧！
                                    <?php endif; ?>
                                <?php endif; ?>
                            </p>
                            <?php if (!empty($search_keyword) || !empty($category_filter)): ?>
                                <a href="index.php" class="btn btn-primary mt-2">查看所有资料</a>
                            <?php endif; ?>
                        </div>
                    </div>
                <?php endif; ?>
            </div>
        </section>

    <!-- 上传区域 -->
    <?php if (isset($_SESSION['user_id'])): ?>
        <section id="upload" class="mb-5">
            <h2 class="mb-4">上传学习资料</h2>
            <div class="card">
                <div class="card-body">
                    <?php if (!empty($upload_message)): ?>
                        <div class="alert alert-info"><?php echo $upload_message; ?></div>
                    <?php endif; ?>
                    <form id="uploadForm" enctype="multipart/form-data">
                        <div class="upload-area" id="uploadArea">
                            <p>点击或拖拽文件到此处上传</p>
                            <input type="file" class="d-none" id="fileInput" name="file" required>
                            <button type="button" class="btn btn-primary" onclick="document.getElementById('fileInput').click()">选择文件</button>
                            <p class="small text-muted mt-2">最大文件大小: 2GB</p>
                            
                            <!-- 文件预览区域 -->
                            <div class="file-preview d-flex align-items-center" id="filePreview">
                                <div class="file-icon">
                                    <i class="bi bi-file-earmark"></i>
                                </div>
                                <div class="file-details">
                                    <div class="file-name" id="fileName">文件名</div>
                                    <div class="file-meta">
                                        <span id="fileSize">0 KB</span> • 
                                        <span id="fileType">文件类型</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="title" class="form-label">资料标题 *</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">资料描述 *</label>
                            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="categories" class="form-label">分类 (可多选) *</label>
                            <select class="form-select" id="categories" name="categories[]" multiple required>
                                <?php foreach ($categories as $cat): ?>
                                    <option value="<?php echo $cat['id']; ?>"><?php echo htmlspecialchars($cat['name']); ?></option>
                                <?php endforeach; ?>
                                </select>
                        </div>
                        <button type="submit" class="btn btn-primary">提交审核</button>
                    </form>
                </div>
            </div>
        </section>
    <?php endif; ?>
    
    <!-- 上传进度窗口 -->
    <div class="progress-modal" id="progressModal">
        <div class="progress-content">
            <h4>上传中...</h4>
            <div class="progress-text" id="progressText">正在准备上传...</div>
            <div class="progress-bar-container">
                <div class="progress-bar-fill" id="progressBar"></div>
            </div>
            <div class="progress-details">
                <span id="uploadedSize">0 KB</span>
                <span id="totalSize">0 KB</span>
            </div>
            <div class="progress-details">
                <span id="uploadSpeed">0 KB/s</span>
                <span id="timeRemaining">--</span>
            </div>
            <button class="btn btn-danger cancel-upload-btn" id="cancelUploadBtn">取消上传</button>
        </div>
    </div>

    <!-- 页脚 -->
    <footer class="bg-light text-center">
        <div class="container">
            <p class="mb-0">学习资料共享平台 &copy; 2025 版权所有</p>
            <p class="text-muted small">bug反馈邮箱:2244823654@qq.com</p>
            <p class="text-muted small">所有资料仅供厦大电院同学学习交流使用，请勿用于商业用途</p>
            <p class="text-muted small">严禁在本互联网非涉密平台处理、传输国家秘密，请确认扫描、传输的文件资料不涉及国家秘密</p>
            <p class="text-muted small">不得上传涉及侵犯他人知识产权、个人隐私、封建迷信等内容；不得利用本站进行商业活动或其他非法行为等。同时若发现有违规行为，本站将有权立即删除相关内容并停止用户服务。</p>
            <p class="text-muted small">本站不对上传内容的真实性、准确性、合法性负责，并且不承担任何由此引起的纠纷和责任问题，一切后果由上传者自负。若因使用本站服务而导致任何形式的损失或损害，本站概不负责。</p>
        </div>
    </footer>

    <!-- 登录模态框 -->
    <div class="modal fade" id="loginModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">用户登录</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <?php if (!empty($login_error)): ?>
                        <div class="alert alert-danger"><?php echo $login_error; ?></div>
                    <?php endif; ?>
                    <form method="POST">
                        <div class="mb-3">
                            <label for="loginEmail" class="form-label">邮箱地址</label>
                            <input type="email" class="form-control" id="loginEmail" name="email" 
                                   value="<?php echo htmlspecialchars($login_email); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="loginPassword" class="form-label">密码</label>
                            <input type="password" class="form-control" id="loginPassword" name="password" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">记住我</label>
                        </div>
                        <button type="submit" name="login" class="btn btn-primary w-100">登录</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 注册模态框 -->
    <div class="modal fade" id="registerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">用户注册</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <?php if (!empty($register_error)): ?>
                        <div class="alert alert-danger"><?php echo $register_error; ?></div>
                    <?php endif; ?>
                    <form method="POST" id="registerForm">
                        <div class="mb-3">
                            <label for="registerUsername" class="form-label">用户名</label>
                            <input type="text" class="form-control" id="registerUsername" name="username" 
                                   value="<?php echo htmlspecialchars($register_username); ?>" required 
                                   oninput="checkUsernameAvailability(this.value)">
                            <div class="username-feedback" id="usernameFeedback"></div>
                        </div>
                        <div class="mb-3">
                            <label for="registerEmail" class="form-label">邮箱地址</label>
                            <input type="email" class="form-control" id="registerEmail" name="email" 
                                   value="<?php echo htmlspecialchars($register_email); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="registerPassword" class="form-label">密码</label>
                            <input type="password" class="form-control" id="registerPassword" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">确认密码</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirm_password" required>
                        </div>
                        <button type="submit" name="register" class="btn btn-primary w-100" id="registerButton">注册</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript部分 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>window.jQuery || document.write('<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"><\/script>')</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // 初始化Select2
            $('#categories').select2();
            $('#categoryFilter').select2();
            
            // 检查是否需要自动打开登录或注册模态框
            <?php if (isset($_SESSION['show_login_modal']) && $_SESSION['show_login_modal']): ?>
                $('#loginModal').modal('show');
                <?php unset($_SESSION['show_login_modal']); ?>
            <?php elseif (isset($_SESSION['show_register_modal']) && $_SESSION['show_register_modal']): ?>
                $('#registerModal').modal('show');
                <?php unset($_SESSION['show_register_modal']); ?>
            <?php endif; ?>
            
            const fileInput = document.getElementById('fileInput');
            const filePreview = document.getElementById('filePreview');
            const uploadArea = document.getElementById('uploadArea');
            const fileName = document.getElementById('fileName');
            const fileSize = document.getElementById('fileSize');
            const fileType = document.getElementById('fileType');
            const uploadForm = document.getElementById('uploadForm');
            
            // 初始隐藏预览区域
            if (filePreview) {
                filePreview.style.display = 'none';
            }
            
            // 文件选择处理
            if (fileInput) {
                fileInput.addEventListener('change', function(e) {
                    if (this.files.length > 0) {
                        handleFilePreview(this.files[0]);
                    }
                });
            }

            // 拖放功能
            if (uploadArea) {
                uploadArea.addEventListener('dragover', function(e) {
                    e.preventDefault();
                    uploadArea.classList.add('dragover');
                });
                
                uploadArea.addEventListener('dragleave', function() {
                    uploadArea.classList.remove('dragover');
                });
                
                uploadArea.addEventListener('drop', function(e) {
                    e.preventDefault();
                    uploadArea.classList.remove('dragover');
                    
                    if (e.dataTransfer.files.length) {
                        fileInput.files = e.dataTransfer.files;
                        handleFilePreview(e.dataTransfer.files[0]);
                    }
                });
                
                // 点击上传区域也可以选择文件
                uploadArea.addEventListener('click', function(e) {
                    if (e.target.tagName !== 'BUTTON' && fileInput) {
                        fileInput.click();
                    }
                });
            }

            // 处理文件预览 - 修复空引用错误
            function handleFilePreview(file) {
                if (!filePreview) {
                    console.error("File preview element not found");
                    return;
                }
                
                // 文件大小检查 - 限制为2GB
                const maxSize = 2 * 1024 * 1024 * 1024; // 2GB
                if (file.size > maxSize) {
                    alert('文件大小超过2GB限制，请选择其他文件');
                    // 清空文件输入
                    document.getElementById('fileInput').value = '';
                    // 隐藏预览区域
                    filePreview.style.display = 'none';
                    return;
                }
                
                const fileSizeFormatted = formatFileSize(file.size);
                const fileExtension = getFileExtension(file.name);
                const fileIcon = getFileIcon(fileExtension);
                
                // 更新预览区域
                if (fileName) fileName.textContent = file.name;
                if (fileSize) fileSize.textContent = fileSizeFormatted;
                if (fileType) fileType.textContent = fileExtension.toUpperCase() + ' 文件';
                
                const fileIconElement = document.querySelector('#filePreview .file-icon i');
                if (fileIconElement) {
                    fileIconElement.className = 'bi ' + fileIcon;
                }
                
                // 显示预览区域
                filePreview.style.display = 'flex';
            }
            
            // 删除确认函数
            function confirmDelete(e) {
                if (!confirm('确定要删除这个资料吗？此操作不可恢复。')) {
                    e.preventDefault();
                }
            }

            // 为所有删除按钮添加事件监听
            const deleteButtons = document.querySelectorAll('button[name="delete"]');
            deleteButtons.forEach(button => {
                button.addEventListener('click', confirmDelete);
            });
            // 展开/收起功能
            document.body.addEventListener('click', function(e) {
                if (e.target.classList.contains('show-more-link')) {
                    const link = e.target;
                    const targetId = link.getAttribute('data-target');
                    const targetElement = document.getElementById(targetId);
                    const fullText = link.getAttribute('data-full');
                    const shortText = link.getAttribute('data-short');
                    
                    if (link.textContent === '查看更多') {
                        targetElement.innerHTML = fullText;
                        link.textContent = '收起';
                    } else {
                        targetElement.innerHTML = shortText;
                        link.textContent = '查看更多';
                    }
                }
            });
            
            // 初始化所有描述文本
            const descriptions = document.querySelectorAll('.material-description');
            descriptions.forEach(desc => {
                // 确保文本不会超出卡片范围
                desc.style.wordWrap = 'break-word';
            });
            // 上传进度相关变量
            let uploadXHR = null;
            let uploadStartTime = null;
            let lastLoaded = 0;
            let lastTime = null;
            
            // 显示上传进度窗口
            function showProgressModal() {
                $('#progressModal').css('display', 'flex');
                $('#progressText').text('正在准备上传...');
                $('#progressBar').css('width', '0%');
                $('#uploadedSize').text('0 KB');
                $('#totalSize').text('0 KB');
                $('#uploadSpeed').text('0 KB/s');
                $('#timeRemaining').text('--');
            }
            
            // 隐藏上传进度窗口
            function hideProgressModal() {
                $('#progressModal').hide();
            }
            
            // 更新进度条
            function updateProgress(loaded, total) {
                const percent = Math.round((loaded / total) * 100);
                $('#progressBar').css('width', percent + '%');
                $('#progressText').text('上传中: ' + percent + '%');
                
                // 更新上传大小
                $('#uploadedSize').text(formatFileSize(loaded));
                $('#totalSize').text(formatFileSize(total));
                
                // 计算上传速度
                const now = new Date().getTime();
                const timeDiff = (now - uploadStartTime) / 1000; // 秒
                const speed = loaded / timeDiff; // 字节/秒
                
                // 更新上传速度
                $('#uploadSpeed').text(formatFileSize(speed) + '/s');
                
                // 计算剩余时间
                if (speed > 0) {
                    const remainingBytes = total - loaded;
                    const remainingSeconds = remainingBytes / speed;
                    $('#timeRemaining').text(formatTime(remainingSeconds));
                }
            }
            
            // 格式化文件大小
            function formatFileSize(bytes) {
                if (bytes === 0) return '0 B';
                const k = 1024;
                const sizes = ['B', 'KB', 'MB', 'GB'];
                const i = Math.floor(Math.log(bytes) / Math.log(k));
                return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
            }
            
            // 格式化时间
            function formatTime(seconds) {
                if (seconds < 60) {
                    return Math.round(seconds) + '秒';
                } else if (seconds < 3600) {
                    return Math.round(seconds / 60) + '分钟';
                } else {
                    return Math.round(seconds / 3600) + '小时';
                }
            }
            
            // 取消上传
            $('#cancelUploadBtn').on('click', function() {
                if (uploadXHR) {
                    uploadXHR.abort();
                    hideProgressModal();
                    alert('上传已取消');
                }
            });
            
            // 处理表单提交（AJAX上传）
            $('#uploadForm').on('submit', function(e) {
                e.preventDefault();
                
                const form = this;
                const formData = new FormData(form);
                const fileInput = document.getElementById('fileInput');
                
                if (fileInput.files.length === 0) {
                    alert('请选择文件');
                    return;
                }
                
                const file = fileInput.files[0];
                const totalSize = file.size;
                
                // 添加AJAX上传标识
                formData.append('ajax_upload', '1');
                
                // 显示进度窗口
                showProgressModal();
                uploadStartTime = new Date().getTime();
                
                // 创建AJAX请求
                uploadXHR = new XMLHttpRequest();
                
                // 监听进度事件
                uploadXHR.upload.addEventListener('progress', function(e) {
                    if (e.lengthComputable) {
                        updateProgress(e.loaded, e.total);
                    }
                });
                
                // 监听完成事件
                uploadXHR.addEventListener('load', function() {
                    if (uploadXHR.status === 200) {
                        try {
                            const response = JSON.parse(uploadXHR.responseText);
                            if (response.success) {
                                alert(response.message);
                                form.reset();
                                $('#filePreview').hide();
                                hideProgressModal();
                                
                                // 刷新页面显示新上传的文件
                                setTimeout(function() {
                                    location.reload();
                                }, 1500);
                            } else {
                                alert('上传失败: ' + response.message);
                                hideProgressModal();
                            }
                        } catch (e) {
                            console.error('解析JSON失败', uploadXHR.responseText);
                            alert('上传失败：服务器返回格式错误');
                            hideProgressModal();
                        }
                    } else {
                        alert('上传失败: 服务器错误 ' + uploadXHR.status);
                        hideProgressModal();
                    }
                });
                
                // 监听错误事件
                uploadXHR.addEventListener('error', function() {
                    alert('上传请求失败');
                    hideProgressModal();
                });
                
                // 监听取消事件
                uploadXHR.addEventListener('abort', function() {
                    hideProgressModal();
                });
                
                // 发送请求
                uploadXHR.open('POST', '<?php echo $_SERVER['PHP_SELF']; ?>');
                uploadXHR.send(formData);
            });
        });

        // 格式化文件大小
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 B';
            const k = 1024;
            const sizes = ['B', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }

        // 获取文件扩展名
        function getFileExtension(filename) {
            return filename.split('.').pop().toLowerCase();
        }

        // 根据文件类型获取图标
        function getFileIcon(extension) {
            const iconMap = {
                'pdf': 'bi-file-earmark-pdf',
                'doc': 'bi-file-earmark-word',
                'docx': 'bi-file-earmark-word',
                'ppt': 'bi-file-earmark-ppt',
                'pptx': 'bi-file-earmark-ppt',
                'xls': 'bi-file-earmark-excel',
                'xlsx': 'bi-file-earmark-excel',
                'txt': 'bi-file-earmark-text',
                'zip': 'bi-file-earmark-zip',
                'rar': 'bi-file-earmark-zip',
                'jpg': 'bi-file-earmark-image',
                'jpeg': 'bi-file-earmark-image',
                'png': 'bi-file-earmark-image',
                'gif': 'bi-file-earmark-image'
            };
            
            return iconMap[extension] || 'bi-file-earmark';
        }
        // 检查用户名可用性
        function checkUsernameAvailability(username) {
            if (username.length < 3) {
                $('#usernameFeedback').html('').removeClass('username-available username-taken username-checking');
                $('#registerButton').prop('disabled', false);
                return;
            }
            
            $('#usernameFeedback').html('检查中...').addClass('username-checking').removeClass('username-available username-taken');
            
            // 使用AJAX检查用户名
            $.get('<?php echo $_SERVER['PHP_SELF']; ?>', {check_username: username}, function(response) {
                if (response === 'exists') {
                    $('#usernameFeedback').html('用户名已被使用').addClass('username-taken').removeClass('username-available username-checking');
                    $('#registerButton').prop('disabled', true);
                } else if (response === 'available') {
                    $('#usernameFeedback').html('用户名可用').addClass('username-available').removeClass('username-taken username-checking');
                    $('#registerButton').prop('disabled', false);
                }
            });
        }
        
        // 页面加载时如果有用户名值，检查其可用性
        <?php if (!empty($register_username)): ?>
            $(document).ready(function() {
                checkUsernameAvailability('<?php echo $register_username; ?>');
            });
        <?php endif; ?>
    </script>
</body>
</html>

<?php
// 格式化文件大小显示
function formatFileSize($bytes) {
    if ($bytes == 0) return '0 B';
    $k = 1024;
    $sizes = ['B', 'KB', 'MB', 'GB'];
    $i = floor(log($bytes) / log($k));
    return number_format(($bytes / pow($k, $i)), 2) . ' ' . $sizes[$i];
}

// 高亮显示关键词
function highlightKeywords($text, $keyword) {
    if (empty($keyword)) return $text;
    
    $keywords = preg_split('/\s+/', $keyword);
    foreach ($keywords as $kw) {
        if (!empty($kw)) {
            $text = preg_replace("/(" . preg_quote($kw) . ")/i", "<span class=\"search-highlight\">$1</span>", $text);
        }
    }
    return $text;
}

// 关闭数据库连接
$conn->close();
?>