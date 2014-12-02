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

$array = array('region'=>$regionName);

// Construct query parameter and post it to dashboard.php
$query = http_build_query($array);

header('Location: '. SERVER_PATH. 'searchUsers.php?'. $query);
exit();


