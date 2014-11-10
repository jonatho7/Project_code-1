<?php

require_once '../config.php';
/*
 * Stores all the state corressponding to Turker
* in session object.
*/
function cacheTurkerResults($assignmentId, $workerId, $hitId) {
	@session_start();
	$_SESSION[ASSIGNMENT_ID] = $assignmentId;
	$_SESSION[WORKER_ID] = $workerId;
	$_SESSION[HIT_ID] = $hitId;
	$_SESSION[CURRRENT_TASK] = "1";
}

/*
 * See if the AMT Turker is already active
 */
function isAMTTurkerActive($workerId) {
	@session_start();
	if (empty($_SESSION[WORKER_ID]) || ($_SESSION[WORKER_ID] != $workerId)) {
		return false;
	}
	return true;
}

/*
 * Get current task
 * 
 */
function getCurrentTask() {
	@session_start();
	return $_SESSION[CURRRENT_TASK];
}


/*
 * Is there a next Question for the Turker
 */
function hasNextQuestion() {
	@session_start();
	$currentQuestion = intval($_SESSION[CURRRENT_TASK]);
	
	if ($currentQuestion >= intval(MAX_QUESTIONS)) {
		// Ran out of Questions
		return false;
	}
	return true;
}

function isAnyQuestionActive() {
	if (empty($_SESSION[CURRRENT_TASK])) {
		return false;
	} else {
		return false;
	}
}
/*
 * Gets worker Id
 *
 */
function getWorkerId() {
	@session_start();
	return @$_SESSION[WORKER_ID];
}

/*
 * 
 * Set the state for next question:
 */
function setNextQuestion() {
	@session_start();
	$_SESSION[CURRRENT_TASK] = strval(intval($_SESSION[CURRRENT_TASK]) + 1);
}

/*
 * Get the assignment id for AMT worker
 */

function getAssignmentId() {
	@session_start();
	return @$_SESSION[ASSIGNMENT_ID];
}
