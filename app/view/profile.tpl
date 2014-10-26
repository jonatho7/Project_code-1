<?php
	
	require_once '../controller/sessionAttributes.php';
	if (!isset($e_user)) {
		# Redirect as user is not logged in.
    	session_unset();
    	require_once 'login.php';
    	exit();
	}

?>

<h1>Profile</h1>

<?php
	$userName = $e_user->getUserid();
	$firstName = $e_user->getFirstName();
	$middleName = $e_user->get('middleName');
	$lastName = $e_user->getLastName();
	$visibility = $e_user->get('visibility');
?>

<img alt="Profile Picture" src="<?=SERVER_PATH?>public/img/emptyProfilePicLarge.jpg">

<p class="profileElement"><strong>Username: </strong><?php echo $userName?></p>

<p class="profileElement"><strong>First Name: </strong><?php echo $firstName?> </p>

<p class="profileElement"><strong>Middle Name: </strong>
	<?php 
		if($middleName != NULL){
			echo $middleName;
		}
	?>
</p>

<p class="profileElement"><strong>Last Name: </strong><?php echo $lastName?> </p>

<p class="profileElement"><strong>Password: </strong></p>

<p class="profileElement"><strong>Profile Visibility: </strong>
	<?php 
		if($visibility == "y"){
			echo "public";
		} else {
			echo "private";
		}
	?>
</p>