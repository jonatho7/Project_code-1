<?php

require_once '../config.php';
require_once '../model/UserState.class.php';
require_once 'sessionAttributes.php';



function redirectToDashBoard() {
    #does redirect to dashboard.php page.
    header('Location: '. SERVER_PATH. 'dashboard.php');
    exit();
}


//find the role selection of the user.
$roleSelected = $_POST['roleSelected'];
//find the userQuery ( username ).
$userQuery_username = $_POST['userQuery'];
//find the user.
$user = $_POST['user'];
//find the region.
$region = $_POST['region'];

//echo "userQuery ". $userQuery;
//echo "region ". $region;


//grab the user object.
$e_user = User::getUserByUserName($user);
$e_userRole = $e_user->getUserRole();
//grab the userQuery object.
$userQuery_user = User::getUserByUserName($userQuery_username);
$userQuery_role = $userQuery_user->getUserRole();


//Now double check that the user actually does have privileges
//to be able to change the role of this user.
if ( User::privilegesGreaterOrEqualToOtherUser($e_userRole, $userQuery_role ) ){
    redirectToDashBoard();
}


//now go ahead and update the database with the new role for the user.
$userQuery_user->changeRole($roleSelected);


// Construct query parameter.
$array = array('userQuery'=>$userQuery, 'region'=>$region);
$queryParameters = http_build_query($array);


$redirectPath = "administration?" . $queryParameters;
header('Location: '. $redirectPath);
exit();
