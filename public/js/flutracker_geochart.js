
//Here is the API Reference:
//  https://google-developers.appspot.com/chart/interactive/docs/gallery/geochart#full

google.load("visualization", "1", {packages:["geochart"]});
google.setOnLoadCallback(drawRegionsMap);

function drawRegionsMap() {

    var regionValues = [400, 200, 153, 300, 536, 612, 795, 1112, 900, 510];

    var data = google.visualization.arrayToDataTable(
        [
            ['State',   'Severity'],
            //Region 1 = Boston HHS = CT, ME, MA, NH, RI, VT
            ['US-CT', regionValues[0] ],
            ['US-ME', regionValues[0] ],
            ['US-MA', regionValues[0] ],
            ['US-NH', regionValues[0] ],
            ['US-RI', regionValues[0] ],
            ['US-VT', regionValues[0] ],
            //Region 2 = New York HHS = NJ, NY, PR, VI
            ['US-NJ', regionValues[1] ],
            ['US-NY', regionValues[1] ],
            ['US-PR', regionValues[1] ],
            ['US-VI', regionValues[1] ],
            //Region 3 = Philadelphia HHS = DE, DC, MD, PA, VA, WV
            ['US-DE', regionValues[2] ],
            ['US-DC', regionValues[2] ],
            ['US-MD', regionValues[2] ],
            ['US-PA', regionValues[2] ],
            ['US-VA', regionValues[2] ],
            ['US-WV', regionValues[2] ],
            //Region 4 = Atlanta HHS = AL, FL, GA, KY, MS, NC, SC, TN
            ['US-AL', regionValues[3] ],
            ['US-FL', regionValues[3] ],
            ['US-GA', regionValues[3] ],
            ['US-KY', regionValues[3] ],
            ['US-MS', regionValues[3] ],
            ['US-NC', regionValues[3] ],
            ['US-SC', regionValues[3] ],
            ['US-TN', regionValues[3] ],
            //Region 5 = Chicago HHS = IL, IN, MI, MN, OH, WI
            ['US-IL', regionValues[4] ],
            ['US-IN', regionValues[4] ],
            ['US-MI', regionValues[4] ],
            ['US-MN', regionValues[4] ],
            ['US-OH', regionValues[4] ],
            ['US-WI', regionValues[4] ],
            //Region 6 = Dallas HHS = AR, LA, NM, OK, TX
            ['US-AR', regionValues[5] ],
            ['US-LA', regionValues[5] ],
            ['US-NM', regionValues[5] ],
            ['US-OK', regionValues[5] ],
            ['US-TX', regionValues[5] ],
            //Region 7 = Kansas City HHS = IA, KS, MO, NE
            ['US-IA', regionValues[6] ],
            ['US-KS', regionValues[6] ],
            ['US-MO', regionValues[6] ],
            ['US-NE', regionValues[6] ],
            //Region 8 = Denver HHS = CO, MT, ND, SD, UT, WY
            ['US-CO', regionValues[7] ],
            ['US-MT', regionValues[7] ],
            ['US-ND', regionValues[7] ],
            ['US-SD', regionValues[7] ],
            ['US-UT', regionValues[7] ],
            ['US-WY', regionValues[7] ],
            //Region 9 = San Francisco HHS = AZ, CA, HI, NV, and some other island territories
            ['US-AZ', regionValues[8] ],
            ['US-CA', regionValues[8] ],
            ['US-HI', regionValues[8] ],
            ['US-NV', regionValues[8] ],
            //Region 10 = Seattle HHS = AK, ID, OR, WA
            ['US-AK', regionValues[9] ],
            ['US-ID', regionValues[9] ],
            ['US-OR', regionValues[9] ],
            ['US-WA', regionValues[9] ]
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