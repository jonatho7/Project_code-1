<?php

session_start();

function defaultUserRegistrationErrors() {
	return [];
}
/*
 * Note this associate array is passed to registration form again to
* display the errors, if any.
*  class or array
*/
function getuserRegistrationErrors() {
	if (isset($_SESSION['userRegistrationErrors'])) {
		return $_SESSION['userRegistrationErrors'];
	} else {
		return $userRegistrationErrors = defaultUserRegistrationErrors();
	}
}