<?php

require_once '../config.php';
require_once '../model/User.class.php';

/*
 * This is a page that would be displayed only for Amazon
 * Mechanical Turks worker only. 
 * 
 * i) Authentication is bypassed
 * 
 * ii) If worker is previewing the hit, sample test will be shown
 * 
 * iii) If the worker has accepted the hit, then a new user with
 * the following paramaters <username, password> = <workerId, workerID>
 * in the dabasase.
 * 
 * To do: Figure out what else to cache.
 * 
 */

#echo "Hello AMT worker";

/*
 * Need to add more checkings later
 */ 

if (empty($_GET["assignmentId"])) {
	echo "Unauthorized access. Access only for AMT workers";
	exit();
} 


$assignmentID = $_GET[ASSIGNMENT_ID];

if ($assignmentID == PREVIEW_HIT) {
	require_once '../view/previewHit.tpl';
	exit();
} else {
	/*
	 * Add a user Id if user doesn't already exists
	 * and start providing him the tasks.
	 */
	if (empty($_GET[WORKER_ID])) {
		echo "workerID is null. Exiting";
		exit();
	}
	$workerId = $_GET[WORKER_ID];
	
	$user = User::getUserByUserName($workerId);
	if ($user == null) {
		#echo "user doesn't exist so creating a new one";
		#$user = new User()
	}
	
	
}
