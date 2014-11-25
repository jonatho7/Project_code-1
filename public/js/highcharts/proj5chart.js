$(function () {
    
    $('#container').highcharts({
        chart: {
            renderTo: 'container',
            animation: false
        },
        
        title: {
            text: ''
        },
        
        yAxis: {
            title: {
                text: 'Flu Cases Reported'
            }
        },
        
        xAxis: {
            //categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
            title: {
                text: 'Week #'
            }
        },
    
        plotOptions: {
            series: {
                cursor: 'ns-resize',
                point: {
                    events: {
    
                        drag: function (e) {
                            // Returning false stops the drag and drops.
                            //(For an upper limit when dragging.) Example:
                            /*
                            if (e.newY > 300) {
                                this.y = 300;
                                return false;
                            }
                            */
                            $('#drag').html(
                                'Dragging <b>' + this.series.name + '</b>, <b>' + this.category + '</b> to <b>' + Highcharts.numberFormat(e.newY, 2) + '</b>');
                        },
                        drop: function () {
                            $('#drop').html(
                                'In <b>' + this.series.name + '</b>, <b>' + this.category + '</b> was set to <b>' + Highcharts.numberFormat(this.y, 2) + '</b>');
                        }
                    }
                },
                stickyTracking: false
            },
            column: {
                stacking: null
            }
        },
    
        tooltip: {
            yDecimals: 2
        },
    
        series: [{
            data: [0, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
            draggableY: true,
            dragMinY: 0,
            //minPointLength: 2
        }, {
            data: [0, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4].reverse(),
            draggableY: true,
            dragMinY: 0
        }
        ]
    });
});
