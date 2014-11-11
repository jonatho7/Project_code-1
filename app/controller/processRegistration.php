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
	$userRegistrationErrors['firstName'] = "First name is mandatory";	
} else {
	$firstName = $_POST['firstName'];
}

if (empty($_POST['lastName'])) {
	$userRegistrationErrors['lastName'] = "Last name is mandatory";
} else {
	$lastName = $_POST['lastName'];
}

if (empty($_POST['userName'])) {
	$userRegistrationErrors['userName'] = "Username is empty";
} else {
	$userName = $_POST['userName'];
}

if (empty($_POST['emailAddress'])) {
	$userRegistrationErrors['emailAddress'] = "Email Address is empty";
} else {
	$emailAddress = $_POST['emailAddress'];
}

if (empty($_POST['confirmEmailAddress'])) {
	$userRegistrationErrors['confirmEmailAddress'] = "Confirm Email Address is empty";
} else {
	$confirmEmailAddress = $_POST['confirmEmailAddress'];
}

if (empty($_POST['password'])) {
	$userRegistrationErrors['password'] = "Password is empty";
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

# Check if email address entered twice are the same
if ($confirmEmailAddress != $emailAddress) {
	$userRegistrationErrors['confirmEmailAddress'] = "Email Addresses don't match.";
	sendRedirect('userRegistrationErrors', $userRegistrationErrors, 'register');
}

//middle name is optional.
$middleName = $_POST['middleName'];

if (isset($_POST['emailVisibility'])  && ($_POST['emailVisibility'] == 'Public')){
	$emailVisibility = 'Public';
} else {
	$emailVisibility = 'Private';
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

/*
 * Now create the new user in the system
 */
$userArgument = Array(
					'firstName'=>$firstName,
					'lastName'=>$lastName,
					'middleName'=>$middleName,
					'userId'=>$userName,
					'profilePic'=>$profilePic,
					'emailVisibility'=>$emailVisibility,
					'password'=>$password,
					'emailAddress'=>$emailAddress);

$user = new User($userArgument, True);


session_unset(); # Free all session specific data

require_once 'login.php';


