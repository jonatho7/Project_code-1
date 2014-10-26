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
		
	<title><?= $e_Title?></title>
	
	<!-- Bootstrap core CSS -->
    <link href="<?=SERVER_PATH?>public/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<?=SERVER_PATH?>public/css/navbar-static-top.css" rel="stylesheet">

    <!-- Bootstrap JS -->
	<script src="<?=SERVER_PATH?>public/js/bootstrap.min.js"></script>
	
	
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="<?= SERVER_PATH ?>public/js/respond.js"></script>
	
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="container">
<!--Closing body tag is in the basic_footer.php file-->

    <!-- Static navbar -->
    <div class="navbar navbar-default navbar-static-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Flu Tracker</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="../navbar/">Log In</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>





