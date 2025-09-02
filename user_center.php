<?php
// 在原有代码基础上增加以下功能
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
            $login_error = "密码错误";
        }
    } else {
        $login_error = "邮箱不存在";
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

// 处理用户删除自己上传的文件
if (isset($_POST['user_delete']) && isset($_SESSION['user_id'])) {
    $material_id = $_POST['material_id'];
    
    // 检查用户是否有权删除这个文件
    $stmt = $conn->prepare("SELECT filename, uploader_id FROM materials WHERE id = ?");
    $stmt->bind_param("i", $material_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows == 1) {
        $material = $result->fetch_assoc();
        
        // 只有文件的上传者或管理员可以删除
        if ($material['uploader_id'] == $_SESSION['user_id'] || (isset($_SESSION['role']) && $_SESSION['role'] == 'admin')) {
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
    }
    $stmt->close();
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
// 处理文件编辑和更新
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['update_material']) && isset($_SESSION['user_id'])) {
    $material_id = $_POST['material_id'];
    $title = trim($_POST['title']);
    $description = trim($_POST['description']);
    $selected_categories = isset($_POST['categories']) ? $_POST['categories'] : [];
    
    // 验证用户是否有权编辑这个文件
    $stmt = $conn->prepare("SELECT uploader_id FROM materials WHERE id = ?");
    $stmt->bind_param("i", $material_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows == 1) {
        $material = $result->fetch_assoc();
        
        if ($material['uploader_id'] == $_SESSION['user_id'] || (isset($_SESSION['role']) && $_SESSION['role'] == 'admin')) {
            // 处理文件重新上传（如果有）
            $file_update = "";
            $file_params = [];

            if (isset($_FILES['file']) && $_FILES['file']['error'] == UPLOAD_ERR_OK) {
                // 获取原文件信息
                $old_file_stmt = $conn->prepare("SELECT filename FROM materials WHERE id = ?");
                $old_file_stmt->bind_param("i", $material_id);
                $old_file_stmt->execute();
                $old_file_result = $old_file_stmt->get_result();
                
                if ($old_file_result->num_rows == 1) {
                    $old_file = $old_file_result->fetch_assoc();
                    
                    // 上传新文件
                    $upload_dir = "uploads/";
                    $original_name = basename($_FILES['file']['name']);
                    $file_ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
                    $filename = uniqid() . '.' . $file_ext;
                    $file_path = $upload_dir . $filename;
                    $file_size = $_FILES['file']['size'];
                    
                    if (move_uploaded_file($_FILES['file']['tmp_name'], $file_path)) {
                        // 删除旧文件
                        if (file_exists($upload_dir . $old_file['filename'])) {
                            unlink($upload_dir . $old_file['filename']);
                        }
                        
                        $file_update = ", filename = ?, original_name = ?, file_size = ?";
                        $file_params = [$filename, $original_name, $file_size];
                    }
                }
                $old_file_stmt->close();
            }

            // 更新数据库
            $sql = "UPDATE materials SET title = ?, description = ?" . $file_update . ", status = 'pending' WHERE id = ?";
            $stmt = $conn->prepare($sql);

            if (!empty($file_update)) {
                // 动态参数绑定 - 有文件更新
                $types = "ss" . "sss" . "i"; // 2个字符串 (title, desc) + 3个字符串 (file params) + 1个整数 (id)
                $params = array_merge([$title, $description], $file_params, [$material_id]);
                $stmt->bind_param($types, ...$params);
            } else {
                // 没有文件更新
                $stmt->bind_param("ssi", $title, $description, $material_id);
            }

            if ($stmt->execute()) {
                // 更新分类信息
                $conn->query("DELETE FROM material_categories WHERE material_id = $material_id");
                
                if (!empty($selected_categories)) {
                    foreach ($selected_categories as $category_id) {
                        $category_stmt = $conn->prepare("INSERT INTO material_categories (material_id, category_id) VALUES (?, ?)");
                        $category_stmt->bind_param("ii", $material_id, $category_id);
                        $category_stmt->execute();
                        $category_stmt->close();
                    }
                }
                
                $_SESSION['update_message'] = "文件更新成功，等待管理员重新审核";
            } else {
                $_SESSION['update_message'] = "文件更新失败: " . $conn->error;
            }
            $stmt->close();
            
            // 使用JavaScript重定向而不是header，因为可能已经有输出
            echo '<script>window.location.href = "user_center.php";</script>';
            exit();
        }
    }
}

// 获取用户上传的资料
function getUserMaterials($conn, $user_id, $status_filter = '') {
    $materials = [];
    
    $where_clause = "WHERE m.uploader_id = ?";
    if (!empty($status_filter)) {
        $where_clause .= " AND m.status = ?";
    }
    
    $sql = "SELECT m.*, 
                   GROUP_CONCAT(c.name SEPARATOR ', ') as category_names,
                   COUNT(mc.category_id) as category_count
            FROM materials m 
            LEFT JOIN material_categories mc ON m.id = mc.material_id
            LEFT JOIN categories c ON mc.category_id = c.id
            $where_clause 
            GROUP BY m.id
            ORDER BY m.uploaded_at DESC";
    
    $stmt = $conn->prepare($sql);
    
    if (!empty($status_filter)) {
        $stmt->bind_param("is", $user_id, $status_filter);
    } else {
        $stmt->bind_param("i", $user_id);
    }
    
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $materials[] = $row;
        }
    }
    
    $stmt->close();
    return $materials;
}
?>

