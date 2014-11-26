<?php

require_once 'Region.class.php';
require_once 'User.class.php';

class UserPred {
	// Points to user object
	public 	$userObj = NULL;
	
	/*
	 * Fields same as database schema for table user_pred
	 */
	const USER_PRED_TABLE = "user_pred";
	
	protected $up_id; 
	protected $up_value;
	protected $up_modified;
	protected $r_id;
	public 	  $up_date;
	protected $up_comment;
	protected $u_id;
	
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
	
	public function getDateFormatted() {
		return date_create($this->up_date)->format('D jS M Y');
	}
	
	public function getValue() {
		return $this->up_value;
	}
	
	public function getComment() {
		return $this->up_comment;
	}
	
	public function  getLastModified() {
		return $this->up_modified;
	}
	
	public function getLastModifiedFormatted() {
		return date_create($this->getLastModified())->format('G:ia \o\n D jS M Y');
	}
	
	public function getup_pk() {
		/* 
		 * Gets primary key of user prediction row
		 */
		return $this->up_id;
		
	}
	public function isExpriredPrediction() {
		$maxdate = Region::getLatestPredictionDateById($this->r_id);
		
		if (date_create($this->up_date) <= $maxdate ){
			return True;
		} else {
			return False;
		}
	}
	
	public static  function getPreditionForId($up_id) {
		/*
		 * Get prediction row by unique value which happends to be $up_id
		 * 
		 */
		$query = 'SELECT *  from '. self::USER_PRED_TABLE. " where up_id = $up_id";
		
		//echo $query;
		
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet->num_rows === 0) {
			return NULL;
		}
		$row = mysqli_fetch_assoc($resultSet);
		#print_r($row);
		$user = User::getUserbyUserID($row['up_id']);
		return new UserPred($user, $row);
	}
	
	public function getUserObj() {
		return $this->userObj;
	}

	public function deleteUserPred() {
		
		$query = 'DELETE from '. self::USER_PRED_TABLE. ' where up_id = '.$this->up_id;
		$resultSet = DBAccess::runQuery($query);
		
		if ($resultSet == False) {
			echo "Couldn't delete the entry<br>";
			return FALSE;
		}
		
		return TRUE;
		
	}
	
	public function save($value, $comment) {
		/* Saves the date value and comment
		 * for a prediction in the database table
		 */
		$value = DBAccess::quoteString($value);
		$comment = DBAccess::quoteString($comment);
		
		$query = 'UPDATE '. self::USER_PRED_TABLE . " set up_value=$value , up_comment=$comment ".
				"where up_id=".$this->up_id;
		//echo "<br>$query";
		
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet == False) {
			echo "Couldn't delete the entry<br>";
			return FALSE;
		}
		return True;
		
	}

    public function saveCommentOnly($comment) {
        /* Saves the comment
         * for a prediction in the database table
         */
        $comment = DBAccess::quoteString($comment);

        $query = 'UPDATE '. self::USER_PRED_TABLE . " set up_comment=$comment ".
            "where up_id=".$this->up_id;
        //echo "<br>$query";

        $resultSet = DBAccess::runQuery($query);
        if ($resultSet == False) {
            echo "Couldn't delete the entry<br>";
            return FALSE;
        }
        return True;

    }
	
	public static function storeNewPrediction($regionName, $value, $predDate, $comment) {
		
		$userPK = User::getUserByUserName($_SESSION['userName'])->getUserPKId();
		$regionPK = Region::getRegionPKfromRegionName($regionName);
		
		$predDate = DBAccess::quoteString($predDate);
		
		$comment = DBAccess::quoteString($comment);
			
		$query = 'INSERT INTO '. self::USER_PRED_TABLE. ' (up_value, r_id, up_date, up_comment, u_id)'.
				" VALUES ($value, $regionPK, $predDate, $comment, $userPK)";
		
		echo $query;
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet == False) {
			echo "Couldn't add the entry<br>";
			return FALSE;
		}
		return True;
	}
}