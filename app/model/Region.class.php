<?php

require_once 'DbAccess.class.php';

/*
 *  Look at the static methods for more details regarding what information
 *  is provided by each API.
 *
 */

class Region {
	/*
	 * The number of regions cannot be changed while web app
	 * is running. So, it remains constant.
	 * 
	 */
	const  REGION_TABLE = 'region';
	
	/*
	 * List of all the regions in the db as associative array
	 */
	public static $regionList = NULL;
	/*
	 * Database fields names match with Schema names so
	 * that no conversion is required for loading/unloading
	 * from database.
	 */
	protected $r_id; # This identifies unique row in the table
	protected $r_name;
	
	public function __construct($r_id, $r_name) {
		$this->r_id = $r_id;
		$this->r_name = $r_name;
	}
	
	public function getRegionId() {
		return $this->r_id;
	}
	
	public function getRegionName() {
		return $this->r_name;
	}

    public static function getRegionIdFromName($r_name){

        $query = "select r_id from ". self::REGION_TABLE . " where r_name = $r_name";
        $result = DBAccess::runQuery($query);

        if ($result == NULL || $result == False) {
            echo "Unable to access database";
            return NULL;
        }
        else
        {
            $regionId = mysqli_fetch_assoc($result);
            return $regionId["r_id"];

        }

    }
	
	public static function getAllRegions() {
		
		if (self::$regionList != NULL) {
			return self::$regionList;
		}

        //Made this function sort by r_id ascending.
		$query = "select r_id, r_name from ". self::REGION_TABLE . " order by r_id asc";
		
		#echo "$query";
		
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet == NULL || $resultSet == False) {
			echo "Unable to access database";
			return NULL;
		}
		
		# Loop through all the regions
		$rows = mysqli_num_rows($resultSet);
		if ($rows == 0)
			return NULL;
		
		$r_list = [];
		for($i = 0; $i < $rows; $i++) {
			$row = mysqli_fetch_assoc($resultSet);
			$r_list[] = new Region($row['r_id'], $row['r_name']);		
		}
		self::$regionList = $r_list;
		
		return self::$regionList;
		
	}
	
	public static function getLatestPredictionDate($r_name) {
		/*
		 * Returns the date object corressponding to latest 
		 * real data available for a given region
		 */
		$r_name = DBAccess::quoteString($r_name);
		$query = 'SELECT max(ad_date) as date from actual_data where r_id = '.
				"(select distinct(r_id) from region where r_name=$r_name)";
		
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet->num_rows === 0) {
			return NULL;
		}
		//$row = mysqli_fetch_assoc($resultSet);
		//print_r($row);
		return date_create(mysqli_fetch_assoc($resultSet)['date']);
	}
	public static function getLatestPredictionDateById($r_id) {
		/*
		 * Returns the date object corressponding to latest
		* real data available for a given region id
		*/
		$query = "SELECT max(ad_date) as date from actual_data where r_id = $r_id";
	
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet->num_rows === 0) {
			return NULL;
		}
		//$row = mysqli_fetch_assoc($resultSet);
		//print_r($row);
		return date_create(mysqli_fetch_assoc($resultSet)['date']);
	}
	
	public static function getRegionPKfromRegionName($r_name) {
		$r_name = DBAccess::quoteString($r_name);
		
		$query = "select distinct(r_id) as r_id from region where r_name=$r_name";
		#echo $query;
		
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet->num_rows === 0) {
			return NULL;
		}
		return mysqli_fetch_assoc($resultSet)['r_id'];
	}

    /*
     * Returns the name of the first region extracted from database
     */
    public static function getFirstRegion() {
        $regionsList = self::getAllRegions();
        return $regionsList[0]->r_name;
    }


    /*
     *  This method returns the latest surveillance data for each region
     *  in the system.
     *
     *  Output: An associative array:
     *   {<region_id>: {"region_abbr":<value>, "region_name":<value>, "date":<value>, "count":<value> }
     */
    public static function getLatestActualData() {
        $query = "select r_name_display as region_id , r_abbr as region_abbr, r_name as region_name, ad_date as date , ad_value as value from region, actual_data where ad_date =(select max(ad_date) from actual_data) and region.r_id = actual_data.r_id";

        $resultSet = DBAccess::runQuery($query);
		if ($resultSet->num_rows === 0) {
            return NULL;
        }

        # find number of rows
		$rows = mysqli_num_rows($resultSet);
		if ($rows == 0)
            return NULL;

        $regions = array();
		for($i = 0; $i < $rows; $i++) {
            $temp = mysqli_fetch_assoc($resultSet);
            $region_id = $temp['region_id'];
            $regions[$region_id] = array();
            $regions[$region_id]['region_abbr'] = $temp['region_abbr'];
            $regions[$region_id]['region_name'] = $temp['region_name'];
            $regions[$region_id]['date'] = $temp['date'];
            $regions[$region_id]['value'] = $temp['value'];
        }

        return $regions;
    }
}