<!-- 创建用户中心页面 user_center.php -->
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户中心 - 学习资料共享平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">
    <style>
        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .material-card {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .material-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .category-tag {
            display: inline-block;
            background-color: #e9ecef;
            padding: 0.25em 0.4em;
            margin: 2px;
            border-radius: 0.25rem;
            font-size: 0.875em;
        }
        .file-size {
            font-size: 0.9rem;
            color: #6c757d;
        }
        .nav-pills .nav-link.active {
            background-color: #0d6efd;
        }
        .stats-card {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
        }
        .select2-container--default .select2-selection--multiple {
            min-height: 38px;
            border: 1px solid #ced4da;
            border-radius: 0.375rem;
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
        .delete-btn {
            position: absolute;
            top: 10px;
            left: 10px;
            opacity: 0.7;
            transition: opacity 0.3s;
        }
        .material-card:hover .delete-btn {
            opacity: 1;
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
        /* 多行截断示例 */
        .material-description.truncated {
            display: -webkit-box;
            -webkit-line-clamp: 3; /* 限制显示3行 */
            -webkit-box-orient: vertical;
            overflow: hidden;
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
                    <li class="nav-item"><a class="nav-link" href="index.php">首页</a></li>
                    <li class="nav-item"><a class="nav-link" href="index.php?status=approved">资料库</a></li>
                    <?php if (isset($_SESSION['user_id'])): ?>
                        <li class="nav-item"><a class="nav-link" href="index.php#upload">上传资料</a></li>
                        <li class="nav-item"><a class="nav-link active" href="user_center.php">用户中心</a></li>
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
                
                <div class="d-flex">
                    <?php if (isset($_SESSION['user_id'])): ?>
                        <span class="navbar-text me-3">欢迎, <?php echo $_SESSION['username']; ?></span>
                        <?php if ($_SESSION['role'] == 'admin'): ?>
                            <span class="navbar-text badge bg-warning me-3">管理员</span>
                        <?php endif; ?>
                        <a class="btn btn-outline-light" href="?logout=true">退出</a>
                    <?php else: ?>
                        <a class="btn btn-outline-light me-2" href="index.php">登录</a>
                        <a class="btn btn-primary" href="index.php">注册</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <!-- 用户信息侧边栏 -->
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="bi bi-person-circle" style="font-size: 4rem;"></i>
                        </div>
                        <h4><?php echo $_SESSION['username']; ?></h4>
                        <p class="text-muted"><?php echo $_SESSION['email']; ?></p>
                        <span class="badge bg-<?php echo $_SESSION['role'] == 'admin' ? 'warning' : 'primary'; ?>">
                            <?php echo $_SESSION['role'] == 'admin' ? '管理员' : '普通用户'; ?>
                        </span>
                    </div>
                </div>
                
                <!-- 数据统计 -->
                <?php
                $all_materials = getUserMaterials($conn, $_SESSION['user_id']);
                $approved_materials = getUserMaterials($conn, $_SESSION['user_id'], 'approved');
                $pending_materials = getUserMaterials($conn, $_SESSION['user_id'], 'pending');
                $rejected_materials = getUserMaterials($conn, $_SESSION['user_id'], 'rejected');
                ?>
                
                <div class="stats-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5>我的资料统计</h5>
                        <i class="bi bi-folder2-open" style="font-size: 1.5rem;"></i>
                    </div>
                    <div class="row text-center">
                        <div class="col-6 mb-3">
                            <div class="stats-number"><?php echo count($all_materials); ?></div>
                            <div>总上传</div>
                        </div>
                        <div class="col-6 mb-3">
                            <div class="stats-number"><?php echo count($approved_materials); ?></div>
                            <div>已通过</div>
                        </div>
                        <div class="col-6">
                            <div class="stats-number"><?php echo count($pending_materials); ?></div>
                            <div>待审核</div>
                        </div>
                        <div class="col-6">
                            <div class="stats-number"><?php echo count($rejected_materials); ?></div>
                            <div>未通过</div>
                        </div>
                    </div>
                </div>
                
                <!-- 状态筛选 -->
                <div class="card">
                    <div class="card-header">状态筛选</div>
                    <div class="card-body p-0">
                        <ul class="nav nav-pills flex-column">
                            <li class="nav-item">
                                <a class="nav-link <?php echo (!isset($_GET['status']) || $_GET['status'] == 'all') ? 'active' : ''; ?>" 
                                   href="user_center.php?status=all">
                                   全部资料 <span class="badge bg-secondary float-end"><?php echo count($all_materials); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <?php echo (isset($_GET['status']) && $_GET['status'] == 'approved') ? 'active' : ''; ?>" 
                                   href="user_center.php?status=approved">
                                   已审核 <span class="badge bg-success float-end"><?php echo count($approved_materials); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <?php echo (isset($_GET['status']) && $_GET['status'] == 'pending') ? 'active' : ''; ?>" 
                                   href="user_center.php?status=pending">
                                   待审核 <span class="badge bg-warning float-end"><?php echo count($pending_materials); ?></span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <?php echo (isset($_GET['status']) && $_GET['status'] == 'rejected') ? 'active' : ''; ?>" 
                                   href="user_center.php?status=rejected">
                                   未通过 <span class="badge bg-danger float-end"><?php echo count($rejected_materials); ?></span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>我的上传</h2>
                    <a href="index.php#upload" class="btn btn-primary">
                        <i class="bi bi-plus-circle"></i> 上传新资料
                    </a>
                </div>
                
                <?php if (isset($_SESSION['update_message'])): ?>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <?php echo $_SESSION['update_message']; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <?php unset($_SESSION['update_message']); ?>
                <?php endif; ?>
                
                <!-- 资料列表 -->
                <div class="row">
                    <?php
                    $status_filter = isset($_GET['status']) ? $_GET['status'] : 'all';
                    
                    if ($status_filter == 'all') {
                        $display_materials = $all_materials;
                    } else {
                        $display_materials = getUserMaterials($conn, $_SESSION['user_id'], $status_filter);
                    }
                    
                    if (count($display_materials) > 0): ?>
                        <?php foreach ($display_materials as $material): ?>
                            <div class="col-md-6 mb-4">
                                <div class="card material-card position-relative">
                                    
                                    
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
                                        <h5 class="card-title"><?php echo htmlspecialchars($material['title']); ?></h5>
                                        <!-- 替换原有的描述部分代码 -->
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
                                                    <a href="index.php?download=<?php echo $material['id']; ?>" class="btn btn-sm btn-primary">下载</a>
                                                <?php endif; ?>
                                                <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editModal<?php echo $material['id']; ?>">
                                                    编辑
                                                </button>
                                                <!-- 删除按钮 -->
                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                        data-bs-toggle="modal" data-bs-target="#deleteModal<?php echo $material['id']; ?>">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 删除确认模态框 -->
                            <div class="modal fade" id="deleteModal<?php echo $material['id']; ?>" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">确认删除</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>您确定要删除 "<strong><?php echo htmlspecialchars($material['title']); ?></strong>" 吗？</p>
                                            <p class="text-danger">此操作不可逆，文件将被永久删除。</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                            <form method="POST">
                                                <input type="hidden" name="material_id" value="<?php echo $material['id']; ?>">
                                                <button type="submit" name="user_delete" class="btn btn-danger">确认删除</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 编辑模态框 -->
                            <div class="modal fade" id="editModal<?php echo $material['id']; ?>" tabindex="-1">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">编辑资料</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form method="POST" enctype="multipart/form-data">
                                            <div class="modal-body">
                                                <input type="hidden" name="material_id" value="<?php echo $material['id']; ?>">
                                                
                                                <div class="mb-3">
                                                    <label for="title<?php echo $material['id']; ?>" class="form-label">资料标题 *</label>
                                                    <input type="text" class="form-control" id="title<?php echo $material['id']; ?>" name="title" value="<?php echo htmlspecialchars($material['title']); ?>" required>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="description<?php echo $material['id']; ?>" class="form-label">资料描述 *</label>
                                                    <textarea class="form-control" id="description<?php echo $material['id']; ?>" name="description" rows="3" required><?php echo htmlspecialchars($material['description']); ?></textarea>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="categories<?php echo $material['id']; ?>" class="form-label">分类 (可多选) *</label>
                                                    <select class="form-select" id="categories<?php echo $material['id']; ?>" name="categories[]" multiple required>
                                                        <?php 
                                                        // 获取当前资料的分类
                                                        $cat_stmt = $conn->prepare("SELECT category_id FROM material_categories WHERE material_id = ?");
                                                        $cat_stmt->bind_param("i", $material['id']);
                                                        $cat_stmt->execute();
                                                        $cat_result = $cat_stmt->get_result();
                                                        $current_categories = [];
                                                        
                                                        while ($cat_row = $cat_result->fetch_assoc()) {
                                                            $current_categories[] = $cat_row['category_id'];
                                                        }
                                                        $cat_stmt->close();
                                                        
                                                        foreach ($categories as $cat): ?>
                                                            <option value="<?php echo $cat['id']; ?>" <?php echo in_array($cat['id'], $current_categories) ? 'selected' : ''; ?>>
                                                                <?php echo htmlspecialchars($cat['name']); ?>
                                                            </option>
                                                        <?php endforeach; ?>
                                                    </select>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label class="form-label">重新上传文件 (可选)</label>
                                                    <div class="upload-area" id="uploadArea<?php echo $material['id']; ?>">
                                                        <p>点击或拖拽文件到此处上传 (留空则保留原文件)</p>
                                                        <input type="file" class="d-none" id="fileInput<?php echo $material['id']; ?>" name="file">
                                                        <button type="button" class="btn btn-primary" onclick="document.getElementById('fileInput<?php echo $material['id']; ?>').click()">选择文件</button>
                                                        
                                                        <!-- 当前文件信息 -->
                                                        <div class="file-preview d-flex align-items-center mt-3">
                                                            <div class="file-icon">
                                                                <i class="bi bi-file-earmark"></i>
                                                            </div>
                                                            <div class="file-details">
                                                                <div class="file-name"><?php echo htmlspecialchars($material['original_name']); ?></div>
                                                                <div class="file-meta">
                                                                    <span><?php echo formatFileSize($material['file_size']); ?></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="alert alert-info">
                                                    <i class="bi bi-info-circle"></i> 注意：任何修改都需要重新审核通过后才能公开显示。
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                                <button type="submit" name="update_material" class="btn btn-primary">提交修改</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                        
                    <?php else: ?>
                        <div class="col-12 text-center py-5">
                            <div class="text-muted">
                                <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                                <p class="mt-3">
                                    <?php if ($status_filter == 'all'): ?>
                                        您还没有上传任何资料
                                    <?php elseif ($status_filter == 'approved'): ?>
                                        您没有已通过审核的资料
                                    <?php elseif ($status_filter == 'pending'): ?>
                                        您没有待审核的资料
                                    <?php elseif ($status_filter == 'rejected'): ?>
                                        您没有未通过审核的资料
                                    <?php endif; ?>
                                </p>
                                <a href="index.php#upload" class="btn btn-primary mt-2">上传资料</a>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script>
        // 初始化Select2
        $(document).ready(function() {
            $('select[id^="categories"]').select2();
        });
        
        // 文件上传预览功能
        document.addEventListener('DOMContentLoaded', function() {
            // 为每个模态框设置独立的文件上传处理
            <?php foreach ($display_materials as $material): ?>
            (function() {
                const materialId = <?php echo $material['id']; ?>;
                const fileInput = document.getElementById('fileInput' + materialId);
                const uploadArea = document.getElementById('uploadArea' + materialId);
                
                if (fileInput && uploadArea) {
                    fileInput.addEventListener('change', function(e) {
                        if (this.files.length > 0) {
                            handleFilePreview(this.files[0], materialId);
                        }
                    });
                    
                    // 拖放功能
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
                            handleFilePreview(e.dataTransfer.files[0], materialId);
                        }
                    });
                }
            })();
            <?php endforeach; ?>
            
            function handleFilePreview(file, materialId) {
                const fileSizeFormatted = formatFileSize(file.size);
                const fileExtension = getFileExtension(file.name);
                const fileIcon = getFileIcon(fileExtension);

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
                
                // 创建或更新预览区域
                let previewArea = document.querySelector('#uploadArea' + materialId + ' .file-preview');
                if (!previewArea) {
                    previewArea = document.createElement('div');
                    previewArea.className = 'file-preview d-flex align-items-center mt-3';
                    previewArea.innerHTML = `
                        <div class="file-icon">
                            <i class="bi ${fileIcon}"></i>
                        </div>
                        <div class="file-details">
                            <div class="file-name">${file.name}</div>
                            <div class="file-meta">
                                <span>${fileSizeFormatted}</span> • 
                                <span>${fileExtension.toUpperCase()} 文件</span>
                            </div>
                        </div>
                    `;
                    document.getElementById('uploadArea' + materialId).appendChild(previewArea);
                } else {
                    previewArea.querySelector('.file-icon i').className = 'bi ' + fileIcon;
                    previewArea.querySelector('.file-name').textContent = file.name;
                    previewArea.querySelector('.file-meta span:first-child').textContent = fileSizeFormatted;
                    previewArea.querySelector('.file-meta span:last-child').textContent = fileExtension.toUpperCase() + ' 文件';
                }
            }
            
            function formatFileSize(bytes) {
                if (bytes === 0) return '0 B';
                const k = 1024;
                const sizes = ['B', 'KB', 'MB', 'GB'];
                const i = Math.floor(Math.log(bytes) / Math.log(k));
                return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
            }
            
            function getFileExtension(filename) {
                return filename.split('.').pop().toLowerCase();
            }
            
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
        });

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