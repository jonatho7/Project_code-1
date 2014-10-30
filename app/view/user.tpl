<?php
	
	require_once '../controller/sessionAttributes.php';
	if (!isset($e_user)) {
		# Redirect as user is not logged in.
    	session_unset();
    	header('Location: '. SERVER_PATH. 'login/');
    	exit();
	}

?>

<?php
	$userQuery = $_GET["userQuery"];
?>

<?php
	//We need to determine whether the username from the userQuery is a valid user in the database.
	$profile_user = User::getUserByUserName($userQuery);
	if ($profile_user == null){
		//This user does not exist in the DB. 
		echo "<h2>I'm sorry</h2>";
		echo "<h3>This user was not found.</h3>";
		$redirectPath = SERVER_PATH . 'dashboard.php';
		echo '<p><a href="' . $redirectPath . '">Your Dashboard</a></p>';
		die();
	}
		
	$profile_userName = $profile_user->getUserid();
	//echo 'profile_userName ' . $profile_userName . '!';
	$userName = $e_user->getUserid();
	//echo 'userName ' . $userName . '!';


	if ($profile_userName == $userName){
		$viewingOwnProfile = true;
	} else {
		$viewingOwnProfile = false;
	}
	//echo 'viewing own profile: ' . $viewingOwnProfile ;
	
	$profile_firstName = $profile_user->getFirstName();
	$profile_middleName = $profile_user->get('middleName');
	$profile_lastName = $profile_user->getLastName();
	$profile_visibility = $profile_user->get('visibility');
	$profile_emailAddress = $profile_user->get('emailAddress');
?>

<div>
	<div class="userTPL_left">
		<img alt="Profile Picture" src="<?=SERVER_PATH?>public/img/emptyProfilePicLarge.jpg">
	</div>

	<div>
		<h1 class="profileHeader">Profile</h1>
	</div>
	
	
	<div class="profileDiv">
		
		<h3>Name</h3>
		<div>
			<p class="userTPL_profile"><strong>First: </strong></p>
			<p class="userTPL_profile"><?php echo $profile_firstName?></p>
		</div>
		<div>
			<p class="userTPL_profile"><strong>Middle: </strong></p>
			<p class="userTPL_profile">
				<?php 
					if($profile_middleName != NULL){
						echo $profile_middleName;
					}
				?>
			</p>
		</div>
		<div>
			<p class="userTPL_profile"><strong>Last: </strong></p>
			<p class="userTPL_profile"><?php echo $profile_lastName?></p>
		</div>
	</div>
	
	
	<div class="profileDiv">
		<h3>Username</h3>
		<p class="userTPL_profile"><strong>Username: </strong></p>
		<p class="userTPL_profile"><?php echo $profile_userName?></p>
	</div>
	
	<div class="profileDiv">
		<h3>Email Address</h3>
		<?php
			if ($viewingOwnProfile == true){
				echo "<div>";
					echo '<p class="userTPL_profile"><strong>Visibility: </strong></p>';
					echo '<p class="userTPL_profile">';
						if($profile_visibility == "y"){
							echo "public";
						} else {
							echo "private";
						}
					echo "</p>";
				echo "</div>";
			}
		?>
		
		<div>
			<p class="userTPL_profile"><strong>Email: </strong></p>
			<p class="userTPL_profile"><?php echo $profile_emailAddress?></p>
		</div>
		
	</div>
	
	<div class="clearFloat">
		<!--  Add the buttons now side by side -->
        <button class="btn btn-primary btn-sm" >Discard Changes</button>
        <button formmethod="post" formaction="<?=SERVER_PATH?>processUserEdit.php" type="submit" class="btn btn-primary btn-sm">Submit Changes</button>
     	
	</div>

</div>






