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
require_once '../global.php';
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

$e_userState = UserState::getUserState($userObj);
if (!empty($_SESSION['REGION_NAME'])) {
	$e_userState->setcurrentDashBoardRegion($_SESSION['REGION_NAME']);
}

$userPred = UserPred::getPreditionForId($_POST['up_id']);

if (($userPred == NULL) || $userPred->isExpriredPrediction()) {
	# Again redirect as there is no prediction or
	# prediction is already expired. So nothing to do.
	redirectToDashBoard();
}


#echo "Successfully reached till here";

$e_userPred = $userPred;
$e_user = $userObj;
$e_Title = "Edit page";


require_once '../view/loggedInHeader.tpl';

require_once '../view/dashboardEdit.tpl';


require_once '../view/loggedInFooter.tpl';