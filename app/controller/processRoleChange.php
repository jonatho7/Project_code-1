<?php

require_once '../config.php';
require_once '../model/UserState.class.php';
require_once 'sessionAttributes.php';

//find the role selection of the user.
$roleSelected = $_POST['roleSelected'];
//find the userQuery ( username ).
$userQuery = $_POST['userQuery'];
//find the region.
$region = $_POST['region'];

echo "userQuery ". $userQuery;
echo "region ". $region;


//Now double check that the user actually does have privileges
//to be able to change the role of this user.



//grab the user object.
$userQuery_user = User::getUserByUserName($userQuery);
//now go ahead and update the database with the new role for the user.
$userQuery_user->changeRole($roleSelected);


// Construct query parameter.
$array = array('userQuery'=>$userQuery, 'region'=>$region);
$queryParameters = http_build_query($array);


$redirectPath = "administration?" . $queryParameters;
header('Location: '. $redirectPath);
exit();
