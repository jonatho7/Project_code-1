<?php

/*
 * 
 * Note: This file is only written for testing the API provided
 * by various classes.
 * 
 */

require_once '../config.php';
require_once '../model/User.class.php';

require_once '../model/Event.class.php';
require_once '../model/Region.class.php';


require_once '../model/Region.class.php';


function println($string) {
	echo $string . "<br>";
}

println("");

/*
$following = User::getUsersFollowingById(1);

for ($i = 0 ; $i < count($following); $i++) {
	println($following[$i]);
}


$followers = User::getUsersFollowersById(1);

for ($i = 0 ; $i < count($followers); $i++) {
	println($followers[$i]);
}

Event::createEventNameToIdMapping();



$regions = Region::getLatestActualData();

foreach($regions as $x) {
    print_r($x);
    println("");
}

println(json_encode($regions));
*/


#echo "date = " . Region::getNextPredictonDateForUser(38, 'vivekb88');
$d  = Region::getNextPredictonDateForUser(38, 'vivekb88');
echo "date= $d <br>";
echo "time = ". time($d) . "<br>";

#echo date("Y-m-d", strtotime("next Wednesday", time($d)));


echo date('Y-m-d', strtotime('next Wednesday', strtotime($d))) . "<br>";