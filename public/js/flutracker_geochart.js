
//Here is the API Reference:
//  https://google-developers.appspot.com/chart/interactive/docs/gallery/geochart#full

google.load("visualization", "1", {packages:["geochart"]});
google.setOnLoadCallback(drawRegionsMap);

var regions_json= null;

function drawRegionsMap() {

    var regions;

    /*
        Make a synchronous ajax call to get all the regions and their corresponding latest data.
     */
    var url = window.location.origin + '/flutracker/guest/api/getLatestActualData/';
    $.ajax(url, {
                success: function (response) {
                    regions_json = response;
                    console.log(regions_json);
                },
            async: false,
            dataType: "json"
    });

    var data = google.visualization.arrayToDataTable(
        [
            ['State',   'Severity'],

            //Region 1 = Boston HHS = CT, ME, MA, NH, RI, VT
            ['US-CT', +regions_json['1'].value],
            ['US-ME', +regions_json['1'].value],
            ['US-MA', +regions_json['1'].value],
            ['US-NH', +regions_json['1'].value],
            ['US-RI', +regions_json['1'].value],
            ['US-VT', +regions_json['1'].value],

            //Region 2 = New York HHS = NJ, NY, PR, VI
            ['US-NJ', +regions_json['2'].value ],
            ['US-NY', +regions_json['2'].value],
            ['US-PR', +regions_json['2'].value ],
            ['US-VI', +regions_json['2'].value ],

            //Region 3 = Philadelphia HHS = DE, DC, MD, PA, VA, WV
            ['US-DE', +regions_json['3'].value ],
            ['US-DC', +regions_json['3'].value ],
            ['US-MD', +regions_json['3'].value ],
            ['US-PA', +regions_json['3'].value ],
            ['US-VA', +regions_json['3'].value ],
            ['US-WV', +regions_json['3'].value ],

            //Region 4 = Atlanta HHS = AL, FL, GA, KY, MS, NC, SC, TN

            ['US-AL', +regions_json['4'].value ],
            ['US-FL', +regions_json['4'].value ],
            ['US-GA', +regions_json['4'].value ],
            ['US-KY', +regions_json['4'].value ],
            ['US-MS', +regions_json['4'].value ],
            ['US-NC', +regions_json['4'].value ],
            ['US-SC', +regions_json['4'].value ],
            ['US-TN', +regions_json['4'].value ],

            //Region 5 = Chicago HHS = IL, IN, MI, MN, OH, WI
            ['US-IL', +regions_json['5'].value ],
            ['US-IN', +regions_json['5'].value ],
            ['US-MI', +regions_json['5'].value ],
            ['US-MN', +regions_json['5'].value ],
            ['US-OH', +regions_json['5'].value ],
            ['US-WI', +regions_json['5'].value ],

            //Region 6 = Dallas HHS = AR, LA, NM, OK, TX
            ['US-AR', +regions_json['6'].value ],
            ['US-LA', +regions_json['6'].value ],
            ['US-NM', +regions_json['6'].value ],
            ['US-OK', +regions_json['6'].value ],
            ['US-TX', +regions_json['6'].value ],

            //Region 7 = Kansas City HHS = IA, KS, MO, NE
            ['US-IA', regions_json['7'].value ],
            ['US-KS', regions_json['7'].value ],
            ['US-MO', regions_json['7'].value ],
            ['US-NE', regions_json['7'].value ],

            //Region 8 = Denver HHS = CO, MT, ND, SD, UT, WY
            ['US-CO', regions_json['8'].value ],
            ['US-MT', regions_json['8'].value ],
            ['US-ND', regions_json['8'].value ],
            ['US-SD', regions_json['8'].value ],
            ['US-UT', regions_json['8'].value ],
            ['US-WY', regions_json['8'].value ],

            //Region 9 = San Francisco HHS = AZ, CA, HI, NV, and some other island territories
            ['US-AZ', regions_json['9'].value ],
            ['US-CA', regions_json['9'].value ],
            ['US-HI', regions_json['9'].value ],
            ['US-NV', regions_json['9'].value ],

            //Region 10 = Seattle HHS = AK, ID, OR, WA
            ['US-AK', regions_json['10'].value ],
            ['US-ID', regions_json['10'].value ],
            ['US-OR', regions_json['10'].value ],
            ['US-WA', regions_json['10'].value ]
        ]
    );

    var options = {
        region: 'US',
        colorAxis: {colors: ['#fff0f0', '#ff7575']},
        backgroundColor: '#81d4fa',
        datalessRegionColor: '#f8bbd0',
        resolution: 'provinces'
    };

    var chart = new google.visualization.GeoChart(document.getElementById('geochart-colors'));
    chart.draw(data, options);
};