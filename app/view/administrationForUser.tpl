<?php
	
	require_once '../controller/sessionAttributes.php';
	require_once '../model/Event.class.php';
	
	if (!isset($e_user)) {
		# Redirect as user is not logged in.
    	session_unset();
    	header('Location: '. SERVER_PATH. 'login/');
    	exit();
	}

    //Show message if user does not have at least moderator privileges.
    if (!$e_user->hasModeratorPrivileges()){
        echo "<h2>I'm sorry</h2>";
        echo "<h4 class='userNotFound'>You do not have administrative privileges.</h4>";
        $redirectPath = SERVER_PATH . 'dashboard.php';
        echo '<p><a href="' . $redirectPath . '">Your Dashboard</a></p>';
        die();
    }

    $userName = $e_user->getUserid();
    $userRole = $e_user->getUserRole();

?>

<?php
	$userQuery = $_GET["userQuery"];
?>

<?php
	//We need to determine whether the username from the userQuery is a valid user in the database.
	$profile_user = User::getUserByUserName($userQuery);
	if ($profile_user == null){
		//This user does not exist in the DB. Display a message.
		echo "<h2>I'm sorry</h2>";
        echo "<h4 class='userNotFound'>This user was not found.</h4>";
		$redirectPath = SERVER_PATH . 'dashboard.php';
		echo '<p><a href="' . $redirectPath . '">Your Dashboard</a></p>';
		die();
	}
		
	$profile_userName = $profile_user->getUserid();

	if ($profile_userName == $userName){
		$viewingOwnProfile = true;
	} else {
		$viewingOwnProfile = false;
	}
	
	//$profile_firstName = $profile_user->getFirstName();
	//$profile_middleName = $profile_user->get('middleName');
	//$profile_lastName = $profile_user->getLastName();
	//$profile_email_visibility = $profile_user->get('emailVisibility');
	//$profile_emailAddress = $profile_user->get('emailAddress');

    $profile_userRole = $profile_user->getUserRole();
    //Show a message if the user is not allowed to view this page.
    //Reasons: 1) moderator trying to view an admin page. admin is above moderator.
    if (!$e_user->comparePrivileges($userRole, $profile_userRole)){
        echo "<h2>I'm sorry</h2>";
        echo "<h4 class='userNotFound'>You do not have sufficient privileges to view this page.</h4>";
        $redirectPath = SERVER_PATH . 'dashboard.php';
        echo '<p><a href="' . $redirectPath . '">Your Dashboard</a></p>';
        die();
    }

?>

<div>

    <h2 class="administrationText">Administration</h2>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">User</h3>
        </div>
        <div class="panel-body">
            <p class="usernameText">Username: </p>
            <p class="usernameActual"><?php echo $userQuery ?></p>
            <p></p>
            <p class="roleText">Role: </p>
            <p class="roleActual"><?php echo $profile_userRole ?></p>
            <button type='button' class='btn btn-primary btn-sm promoteToModerator'>Promote to Moderator</button>
            <button type='button' class='btn btn-primary btn-sm promoteToAdmin'>Promote to Admin</button>

        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">User Comments</h3>
        </div>
        <div class="panel-body">


            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Region</th>
                        <th>Comment</th>
                        <th>Modify Comment</th>
                    </tr>
                </thead>
                <tbody>


                <?php
                    $zeroPredictionsMade = True;

                    //Get all the regions from The database as an array
                    $regions = Region::getAllRegions();

                    //Iterate over the regions array, for each region.
                    for($regionNumber = 0; $regionNumber < count($regions); $regionNumber++ )
                    {
                        $region = $regions[$regionNumber];
                        $userPredList = UserData::getPredictionsForRegion($profile_user,$region->getRegionName());

                        if( count($userPredList) != 0){
                            $zeroPredictionsMade = False;
                        }

                        //Iterate over the specific region, outputting rows for each prediction.
                        for($userPredNumber = 0; $userPredNumber < count($userPredList); $userPredNumber++)
                        {
                 ?>
                            <tr>
                                <td><?php echo $userPredList[$userPredNumber]->getDateFormatted()?></td>
                                <td><?php echo $region->getRegionName()?></td>
                                <td><?php echo $userPredList[$userPredNumber]->getComment()?></td>
                                <td>
                                    <form role="role">
                                        <?php
                                        /*
                                         * Put the region name here so that server knows which
                                         * region to display.
                                         */
                                        //$array = array('region'=>$e_region);

                                        // Construct query parameter and post it to dashboard.php
                                        //$query = http_build_query($array);
                                        $query = "meh";
                                        ?>
                                        <button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardEdit.php?<?=$query?>" class="btn btn-warning btn-xs disabled"  name="up_id" value="sheesh">Edit</button>
                                        <button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardDelete.php?<?=$query?>" class="btn btn-danger btn-xs disabled" name="up_id" value="sheesh">Delete</button>
                                    </form>
                                </td>
                            </tr>
                <?php
                        }
                    }

                    if( $zeroPredictionsMade == True){
                        echo "User has not made any predictions yet.";
                    }
                ?>

                <?php
                $count = count($userPredList);
                for ($i=0; $i < $count; $i++) { ?>
                    <tr>
                        <td><?php echo $userPredList[$i]->getDateFormatted()?></td>
                        <td>Boston HHS</td>
                        <td><?php echo $userPredList[$i]->getComment()?></td>
                        <td>
                            <form role="role">
                                <?php
                                /*
                                 * Put the region name here so that server knows which
                                 * region to display.
                                 */
                                //$array = array('region'=>$e_region);

                                // Construct query parameter and post it to dashboard.php
                                //$query = http_build_query($array);
                                $query = "meh";
                                ?>
                                <button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardEdit.php?<?=$query?>" class="btn btn-warning btn-xs disabled"  name="up_id" value="sheesh">Edit</button>
                                <button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardDelete.php?<?=$query?>" class="btn btn-danger btn-xs disabled" name="up_id" value="sheesh">Delete</button>
                            </form>
                        </td>
                    </tr>
                <?php
                }
                ?>
                </tbody>
            </table> <!-- <!-- End of table format -->
        </div>
    </div>



	
</div>







