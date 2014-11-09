<?php

require_once '../config.php';

require_once 'sessionAttributes.php';
require_once '../model/User.class.php';

// Always get the fresh copy
$userRegistrationErrors = [];

function sendRedirect($key, $value, $url) {
	/*
	 * Note this function does the redirection to page while
	 * storying the pair in session object.
	 */
	$_SESSION[$key] = $value;
	header('Location: '. SERVER_PATH. $url);
	exit();
	
}

if (empty($_POST['firstName'])) {
	$userRegistrationErrors['firstName'] = "first name is mandatory";	
} else {
	$firstName = $_POST['firstName'];
}

if (empty($_POST['lastName'])) {
	$userRegistrationErrors['lastName'] = "Last name is mandatory";
} else {
	$lastName = $_POST['lastName'];
}

if (empty($_POST['userName'])) {
	$userRegistrationErrors['userName'] = "username is empty";
} else {
	$userName = $_POST['userName'];
}

if (empty($_POST['password'])) {
	$userRegistrationErrors['password'] = "password is empty";
} else {
	$password = $_POST['password'];
}

if (empty($_POST['confirmPassword'])) {
	$userRegistrationErrors['confirmPassword'] = "Re-enter same password again";
} else {
	$confirmPassword = $_POST['confirmPassword'];
}

if (sizeof($userRegistrationErrors) != 0) {
	sendRedirect('userRegistrationErrors', $userRegistrationErrors, 'register');
}

#Check if userid already exits
$user = User::getUserByUserName($userName);

if ($user != NULL) {
	$userRegistrationErrors['userName'] = "User name $userName already exists. Choose Another one";
	sendRedirect('userRegistrationErrors', $userRegistrationErrors, 'register');
}

# Check if password entered twice are the same
if ($confirmPassword != $password) {
	$userRegistrationErrors['password'] = "Passwords don't match.";
	sendRedirect('userRegistrationErrors', $userRegistrationErrors, 'register');
	
}

// dont' care
$middleName = $_POST['middleName'];

if (isset($_POST['profileVisibility'])  && ($_POST['profileVisibility'] == 'yes')){
	$profileVisibility = 'n';
} else {
	$profileVisibility = 'y';
	//echo '<br> The profile is not set';
}

#Everything so far is good. Just copy the profile picture 
#provided by the user.
#
# NOTE: This functionality is not yet implemented. However,
# code exists.
#
if (isset($_FILES["inputFile"]) && (!empty($_FILES["inputFile"]))) {
	
	if ($_FILES['inputFile']['error'] > 0) {
		# silently skip the error as this field is not mandatory
		$profilePic = "";

	} else {
		# Move the file to ../model/profiles/userId_<filename>.*
		$profilePic = $userName . '_' . $_FILES['inputFile']['name'];
		move_uploaded_file($_FILES["inputFile"]["tmp_name"], "../model/profiles/" . $profilePic);
	}
} else {
	$profilePic = "";
}

#echo "Everything is fine till now";

/*
 * Now create the new user in the system
 */
$userArgument = Array(
					'firstName'=>$firstName,
					'lastName'=>$lastName,
					'middleName'=>$middleName,
					'userId'=>$userName,
					'profilePic'=>$profilePic,
					'visibility'=>$profileVisibility,
					'password'=>$password);

$user = new User($userArgument, True);

#
# Should we redirect or include here??
#
session_unset(); # Free all session specific data

require_once 'login.php';


