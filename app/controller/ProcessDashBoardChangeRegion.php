<?php


#echo "I am here";

require_once '../global.php';
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

header('Location: '. SERVER_PATH. 'dashboard.php');
exit();


