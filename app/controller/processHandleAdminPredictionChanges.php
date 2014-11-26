<?php

/*
 *  This file handles the prediction request changes from user.
 */

require_once '../config.php';
require_once '../model/User.class.php';
require_once '../model/UserPred.class.php';
require_once 'sessionAttributes.php';
require_once '../model/UserState.class.php';
require_once 'controllerHelper.php';




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

/*
 * get the prediction id from the session
*/
$up_id = $_SESSION['PREDICTION_ID'];

echo " At least I got pid = $up_id";

/*
 * Extract $value and $comment
*/
$value = $_POST[$up_id."-value"];

if (!is_numeric($value) || (intval($value) < 0)) {
	header('Location: '. SERVER_PATH. 'dashboard.php');
	exit();
}

$comment = $_POST[$up_id."-comment"];

echo "<br>value = $value comment = $comment";

$userPred = UserPred::getPreditionForId($up_id);

echo "<br>value = $value comment = $comment";

echo $userPred->getDateFormatted();

$userPred->saveCommentOnly($comment);

// Construct query parameter.

$regionName = $_GET['region'];
$userQuery = $_GET['userQuery'];
$array = array('userQuery'=>$userQuery, 'region'=>$regionName);
$queryParameters = http_build_query($array);


/*
 * Everything done. Redirect to
* dashboard
*/
unset($_SESSION['PREDICTION_ID']);
header('Location: '. SERVER_PATH. 'administration?' . $queryParameters );
exit();
