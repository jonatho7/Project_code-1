<?php
	/* 
	 * This is the basic Dashboard page seen by user
	 * when he logs in.
	 * 
	 * 
	 * 
	 * argument: USer login id is stored as USER_NAME in SESSION 
	 */

require_once '../config.php';
require_once 'sessionAttributes.php';
require_once '../model/User.class.php';
require_once '../model/UserState.class.php';
require_once 'controllerHelper.php';

#Note the convention that is used here
# we get the username and region from the get method request to this page.
# Otherwise, we select username would be who is logged in and region would
# be some default region
# get variables: userName, region


if (empty($_SESSION['userName'])) {
	# Redirect as user is not logged in.
	session_unset();
	require_once 'login.php';
	exit();
}

$userName = $_SESSION['userName'];

if (!empty($_GET['userName'])) {
    $userName = $_GET['userName'];
}

$region = getRegion(@$_GET['region']);


$user = User::getUserByUserName($_SESSION['userName']);

if ($user == NULL) {
	# Unexpected but change later
    header('Location: '. SERVER_PATH. 'test.php');
	exit();
}

# Set the title, region etc.
$e_Title = "Dashboard";
$e_user = $user;
$e_region = $region;

require_once '../view/loggedInHeader.tpl';
require_once '../view/dashboard.tpl';
require_once '../view/loggedInFooter.tpl';