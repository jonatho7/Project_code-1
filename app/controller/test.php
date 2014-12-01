<!DOCTYPE html>
<?
 require_once '../config.php';
?>
<html>
<head>
    <meta charset="utf-8">
    <title>My page</title>

    <!-- CSS dependencies -->
    <link rel="stylesheet" type="text/css" href="<?=SERVER_PATH?>public/css/bootstrap.min.css">
</head>
<body>

<p>Content here. <a class="alert" href=#>Alert!</a></p>

<!-- JS dependencies -->
<script src="<?php echo  SERVER_PATH ?>public/js/jquery-1.11.0.js"></script>
<script src="<?=SERVER_PATH?>public/js/bootstrap.min.js"></script>
<?php

    if (date_create('2014-10-10') > date_create('2014-10-11')) {
        echo "greater";
    } else {
        echo "lesser";
    }

?>
</body>
</html>