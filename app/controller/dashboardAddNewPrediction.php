<?php


require_once '../config.php';
require_once '../model/User.class.php';
require_once '../model/UserPred.class.php';
require_once 'sessionAttributes.php';
require_once '../model/UserState.class.php';

function redirectToDashBoard() {
	#does redirect to dashboard.php page.
	header('Location: '. SERVER_PATH. 'dashboard.php');
	exit();
}

function redirecttoHomePage() {
	header('Location: '. SERVER_PATH. 'login');
	exit();
}

if (empty($_SESSION['userName'])) {
	redirecttoHomePage();
}

$userObj = User::getUserByUserName($_SESSION['userName']);
if (empty($userObj)) {
	// No username exists so redirect to home page
	redirecttoHomePage();
}

# create UserState object and pass it along.

$region = @$_GET['region'];

if (empty($region)) {
    $region = Region::getFirstRegion();
}



$e_user = $userObj;
$e_Title = "Make new Prediction";
$e_region = $region;

require_once '../view/loggedInHeader.tpl';

require_once '../view/dashboardAddNewPred.tpl';


require_once '../view/loggedInFooter.tpl';

