<?php

/*
 * 
 * Note: This file is only written for testing the API provided
 * by various classes.
 * 
 */

require_once '../config.php';
require_once '../model/User.class.php';

function println($string) {
	echo $string . "<br>";
}

println("");

/*
$following = User::getUsersFollowingById(1);

for ($i = 0 ; $i < count($following); $i++) {
	println($following[$i]);
}
*/

$followers = User::getUsersFollowersById(1);

for ($i = 0 ; $i < count($followers); $i++) {
	println($followers[$i]);
}




?>