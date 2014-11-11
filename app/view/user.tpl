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
		//This user does not exist in the DB. Display a message.
		echo "<h2>I'm sorry</h2>";
		echo "<h3>This user was not found.</h3>";
		$redirectPath = SERVER_PATH . 'dashboard.php';
		echo '<p><a href="' . $redirectPath . '">Your Dashboard</a></p>';
		die();
	}
		
	$profile_userName = $profile_user->getUserid();
	$userName = $e_user->getUserid();

	if ($profile_userName == $userName){
		$viewingOwnProfile = true;
	} else {
		$viewingOwnProfile = false;
	}
	
	$profile_firstName = $profile_user->getFirstName();
	$profile_middleName = $profile_user->get('middleName');
	$profile_lastName = $profile_user->getLastName();
	$profile_email_visibility = $profile_user->get('emailVisibility');
	$profile_emailAddress = $profile_user->get('emailAddress');
?>

<div class="profileContainer">
	<div class="userTPL_left">
		<div>
			<img alt="Profile Picture" src="<?php echo SERVER_PATH?>public/img/emptyProfilePicLarge.jpg">
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
					echo '<p class="userTPL_profile"><strong>Email Visibility: </strong></p>';
					echo '<p class="userTPL_profile userTPL_visibility">';
						if($profile_email_visibility == "Public"){
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
			<?php
				if($profile_email_visibility == "Public"){
					echo "<p class='userTPL_profile userTPL_email'>{$profile_emailAddress}</p>";
				} else {
					echo "<p class='userTPL_profile userTPL_email'>Private</p>";
				}
			?>
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
	
	<?php
		//TODO. Hardcode. Need to get from the database whether you are following the other user or not.
		$followingOtherUser = false;
		
		//If a user is viewing someone else's profile, show the Follow button.
		if ($viewingOwnProfile == false){
			echo '<div class="followButtonsDiv">';
				//echo "<button type='submit' class='btn btn-primary btn-sm followButton' >Follow</button>";
				echo "<button type='submit' class='btn btn-warning btn-sm followButton";
				if ($followingOtherUser == true){
					echo " buttonDisplayHidden";
				} else {
					echo " buttonDisplayInherit";
				}
				echo "' >Follow</button>";
			echo '</div>';
			echo '<div class="followButtonsDiv">';
				//echo "<button type='button' class='btn btn-primary btn-sm unfollowButton' >Unfollow</button>";
				echo "<button type='button' class='btn btn-warning btn-sm unfollowButton";
				if ($followingOtherUser == true){
					echo " buttonDisplayInherit";
				} else {
					echo " buttonDisplayHidden";
				}
				echo "' >Unfollow</button>";
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
			// Get the following list from the User class
			
			$followingArray = User::getUsersFollowingById($profile_user->getUserPKId());
			$maxFriendsToShow = 5;	//Only show this many friends.
			$indexMax = $maxFriendsToShow;
			if (count($followingArray) < $maxFriendsToShow){
				$indexMax = count($followingArray);
			}
			
			//Don't echo the seperator for the last entry
			$sep = ',';
			for ($index = 0; $index < $indexMax; $index++) {
				$friendPath = SERVER_PATH . "users/" . $followingArray[$index];
				if ($index == ($indexMax -1))
					$sep = '';
				echo "<p class='userTPL_profile'><a href='$friendPath'>$followingArray[$index]</a>$sep </p>";
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
			// Get followers from database; 
			$followersArray = User::getUsersFollowersById($profile_user->getUserPKId());
			
			$indexMax = $maxFriendsToShow;
			if (count($followersArray) < $maxFriendsToShow){
				$indexMax = count($followersArray);
			}
			
			$sep = ',';
			for ($index = 0; $index < $indexMax; $index++) {
				$friendPath = SERVER_PATH . "users/" . $followersArray[$index];
				if ($index == ($indexMax-1))
					$sep = '';
				echo "<p class='userTPL_profile'><a href='$friendPath'>$followersArray[$index]</a>$sep </p>";
			}
			
			if (count($followersArray) > $maxFriendsToShow){
				$redirectPath = SERVER_PATH . "users/" . $userQuery . "/friends";
				echo "<p class='userTPL_profile'><a href ='$redirectPath'>...</a></p>";
			}
		?>
		</div>
		
		<div>
			<?php
				$redirectPath = SERVER_PATH . "users/" . $userQuery . "/friends";
				echo "<p><a href ='$redirectPath'>(Show All)</a></p>";
			?>
		</div>
		
	</div>
	
	<div class="userActivityFeed">
		<div>
			<h3>Activity Feed</h3>
		</div>
		<?php
			/*
			 *TODO. Need to get all activities which correspond to the specific user.
			 *...Get the entire rows of the activity_log table which have a user_id or user_id2
			 *which corresponds to the user_id of "vivekb88", for example.
			 *
			 *What needs to be done: Provide the $activities array, which is accessed from the database.
			 *
			 **/
			
			//Some hardcode, for testing. ...
			//DELETE after database access is implemented.(Start)
			
			$activity1 = new Activity();
			$activity1->set('activity_type_id',3);
			$activity1->set('user_id_string','vivekb88');
			$activity1->set('date_modified_new','2014-10-21 18:53:33');
			$activity1->set('up_value_new','130');
			$activity1->set('up_date','2014-10-12');
			$activity1->set('r_name','West Virginia');
			$activity1->set('comment_new','This is so much fun!');
			
			$activity2 = new Activity();
			$activity2->set('activity_id',1);
			$activity2->set('u_id',1);
			$activity2->set('user_id_string','vivekb88');
			$activity2->set('activity_type_id',1);
			$activity2->set('date_modified_new','2014-11-09 13:29:28');
			$activity2->set('date_modified_old','2014-11-07 09:19:02');
			$activity2->set('first_name_new','Vivek');
			$activity2->set('first_name_old','Vive');
			$activity2->set('middle_name_new','Bharath');
			$activity2->set('middle_name_old','B');
			$activity2->set('last_name_new','Akupatni');
			$activity2->set('last_name_old','Ak.');
			
			$activity3 = new Activity();
			$activity3->set('activity_type_id',2);
			$activity3->set('user_id_string','vivekb88');
			$activity3->set('user_id2_string','jonatho7');
			$activity3->set('date_modified_new','2014-11-09 13:33:41');
			
			$activity4 = new Activity();
			$activity4->set('activity_type_id',2);
			$activity4->set('user_id_string','harshalh');
			$activity4->set('user_id2_string','vivekb88');
			$activity4->set('date_modified_new','2014-11-09 13:35:05');
			
			$activity5 = new Activity();
			$activity5->set('activity_type_id',4);
			$activity5->set('user_id_string','vivekb88');
			$activity5->set('date_modified_new','2014-11-09 13:48:47');
			$activity5->set('up_value_new','200');
			$activity5->set('up_date','2014-10-12');
			$activity5->set('r_name','West Virginia');
			$activity5->set('comment_new','I think this prediction will be more accurate, actually.');
			
			$activity6 = new Activity();
			$activity6->set('activity_type_id',5);
			$activity6->set('user_id_string','vivekb88');
			$activity6->set('date_modified_new','2014-11-09 13:51:55');
			$activity6->set('up_date','2014-10-12');
			$activity6->set('r_name','West Virginia');
			
			//The activities array.
			$activities = array($activity1, $activity2, $activity3, $activity4, $activity5, $activity6);
			//DELETE after database access is implemented.(End)
			
			//Max number of activity feed items to show.
			$max_activity_feed = 20;
			
			//iterate over the activity feed.
			for($index = 0; $index < count($activities) && $index < $max_activity_feed; $index++){
				$activity = $activities[$index];
				
				if ($activity->get('activity_type_id') == 1){
					echo '<div class="activityFeedDiv">';
						$newName = $activity->get('first_name_new') . " " . $activity->get('middle_name_new') . " " . $activity->get('last_name_new');
						echo "<p class='activityFeedParag'><a href='SERVER_PATH . 'users/' . {$activity->get('user_id_string')}'>{$activity->get('user_id_string')}</a> changed their name to {$newName}</p>";
						echo "<p class='activityFeedParag activityFeedDate'>{$activity->getDate_Modified_New()}</p>";
					echo '</div>';
				}
				
				if ($activity->get('activity_type_id') == 2){
					echo '<div class="activityFeedDiv">';
						$newName = $activity->get('first_name_new') . " " . $activity->get('middle_name_new') . " " . $activity->get('last_name_new');
						echo "<p class='activityFeedParag'><a href='SERVER_PATH . 'users/' . {$activity->get('user_id_string')}'>{$activity->get('user_id_string')}</a> is now following <a href='SERVER_PATH . 'users/' . {$activity->get('user_id2_string')}'>{$activity->get('user_id2_string')}</a></p>";
						echo "<p class='activityFeedParag activityFeedDate'>{$activity->getDate_Modified_New()}</p>";
					echo '</div>';
				}
				
				if ($activity->get('activity_type_id') == 3){
					echo '<div class="activityFeedDiv">';
						echo "<p class='activityFeedParag'><a href='SERVER_PATH . 'users/' . {$activity->get('user_id_string')}'>{$activity->get('user_id_string')}</a> made a new prediction for {$activity->get('r_name')} for {$activity->get('up_date')}.</p>";
						echo "<p class='activityFeedParag activityFeedDate'>{$activity->getDate_Modified_New()}</p>";
						echo "<p class='activityFeedComment'><strong>\"{$activity->get('comment_new')}\"</strong></p>";
					echo '</div>';
				}
				
				if ($activity->get('activity_type_id') == 4){
					echo '<div class="activityFeedDiv">';
						echo "<p class='activityFeedParag'><a href='SERVER_PATH . 'users/' . {$activity->get('user_id_string')}'>{$activity->get('user_id_string')}</a> modified their prediction for {$activity->get('r_name')} for {$activity->get('up_date')}.</p>";
						echo "<p class='activityFeedParag activityFeedDate'>{$activity->getDate_Modified_New()}</p>";
						echo "<p class='activityFeedComment'><strong>\"{$activity->get('comment_new')}\"</strong></p>";
					echo '</div>';
				}
				
				if ($activity->get('activity_type_id') == 5){
					echo '<div class="activityFeedDiv">';
						echo "<p class='activityFeedParag'><a href='SERVER_PATH . 'users/' . {$activity->get('user_id_string')}'>{$activity->get('user_id_string')}</a> deleted their prediction for {$activity->get('r_name')} for {$activity->get('up_date')}.</p>";
						echo "<p class='activityFeedParag activityFeedDate'>{$activity->getDate_Modified_New()}</p>";
					echo '</div>';
				}
			}
		?>
		
		<!--
		<div>
			<p><strong>Hard code examples, which correllate to the activity_log table in mysql...Will make more dynamic soon.</strong></p>
			<p>vivekb88 changed their name to Vivek Bharath Akupatni</p>
			<p>vivekb88 is now following jonatho7</p>
			<p>harshalh is now following vivekb88</p>
			<p>vivekb88 made a new prediction for West Virginia for 2014-10-12. "This is so much fun!"</p>
			<p>vivekb88 modified their prediction for West Virginia for 2014-10-12. "I think this prediction will be more accurate, actually."</p>
			<p>vivekb88 deleted their prediction for West Virginia for 2014-10-29."</p>
		</div>
		-->
		
	</div>
	
</div>







