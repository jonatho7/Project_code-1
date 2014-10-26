<?php

class DBAccess {
	
	public static $conn = Null;
	
	public static function createSQLConnection() {
		
		# These paramaters are obtained from config file
		$db = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_DATABASE);
		if (mysqli_connect_errno()) {
			echo "DATABASE ACCESS unsuccessful";
		}
		else {
			/*DEBUG */
			#echo "Succussfully established connection to server";
		}
		return $db;
	}

	public static function runQuery($queryString) {
		if (DBAccess::$conn == NULL) {
			DBAccess::$conn = DBAccess::createSQLConnection();
		}
		return mysqli_query(DBAccess::$conn, $queryString);
	}
	
	/*
	 * Quotes to use for name searching
	 */
	public static function quoteString($s) {
		if (DBAccess::$conn == NULL) {
			DBAccess::$conn = DBAccess::createSQLConnection();
		}
		return "'" . mysqli_escape_string(self::$conn, $s) . "'";
	}
	
	/*
	 * Same code as used by Prof. Kurt in his demo example. Copied verbatim
	 *
	 */
	public static function buildInsertQuery($table = '', $data = array()) {
		
		$fields = '';
		$values = '';
	
		# Take the field names from the $mapping
		foreach ($data as $field => $value) {
			if($value !== null) { // skip unset fields
				$fields .= "`".$field . "`, ";
				$values .= self::quoteString($value) . ", ";
			}
		}
	
		// cut off the last ', ' for each
		$fields = substr($fields, 0, -2);
		$values = substr($values, 0, -2);
	
		$query = sprintf("INSERT INTO `%s` (%s) VALUES (%s);",
				$table,
				$fields,
				$values
		);
		return ($query);
	}
}