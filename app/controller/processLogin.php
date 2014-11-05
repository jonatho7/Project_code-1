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


if (sizeof($userRegistrationErrors) != 0) {
	sendRedirect('userRegistrationErrors', $userRegistrationErrors, 'login');
}

#Check if userid exists in the database.
$user = User::getUserByUserName($userName);
if ($user == NULL) {
	$userRegistrationErrors['userName'] = "User name $userName does not exist.";
	sendRedirect('userRegistrationErrors', $userRegistrationErrors, 'login');
} else {
	#Now Check to see if the password is correct.
	$password = $_POST['password'];
	if ($user->get('password') != $password ){
		$userRegistrationErrors['password'] = "Password is not valid.";
		sendRedirect('userRegistrationErrors', $userRegistrationErrors, 'login');
	} else {
		#Set some kind of session here??
		#Then redirect to the home page.
		# Set the user name before passing the control.
		# Don't include, but do a redirect
		#unset($_SESSION['varname']);.
		sendRedirect("userName", $userName, 'dashboard.php');
		// Won't reach here  
	}
}
