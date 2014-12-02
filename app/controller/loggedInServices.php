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
require_once '../model/UserState.class.php';
require_once '../model/User.class.php';
require_once '../model/UserPred.class.php';

/*
 * Service = getNextPredictionDate
 *  Gets a list of {<region name>, <next prediction date 'YYYY'-'MM'-'DD'>
 *
 * Service = getPredictionEntries
 *  Gets a list of prediction and actual values for a given region so that front End
 * can do the visualization.
 *
 * service = storePredictionEntries
 *  Stores the predictions made by user via visualization
 */


if (empty($_SESSION['userName'])) {
    # Redirect as user is not logged in.
    session_unset();
    echo "";
    exit();
}
// user is logged in.



$username = $_SESSION['userName'];
$service = @$_GET['service'];

if (empty($service)) {
    echo "";
    exit;
}

/*
 * Store the prediction values stored by the user
 */
if ($service == 'storePredictionEntries') {

    $data = @$_POST['data'];

    if (empty($data)) {
        echo "";
        exit;
    }

    $data = json_decode($data);



    //loop through all the predictions values and update in the database.
    foreach ($data as $entry) {
        if (!empty($entry->newValue)){
            if (!empty($entry->predId)) {
                $predId = intval($entry->predId);
                $predEntry = UserPred::getPreditionForId($predId);
                if (!empty($predEntry)) {
                    $predEntry->save(intval($entry->newValue), $predEntry->getComment());
                }
            }
        }
    }
    $output = array();
    $output['success'] = true;

    echo json_encode($output);
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

} else if ($service = 'getPredictionEntries') {
    $region = @$_GET['region'];

    if (empty($region) || (Region::getRegionIdFromName($region) == null)) {
        /*  We need at least the region to send the data
            and also check if the region name really exists
        */
        echo "";
        exit;
    }
    $season_year = @$_GET['year'];

    if (empty($season_year)) {
        /* Assume to the current year */
        $season_year = '2014';
    }

    $output = array();

    /*
     * Get the predicted values first
     */
    $predictionEntryList = UserData::getPredictionsForRegion(User::getUserByUserName($username), $region);

    //var_dump($predictionEntryList);

    $temp = array();

    if ($predictionEntryList != null) {
        foreach ($predictionEntryList as $entry) {
            //$temp[$entry->getPredictionDate()] = $entry->getValue();
            $temp[$entry->getPredictionDate()] = array();
            $temp[$entry->getPredictionDate()]['value'] = $entry->getValue();
            $temp[$entry->getPredictionDate()]['expired'] = $entry->isExpriredPrediction();
            $temp[$entry->getPredictionDate()]['predId'] = $entry->getup_pk();
        }
    }

    $output['prediction'] = $temp;

    /*
     * Now get the actual data available from surveillance methods.
     */
    $output['actual'] = Region::getActualData($region, $season_year);


    echo json_encode($output);
}
