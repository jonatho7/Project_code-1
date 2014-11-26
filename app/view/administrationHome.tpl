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


<div>

    <h2 class="administrationText">Administration</h2>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">User</h3>
        </div>
        <div class="panel-body">
            <p class="usernameText">Username: </p>
            <p class="usernameActual"><a href="<?php echo SERVER_PATH?>users/<?php echo $userName ?>"><?php echo $userName ?></a></p>
            <p></p>
            <p class="roleText">Role: </p>
            <p class="roleActual"><?php echo $userRole ?></p>
            <button type='button' class='btn btn-primary btn-sm promoteToModerator'>Promote to Moderator</button>
            <button type='button' class='btn btn-primary btn-sm promoteToAdmin'>Promote to Admin</button>

        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Search For User</h3>
        </div>
        <div class="panel-body">

            <p>A Search for a user will go here. (Coming Soon).</p>
            <p>Your search found this user:</p>
            <a href="<?php echo SERVER_PATH?>administration.php?userQuery=jonatho7">jonatho7</a>
            <a href="<?php echo SERVER_PATH?>administration?userQuery=harshalh">harshalh</a>
            <a href="<?php echo SERVER_PATH?>administration?userQuery=jdoe">jdoe</a>
            <a href="<?php echo SERVER_PATH?>administration?userQuery=marysmith">marysmith</a>
            <a href="<?php echo SERVER_PATH?>administration?userQuery=lukebryan">lukebryan</a>

        </div>
    </div>



	
</div>







