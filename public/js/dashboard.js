/**
 * Created on 11/30/14.
 *
 * Contains the functionality for dashboard.tpl view.
 */

/*
    Creates a input message
 */
function createInputTag(name, value) {
    var $input = $("<input>");
    $input.attr("name", name);
    $input.attr("value", value);
    return $input;
}

/*
    Makes a post request to delete the entry that user has selected and confirmed.
 */
function doFormAction($button) {

    var $form = $("<form></form>");
    var $input = createInputTag($button.attr("name"), $button.attr("value"));

    $form.attr("action", $button.data("url"));
    $form.attr("method", "post");
    $form.append($input);

    $form.submit();

}

/*
    Adds a confirmation box using "bootbox" plugin with custom message corresponding to the entry
    being deleted.
 */
function addConfirmationBox() {

    var predicationDate = $(this).closest('tr.predictionTable').find('.predictionDate').text();
    var predictionValue = $(this).closest('tr.predictionTable').find('.predictionValue').text();
    var predictionRegion = $(this).data("region");
    var $button = $(this);

    var message = "Do you really want to delete this prediction?" + "<br>" +
            "Date = " + predicationDate +"<br>Value = " + predictionValue +
            "<br>Region = " + predictionRegion;


     bootbox.confirm(message, function(result) {

        if (result == true) {
            /* User choose yes.
                Create a post request.
             */
            doFormAction($button);
        }

    });
}

/*
 Find all the buttons with class deletePrediction and add a
 confirmation prompt.
 */
function deletePredictionInit() {
    $(".deletePrediction").click(addConfirmationBox);
}

function init() {
    deletePredictionInit();
}




$(document).ready(function() {
    init();
});
