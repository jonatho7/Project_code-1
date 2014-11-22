/*
	Creates an input element with name and value 
	pairs
 */
function createInputTag(name, value) {
	var $input = $("<input>");
	$input.attr("name", name);
	$input.attr("value", value);
	return $input;
}

/*
	Sends a post request to server to toggle
	follow/unfollow state
 */
function sendPostFollowRequest() {
	var serverPath = $("body").data("server-path");
	var profileUser = $(".get-data").data("profile-user");
	var followState = $(".get-data").data("follow-state");

	var $form = $("<form></form>");

	$form.attr("method", "post");

	var serverPath = $("body").data("server-path");

	$form.attr("action", serverPath + "handleUserProfileChanges.php");

	$form.append(createInputTag("profile-user", profileUser));
	$form.append(createInputTag("follow-state", followState));
	$form.append(createInputTag("service", "followRequest"));

	$form.submit();
}

var adminMode = false;
var main = function() {

	/*
	    Implement toggle between Admin and normal mode
	 */

	$("button.adminMode").click(function () {
		if (adminMode == false) {
			adminMode = true;
			$("button.adminMode").text("Exit Admin Mode");
			$("li.adminMode").show();
		} else {
			adminMode = false;
			$("li.adminMode").hide();
			$("button.adminMode").text("Enter Admin Mode");
		}
	});

	$(".unfollowButton").click(function() {
		var result = confirm("Are you sure you want to unfollow this user?");
		if (result == true){
			//TODO. Need to unfollow the user. Add this data to the database.
			;

			alert("You are no longer following this user.")

			//Show the follow button.
			$(".followButton").removeClass( "buttonDisplayHidden" );
			$(".followButton").addClass( "buttonDisplayInherit" );

			//Hide the unfollow button.
			$(".unfollowButton").removeClass( "buttonDisplayInherit" );
			$(".unfollowButton").addClass( "buttonDisplayHidden" );
			sendPostFollowRequest();
		}
	});

	$(".followButton").click(function() {
		//TODO. Need to follow the user. Add this data to database.
		;

		alert("You are now following this user.")

		//Show the unfollow button.
		$(".unfollowButton").removeClass( "buttonDisplayHidden" );
		$(".unfollowButton").addClass( "buttonDisplayInherit" );

		//Hide the follow button.
		$(".followButton").removeClass( "buttonDisplayInherit" );
		$(".followButton").addClass( "buttonDisplayHidden" );
		sendPostFollowRequest();

	});

	$(".editProfileButton").click(function() {
		//Hide these items.
		$(".userTPL_firstName").css( "display", "none" );
		$(".userTPL_middleName").css( "display", "none" );
		$(".userTPL_lastName").css( "display", "none" );
		$(".userTPL_visibility").css( "display", "none" );
		$(".userTPL_email").css( "display", "none" );
		$(".editProfileButton").css( "display", "none" );

		//Show these items.
		$(".userTPL_firstNameForm").css( "display", "inline" );
		$(".userTPL_middleNameForm").css( "display", "inline" );
		$(".userTPL_lastNameForm").css( "display", "inline" );
		$(".userTPL_visibilityForm").css( "display", "inline" );
		$(".userTPL_emailForm").css( "display", "inline" );
		$(".submitChangesButton").css( "display", "inline" );
		$(".cancelChangesButton").css( "display", "inline" );
		$(".passwordDiv").css( "display", "block" );

		//Transfer the values.
		$(".userTPL_firstNameForm").val( $(".userTPL_firstName").text() );
		$(".userTPL_middleNameForm").val( $(".userTPL_middleName").text() );
		$(".userTPL_lastNameForm").val( $(".userTPL_lastName").text() );
		$(".userTPL_visibilityForm").val( $(".userTPL_visibility").text() );
		$(".userTPL_emailForm").val( $(".userTPL_email").text() );
	});


	$(".submitChangesButton").click(function() {
		//Perform some data validation.
		var errorMessage = "";

		//Check for empty fields
		var value = $(".userTPL_firstNameForm").val()
		if (value == null || value == "") {
			errorMessage = "Error: Please enter a value for First Name."
		}

		value = $(".userTPL_lastNameForm").val()
		if (value == null || value == "") {
			errorMessage = "Error: Please enter a value for Last Name."
		}

		value = $(".userTPL_emailForm").val()
		if (value == null || value == "") {
			errorMessage = "Error: Please enter a value for Email Address."
		}

		//If a password is entered...then check the confirmation password.
		value = $(".userTPL_passwordForm").val()
		if (value != null && value != "") {
			var value2 = $(".userTPL_confirmPasswordForm").val();
			if (value != value2) {
				errorMessage = "Error: Passwords entered did not match."
			}
		}

		if (errorMessage == "") {
			//No Error messages. Try to make the changes to the user account in the database.

			transferValuesFromInputsToParagraphs()

			showParagraphsAndHideInputs()

			removeErrorMessages();

			alert("Successfully updated your profile information.");

			/*
			 * Create a form and submit the results via post
			 */
			var $form = $("<form></form>");

			$form.attr("method", "post");
			var serverPath = $("body").data("server-path");
			$form.attr("action", serverPath + "handleUserProfileChanges.php");
			$form.append(createInputTag("firstName", $(".userTPL_firstNameForm").val()));
			$form.append(createInputTag("middleName", $(".userTPL_middleNameForm").val()));
			$form.append(createInputTag("lastName", $(".userTPL_lastNameForm").val()));
			$form.append(createInputTag("visibility",$(".userTPL_visibilityForm").val()));
			$form.append(createInputTag("email",$(".userTPL_emailForm").val()));
			$form.append(createInputTag("password", $(".userTPL_passwordForm").val()));
			$form.append(createInputTag("username", $("body").data("username")));
			$form.append(createInputTag("service", "profileRequest"));
			$form.submit();


		} else {
			//Display the error message.
			$(".errorBox").css( "display", "block" );
			$('#errorMessage').text( errorMessage  );
			$("#errorMessage").css( "display", "block" );
		}


	});

	$(".cancelChangesButton").click(function() {
		showParagraphsAndHideInputs()
		
		//Clear any of the originally empty fields, such as the password fields,
		// to make sure that they are empty when we press Edit the next time.
		$(".userTPL_passwordForm").val("");
		$(".userTPL_confirmPasswordForm").val("");
		

	});

	function showParagraphsAndHideInputs() {
		//Show these items.
		$(".userTPL_firstName").css( "display", "inline" );
		$(".userTPL_middleName").css( "display", "inline" );
		$(".userTPL_lastName").css( "display", "inline" );
		$(".userTPL_userName").css( "display", "inline" );
		$(".userTPL_visibility").css( "display", "inline" );
		$(".userTPL_email").css( "display", "inline" );
		$(".editProfileButton").css( "display", "inline" );

		//Hide these items.
		$(".userTPL_firstNameForm").css( "display", "none" );
		$(".userTPL_middleNameForm").css( "display", "none" );
		$(".userTPL_lastNameForm").css( "display", "none" );
		$(".userTPL_userNameForm").css( "display", "none" );
		$(".userTPL_visibilityForm").css( "display", "none" );
		$(".userTPL_emailForm").css( "display", "none" );
		$(".submitChangesButton").css( "display", "none" );
		$(".cancelChangesButton").css( "display", "none" );
		$(".passwordDiv").css( "display", "none" );
	}

	function transferValuesFromInputsToParagraphs() {
		//Transfer the values.
		$(".userTPL_firstName").text( $(".userTPL_firstNameForm").val() );
		$(".userTPL_middleName").text( $(".userTPL_middleNameForm").val() );
		$(".userTPL_lastName").text( $(".userTPL_lastNameForm").val() );
		$(".userTPL_userName").text( $(".userTPL_userNameForm").val() );
		$(".userTPL_visibility").text( $(".userTPL_visibilityForm").val() );
		$(".userTPL_email").text( $(".userTPL_emailForm").val() );
	}

	function removeErrorMessages() {
		//Remove error message, and hide the errorBox.
		$('#errorMessage').text("");
		$(".errorBox").css( "display", "none" );
	};

    /*
        General class of click handlers for buttons. When clicked
        re direct the page to whatever url mentioned in 'redirect-url'
        data attirbute
     */
    $('.actionRedirect').click(function () {
        window.location.assign($(this).data("redirect-url"));
    })

}

$(document).ready(main);
