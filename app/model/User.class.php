<?php

require_once 'DbAccess.class.php';
require_once 'Event.class.php';

class User {
	
	const DBTABLE= 'user';
	const FOLLOWER_TABLE = 'follower_table';
	
	protected $pkId;
	protected $firstName;
	protected $lastName;
	protected $middleName;
	protected $userId;
	protected $profilePic;
	protected $emailAddress;
	protected $emailVisibility;
	protected $admin;
	protected $registeredDate;
	protected $password;
	protected $isNew = FALSE;
	
	public static $DBToObjMapping = Array(
			'id'=>'pkId',
			'first_name'=>'firstName',
			'last_name'=>'lastName',
			'middle_name'=>'middleName',
			'user_id'=>'userId',
			'profile_pic'=>'profilePic',
			'email_address'=>'emailAddress',
			'email_visibility'=>'emailVisibility',
			'admin'=>'admin',
			'register_date'=>'registeredDate',
			'password'=>'password');
	
	 public static $ObjToDBMapping = NULL; //array_flip(self::DBToObjMapping);
	
	
	public function __construct($dbObject, $isNew = False) {
		/* Constructs only one object at a time 
		 *  Note: if $isNew is False, then User object is
		 *  getting created from Database:
		 * 
		 * $isNew = True, then User Object is getting created from 
		 * a new user registering for the website. Note:
		 * The caller needs to pass the associative array in
		 * where keys match with the names of the User class
		 *  
		 *  Note: Error checking needs to be done.(TO DO TASK)
		 *  
		 */
		if ($isNew == False) {
			foreach ($dbObject as $key=>$value) {
				$x = self::$DBToObjMapping[$key];
				$this->$x = $value;
			}
			$this->isNew = FALSE;
			
		} else if ($isNew == True) {
			
			foreach ($dbObject as $key=>$value) {
				$this->$key = $value;
			}
			$this->isNew = TRUE;
			$this->addUsertoDB();
		}
	}
	
	public function isAdmin() {
		if ($this->admin == 'y')
			return true;
		else 
			return false;
	}
	
	public function addUsertoDB() {
		$userArray = $this->UserObjtoArray_DBSchema();
		
		#print_r($userArray);
		#echo"<br>";
		
		$query = DBAccess::buildInsertQuery(self::DBTABLE, $userArray);
		DBAccess::runQuery($query); 
	}
	
	public function UserObjtoArray() {
		/*
		 * Converts an user object into associate array:
		 */
		$array = [];
		
		/* We are only concerned with keys here */
		foreach (self::$ObjToDBMapping as $key=>$value) {
			if (!empty($this->$key)) {
				$array[$key] = $this->$key;
			} 
		}
		
		return $array;
	}
	
	public function UserObjtoArray_DBSchema() {
		/*
		 * Converts an user object into associate array with database Schema
		*/
		$array = [];
	
		foreach (self::$ObjToDBMapping as $key=>$value) {
			if (!empty($this->$key)) {
				
				# Get the database column key from the mapping
				$columnKey = $value;
				$array[$columnKey] = $this->$key;
			}
		}
	
		return $array;
	}
	
