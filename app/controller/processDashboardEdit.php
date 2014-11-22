<?php

//echo "up_id = ". $_POST['up_id'];

/*
 * 
 * Note $up_id variable identifies the primary key
 * of user predictions table.
 */
/*
 * Do the basic login whether user is loggin in or out.
 * 
 * 
 */
require_once '../config.php';
require_once '../model/User.class.php';
require_once '../model/UserPred.class.php';
require_once 'sessionAttributes.php';
require_once '../model/UserState.class.php';
require_once 'controllerHelper.php';

function redirectToDashBoard() {
	#does redirect to dashboard.php page.
	header('Location: '. SERVER_PATH. 'dashboard.php' . '?' . get_url_encode_region(@$_GET['region']));
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


$userPred = UserPred::getPreditionForId($_POST['up_id']);

if (($userPred == NULL) || $userPred->isExpriredPrediction()) {
	redirectToDashBoard();
}


$e_userPred = $userPred;
$e_user = $userObj;
$e_Title = "Edit page";
$e_region = getRegion(@$_GET['region']);

require_once '../view/loggedInHeader.tpl';

require_once '../view/dashboardEdit.tpl';


require_once '../view/loggedInFooter.tpl';