<?php

/*
 * 
 * This file provides class and methods to add events
 * in the system and retrieves the events too.
 */
require_once 'DbAccess.class.php';

class Event {
	
	protected static $event_type_mappings = NULL;
	// EventName to EventId mappings
	
	const EVENT_TYPE_TABLE = "EventType";
	const USER_EVENT_TABLE = "userEvent";
	
	const EVENT_UNFOLLOW = "unfollow";
	const EVENT_FOLLOWING = "following";
	const EVENT_FOLLOWER = "follower";
	
	const EVENT_FIRSTNAME = "firstName";
	const EVENT_MIDDLENAME = "middleName";
	const EVENT_LASTNAME = "lastName";
	const EVENT_PASSWORD = "password";
	const EVENT_EMAILID  = "email";
	const EVENT_VISIBILITY = "emailVisibility";
	
	const DBTABLE="userEvent";
	
	// Same as database names
	protected $id;
	protected $u_Id;
	protected $eventId; 
	protected $pastData;
	protected $newData;
	protected $eventDate;
	
	// Invoked because of user actions
	public function __construct($array, $save) {
		$this->id = $array['id'];
		$this->id = $array['u_id'];
		$this->id = $array['eventId'];
		$this->id = $array['pastData'];
		$this->id = $array['newData'];
		$this->id = $array['eventDate'];
		
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
		$query = 'SELECT EventId, EventName from '. self::EVENT_TYPE_TABLE;
		
		$resultSet = DBAccess::runQuery($query);
		
		if ($resultSet->num_rows === 0) {
			echo "Event type query failed";
			return NULL;
		}
		
		self::$event_type_mappings = [];
		
		for ($i = 0; $i < $resultSet->num_rows; $i++) {
			$row = mysqli_fetch_assoc($resultSet);
			self::$event_type_mappings[$row['EventName']] = $row['EventId'];
		}
		
		#print_r(self::$event_type_mappings);
	}
}