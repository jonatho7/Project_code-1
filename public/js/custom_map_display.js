/**
 * Created on 11/29/14.
 */
var json_response = null;

/*
    Get the latest Data published by CDC regarding the current ILI
    activity at state level.
 */
function populateStateData() {
    var data = {};

    // craft the URL
    var url = window.location.origin + '/flutracker/guest/api/getLatestActualData/CDC/stateActivity/';


    // Do a synchronous get request
    $.ajax(url, {
        success: function (response) {
            json_response = response;
            //console.log(json_response);
        },
        async: false,
        dataType: "json"
    });
    for (var i in json_response.state) {
        var state = json_response.state[i].abbrev;
        data[state] = {};
        data[state].fillKey = json_response.state[i].label;
        data[state].hoverData = json_response.state[i].label;
    }
    return data;
}

/*
    Construct the necessary state for displaying the geo graph.
 */
function display_map() {
    var activity_data = new Datamap({
        scope: 'usa',
        element: document.getElementById('map_severity'),
        geographyConfig: {
            popupTemplate: function(geography, data) {
                return '<div class="hoverinfo">' + geography.properties.name + '<br>'+
                'current state : ' +  data.hoverData;
            },
            highlightBorderWidth: 3
        },

        /*
            Colors for different activity levels
         */
        fills: {
            'Local Activity': '#CC6633',
            'Regional': '#FF0033',
            'Sporadic': '#FFFF00',
            'No Activity': '#347C2C',
            'No Report': '#660033',
            defaultFill: '#EDDC4E'
        },
        data: populateStateData()
    });
    activity_data.labels();
}

$(document).ready(function() {
    display_map();
});
