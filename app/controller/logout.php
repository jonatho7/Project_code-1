<?php

/*
 * 
 * This is a logout processing page.
 */

require_once '../global.php';

require_once 'sessionAttributes.php';
require_once '../model/User.class.php';


session_unset();
# Redirect to splash screen
header('Location: '. SERVER_PATH);
exit();