	public static function getUserByUserName($userId) {
		
		if (($userId == NULL) || (strlen(($userId) === 0))) {
			return NULL;
		}
		
		if (self::$ObjToDBMapping == NULL) {
			self::$ObjToDBMapping = array_flip(self::$DBToObjMapping);
		}
		
		$query = 'select * from '. self::DBTABLE . ' where ' . self::$ObjToDBMapping['userId'] .
					'=' . DBAccess::quoteString($userId);
		#echo $query;
		
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet->num_rows === 0) {
			return NULL;
		}
		$user = new User(mysqli_fetch_assoc($resultSet));
		return $user;
	} 
	
	public function getUserid() {
		return $this->userId;
	}
	
	public function getFirstName() {
		return $this->firstName;
	}
	
	public function getLastName() {
		return $this->lastName;
	}
	
	public function get($field=null) {
		if($field == null){
			return null;
		} else {
			return ($this->$field);
		}
	}
	
	public function getUserPKId() {
		return $this->pkId;
	}

	public static function getUserbyUserID($id) {
		if (($id == NULL) || (strlen(($id) === 0))) {
			return NULL;
		}
		
		$query = 'select * from '.self::DBTABLE. " where id=$id";
		#echo $query;
		
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet->num_rows === 0) {
			return NULL;
		}
		$row = mysqli_fetch_assoc($resultSet);
		//print_r($row);
		return new User($row);
	}
	
	/*
	 * Gets the list of all people that the given user is following
	 * as an array (note: gives only the user names)
	 * 
	 */
	 public static function getUsersFollowingById($id) {
	 	
	 	if ($id == NULL)
	 		return NULL;
	 	
	 	$query = 'select user_id from '. self::DBTABLE . ' where id in ' .
	 		'(select distinct user_id from ' . self::FOLLOWER_TABLE .
	 		" where follower_id=" . $id . ')';
	 	
	 	#echo $query;
	 	
	 	$resultSet = DBAccess::runQuery($query);
	 	if ($resultSet->num_rows === 0) {
	 		return NULL;
	 	}
	 	
	 	$following = [];
	 	for ($i = 0; $i < $resultSet->num_rows; $i++) {
	 		$row = mysqli_fetch_assoc($resultSet);
	 		$following[] = $row['user_id'];
	 	}
	 	
	 	return $following;
	 }
	 
	 /*
	  * Gets the list of all people (only usernames) who are following
	  * a given user 
	  * 
	 */
	 public static function getUsersFollowersById($id) {
	 	 
	 	if ($id == NULL)
	 		return NULL;
	 	 
	 	$query = 'select user_id from '. self::DBTABLE . ' where id in ' .
	 			'(select distinct follower_id from ' . self::FOLLOWER_TABLE .
	 			" where user_id=" . $id . ')';
	 	 
	 	#echo $query;
	 	 
	 	$resultSet = DBAccess::runQuery($query);
	 	if ($resultSet->num_rows === 0) {
	 		return NULL;
	 	}
	 	 
	 	$followers = [];
	 	for ($i = 0; $i < $resultSet->num_rows; $i++) {
	 		$row = mysqli_fetch_assoc($resultSet);
	 		$followers[] = $row['user_id'];
	 	}
	 	 
	 	return $followers;
	 }
	 
	 /*
	  * Returns true or false depending on whether the user 
	  * instance is a follower of $userObj or not
	  */
	 public function isFollower($userObj) {
		$follower_id = $this->pkId;	
		$user_id = $userObj->pkId;
		
		$query = 'select * from '. self::FOLLOWER_TABLE . ' where user_id='. $user_id .
				' and follower_id = '. $follower_id;
		
		#echo $query;
		$resultSet = DBAccess::runQuery($query);
		
		if ($resultSet == NULL || $resultSet->num_rows === 0) {
			return false;
		} else {
			return true;
		}
	 }
	 
	 /*
	  * Toggle follower/unfollower state and add an corresponding
	  * event.
	  */
	 public function toggleFollowerState($profileUser, $currentState) {
	 	
	 	if ($profileUser == NULL) {
	 		return NULL;
	 	}
	 	
	    if ($currentState == "1") {
	    	//Unfollow
	    	$follower_id = $this->pkId;
	    	$user_id = $profileUser->getUserPKId();
	    	$query = 'delete from '. self::FOLLOWER_TABLE. " where follower_id = $follower_id and user_id= $user_id";
	    	#echo $query;
	    	
	    	$resultSet = DBAccess::runQuery($query);
	    	if ($resultSet == NULL) {
	    		echo "failed to remove an entry from follewer table";
	    	}
	    	
	    	//add unfollow event to $this instance.
	    	Event::createEventgivenUser($this, Event::EVENT_UNFOLLOW, $profileUser->getUserid(), NULL);
	    	
	    } else {
	    	//Follow
	    	$follower_id = $this->pkId;
	    	$user_id = $profileUser->getUserPKId();
	    	$query = 'insert into '. self::FOLLOWER_TABLE. " (user_id, follower_id) VALUES($user_id,$follower_id)";
	    	$resultSet = DBAccess::runQuery($query);
	    	if ($resultSet == NULL) {
	    		echo "insert follow entry failed";
	    	}
	    	
	    	// add two events
	    	// Following event to $this instance
	    	Event::createEventgivenUser($this, EVENT::EVENT_FOLLOWING, NULL, $profileUser->getUserid());
	    	
	    	// Follower event to $profileUser instance
	    	Event::createEventgivenUser($profileUser, EVENT::EVENT_FOLLOWER, NULL, $this->userId);
	    }
	 	
	 }
	 
	 private function runUpdateQuery($field, $value) {
	 	
	 	$query = 'UPDATE '. self::DBTABLE . " set $field=". DBAccess::quoteString($value). " where id=".$this->pkId;
	 	$resultSet = DBAccess::runQuery($query);
	 	echo $query;
	 	if ($resultSet == NULL) {
	 		echo "Failed to update user Entry";
	 	}
	 }
	 
	 public function changeFirstName($new) {
	 	
	 	if (empty(trim($new)) || ($this->firstName == $new)) {
	 		//Nothing changed
	 		return;
	 	}
	 	$this->runUpdateQuery("first_name", $new);
	 	Event::createEventgivenUser($this, EVENT::EVENT_FIRSTNAME, $this->firstName, $new);
	 }
	 
	 public function changeMiddleName($new) {
	 	 
	 	if (empty(trim($new)) || ($this->middleName == $new)) {
	 		//Nothing changed
	 		return;
	 	}
	 	$this->runUpdateQuery("middle_name", $new);
	 	Event::createEventgivenUser($this, EVENT::EVENT_MIDDLENAME , $this->middleName, $new);
	 }
	 
	 public function changeLastName($new) {
	 	 
	 	if (empty(trim($new)) || ($this->lastName == $new)) {
	 		//Nothing changed
	 		return;
	 	}
	 	$this->runUpdateQuery("last_name", $new);
	 	Event::createEventgivenUser($this, EVENT::EVENT_LASTNAME, $this->lastName, $new);
	 }
	 
	 public function changeVisibility($new) {
	 	 
	 	if (empty(trim($new)) || ($this->emailVisibility == $new)) {
	 		//Nothing changed
	 		return;
	 	}
	 	$this->runUpdateQuery("email_visibility", $new);
	 	Event::createEventgivenUser($this, EVENT::EVENT_VISIBILITY, $this->emailVisibility, $new);
	 }
	 
	 public function changeEmailId($new) {
	 	 
	 	if (empty(trim($new)) || ($this->emailAddress == $new)) {
	 		//Nothing changed
	 		return;
	 	}
	 	
	 	$this->runUpdateQuery("email_address", $new);
	 	Event::createEventgivenUser($this, EVENT::EVENT_EMAILID, $this->emailAddress, $new);
	 }
	 
	 public function changePassword($new) {
	 
	 	if (empty(trim($new)) || ($this->password == $new)) {
	 		//Nothing changed
	 		return;
	 	}
	 	$this->runUpdateQuery("password", $new);
	 	Event::createEventgivenUser($this, EVENT::EVENT_PASSWORD, $this->password, $new);
	 }
	 
}
