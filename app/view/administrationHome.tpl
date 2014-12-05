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

    $errorMessage = '';
    if (!empty($_GET['errorMessage'])) {
        $errorMessage = $_GET['errorMessage'];
    }

    $userQuery = '';
    if (!empty($_GET['userQuery'])) {
        $userQuery = $_GET['userQuery'];
    }

?>


<div>


    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header administrationText">Administration</h1>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Your Account</h3>
        </div>
        <div class="panel-body">
            <p class="usernameText">Username: </p>
            <p class="usernameActual"><a href="<?php echo SERVER_PATH?>users/<?php echo $userName ?>"><?php echo $userName ?></a></p>
            <p></p>
            <p class="roleText">Role: </p>
            <p class="roleActual"><?php echo $userRole ?></p>

        </div>
    </div>


    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Search For User</h3>
        </div>
        <div class="panel-body">

            <form role="form">
                <p>Search for a user by username:</p>
                <!--Let the user type in the name they would like to search for.-->
                <input type="text" required class="form-control searchForUser" name="userQuery" value="<?php echo $userQuery ?>">
                <button class='btn btn-primary btn-sm searchForUserButton' type='submit'
                        formmethod="post" formaction="<?php echo SERVER_PATH?>processSearchForUser">Search</button>

                <p></p>
                <?php
                if ($errorMessage == 'none') {
                    ?>
                    <p>Search Results: </p>
                    <p><a href="<?php echo SERVER_PATH?>administration?userQuery=<?php echo $userQuery ?>"><?php echo $userQuery ?></a></p>
                <?php
                } else if ($errorMessage == 'user not found') {
                    echo "<p>No users found for search term: $userQuery</p>";
                } else if ($errorMessage == ''){
                    //Just loaded the page. No error message yet because no search has been performed.
                }
                ?>
            </form>

        </div> <!--End panel body-->
    </div> <!--End panel-->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Friends</h3>
        </div>
        <div class="panel-body">

            <div>
                <h4>Following:</h4>
                <?php

                /*
                 * Get the following list for a user from DB.
                 */

                $followingArray = User::getUsersFollowingById($e_user->getUserPKId());

                if ( count($followingArray) == 0){
                    $findFriendsPath = SERVER_PATH . 'app/controller/searchUsers.php';
                    echo "<p>You are not following any users yet. See the <a href='$findFriendsPath'>Find Users</a> page to find users to follow.</p>";
                } else {
                    for ($index = 0; $index < count($followingArray); $index++) {
                        $friendPath = SERVER_PATH . "administration?userQuery=" . $followingArray[$index];
                        echo "<p><a href='$friendPath'>$followingArray[$index]</a></p>";
                    }
                }

                ?>
            </div>

            <div">
                <h4>Followers:</h4>
                <?php

                /*
                 * Get Followers for profile user from database.
                 *
                 */
                $followersArray = User::getUsersFollowersById($e_user->getUserPKId());

                if ( count($followersArray) == 0){
                    echo "<p>You do not have any followers yet.</p>";
                } else {
                    for ($index = 0; $index < count($followersArray); $index++) {
                        $friendPath = SERVER_PATH . "administration?userQuery=" . $followersArray[$index];
                        echo "<p><a href='$friendPath'>$followersArray[$index]</a></p>";
                    }
                }
                ?>
            </div>

            </div> <!--End follow div-->

        </div> <!--End panel body-->
    </div> <!--End panel-->


</div>






