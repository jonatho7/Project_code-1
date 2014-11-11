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
	
	// Same as database names
	protected $id;
	protected $u_Id;
	protected $eventId; 
	protected $pastData;
	protected $newData;
	protected $eventDate;
	
	// Invoked because of user actions
	public function __construct($array) {
		$this->id = $array['id'];
		$this->id = $array['u_id'];
		$this->id = $array['eventId'];
		$this->id = $array['pastData'];
		$this->id = $array['newData'];
		$this->id = $array['eventDate'];
	}
	
	// Note $userObj is an instance of User Object.
	// Creates an instance of Event class
	public static function createEventgivenUser($userObj,$eventName, $pastData, $newData) {
		
		if (self::$event_type_mappings == NULL) {
			self::createEventNameToIdMapping();
		}
		
		$array = Array('id'=> NULL,
				'eventDate'=>NULL,
				'pastDate'=>$pastData,
				'newData'=>$newData,
				'eventId'=>self::$event_type_mappings[$eventName],
				'u_id'=>$userObj->getUserPKId()
				);
		$event = new Event($array);
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