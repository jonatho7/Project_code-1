<?php 

/* 
 * Note: the convention:
 * any arguments passed will have
 * $e_* naming convention.
 *  This will include the necessary content for 
 *  running with bootstrap code.
 *  
 *  $e_Preview = hit being preview or not
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
	<?php 
		if (!empty($e_Preview)) { ?>
			<div class="alert alert-warning" role="alert"> 
				Preview Mode. Accept HIT to complete the task.
			</div>
		<?php }
	?>
	<div class="panel panel-primary">
		<div class="panel-heading">
    		<h3 class="panel-title">Instructions for completing the Task</h3>
  		</div>
  		<div class="panel-body">
    		<p>
    			This assignment would consist of 10 plots (1 plot per page). A
    			plot will consist of 3 time series curves indicated by following colors:<br>
    			<ul>
  					<li>Black</li>
  					<li>Red</li>
  					<li>Blue</li>
				</ul>
				The task is to determine which curve i.e. red or blue curve that fits/predicts/follows
				black curve.
    		</p>
  		</div>
	</div>