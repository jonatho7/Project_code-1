<?php
/**
 * Creation
 * Date: 11/30/14
 * Time: 10:11 PM
 *
 * This file contains all the services that will be provided to user who is logged in.
 * The output would always be in the json format.
 */

require_once '../config.php';
require_once '../model/Region.class.php';
require_once 'sessionAttributes.php';

/*
 * Service = getNextPredictionDate
 *  Gets a list of {<region name>, <next prediction date 'YYYY'-'MM'-'DD'>
 *
 *
 */

if (empty($_SESSION['userName'])) {
    # Redirect as user is not logged in.
    session_unset();
    echo "";
    exit();
}

$service = @$_GET['service'];
// user is logged in.
if (empty($service)) {
    echo "";
    exit;
}


if ($service == 'getNextPredictionDate') {
    $username = $_SESSION['userName'];
    $regionsList = Region::getAllRegions();
    $output_data = array();
    foreach($regionsList as $region) {
        $output_data[$region->getRegionName()] = Region::getNextPredictonDateForUser($region->getRegionId(), $username);
    }
    echo json_encode($output_data);
}
