<?php

#define('SERVER_PATH','http://localhost/flutracker/');

// Path for setting up on Amazon EC2
define('SERVER_PATH','https://ec2-54-69-66-88.us-west-2.compute.amazonaws.com/flutracker/');

// database constants
define('DB_HOST','localhost');
define('DB_USER','root');
define('DB_PASS','buddY181');
define('DB_DATABASE','flu2');

//Variable stored in Session for tracking state of each user.
define('USER_STATE', 'userState');

//Change this parameter depending on where the results need to be submitted
//for Amazon Mechanical Turks
#define("AMT_SUBMIT_FORM", SERVER_PATH. "test.php");
define("AMT_SUBMIT_FORM", "https://www.mturk.com/mturk/externalSubmit");

define("PREVIEW_HIT", "ASSIGNMENT_ID_NOT_AVAILABLE");
define("ASSIGNMENT_ID", "assignmentId");
define("WORKER_ID", "workerId");
define("HIT_ID", "hitId");
define("CURRRENT_TASK", "task"); //Indicates the current task that the turker is supposed to do.
define("MAX_QUESTIONS", "6");
