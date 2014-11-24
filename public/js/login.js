/**
 *  jQuery for validating login form on the client side.
 */

jQuery(document).ready(function(){
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
});