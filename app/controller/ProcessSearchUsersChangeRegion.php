<?php


// This file stores the region selected by the user on the Find / Search  Users page

require_once '../config.php';
require_once '../model/UserState.class.php';
require_once 'sessionAttributes.php';

/*
 * find the region selected by the user
 * 
 */
$regionName = trim($_POST['ChangeRegionName']);

#echo 'Selected regionid = '. $regionName;

# Store the regionName in SESSION and redirect.

$_SESSION['REGION_NAME'] = $regionName;

header('Location: '. SERVER_PATH. 'searchUsers.php');
exit();


