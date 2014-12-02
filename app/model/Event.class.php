<?php

/*
 * 
 * This file provides class and methods to add events
 * in the system and retrieves the events too.
 */
require_once 'DbAccess.class.php';
require_once 'User.class.php';

class Event {
	
	protected static $event_type_mappings = NULL;
	// EventName to EventId mappings
	
	const EVENT_TYPE_TABLE = "eventtype";
	const USER_EVENT_TABLE = "userevent";
	
	const EVENT_UNFOLLOW = "unfollow";
	const EVENT_FOLLOWING = "following";
	const EVENT_FOLLOWER = "follower";
	
	const EVENT_FIRSTNAME = "firstName";
	const EVENT_MIDDLENAME = "middleName";
	const EVENT_LASTNAME = "lastName";
	const EVENT_PASSWORD = "password";
	const EVENT_EMAILID  = "email";
	const EVENT_VISIBILITY = "emailVisibility";
	
	const DBTABLE="userevent";
	
	// Same as database names
	protected $id;
	protected $u_id;
	protected $eventId; 
	protected $pastData;
	protected $newData;
	protected $eventDate;
	
	// Invoked because of user actions
	public function __construct($array, $save) {
		$this->id = $array['id'];
		$this->u_id = $array['u_id'];
		$this->eventId = $array['eventId'];
		$this->pastData = $array['pastData'];
		$this->newData = $array['newData'];
		$this->eventDate = $array['eventDate'];
		
		if ($save == True) 
			$this->save($array);
	}
	
	/* Write the event to dB */
	public function save($array) {
		$query = DBAccess::buildInsertQuery(self::DBTABLE, $array);
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet == NULL) {
			echo "write to ". self::DBTABLE . "failed";
		}
	
	}
	
	
	// Note $userObj is an instance of User Object.
	// Creates an instance of Event class
	public static function createEventgivenUser($userObj,$eventName, $pastData, $newData) {
		
		if (self::$event_type_mappings == NULL) {
			self::createEventNameToIdMapping();
		}
		
		$array = Array('id'=> NULL,
				'eventDate'=>NULL,
				'pastData'=>$pastData,
				'newData'=>$newData,
				'eventId'=>self::$event_type_mappings[$eventName],
				'u_id'=>$userObj->getUserPKId()
				);
		$event = new Event($array, True);
		
		return $event;
	}
	
	public static function createEventNameToIdMapping() {
		$query = 'SELECT eventId, eventName from '. self::EVENT_TYPE_TABLE;
		
		$resultSet = DBAccess::runQuery($query);
		
		if ($resultSet->num_rows === 0) {
			echo "Event type query failed";
			return NULL;
		}
		
		self::$event_type_mappings = [];
		
		for ($i = 0; $i < $resultSet->num_rows; $i++) {
			$row = mysqli_fetch_assoc($resultSet);
			self::$event_type_mappings[$row['eventName']] = $row['eventId'];
		}
		
		#print_r(self::$event_type_mappings);
	}
	
	public static function getEventsforUserPk($u_id , $includePrivate) {
	
		if ($includePrivate == true) {
			$query = "select * from ". self::DBTABLE . ' where u_id='. $u_id . ' order by eventDate desc';
		} else {
			$query = "select * from ". self::DBTABLE . ' where u_id='. $u_id . " and eventId in (select eventId from eventtype where eventPublic='y')"
					. ' order by eventDate desc';
		}
		
		$resultSet = DBAccess::runQuery($query);
		

		if ($resultSet->num_rows === 0) {
			//echo for testing.
			//echo "unexpected";
			
			return NULL;
		}
		
		$events = [];
		for ($i = 0; $i < $resultSet->num_rows; $i++) {
			$row = mysqli_fetch_assoc($resultSet);
			$events[] = new Event($row, false);
		}
		
		return $events;
		
	}
	
	public static function getEventsFromAll() {
		
		$query = "select * from ". self::DBTABLE . " where eventId in (select eventId from eventtype where eventPublic='y') order by eventDate desc";

		#echo $query;
		
		$resultSet = DBAccess::runQuery($query);
		
		if ($resultSet == NULL) {
			echo "Query failed";
			return NULL;
			
		}
		if ($resultSet->num_rows === 0) {
			echo "unexpected";
			return NULL;
		}
		
		$events = [];
		for ($i = 0; $i < $resultSet->num_rows; $i++) {
			$row = mysqli_fetch_assoc($resultSet);
			$events[] = new Event($row, false);
		}

		return $events;
	
	}

    public static function getEventsFromFollowing($myUserID) {

        $query = "SELECT * FROM ". self::DBTABLE . " where eventId in (select eventId from eventtype where eventPublic='y') AND (u_id = " . $myUserID . " OR u_id in (select user_id from follower_table where follower_id = " . $myUserID . ")) order by eventDate desc";

        //TODO. Change the 29 to the user_id of course.

        #echo $query;

        $resultSet = DBAccess::runQuery($query);

        if ($resultSet == NULL) {
            echo "Query failed";
            return NULL;

        }
        if ($resultSet->num_rows === 0) {
            echo "unexpected";
            return NULL;
        }

        $events = [];
        for ($i = 0; $i < $resultSet->num_rows; $i++) {
            $row = mysqli_fetch_assoc($resultSet);
            $events[] = new Event($row, false);
        }

        return $events;

    }
	
	public function getEventCreater() {
		$user = User::getUserbyUserID($this->u_id);
		return $user->getUserid();
	}
	
	public function getEventLog() {
		if (self::$event_type_mappings == NULL) {
			self::createEventNameToIdMapping();
		}
		$log = "";
		if ($this->eventId == "1") {
			$log = 'first name changed to ' . $this->newData. ' from ' . $this->pastData;	
		}	else if ($this->eventId == "2") {
			$log = 'middle name changed to ' . $this->newData. ' from ' . $this->pastData;
		}	else if ($this->eventId == "3") {
			$log = 'last name changed to ' . $this->newData. ' from ' . $this->pastData;
		}	else if ($this->eventId == "4") {
			$log = 'changed password';
		}	else if ($this->eventId == "5") {
			$log = 'email visibility changed to '.$this->newData. ' from ' . $this->pastData;
		} 	else if ($this->eventId == "6") {
			$log = 'email changed to '.$this->newData. ' from ' . $this->pastData;
		}	else if (($this->eventId == "7") || ($this->eventId == "8")) {
			$log = $this->getEventCreater() . ' started following ' . $this->newData;	
		}  else if ($this->eventId == "11") {
			$log = $this->getEventCreater() . " unfollowed " . $this->pastData;
		}

		return $log;
	}
	
	public function getEventTime() {
		return date_create($this->eventDate)->format('G:ia \o\n D jS M Y');
	}
}
