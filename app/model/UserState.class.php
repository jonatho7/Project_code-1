<?php

require_once 'User.class.php';

require_once 'Region.class.php';
require_once 'UserPred.class.php';
/*
 * This class encapsulates all the state about 
 * user who is logged in. 
 * This should be created when user logs in and
 * destroyed when user logs out and is stored in Session.
 *
 *  and this points to $userObject (object encapulation)
 */

class UserData {

	public static function getPredictionsForRegion($user, $r_name) {

		$userPId = $user->getUserPKId(); //Take Primary key

		$userPId = DBAccess::quoteString($userPId);
		$r_name = DBAccess::quoteString($r_name);

		$query = "select * from " . UserPred::USER_PRED_TABLE . " where u_id= $userPId and r_id = (select distinct(r_id) from " . REGION::REGION_TABLE. " where r_name=$r_name) order by up_date";

		#echo $query;
		$resultSet = DBAccess::runQuery($query);
		if ($resultSet == NULL || $resultSet == False) {
			echo "Unable to access database";
			return NULL;
		}

		# Loop through all the regions
		$rows = mysqli_num_rows($resultSet);
		if ($rows == 0)
			return NULL;


		$userPredList = [];
		for($i = 0; $i < $rows; $i++) {
			$row = mysqli_fetch_assoc($resultSet);
			$userPredList[] = new UserPred($user, $row);
		}

		return $userPredList;
	}

    public static function getUsersForRegion ($user, $r_name){

        $userPId = $user->getUserPKId(); //Take Primary key

        $userPId = DBAccess::quoteString($userPId);
        $r_name = DBAccess::quoteString($r_name);

        // $region_id gets the id from the region name.
        $region_id = Region::getRegionIdFromName($r_name);

        $query = "select user_id from " . User::DBTABLE . " where id in " . "(select distinct u_id from " . UserPred::USER_PRED_TABLE . " where r_id= $region_id)";


        $resultSet = DBAccess::runQuery($query);
        if ($resultSet == NULL || $resultSet == False) {
            echo "Unable to access database";
            return NULL;
        }

        # Loop through all the regions
        $rows = mysqli_num_rows($resultSet);
        if ($rows == 0)
            return NULL;

        // $user_list => list of users
        $user_list = [];
        for($i = 0; $i < $rows; $i++) {
            $row = mysqli_fetch_assoc($resultSet);
            $user_list[] = $row["user_id"];
        }
        return $user_list;




    }




}