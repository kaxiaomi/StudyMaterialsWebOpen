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
    
    if ($row['attempt_count'] > 5) {
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
    
    if ($row['request_count'] > 60) {
        $abnormal = true;
        $reason = "1分钟内请求频率过高: " . $row['request_count'] . "次";
    }
    
    return ['abnormal' => $abnormal, 'reason' => $reason];
}

// 记录访问日志
logAccess($client_ip, $conn);

// 检查IP是否在黑名单中
if (isIPBlacklisted($client_ip, $conn)) {
    http_response_code(403);
    die("您的IP已被封禁，如有疑问请联系管理员。");
}

// 处理用户登录
$login_error = "";
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
            $_SESSION['show_login_modal'] = true;
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

// 处理文件上传
$upload_message = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['upload']) && isset($_SESSION['user_id'])) {
    $title = trim($_POST['title']);
    $description = trim($_POST['description']);
    $selected_categories = isset($_POST['categories']) ? $_POST['categories'] : [];
    
    // 检测异常行为（针对文件上传操作）
    $abnormal_check = detectAbnormalBehavior($client_ip, $conn);
    if ($abnormal_check['abnormal']) {
        $upload_message = "检测到异常行为，上传被禁止";
    } elseif (!empty($title) && isset($_FILES['file']) && $_FILES['file']['error'] == UPLOAD_ERR_OK) {
        // 文件上传处理
        $upload_dir = "uploads/";
        if (!is_dir($upload_dir)) {
            if (!mkdir($upload_dir, 0777, true)) {
                $upload_message = "无法创建上传目录";
            }
        }
        
        $original_name = basename($_FILES['file']['name']);
        $file_ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
        $filename = uniqid() . '.' . $file_ext;
        $file_path = $upload_dir . $filename;
        $file_size = $_FILES['file']['size'];
        
        // 检查文件大小并分块上传处理
        $max_chunk_size = 1024 * 1024 * 20; // 20MB每次
        $chunks = ceil($file_size / $max_chunk_size);
        
        if ($file_size < $max_chunk_size) {
            // 小文件直接上传
            if (move_uploaded_file($_FILES['file']['tmp_name'], $file_path)) {
                saveFileToDB($conn, $title, $description, $filename, $original_name, $file_size, $_SESSION['user_id'], $selected_categories, $upload_message);
            } else {
                $upload_message = "文件上传失败";
            }
        } else {
            // 大文件分块上传 - 使用流式处理避免内存问题
            $tmp_name = $_FILES['file']['tmp_name'];
            $out = fopen($file_path, 'wb');
            if ($out) {
                $in = fopen($tmp_name, 'rb');
                if ($in) {
                    $success = true;
                    $chunk_size = 1024 * 1024 * 5; // 5MB每次
                    $bytes_written = 0;
                    
                    while (!feof($in)) {
                        $chunk = fread($in, $chunk_size);
                        if ($chunk === false) {
                            $success = false;
                            $upload_message = "读取文件块失败";
                            break;
                        }
                        if (fwrite($out, $chunk) === false) {
                            $success = false;
                            $upload_message = "写入文件块失败";
                            break;
                        }
                        
                        $bytes_written += strlen($chunk);
                        $progress = round(($bytes_written / $file_size) * 100);
                        
                        // 更新进度显示
                        echo "<script>document.getElementById('uploadProgress').style.width = '{$progress}%'; document.getElementById('progressText').innerText = '上传中: {$progress}%';</script>";
                        flush();
                    }
                    fclose($in);
                    fclose($out);
                    
                    if ($success) {
                        saveFileToDB($conn, $title, $description, $filename, $original_name, $file_size, $_SESSION['user_id'], $selected_categories, $upload_message);
                    } else {
                        // 删除不完整的文件
                        if (file_exists($file_path)) {
                            unlink($file_path);
                        }
                    }
                } else {
                    $upload_message = "无法打开上传的文件";
                }
            } else {
                $upload_message = "无法创建目标文件";
            }
        }
    } else {
        $upload_message = "请填写标题并选择文件";
        if (isset($_FILES['file']['error'])) {
            switch ($_FILES['file']['error']) {
                case UPLOAD_ERR_INI_SIZE:
                case UPLOAD_ERR_FORM_SIZE:
                    $upload_message .= " (文件太大)";
                    break;
                case UPLOAD_ERR_PARTIAL:
                    $upload_message .= " (文件部分上传)";
                    break;
                case UPLOAD_ERR_NO_FILE:
                    $upload_message .= " (没有选择文件)";
                    break;
                case UPLOAD_ERR_NO_TMP_DIR:
                    $upload_message .= " (缺少临时文件夹)";
                    break;
                case UPLOAD_ERR_CANT_WRITE:
                    $upload_message .= " (写入磁盘失败)";
                    break;
            }
        }
    }
}

