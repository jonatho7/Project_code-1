<?php

require_once '../config.php';
require_once '../model/User.class.php';
require_once '../model/UserPred.class.php';
require_once 'sessionAttributes.php';
require_once 'controllerHelper.php';

function redirectToDashBoard() {
	#does redirect to dashboard.php page.
	header('Location: '. SERVER_PATH. 'dashboard.php' . '?' . get_url_encode_region(@$_GET['region']));
	exit();
}

if (empty($_POST['up_id'])) {
	# Nothing to just redirect to dashboard.php
	redirectToDashBoard();
}


$userPred = UserPred::getPreditionForId($_POST['up_id']);

if (($userPred == NULL) || $userPred->isExpriredPrediction()) {
	# Again redirect as there is no prediction or
	# prediction is already expired. So nothing to do.
	redirectToDashBoard();
}

$userObj = User::getUserByUserName($_SESSION['userName']);
if (empty($userObj)) {
	echo "The value entered is NULL";
}

# See if the userName matches with what is there in the session

if ($userObj->getUserID() != $_SESSION['userName']) {
	redirectToDashBoard();
}

#echo "Successfully reached till the end";

if ($userPred->deleteUserPred()) {
	//echo "Sucussfully deleted the entry";
} else {
	//echo "Delete unsuccussful";
}


redirectToDashBoard();
