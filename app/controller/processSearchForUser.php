<?php

require_once '../config.php';
require_once '../model/UserState.class.php';
require_once 'sessionAttributes.php';



function redirectToDashBoard() {
    #does redirect to dashboard.php page.
    header('Location: '. SERVER_PATH. 'dashboard.php');
    exit();
}

//grab the userQuery object.
$userQuery_username = $_POST['userQuery'];
$userQuery_user = User::getUserByUserName($userQuery_username);

$errorMessage="";

//now go ahead and search for the user.
$tempUser = User::getUserByUserName($userQuery_username);
if ($tempUser == NULL) {
    $errorMessage="user not found";
} else {
    $errorMessage = "none";
}

// Construct query parameter.
$array = array('userQuery'=>$userQuery_username, 'errorMessage'=>$errorMessage);
$queryParameters = http_build_query($array);


$redirectPath = "administrationHome?" . $queryParameters;
header('Location: '. $redirectPath);
exit();
