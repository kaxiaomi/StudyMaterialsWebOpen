<?php
session_start();
require_once 'base.php'; // 包含数据库连接代码

// 检查管理员权限
if (!isset($_SESSION['role']) || $_SESSION['role'] != 'admin') {
    header("Location: index.php");
    exit();
}

// 处理解禁请求
$unban_message = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['unban_ip'])) {
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

// 获取黑名单列表
$blacklist_ips = getBlacklistIPs($conn);
?>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP黑名单管理 - 学习资料共享平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .table-responsive {
            margin-top: 20px;
        }
        .action-form {
            display: inline;
        }
    </style>
</head>
<body>
    <?php include 'navbar.php'; // 包含导航栏 ?>
    
    <div class="container mt-4">
        <h2>IP黑名单管理</h2>
        
        <?php if (!empty($unban_message)): ?>
            <div class="alert alert-info"><?php echo $unban_message; ?></div>
        <?php endif; ?>
        
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">手动解禁IP</h5>
            </div>
            <div class="card-body">
                <form method="POST" class="row g-3">
                    <div class="col-auto">
                        <label for="ip_address" class="visually-hidden">IP地址</label>
                        <input type="text" class="form-control" id="ip_address" name="ip_address" 
                               placeholder="输入要解禁的IP地址" required>
                    </div>
                    <div class="col-auto">
                        <button type="submit" name="unban_ip" class="btn btn-primary">解禁IP</button>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">当前黑名单列表</h5>
            </div>
            <div class="card-body">
                <?php if (count($blacklist_ips) > 0): ?>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>IP地址</th>
                                    <th>封禁原因</th>
                                    <th>封禁时间</th>
                                    <th>解禁时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($blacklist_ips as $ip): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($ip['ip_address']); ?></td>
                                        <td><?php echo htmlspecialchars($ip['reason']); ?></td>
                                        <td><?php echo $ip['created_at']; ?></td>
                                        <td>
                                            <?php 
                                            if ($ip['expires_at']) {
                                                echo $ip['expires_at'];
                                            } else {
                                                echo '永久封禁';
                                            }
                                            ?>
                                        </td>
                                        <td>
                                            <form method="POST" class="action-form">
                                                <input type="hidden" name="ip_address" value="<?php echo $ip['ip_address']; ?>">
                                                <button type="submit" name="unban_ip" class="btn btn-sm btn-success">解禁</button>
                                            </form>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <p class="text-muted">黑名单为空</p>
                <?php endif; ?>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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