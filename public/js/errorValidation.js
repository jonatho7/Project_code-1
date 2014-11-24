/**
 *  This file contains the code for validating all the forms for the application.
 */

jQuery(document).ready(function(){
    /*
        This code validates the login form
     */
    $("#formValidate").validate({
        rules: {
            userName: {
                required: true
            },
            password: {
                required: true
            }
        },
        messages: {
            userName: {
                required: "Please enter user name"
            },
            password: {
                required: "Please provide a password"
            }
        }
    });

    /*
        This code validates the registration form
     */

    var passwordErrorString = " At least 6 digits long and must contain at least one capital letter,  one special " +
        " characters (! , _, $, @, #) and 1 digit [0-9]";
    $("#registrationForm").validate({
        rules: {
            firstName: {
                required: true
            },
            lastName: {
                required: true
            },
            userName: {
                required: true,
                minlength: 6
            },

            password: {
                required: true,
                minlength: 6,
                pattern: true
            },
            confirmPassword: {
                required: true,
                minlength: 6,
                equalTo: "#password"
            },
            emailAddress: {
                required:true
            },
            confirmEmailAddress: {
                equalTo:"#emailAddress"
            }
        },
        messages: {
            firstName: {
                required: "First Name is compulsory"
            },
            lastName: {
                required: "Last name is compulsory"
            },
            userName: {
                required: "Please enter user name",
                minlength: "User name must be at least 6 characters long"
            },
            password: {
                required: passwordErrorString,
                minlength: passwordErrorString,
                pattern: passwordErrorString
            },
            confirmPassword: {
                required: "Please enter the same password as above",
                minlength: "Please enter the same password as above",
                equalTo: "Please enter the same password as above"
            },
            emailAddress: {
                required:"Please enter a valid email address"
            },
            confirmEmailAddress: {
                equalTo:"Reenter the same email address again."
            }
        }
    });


    jQuery.validator.addMethod('pattern', function(value, element) {
        /* start of function */

        //Check if the password contains one capital Letter
        var re = /[A-Z]/;
        if (re.test(value) == false) {
            return false;
        }

        // Check for special character
        var re = /[!_$@#]+/;
        //For simplicty, we will use only small set of special characters.
        if (re.test(value) == false) {
            return false;
        }

        // Check for a digit
        var re = /[0-9]/;
        if (re.test(value) == false) {
            return false;
        }

        return true;
        /* End of the function */
    }, '');
});