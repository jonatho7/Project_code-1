<?php

require_once '../config.php';
require_once 'AMTTurkerState.php';
require_once '../model/AMTWorkerResult.php';


function print_debug_info() {	
	echo "<br> post_worker = " . $_POST[WORKER_ID];
	echo "<br> stored worker Id =" . getWorkerId();
	echo "<br> current task obtained = " . @$_POST["task_answer_".getCurrentTask()];
}
/*
 * Handles the submit action for Amazon Mechanical code Flow.
 * Tasks:
 * 1) Verifies the results submitted via post method.
 * 2) Stores the result in database.
 * 2) Sets the state for next Question, if available.
 * 3) If this is the last question for an assignment, then submits
 *   the result back to AMT.
 */

/*
 * Verification Starts
 */

if (empty($_POST[WORKER_ID]) || $_POST[WORKER_ID] != getWorkerId() || 
		empty($_POST["task_answer_".getCurrentTask()])) {
	echo "Invalid Post";
	print_debug_info();
	exit();
}

#echo "Reached here";

$workerId = getWorkerId();

if (empty($_POST["task_answer_".getCurrentTask()])) {
	if (isAnyQuestionActive()) {
		require_once '../view/renderTaskToTurker.tpl';
	} else {
		//Not expected to be here unless something
		//bizarre happens.
		exit();
	}
}

$task_answer = $_POST["task_answer_".getCurrentTask()];

$task_id = getCurrentTask();

if (empty($_POST["task_comment_".getCurrentTask()]))
	$task_comment = NULL;
else 
	$task_comment = $_POST["task_comment_".getCurrentTask()];

/*
 * Create an instance of workerResult class to save the results
 * in Database.
 */
$arg = Array(
		'worker_id'=>$workerId,
		'task_id'=>$task_id,
		'task_answer'=>$task_answer,
		'task_comment'=>$task_comment);

$workerResult = new workerResult($arg);

#echo "object creation succussful";
// Store the result in database
$workerResult->save();

if (hasNextQuestion()) {
	setNextQuestion();
	require_once '../view/renderTaskToTurker.tpl';
} else {
	/*
	 *  Done with all thq questions.
	 *  create form to Post to AMT so that worker can complete the hit.
	 */
	require_once '../view/turkerAcknowledgement.tpl';

}

