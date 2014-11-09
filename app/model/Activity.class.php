<?php

class Activity {
	// Points to user object
	public 	$userObj = NULL;
	
	/*
	 * Fields same as database schema for table activity_log
	 */
	
	protected $activity_id;
	protected $u_id;
	protected $user_id_string;
	protected $activity_type_id;
	protected $u_id2;
	protected $user_id2_string;
	protected $date_modified_new;
	protected $date_modified_old;
	protected $up_id;
	protected $up_value_new;
	protected $up_value_old;
	protected $up_date;
	protected $r_name;
	protected $comment_new;
	protected $comment_old;
	protected $first_name_new;
	protected $first_name_old;
	protected $middle_name_new;
	protected $middle_name_old;
	protected $last_name_new;
	protected $last_name_old;
	
	/*
	 TODO. Use this eventually.
	public function __construct($userObj, $args) {
		
		#echo "Seeting this value";
		$this->userObj = $userObj;
		
		//print_r($args);
		//echo "<br>";
		foreach ($args as $key=>$value) {
			#echo "key = $key ". "Value = $value"."<br>";
			$this->$key = $value;
		} 
	}
	*/
	

	public function __construct() {
		
	}

	//Quick getter.
	public function get($field=null) {
		if($field == null){
			return null;
		} else {
			return ($this->$field);
		}
	}
	
	//Quick setter.
	public function set($field=null, $value=null) {
		if($field == null || $value == null){
			return null;
		} else {
			$this->$field = $value;
		}
	}
	
	//Customized getter with formatting.
	public function getDate_Modified_New() {
		//return $this->date_modified_new;
		return date_create($this->date_modified_new)->format('G:ia \o\n D jS M Y');
	}
	
	//Customized getter with formatting.
	public function getDate_Modified_Old() {
		//return $this->date_modified_old;
		return date_create($this->date_modified_old)->format('G:ia \o\n D jS M Y');
	}

	//Customized getter with formatting.
	public function getUp_Date() {
		//return $this->up_date;
		return date_create($this->up_date)->format('D jS M Y');
	}

	public function getUserObj() {
		return $this->userObj;
	}

}