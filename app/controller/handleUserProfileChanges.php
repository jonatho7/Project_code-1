<?php

require_once '../config.php';

require_once 'sessionAttributes.php';
require_once '../model/User.class.php';


if (empty($_SESSION['userName'])) {
	# Redirect as user is not logged in.
	session_unset();
	#require_once 'login.php';
	header('Location: '. SERVER_PATH. 'login/');
	exit();
}

$user = User::getUserByUserName($_SESSION['userName']);

if ($user == NULL) {
	# CHANGE ME to login folder.
	header('Location: '. SERVER_PATH. 'login/');
	exit();
}
// End of biolerplate code

if (empty($_POST['service'])) {
	header('Location:'. SERVER_PATH. 'users/'. $user->getUserid());
	exit();
}

$service = $_POST['service'];

if ($service == 'followRequest') {
	
	if (empty($_POST['profile-user'])) {
		header('Location:'. SERVER_PATH. 'users/'. $user->getUserid());
		exit();
	}
	
	$eventList = [];
	if (empty($_POST['follow-state'])) {
		$currentState = "0";
	} else {
		$currentState = "1";
	}
	
	$profileUser = User::getUserByUserName($_POST['profile-user']);
	
	$user->toggleFollowerState($profileUser, $currentState);
	
	header('Location:'. SERVER_PATH. 'users/'. $user->getUserid());
	exit();
}

if ($service == 'profileRequest') {
	
	$user->changeFirstName($_POST['firstName']);
	$user->changeMiddleName($_POST['middleName']);
	$user->changeLastName($_POST['lastName']);
	$user->changeVisibility($_POST['visibility']);
	$user->changeEmailId($_POST['email']);
	$user->changePassword($_POST['password']);
	header('Location:'. SERVER_PATH. 'users/'. $user->getUserid());
	exit();
}






