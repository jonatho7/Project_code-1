<?php

require_once '../config.php';
require_once '../model/User.class.php';
require_once 'AMTTurkerState.php';

/*
 * This is a page that would be displayed only for Amazon
 * Mechanical Turks worker only. 
 * 
 * i) Authentication is bypassed
 * 
 * ii) If worker is previewing the hit, sample test will be shown
 * 
 * iii) If the worker has accepted the hit, 10 tasks will be shown
 *     sequencially to the AMT user.
 * To do: Figure out what else to cache.
 *   a) hitId
 *   b) workerId
 *   c) AssignmentId
 * 
 */

#echo "Hello AMT worker";

/*
 * Need to add more checkings later
 */ 

if (empty($_GET[ASSIGNMENT_ID]) || empty($_GET[WORKER_ID]) || empty($_GET[HIT_ID])) {
	echo "Unauthorized access. Access only for AMT workers";
	exit();
} 


$assignmentId = $_GET[ASSIGNMENT_ID];

if ($assignmentId == PREVIEW_HIT) {
	require_once '../view/previewHit.tpl';
	exit();
} else {
	/*
	 * Add a user Id if user doesn't already exists
	 * and start providing him the tasks.
	 */
	$workerId = $_GET[WORKER_ID];
	$hitId = $_GET[HIT_ID];
	
	if (isAMTTurkerActive($workerId) == false) {
		/*
		 * Well, this got to the first time AMT user is coming here.
		 * Store, all the details in the Session.
		 */
		
		cacheTurkerResults($assignmentId, $workerId, $hitId);	
	}
	require_once '../view/renderTaskToTurker.tpl'; 
}
