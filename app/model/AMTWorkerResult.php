<?php

require_once 'DbAccess.class.php';

class workerResult {
	const DBTABLE = "amt_result";
	
	protected $worker_id;
	protected $task_id;
	protected $task_answer;
	protected $task_comment;
	protected $task_entry;
	
	public function __construct($result) {
		$this->worker_id = $result['worker_id'];
		$this->task_id = $result['task_id'];
		$this->task_answer = $result['task_answer'];
		$this->task_comment = $result['task_comment'];
		$this->task_entry = NULL;
	}
	
	public function save() {
		$array = Array(
				'worker_id'=>$this->worker_id,
				'task_id'=>$this->task_id,
				'task_answer'=>$this->task_answer,
				'task_comment'=>$this->task_comment);
		
		$query = DBAccess::buildInsertQuery(self::DBTABLE, $array);
		#echo $query;
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet == NULL) {
			echo "write to ". self::DBTABLE . "failed";
		}
	}
}