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
    //Get the userQuery.
	$userQuery = $_GET["userQuery"];

    //Get the region. If not available, set to the first region.
    if (!isset($_GET["region"])) {
        $e_region = "Boston HHS";
    }

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
            <p class="usernameActual"><a href="<?php echo SERVER_PATH?>users/<?php echo $userQuery ?>"><?php echo $userQuery ?></a></p>
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


            <?php
                //Get all the regions from The database as an array
                $userPredList = UserData::getPredictionsForRegion($profile_user,$e_region);
                $regions = Region::getAllRegions();
            ?>

            <p>Select Region </p>
            <form role="form">
                <div class="form-group">
                    <select class="form-control" name="ChangeRegionName">
                        <?php
                        $size = count($regions);
                        for ($i =0; $i < $size; $i++) {
                            $selected = '';
                            if ($e_region== $regions[$i]->getRegionName())
                                $selected = "selected";
                            echo "<option $selected>". $regions[$i]->getRegionName() . '</option>';
                        }
                        ?>
                    </select>

                    <!--A hidden input which will have the userQuery.-->
                    <input type="hidden" name="userQuery" value="<?php echo $profile_userName ?>">

                </div>
                <div class="form-group">
                    <button formmethod="post" formaction="<?php echo SERVER_PATH?>ProcessAdministrationChangeRegion.php"
                            type="submit" class="btn btn-primary">
                        Change Region
                    </button>
                </div>
            </form>


            <p class="listOfPredictions">
                <?php
                if (count($userPredList) != 0) {
                    echo 'List of predictions made for '.$e_region;
                } else {
                    echo 'No predictions yet made for '.$e_region;
                }
                ?>
            </p>

            <?php //Table appears only if there are any entries
            if (count($userPredList) != 0)
            { ?>
                <!-- table starts -->
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Region</th>
                            <th>Comment</th>
                            <th>Modify</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    $count = count($userPredList);
                    for ($i=0; $i < $count; $i++) {
                    ?>
                        <tr>
                            <td><?php echo $userPredList[$i]->getDateFormatted()?></td>
                            <td><?php echo $e_region ?></td>
                            <td><?php echo $userPredList[$i]->getComment()?></td>
                            <td>
                                <form role="role">
                                    <?php
                                    /*
                                     * Put the region name here so that server knows which
                                     * region to display.
                                     */
                                    // Construct query parameter.
                                    $array = array('userQuery'=>$userQuery, 'region'=>$e_region);
                                    $queryParameters = http_build_query($array);
                                    ?>
                                    <button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processAdministrationEdit?<?=$queryParameters?>" class="btn btn-warning btn-xs"  name="up_id" value="<?php echo $userPredList[$i]->getup_pk()?>">Edit</button>
                                </form>
                            </td>
                        </tr>
                    <?php
                    }
                    ?>
                    </tbody>
                </table> <!-- <!-- End of table format -->
            <?php
            }
            ?>
        </div><!--End panel body-->
    </div><!--End User Comments panel-->
	
</div>