// 保存文件到数据库的函数
function saveFileToDB($conn, $title, $description, $filename, $original_name, $file_size, $user_id, $selected_categories, &$message) {
    $stmt = $conn->prepare("INSERT INTO materials (title, description, filename, original_name, file_size, uploader_id) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssii", $title, $description, $filename, $original_name, $file_size, $user_id);
    
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
        
        $message = "文件上传成功，等待管理员审核";
    } else {
        $message = "数据库保存失败: " . $conn->error;
        if (file_exists("uploads/" . $filename)) {
            unlink("uploads/" . $filename); // 删除已上传的文件
        }
    }
    $stmt->close();
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
    <title>上传学习资料</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 20px;
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
        .upload-area.dragover {
            border-color: #0d6efd;
            background-color: rgba(13, 110, 253, 0.05);
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
        .progress {
            margin-top: 15px;
            height: 25px;
        }
        .progress-text {
            text-align: center;
            margin-top: 5px;
            font-size: 0.9rem;
        }
        .fixed-bottom-right {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #2575fc;
        }
        .upload-error {
            color: #dc3545;
            font-weight: bold;
            margin-top: 10px;
        }
        .phpstudy-tip {
            background-color: #f8f9fa;
            border-left: 4px solid #0d6efd;
            padding: 15px;
            margin-top: 20px;
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
                    <li class="nav-item"><a class="nav-link active" href="upload.php">上传资料</a></li>
                    <?php if (isset($_SESSION['user_id'])): ?>
                        <li class="nav-item"><a class="nav-link" href="user_center.php">用户中心</a></li>
                    <?php endif; ?>
                    <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 'admin'): ?>
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="index.php?status=pending">待审核</a>
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
            <h1 class="display-4 fw-bold">上传学习资料</h1>
            <p class="lead">分享知识，共同成长</p>
        </div>
    </section>

    <!-- 主要内容区 -->
    <div class="container">
        <!-- 上传区域 -->
        <section class="mb-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card shadow">
                        <div class="card-body">
                            <?php if (!empty($upload_message)): ?>
                                <div class="alert alert-info"><?php echo $upload_message; ?></div>
                            <?php endif; ?>
                            
                            <form method="POST" enctype="multipart/form-data" id="uploadForm">
                                <div class="upload-area" id="uploadArea">
                                    <i class="bi bi-cloud-arrow-up feature-icon"></i>
                                    <p class="h5">点击或拖拽文件到此处上传</p>
                                    <p class="text-muted">支持PDF、DOC、PPT、ZIP、图片等格式（最大4GB）</p>
                                    <input type="file" class="d-none" id="fileInput" name="file" required>
                                    <button type="button" class="btn btn-primary" onclick="document.getElementById('fileInput').click()">选择文件</button>
                                    
                                    <!-- 上传进度条 -->
                                    <div class="progress mt-3 d-none" id="uploadProgressBar">
                                        <div class="progress-bar" role="progressbar" id="uploadProgress" style="width: 0%"></div>
                                    </div>
                                    <div class="progress-text" id="progressText"></div>
                                    
                                    <!-- 文件预览区域 -->
                                    <div class="file-preview d-flex align-items-center d-none" id="filePreview">
                                        <div class="file-icon">
                                            <i class="bi bi-file-earmark" id="fileIcon"></i>
                                        </div>
                                        <div class="file-details">
                                            <div class="file-name" id="fileName">文件名</div>
                                            <div class="file-meta">
                                                <span id="fileSize">0 KB</span> • 
                                                <span id="fileType">文件类型</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 错误信息显示 -->
                                    <div class="upload-error d-none" id="uploadError"></div>
                                </div>
                                
                                <div class="mb-3 mt-4">
                                    <label for="title" class="form-label">资料标题 *</label>
                                    <input type="text" class="form-control" id="title" name="title" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">资料描述 *</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="categories" class="form-label">分类 (可多选) *</label>
                                    <select class="form-select" id="categories" name="categories[]" multiple required>
                                        <?php foreach ($categories as $cat): ?>
                                            <option value="<?php echo $cat['id']; ?>"><?php echo htmlspecialchars($cat['name']); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                
                                <div class="d-grid">
                                    <button type="submit" name="upload" class="btn btn-primary btn-lg" id="uploadButton">提交审核</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- 上传指引 -->
                    <div class="card mt-4">
                        <div class="card-body">
                            <h4 class="card-title"><i class="bi bi-info-circle me-2"></i>上传指引</h4>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <i class="bi bi-check-circle text-success me-2"></i>
                                    请上传合法的学习资料，禁止上传任何违法、侵权或与学习无关的内容
                                </li>
                                <li class="list-group-item">
                                    <i class="bi bi-check-circle text-success me-2"></i>
                                    文件上传后需要管理员审核才能出现在资料库中
                                </li>
                                <li class="list-group-item">
                                    <i class="bi bi-check-circle text-success me-2"></i>
                                    大文件（超过500MB）上传可能需要较长时间，请耐心等待
                                </li>
                                <li class="list-group-item">
                                    <i class="bi bi-check-circle text-success me-2"></i>
                                    上传进度会实时显示在上传区域
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- 小皮面板(PHPStudy)配置提示 -->
                    <div class="card mt-4">
                        <div class="card-body phpstudy-tip">
                            <h5><i class="bi bi-gear me-2"></i>小皮面板(PHPStudy)配置提示</h5>
                            <p>为了支持大文件上传，请确保以下配置：</p>
                            <ol>
                                <li>打开PHPStudy面板，选择当前使用的PHP版本</li>
                                <li>点击"配置"打开php.ini文件</li>
                                <li>修改以下参数：
                                    <ul>
                                        <li><code>upload_max_filesize = 4096M</code></li>
                                        <li><code>post_max_size = 4096M</code></li>
                                        <li><code>max_execution_time = 3600</code></li>
                                        <li><code>max_input_time = 3600</code></li>
                                        <li><code>memory_limit = 512M</code></li>
                                    </ul>
                                </li>
                                <li>保存修改并重启PHP服务</li>
                                <li>确保临时目录（php.ini中的upload_tmp_dir）有足够空间</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- 页脚 -->
    <footer class="bg-light text-center py-4 mt-5">
        <div class="container">
            <p class="mb-0">学习资料共享平台 &copy; 2025 版权所有</p>
            <p class="text-muted small mb-0">所有资料仅供学习交流使用，请勿用于商业用途</p>
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
                                   value="<?php echo htmlspecialchars($register_username); ?>" required>
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
                        <button type="submit" name="register" class="btn btn-primary w-100">注册</button>
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
            $('#categories').select2({
                placeholder: '选择分类',
                allowClear: true
            });
            
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
            const fileIcon = document.getElementById('fileIcon');
            const uploadProgressBar = document.getElementById('uploadProgressBar');
            const uploadProgress = document.getElementById('uploadProgress');
            const progressText = document.getElementById('progressText');
            const uploadButton = document.getElementById('uploadButton');
            const uploadError = document.getElementById('uploadError');
            
            // 文件选择处理
            if (fileInput) {
                fileInput.addEventListener('change', function(e) {
                    if (this.files.length > 0) {
                        handleFilePreview(this.files[0]);
                        
                        // 显示上传按钮
                        uploadButton.disabled = false;
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
                        
                        // 显示上传按钮
                        uploadButton.disabled = false;
                    }
                });
                
                // 点击上传区域也可以选择文件
                uploadArea.addEventListener('click', function(e) {
                    if (e.target.tagName !== 'BUTTON' && fileInput) {
                        fileInput.click();
                    }
                });
            }
            
            // 处理文件预览
            function handleFilePreview(file) {
                const fileSizeFormatted = formatFileSize(file.size);
                const fileExtension = getFileExtension(file.name);
                const fileIconClass = getFileIcon(fileExtension);
                
                // 更新预览区域
                fileName.textContent = file.name;
                fileSize.textContent = fileSizeFormatted;
                fileType.textContent = fileExtension.toUpperCase() + ' 文件';
                fileIcon.className = 'bi ' + fileIconClass;
                
                // 显示预览区域
                filePreview.classList.remove('d-none');
                
                // 显示上传进度条
                uploadProgressBar.classList.remove('d-none');
                progressText.classList.remove('d-none');
                uploadProgress.style.width = '0%';
                progressText.textContent = '准备上传';
                
                // 隐藏错误信息
                uploadError.classList.add('d-none');
            }
            
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
            
            // 在表单提交时显示上传进度
            document.getElementById('uploadForm').addEventListener('submit', function() {
                // 显示上传进度
                uploadProgressBar.classList.remove('d-none');
                progressText.classList.remove('d-none');
                
                // 禁用上传按钮防止重复提交
                uploadButton.disabled = true;
                uploadButton.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 上传中...';
            });
            
            // 检查文件大小限制
            function checkFileSize(file) {
                const maxSize = 4 * 1024 * 1024 * 1024; // 4GB
                if (file.size > maxSize) {
                    showUploadError('文件大小超过4GB限制');
                    return false;
                }
                return true;
            }
            
            // 显示上传错误
            function showUploadError(message) {
                uploadError.textContent = message;
                uploadError.classList.remove('d-none');
            }
        });
    </script>
</body>
</html>

<?php
// 关闭数据库连接
$conn->close();
?>