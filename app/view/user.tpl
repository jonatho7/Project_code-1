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

<div class="profileContainer">
	<div class="userTPL_left">
		<div>
			<img alt="Profile Picture" src="<?=SERVER_PATH?>public/img/emptyProfilePicLarge.jpg">
		</div>
		
	</div>

	<div class="userTPL_left">
		<h2 class="profileHeader">Profile</h2>
		<h2 class="profileHeader"><?php echo $userQuery ?></h2>
	</div>
	
	<div class="clearFloat"></div>
	
	<div class="profileDiv">
		
		<h3>Name</h3>
		<div>
			<p class="userTPL_profile"><strong>First: </strong></p>
			<p class="userTPL_profile userTPL_firstName"><?php echo $profile_firstName?></p>
			<div>
				<input class="form-control userTPL_firstNameForm" type="text" required="" name="firstName">
			</div>
		</div>
		<div>
			<p class="userTPL_profile"><strong>Middle: </strong></p>
			<p class="userTPL_profile userTPL_middleName">
				<?php 
					if($profile_middleName != NULL){
						echo $profile_middleName;
					}
				?>
			</p>
			<div>
				<input class="form-control userTPL_middleNameForm" type="text" required="" name="middleName">
			</div>
		</div>
		<div>
			<p class="userTPL_profile"><strong>Last: </strong></p>
			<p class="userTPL_profile userTPL_lastName"><?php echo $profile_lastName?></p>
			<div>
				<input class="form-control userTPL_lastNameForm" type="text" required="" name="lastName">
			</div>
		</div>
	</div>
	
	
	
	
	<div class="profileDiv">
		<h3>Email Address</h3>
		<?php
			if ($viewingOwnProfile == true){
				echo "<div>";
					echo '<p class="userTPL_profile"><strong>Visibility: </strong></p>';
					echo '<p class="userTPL_profile userTPL_visibility">';
						if($profile_visibility == "y"){
							echo "Public";
						} else {
							echo "Private";
						}
					echo "</p>";
				echo "</div>";
			}
		?>
		<div class="form-group">
			<select class="form-control userTPL_visibilityForm" name="emailVisibility">
				<option>Public</option>
				<option>Private</option>
			</select>
		</div>
		
		<div>
			<p class="userTPL_profile"><strong>Email: </strong></p>
			<p class="userTPL_profile userTPL_email"><?php echo $profile_emailAddress?></p>
			<div>
				<input class="form-control userTPL_emailForm" type="text" required="" name="emailAddress">
			</div>
		</div>
		
		
		
	</div>
	
	<?php
		//If a user is viewing their own profile, create the password div.
		if ($viewingOwnProfile == true){
			echo '<div class="profileDiv">';
				echo '<div class="passwordDiv">';
					echo '<h3>Password</h3>';
					echo '<p class="userTPL_profile"><strong>New Password: </strong></p>';
					echo '<div>';
						echo '<input class="form-control userTPL_passwordForm" type="password" required="" name="password">';
					echo '</div>';
					echo '<p class="userTPL_profile"><strong>Confirm Password: </strong></p>';
					echo '<div>';
						echo '<input class="form-control userTPL_confirmPasswordForm" type="password" required="" name="confirmPassword">';
					echo '</div>';
				echo '</div>';
			echo '</div>';
		}
	?>
	
	<div class="profileDiv">
		<h3>Username</h3>
		<p class="userTPL_profile"><strong>Username: </strong></p>
		<p class="userTPL_profile userTPL_userName"><?php echo $profile_userName?></p>
	</div>
	
	<div class="clearFloat"></div>
	
	<div class="errorBox">
		<p id="errorMessage"></p>
	</div>
	
	<?php
		//If a user is viewing their own profile, show the Edit Buttons.
		if ($viewingOwnProfile == true){
			echo '<div class="editProfileDiv">';
				echo "<button type='submit' class='btn btn-primary btn-sm editProfileButton' >Edit Profile</button>";
			echo '</div>';
			echo '<div class="editProfileDiv">';
				echo "<button type='button' class='btn btn-primary btn-sm submitChangesButton' >Submit Changes</button>";
			echo '</div>';
		}
	?>
	
	
	
	<div class="clearFloat"></div>
	
	<div class="followersDiv">
		<div>
			<h3>Friends</h3>
		</div>
		
		<div class="followDiv">
			<p class="userTPL_profile"><strong>Following: </strong> </p>
		<?php
			//TODO. Need to get the actual followingArray values from the database.
			//Hardcode.
			$followingArray = array("jonatho7", "sarang87", "harshalh", "otherdude", "otherdude2", "otherdude3");
			$maxFriendsToShow = 5;	//Only show this many friends.
			$indexMax = $maxFriendsToShow;
			if (count($followingArray) < $maxFriendsToShow){
				$indexMax = count($followingArray);
			}
			
			for ($index = 0; $index < $indexMax; $index++) {
				$friendPath = SERVER_PATH . "users/" . $followingArray[$index];
				echo "<p class='userTPL_profile'><a href='$friendPath'>$followingArray[$index]</a>, </p>";
			}
			
			if (count($followingArray) > $maxFriendsToShow){
				$redirectPath = SERVER_PATH . "users/" . $userQuery . "/friends";
				echo "<p class='userTPL_profile'><a href ='$redirectPath'>...</a></p>";
			}
			
		?>
		</div>
		
		<div class="followDiv">
			<p class="userTPL_profile"><strong>Followers: </strong> </p>
		<?php
			//TODO. Need to get the actual followersArray values from the database.
			//Hardcode.
			$followersArray = array("harshalh", "jonatho7", "other", "other2", "other3", "other4");
			$indexMax = $maxFriendsToShow;
			if (count($followersArray) < $maxFriendsToShow){
				$indexMax = count($followersArray);
			}
			
			for ($index = 0; $index < $indexMax; $index++) {
				$friendPath = SERVER_PATH . "users/" . $followersArray[$index];
				echo "<p class='userTPL_profile'><a href='$friendPath'>$followersArray[$index]</a>, </p>";
			}
			
			if (count($followersArray) > $maxFriendsToShow){
				$redirectPath = SERVER_PATH . "users/" . $userQuery . "/friends";
				echo "<p class='userTPL_profile'><a href ='$redirectPath'>...</a></p>";
			}
		?>
		</div>
		
		<div>
			<p><a href="<?= SERVER_PATH . 'users/' . $userQuery . '/friends'?>">(Show All)</a>   </p>
		</div>
		
	</div>
	
	<div class="userActivityFeed">
		<div>
			<h3>Recent Activity</h3>
		</div>
		<div>
			<p>Something something something...</p>
			<p>Yada yada yada...</p>
			<p>someone did something really exciting.</p>
		</div>
	</div>
	
</div>







