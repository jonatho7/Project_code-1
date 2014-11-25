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
	$userName = $e_user->getUserid();
?>

<div>

    <h2 class="administrationText">Administration</h2>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">User</h3>
        </div>
        <div class="panel-body">
            <p class="usernameText">Username: </p>
            <p class="usernameActual"><?php echo $userName ?></p>
            <p></p>
            <p class="roleText">Role: </p>
            <p class="roleActual">Registered User</p>
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
            <a href="<?php echo SERVER_PATH?>users/jonatho7/administration">jonatho7</a>

        </div>
    </div>



	
</div>






