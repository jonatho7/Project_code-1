var main = function() {
		
	$(".changeValue").click(function() {
		//alert("You are no longer following this user.");
		
		//Access the chart.
		var chart = $('#container').highcharts();
		
		//Get the y value.
		var y = chart.series[0].data[1].y;
		
		//Change the y value.
		chart.series[0].data[1].update(y += 20);
		
		//Try changing the x axis.
		chart.xAxis[0].update({categories:['some','new','categories']}, true);
		chart.xAxis[0].setExtremes(4, 7, true, true);
	  });

};

$(document).ready(main);