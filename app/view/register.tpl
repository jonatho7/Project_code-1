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

<h1>Register</h1>
<h3 style="margin-top: 1em; margin-bottom: 1em;">
	Register for the world's largest flu tracking system. You'll be up and running in no time.
</h3>

<form role="form" enctype="multipart/form-data">
   <div class="form-group">
      <label for="name">Name</label>
      <br />
      
      <input type="text" class="form-control" id="firstName" 
         placeholder="First" name="firstName" style="display: inline; width: 200px;">
      
      <input type="text" class="form-control" id="middleName" name="middleName"
         placeholder="Middle (Optional)" style="display: inline; width: 200px;">
      
      <input type="text" class="form-control" id="lastName" name="lastName"
         placeholder="Last" style="display: inline; width: 200px;">
   </div>

   <div class="form-group">
      <label for="username">Choose a Username: </label>
      <br />
      <input type="text" class="form-control" id="userName" name="userName"
         placeholder="Username" style="display: inline; width: 200px;">
   </div>
   
   <div class="form-group">
      <label for="emailAddress">Email Address: </label>
      
      <input type="text" class="form-control" id="emailAddress" name="emailAddress"
         placeholder="" style="width: 200px;">
   </div>
   
   <div class="form-group">
      <label for="confirmEmailAddress">Confirm Your Email Address: </label>
      
      <input type="text" class="form-control" id="confirmEmailAddress" name="confirmEmailAddress"
         placeholder="" style="width: 200px;">
   </div>
   
   <div class="form-group">
		<label for="emailVisibility">Email Visibility: </label>
		
		<select class="form-control" id="emailVisibility" name="emailVisibility" style="width: 200px;">
			<option>Public</option>
			<option>Private</option>
		</select>
	</div>
   
   <div class="form-group">
      <label for="password">Password: </label>
      
      <input type="password" class="form-control" id="password" name="password"
         placeholder="" style="width: 200px;">
   </div>  
   
   <div class="form-group">
      <label for="confirmPassword">Confirm Your Password: </label>
      <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
         placeholder="" style="width: 200px;">
   </div>  
   
   <button type="submit" class="btn btn-default" style="margin: 2em 0 2em 0;" 
   		formmethod="post" formaction="<?php echo SERVER_PATH?>processRegistration.php">Submit
   </button>
</form>