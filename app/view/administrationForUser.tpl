<?php
	
	require_once '../controller/sessionAttributes.php';
	require_once '../model/Event.class.php';
	
	if (!isset($e_user)) {
		# Redirect as user is not logged in.
    	session_unset();
    	header('Location: '. SERVER_PATH. 'login/');
    	exit();
	}

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
		echo "<h3>This user was not found.</h3>";
		$redirectPath = SERVER_PATH . 'dashboard.php';
		echo '<p><a href="' . $redirectPath . '">Your Dashboard</a></p>';
		die();
	}
		
	$profile_userName = $profile_user->getUserid();
	$userName = $e_user->getUserid();

	if ($profile_userName == $userName){
		$viewingOwnProfile = true;
	} else {
		$viewingOwnProfile = false;
	}
	
	$profile_firstName = $profile_user->getFirstName();
	$profile_middleName = $profile_user->get('middleName');
	$profile_lastName = $profile_user->getLastName();
	$profile_email_visibility = $profile_user->get('emailVisibility');
	$profile_emailAddress = $profile_user->get('emailAddress');
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
            <p class="roleActual">Registered User</p>
            <button type='button' class='btn btn-primary btn-sm promoteToModerator'>Promote to Moderator</button>
            <button type='button' class='btn btn-primary btn-sm promoteToAdmin'>Promote to Admin</button>

        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">User Comments</h3>
        </div>
        <div class="panel-body">

            <p>Select Region Box Will Go Here. (Coming Soon).</p>


            <table class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th>Date</th>
                    <th>Comment</th>
                    <th>Modify</th>
                </tr>
                </thead>
                <tbody>
                <?php

                $numComments = [50, 30, 20, 40, 30, 40, 50, 20];

                $count = count($numComments);
                for ($i=0; $i < $count; $i++) { ?>
                    <tr>
                        <td>Wed 17th Sep 2014</td>
                        <td>@#@#*! Some explicit content.</td>
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







