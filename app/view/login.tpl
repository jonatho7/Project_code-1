<?php
	
	require_once '../controller/sessionAttributes.php';
	if (isset($_SESSION)) {
		$userErrors = getuserRegistrationErrors();
		foreach ($userErrors as $type => $text) {
			if (!empty($text)) {
				echo '<div class="alert alert-danger" role="alert">'. $text . '</div>';
			}
		}
	}

?>

<h1>Login</h1>
<h3 style="margin-top: 1em; margin-bottom: 1em;">
	Please type in your username and password in order to log in to the system!
</h3>

<?php
    /*
     * The following is a small style for errors. So, better this code be here rather than
     * anywhere else.
     */
?>
<script src="<?=SERVER_PATH?>public/js/errorValidation.js"></script>

<style>
    #formValidate label.error {
        width: auto;
        display: block;   /* Makes error to appear next to element */
        color: red;        /* Makes error messages red in color */
    }
</style>

<form role="form" enctype="multipart/form-data" id="formValidate" class="cmxform">

   <div class="form-group">
      <label for="username">Username: </label>
      <br />
      <input type="text" class="form-control" id="userName" name="userName"
         placeholder="Username" style="display: inline; width: 200px;">
   </div>
   
   <div class="form-group">
      <label for="password">Password: </label>
      
      <input type="password" class="form-control" id="password" name="password"
         placeholder="" style="width: 200px;">
   
   </div>  
   

   <button type="submit" class="btn btn-default" style="margin: 2em 0 2em 0;" 
   		formmethod="post" formaction="<?php echo SERVER_PATH?>processLogin.php">Submit
   </button>
   
</form>