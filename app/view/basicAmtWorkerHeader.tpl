<?php 

/* 
 * Note: the convention:
 * any arguments passed will have
 * $e_* naming convention.
 *  This will include the necessary content for 
 *  running with bootstrap code.
 * 
 */

?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
		
		<!--Change this icon-->
    <link rel="icon" href="../../favicon.ico">
		
	<title><?php echo  $e_Title?></title>
	
	<!-- Bootstrap core CSS -->
    <link href="<?php echo SERVER_PATH?>public/css/bootstrap.min.css" rel="stylesheet">

	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	 <!-- Bootstrap JS -->
	 <script src="<?php echo SERVER_PATH?>public/js/bootstrap.min.js"></script>
	 
	 <!--  Validation API -->
	 <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.js"></script>

   
</head>

<body class="container">
