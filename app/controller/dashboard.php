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

#Note the order 


if (empty($_SESSION['userName'])) {
	# Redirect as user is not logged in.
	session_unset();
	require_once 'login.php';
	exit();
}

//echo "UserName = ". $_SESSION['userName'];
$user = User::getUserByUserName($_SESSION['userName']);
//echo "Get LAst NAme = ". $user->getFirstName();
//exit();

#$userObj = NULL; 
//$userObj = $_SESSION['userObject']
//echo "Session Status : " .session_status();

if ($user == NULL) {
	# CHANGE ME to login folder.
	
	header('Location: '. SERVER_PATH. 'test.php');
	exit();
}

# Set the title and usehr object
$e_Title = "Dashboard";
$e_user = $user;

# create UserState object and pass it along.

$e_userState = UserState::getUserState($user);


if (!empty($_SESSION['REGION_NAME'])) {
	$e_userState->setcurrentDashBoardRegion($_SESSION['REGION_NAME']);
}

/*if (empty($_SESSION)) {
	echo "Session variable is empty LOL";
}*/

//$_SESSION[USER_STATE] = $userState;


#echo "Set User State object.";
//if 
#echo "Current region = ". $_SESSION['UserState']->getCurrentActiveRegion(UserState::DASHBOARD_PAGE);

//echo "String = <br>"; 

//$list = $userState->getPredictionsforRegion("Region_1");

//$count = count($list);

//for ($i = 0 ; $i < $count ; $i++) {
	//print_r(date_create($list[$i]->up_date)->format('m/d/Y'));
	//echo "<br>";
//}

require_once '../view/loggedInHeader.tpl';
require_once '../view/dashboard.tpl';
require_once '../view/loggedInFooter.tpl';