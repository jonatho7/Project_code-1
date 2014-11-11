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
	
}






