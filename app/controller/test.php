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


<!-- JS dependencies -->
<script src="<?php echo  SERVER_PATH ?>public/js/jquery-1.11.0.js"></script>
<script src="<?=SERVER_PATH?>public/js/bootstrap.min.js"></script>

<?php

// Test if our data came through
if (isset($_POST["points"])) {
    // Decode our JSON into PHP objects we can use
    $points = json_decode($_POST["points"]);
    var_dump($points);
}


?>
</body>
</html>