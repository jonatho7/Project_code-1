/**
 * Created on 12/1/14.
 */

/*
    Fetches the data from the server
 */
var jsonServerData = null;
var actualData = {};
var predictionData = {};
var maxActualDate = null;
function data_init() {
    /*
        craft the url
     */
    var url = window.location.origin + '/flutracker/loggedIn/api/getPredictionEntries';

    // get the current region that is active
    var query = { 'region': $("#currentRegion").data("current-region")};

    url += '?' + $.param(query);

    // Do a synchronous call to get the prediction and actual values to displaying the chart
    $.ajax(url, {
        success: function (response) {
            jsonServerData = response;
            //console.log(response);
        },
        async: false,
        dataType: "json"
    });
    actualData = jsonServerData['actual'];
    predictionData = jsonServerData['prediction']
}

/*
    Constructs points for Actual values
 */
function constructPoint(x,y) {
    var obj = {};
    obj.x = x;
    obj.y = y;
    return obj;
}

/*
    formats the actual values as expected by highcharts
    returns : array of objects
 */
function getActualValues() {
    var array = [];
    for(var key in actualData) {

        if (maxActualDate == null) {
            maxActualDate = key;
        } else {
            if (key > maxActualDate)
                maxActualDate = key;
        }

        var temp = key.split("-");
        array.push(constructPoint(Date.UTC(temp[0], temp[1] -1, temp[2]), +actualData[key]['value']));
    }
    return array;
}

/*
    splits the string passed into years, months, and date.
 */
function splitDateString(dateString) {
    var temp = dateString.split("-");
    temp[1] = temp[1] -1 ; //month
    return temp;
}

/*
    Constructs a prediction object
 */
function constructPredictionPoint(x, y, isExpired) {
    var obj = {};
    obj.x = x;
    obj.y = y;
    obj['expired'] = isExpired;
    return obj;
}

/*
    formats the prediction values as expected by highcharts.
 */
function getPredictionValues() {
    var array = [];
    var startPoint = splitDateString(maxActualDate);

    for(var key in predictionData) {
        var temp = key.split("-");
        array.push(constructPredictionPoint(Date.UTC(temp[0], temp[1] -1, temp[2]), +predictionData[key]['value'],
                    predictionData[key]['expired']));
    }

    //add to predicted data too.
    predictionData[maxActualDate] = {};
    predictionData[maxActualDate]['value'] = +actualData[maxActualDate]['value'];
    predictionData[maxActualDate]['expired'] = true;

    return array;
}

/*
    Draws the chart on the page.
 */

function chart_init() {

    var chart = new Highcharts.Chart({

        chart: {
            renderTo: 'plot-container',
            animation: false
        },

        title: {
            text: 'Predictions Graph View'
        },

        xAxis: {
            type: 'datetime',
            title: {
                text: 'Date'
            }
        },

        yAxis: {
            title: {
                text: 'ILI Count (weekly)'
            }
        },
        plotOptions: {
            series: {
                cursor: 'ns-resize',
                point: {
                    events: {

                        drag: function (e) {
                            var predX = Highcharts.dateFormat('%Y-%m-%d', e.newX);
                            if (predictionData[predX]['expired'] === true ) {
                                e.preventDefault();
                            }
                        },
                        drop: function () {

                            var date = Highcharts.dateFormat('%Y-%m-%d', this.x);

                            if (predictionData[date]['expired']) {
                                return;
                            }

                            var id = '#' + date;

                            /* Change the underlying element */
                            $(id).html(Math.ceil(this.y));
                            predictionData[date].newValue = Math.ceil(this.y);
                            $("#saveChangesPlot").fadeIn();
                        }
                    }
                },
                stickyTracking: false
            },
            column: {
                stacking: 'normal'
            }
        },

        tooltip: {
            yDecimals: 2
        },

        series: [
            {
                data: getActualValues(),
                draggableY: false,
                name: "Actual Data",
                type :'spline',
                color:'black'
            },
            {
                data: getPredictionValues(),
                draggableY: true,
                name: "Predicted Data",
                type :'spline',
                color:'red',
                dashStyle: 'dash'

            }
        ]

    });

}

/*
    This function post the data via AJAX to save the predictions made by the user
    via visualization.
 */
function savePredictionChanges() {
    console.log("I am here");
    var $url = window.location.origin + '/flutracker/loggedIn/api/storePredictionEntries';
    $.ajax({
        url: $url,
        type: 'post',
        data: {"data" : JSON.stringify(predictionData)},
        async: false,
        dataType: "json",
        success: function(response) {
            console.log(response);
            if (response.success == true) {
                // Successfully updated the data in backend.
                bootbox.alert("Successfully updated in the database");

                setInterval(function () {
                    var redirectUrl = window.location.origin + '/flutracker/dashboard.php';

                    var query = { 'region': $("#currentRegion").data("current-region")};
                    redirectUrl += '?' + $.param(query);
                    window.location.replace(redirectUrl);
                }, 1000);

            }
        }
    });

}

$(document).ready(function() {

    data_init();
    chart_init();

    $("#saveChangesPlot").on('click', 'button', savePredictionChanges);
});
