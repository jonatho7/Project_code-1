<?php
  
	/*
	 * While including do the following:
	 *  1) Include global configuration file
	 *  2) $e_Title = Title of the page.
	 */

?>

<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><?php echo $e_Title?></title>

    <!-- Bootstrap Core CSS -->
    <link href="<?php echo  SERVER_PATH ?>public/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="<?php echo  SERVER_PATH ?>public/css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<?php echo  SERVER_PATH ?>public/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- jQuery Version 1.11.0 -->
    <script src="<?php echo  SERVER_PATH ?>public/js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<?php echo  SERVER_PATH ?>public/js/bootstrap.min.js"></script>

    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.js"></script>


</head>

<body>

    <!---    
		This wraps everything in the page.
    -->
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand" href="<?php echo  SERVER_PATH ?>">Flu Tracker</a>
            </div>
            
            
            <!-- /.navbar-collapse -->
        </nav>


        <div id="page-wrapper">			
			<div class="container-fluid">
			<?php 
				
			/*
			 *  This is where the content for each page will go in.
			 *  One could add breadcrumbs, header, and other elements.
			 */
			?>