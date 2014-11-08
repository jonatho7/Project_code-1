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

	<div>
		<h1>Friends</h1>
	</div>

	<div class="followDiv">
		<h3>Following:</h3>
	<?php
	//TODO. Get these values from the database.
	//Hardcode.
	$followingArray = array("jonatho7", "sarang87", "harshalh", "otherdude", "otherdude2", "otherdude3");
	
	for ($index = 0; $index < count($followingArray); $index++) {
		$friendPath = SERVER_PATH . "users/" . $followingArray[$index];
		echo "<p><a href='$friendPath'>$followingArray[$index]</a></p>";
	}	
	?>
	
	<div class="followDiv">
		<h3>Followers:</h3>
	<?php
	//TODO. Get these values from the database.
	//Hardcode.
	$followersArray = array("harshalh", "jonatho7", "other", "other2", "other3", "other4");
			
	for ($index = 0; $index < count($followersArray); $index++) {
		$friendPath = SERVER_PATH . "users/" . $followersArray[$index];
		echo "<p><a href='$friendPath'>$followersArray[$index]</a></p>";
	}	
	?>
	</div>

	
</div>







