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

<!-- bootbox code -->
<script src="<?=SERVER_PATH?>public/js/bootbox.min.js"></script>
<script>
    $(document).on("click", ".alert", function(e) {
        bootbox.alert("Hello world!", function() {
            console.log("Alert Callback");
        });
    });
    bootbox.confirm("Are you sure?", function(result) {
        console.log(result);
        if (result == true) {
            window.location.href = "http://stackoverflow.com";
        }
    });
</script>
</body>
</html>