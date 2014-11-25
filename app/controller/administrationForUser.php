<?php
    	
    require_once '../config.php';
    
    require_once 'sessionAttributes.php';
    require_once '../model/User.class.php';
    require_once '../model/UserState.class.php';
	require_once '../model/Activity.class.php';
    
    
    
   if (empty($_SESSION['userName'])) {
    	# Redirect as user is not logged in.
    	session_unset();
    	#require_once 'login.php';
		header('Location: '. SERVER_PATH. 'login/');
    	exit();
    }
    

    //echo "UserName = ". $_SESSION['userName'];
    $user = User::getUserByUserName($_SESSION['userName']);
    
    if ($user == NULL) {
        # CHANGE ME to login folder.
        header('Location: '. SERVER_PATH. 'login/');
        exit();
    }
    
    # Set the title and user object
    $e_Title = "Administration";
    $e_user = $user;
    
    require_once '../view/loggedInHeader.tpl';
    require_once '../view/administrationForUser.tpl';
	require_once '../view/loggedInFooter.tpl';

?>