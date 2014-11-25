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
        echo "<h4 class='userNotFound'>This user was not found.</h4>";
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
	$profile_visibility = $profile_user->get('emailVisibility');
	$profile_emailAddress = $profile_user->get('emailAddress');
?>

<div>

	<div>
		<h1>Friends</h1>
	</div>

	<div class="followDiv">
		<h3>Following:</h3>
	<?php
	
	/*
	 * Get the following list for a user from DB.
	 */
	
	$followingArray = User::getUsersFollowingById($profile_user->getUserPKId());
	
	if ( count($followingArray) == 0){
		$findFriendsPath = SERVER_PATH . 'app/controller/searchUsers.php';
		echo "<p>You are not following any users yet. See the <a href='$findFriendsPath'>Find Users</a> page to find users to follow.</p>";
	} else {
		for ($index = 0; $index < count($followingArray); $index++) {
			$friendPath = SERVER_PATH . "users/" . $followingArray[$index];
			echo "<p><a href='$friendPath'>$followingArray[$index]</a></p>";
		}
	}
		
	?>
	
	<div class="followDiv">
		<h3>Followers:</h3>
	<?php
	
	/*
	 * Get Followers for profile user from database.
	 * 
	 */
	$followersArray = User::getUsersFollowersById($profile_user->getUserPKId());
	
	if ( count($followersArray) == 0){
		echo "<p>You do not have any followers yet.</p>";
	} else {
		for ($index = 0; $index < count($followersArray); $index++) {
			$friendPath = SERVER_PATH . "users/" . $followersArray[$index];
			echo "<p><a href='$friendPath'>$followersArray[$index]</a></p>";
		}
	}
	?>
	</div>

	
</div>







