<?php

#echo "Hello Vivek";

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


#echo "Successfully reached till here";

$e_user = $userObj;
$e_Title = "Make new Prediction";


require_once '../view/loggedInHeader.tpl';

require_once '../view/dashboardAddNewPred.tpl';


require_once '../view/loggedInFooter.tpl';

