<?php

define('SERVER_PATH','http://localhost/flutracker/');


// database constants
define('DB_HOST','localhost');
define('DB_USER','root');
define('DB_PASS','buddY181');
define('DB_DATABASE','flu');

//Variable stored in Session for tracking state of each user.
define('USER_STATE', 'userState');

//Change this parameter depending on where the results need to be submitted
//for Amazon Mechanical Turks
define("AMT_SUBMIF_FORM", "http://localhost/flutracker/test.php");
define("PREVIEW_HIT", "ASSIGNMENT_ID_NOT_AVAILABLE");
define("ASSIGNMENT_ID", "assignmentId");
define("WORKER_ID", "workerId");