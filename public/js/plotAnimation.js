/**
 * Created on 12/1/14.
 */

/*
    Fetches the data from the server
 */
var jsonServerData = null;
var actualData = {};
var predictionData = {}
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


function constructPoint(x,y) {
    var obj = {};
    obj.x = x;
    obj.y = y;
    console.log(x,y);
    return obj;
}
/*
    formats the actual values as expected by highcharts
    returns : array of objects
 */
function getActualValues() {
    var array = [];
    for(var key in actualData) {
        console.log(key);
        var temp = key.split("-");
        array.push(constructPoint(Date.UTC(temp[0], temp[1] -1, temp[2]), +actualData[key]['value']));
    }
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
            type: 'datetime'
        },

        plotOptions: {
            series: {
                cursor: 'ns-resize',
                point: {
                    events: {

                        drag: function (e) {
                            $('#plot-drag').html(
                                'Dragging <b>' + this.series.name + '</b>, <b>' + this.category + '</b> to <b>' + Highcharts.numberFormat(e.newY, 2) + ' old Y=' + Highcharts.numberFormat(e.y, 2)+ '</b>');

                            /*
                            testPoint = e;
                            currentPoint = Highcharts.dateFormat('%Y-%m-%d', e.newX)
                            if (e.newX == 1410220800000) {
                                e.preventDefault();
                                //console.log(e.hover);
                                e.target.tooltipFormatter = function () { return new Date(e.newX) + "vivek bharath"; }
                            }*/
                        },
                        drop: function () {
                            $('#plot-drop').html(
                                'In <b>' + this.series.name + ' ' +'</b>, <b>' + this.category + '</b> was set to <b>' + Highcharts.numberFormat(this.y, 2) + '</b>');
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
            /*{
                data: [0, 71.5, 106.4, 129.2, 144.0],
                draggableY: true,
                name: "Actual Data",
                type :'spline',
                allowPointSelect: true,
                pointStart: Date.UTC(2014, 8, 2),
                pointInterval: 24 * 3600 * 1000 * 7 // one
            },*/
            /*{
                data:[
                    {x: Date.UTC(2014,10,1), y:10},
            {x: Date.UTC(2014,10,10), y:20},
        {x: Date.UTC(2014,10,17), y:30}
                ],
                type: 'spline',
                color:'black',
                draggableY: true
            },
            {
                data:[
                    [Date.UTC(2014,11,20), 30]
                ],
                type: 'spline',
                color:'black',
                draggableY:true
            }*/
        ]

    });

}

$(document).ready(function() {
    data_init();
    chart_init();
});
