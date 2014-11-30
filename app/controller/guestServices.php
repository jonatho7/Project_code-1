<?php
/**
 * Date: 11/29/14
 * Time: 3:06 PM
 * Usage: Contains services which can be accessed by guest user.
 * (No authentication is required for accessing these services)
 *  Should use GET methods
 */

require_once '../config.php';
require_once '../model/Region.class.php';

$service = @$_GET['service'];
$type = @$_GET['type'];


if (empty($service) || empty($type)) {
    echo "";
    exit;
} elseif ($service == 'getLatestActualData' && $type == 'HSS') {
    /* Get HSS data published by CDC */
    $regions = Region::getLatestActualData();
    echo json_encode($regions);
    exit;
} elseif ($service == 'getLatestActualData' && $type == 'stateActivity') {
     /*
        Get the latest date from the following url:
        http://www.cdc.gov/flu/weekly/flureport.xml
     */
    $response = file_get_contents('http://www.cdc.gov/flu/weekly/flureport.xml');
    $xml = simplexml_load_string($response);

    /*
     * get the latest entry
     */
    $lastNode = $xml->timeperiod[ $xml->count() - 1 ];

    /*
     * Construct an array object from xml node
     */

    $data = array();

    foreach ($lastNode->attributes() as $a => $b) {
        $data[$a] = (string)($b);
    }

    $states_list = [];

    foreach($lastNode->children() as $child) {
        $state = array();
        $state['abbrev'] = (string)$child->abbrev;
        $state['label'] = (string)$child->label;
        $states_list[] = $state;
    }

    $data['state'] = $states_list;

    # Send the response as json

    echo(json_encode($data));
}

