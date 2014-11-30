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

function get_data($url) {
    $ch = curl_init();
    $timeout = 5;
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
}

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

    //$response = file_get_contents('http://www.cdc.gov/flu/weekly/flureport.xml');
    $response = get_data('http://www.cdc.gov/flu/weekly/flureport.xml');

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

