<?php
session_start();
$servername = "******";
$username = "******";
$password = "******";
$dbname = "******";

// 创建数据库连接
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die(json_encode(['success' => false, 'message' => '数据库连接失败']));
}

// 设置字符集
$conn->set_charset("utf8");

// 检查用户是否登录
if (!isset($_SESSION['user_id'])) {
    die(json_encode(['success' => false, 'message' => '请先登录']));
}

// 创建上传临时目录
$tmpDir = 'uploads/tmp/';
if (!is_dir($tmpDir)) {
    mkdir($tmpDir, 0777, true);
}

// 处理分块上传
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['file'])) {
    $chunk = isset($_POST['chunk']) ? (int)$_POST['chunk'] : 0;
    $chunks = isset($_POST['chunks']) ? (int)$_POST['chunks'] : 0;
    $filename = isset($_POST['filename']) ? $_POST['filename'] : '';
    
    // 清理文件名
    $cleanName = preg_replace('/[^a-zA-Z0-9\._-]/', '_', $filename);
    $filePath = $tmpDir . $cleanName . '.part' . $chunk;
    
    // 移动上传的分块
    if (move_uploaded_file($_FILES['file']['tmp_name'], $filePath)) {
        // 检查是否所有分块都已上传
        $allUploaded = true;
        for ($i = 0; $i < $chunks; $i++) {
            if (!file_exists($tmpDir . $cleanName . '.part' . $i)) {
                $allUploaded = false;
                break;
            }
        }
        
        if ($allUploaded) {
            // 所有分块已上传，合并文件
            $finalPath = 'uploads/' . uniqid() . '_' . $cleanName;
            $out = fopen($finalPath, 'wb');
            
            if ($out) {
                for ($i = 0; $i < $chunks; $i++) {
                    $partPath = $tmpDir . $cleanName . '.part' . $i;
                    $in = fopen($partPath, 'rb');
                    if ($in) {
                        while ($buff = fread($in, 4096)) {
                            fwrite($out, $buff);
                        }
                        fclose($in);
                        unlink($partPath); // 删除分块
                    }
                }
                fclose($out);
                
                // 保存到数据库
                $title = $_POST['title'];
                $description = $_POST['description'];
                $categories = json_decode($_POST['categories'], true);
                $file_size = filesize($finalPath);
                
                $stmt = $conn->prepare("INSERT INTO materials (title, description, filename, original_name, file_size, uploader_id) VALUES (?, ?, ?, ?, ?, ?)");
                $baseName = basename($finalPath);
                $stmt->bind_param("ssssii", $title, $description, $baseName, $filename, $file_size, $_SESSION['user_id']);
                
                if ($stmt->execute()) {
                    $material_id = $stmt->insert_id;
                    
                    // 保存分类信息
                    if (!empty($categories)) {
                        foreach ($categories as $category_id) {
                            $category_stmt = $conn->prepare("INSERT INTO material_categories (material_id, category_id) VALUES (?, ?)");
                            $category_stmt->bind_param("ii", $material_id, $category_id);
                            $category_stmt->execute();
                            $category_stmt->close();
                        }
                    }
                    
                    echo json_encode(['success' => true, 'message' => '文件上传成功']);
                } else {
                    unlink($finalPath); // 删除文件
                    echo json_encode(['success' => false, 'message' => '数据库保存失败']);
                }
                $stmt->close();
            } else {
                echo json_encode(['success' => false, 'message' => '无法创建最终文件']);
            }
        } else {
            echo json_encode(['success' => true, 'message' => '分块上传成功']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => '分块上传失败']);
    }
} else {
    echo json_encode(['success' => false, 'message' => '无效请求']);
}

// 关闭数据库连接
$conn->close();
?>