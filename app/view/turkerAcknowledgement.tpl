<?php

require_once '../config.php';
require_once '../controller/AMTTurkerState.php';

/*
 *	Displays an acknowlegement to Turker
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
		
	<title>Acknowledgment Page</title>
	
	<!-- Bootstrap core CSS -->
    <link href="<?php echo SERVER_PATH?>public/css/bootstrap.min.css" rel="stylesheet">

	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	 <!-- Bootstrap JS -->
	 <script src="<?php echo SERVER_PATH?>public/js/bootstrap.min.js"></script>
	 
	 <!--  Validation API -->
	 <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.js"></script>

   
</head>

<body class="container">
	<div class="row">
		<div class="jumbotron">
  			<h2>Thanks for completing the HIT. <br>
  				Click "complete" button below to finish working on the HIT.
  			</h2>
  			<form method="post" action="<?=AMT_SUBMIT_FORM?>">
  				<button class="btn btn-primary btn-md">Complete</button>
  				<input type="hidden" name=<?=WORKER_ID?> value="<?=getWorkerId()?>">
  				<input type="hidden" name="<?=ASSIGNMENT_ID?>" value="<?=getAssignmentId()?>">
  			</form>
		</div>
	</div>

<?php 
	/*
	 * Remove all the session variables.
	 */
	session_unset();
	require_once 'basicAmtWorkerFooter.tpl';
?>