<?php


require_once '../config.php';
require_once '../model/User.class.php';
require_once '../model/UserPred.class.php';
require_once 'sessionAttributes.php';
require_once '../model/UserState.class.php';
require_once 'controllerHelper.php';

function redirectToDashBoard() {
	#does redirect to dashboard.php page.
	#header('Location: '. SERVER_PATH. 'dashboard.php');
	exit();
}

function redirecttoHomePage() {
	#header('Location: '. SERVER_PATH. 'login');
	exit();
}

if (empty($_SESSION['userName'])) {
	#redirecttoHomePage();
}

$userObj = User::getUserByUserName($_SESSION['userName']);
if (empty($userObj)) {
	// No username exists so redirect to home page
	#redirecttoHomePage();
}

/*
 * get the prediction id from the session
 */

#echo "Hello Vivek Bharath";


/*
 * Extract $value and $comment
 * $region and $date
 */
$regionName = $_POST['regionName'];
$value = $_POST['value'];
$predDate  = $_POST['predDate'];
$comment = $_POST['comment'];




if (!is_numeric($value) || (intval($value) < 0)) {
	#header('Location: '. SERVER_PATH. 'dashboard.php?' . );
	exit();
}


/*
 * Everything done. Redirect to
 * dashboard
 */
//unset($_SESSION['PREDICTION_ID']);
//header('Location: '. SERVER_PATH. 'dashboard.php');
//exit();

if (!UserPred::storeNewPrediction($regionName, $value, $predDate, $comment)) {
	echo "I am failing";
}

/*
 * Add the region Name here;
 */
$_SESSION['REGION_NAME'] = $regionName;
#header('Location: '. SERVER_PATH. 'dashboard.php?' . get_url_encode_region(@_GET['region']));
echo "REGION= ". $_GET['region'];
exit();





