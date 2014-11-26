<?php

require_once '../config.php';
require_once '../model/UserState.class.php';
require_once 'sessionAttributes.php';

//find the region selected by the user
$regionName = trim($_POST['ChangeRegionName']);

//find the userQuery ( username ).
$userQuery = $_POST['userQuery'];

// Construct query parameter.
$array = array('userQuery'=>$userQuery, 'region'=>$regionName);
$queryParameters = http_build_query($array);

$redirectPath = "administration?" . $queryParameters;

header('Location: '. $redirectPath);
exit();


