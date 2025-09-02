
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
                        <a class="nav-link active" href="admin_blacklist.php">IP黑名单管理</a>
                    </li>
                <?php endif; ?>
            </ul>
        </div>
    </div>
</nav>
