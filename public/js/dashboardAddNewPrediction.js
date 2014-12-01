/**
 * Javascript for dashboardAddNewPrediction.tpl file
 */


var userNextPredictionDates = null;

/*
    This function gets the prediction dates for all the regions.
 */
function init() {

    // craft a url
    var $url = window.location.origin + '/flutracker/loggedIn/api/getNextPredictionDate/';

    // Do a synchronous get request
    $.ajax($url, {
        success: function (response) {
            userNextPredictionDates = response;
            console.log(userNextPredictionDates);
        },
        async: false,
        dataType: "json"
    });

    /*
        Initially, associate a prediction date with the default region
    */
    var $region = $("#regionSelected").val();
    var $predDate = userNextPredictionDates[$region];
    $('#predDate').val($predDate);

    /*
        Associate a change event to "select" box so that whenever a region is changed,
        the appropriate starting prediction date is also changed.
     */
    $("#regionSelected").on('change', function() {
        var $region = $("#regionSelected").val();
        var $predDate = userNextPredictionDates[$region];
        $('#predDate').val($predDate);
    });
}



$(document).ready(function() {
    init();
});


