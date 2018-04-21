<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="resources/css/wiget.css">

<!-- graph -->
<script src="resources/graph/js/ion.rangeSlider.js"></script>
<script src="resources/graph/js/colpick.js" type="text/javascript"></script>
<script src="resources/graph/dist/roundslider.min.js"></script>
<link rel="stylesheet" href="resources/graph/css/normalize.css" />
<link rel="stylesheet" href="resources/graph/css/ion.rangeSlider.css" />
<link rel="stylesheet" href="resources/graph/css/ion.rangeSlider.skinFlat.css" />
<link rel="stylesheet" href="resources/graph/css/colpick/colpick.css" type="text/css"/>
<link href="resources/graph/dist/roundslider.min.css" rel="stylesheet" />

<script src="resources/graph/js/jquery.barrating.min.js"></script>
<link href="http://fonts.googleapis.com/css?family=Lato:300,400" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Source+Code+Pro" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-1to10.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-movie.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-square.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-pill.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-reversed.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bars-horizontal.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/fontawesome-stars.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/css-stars.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/bootstrap-stars.css">
<link rel="stylesheet" href="resources/graph/dist/barrating/themes/fontawesome-stars-o.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">


<script type="text/javascript">
	$(function() {
		$('#see').html('${html}');
		
		
		var etc_graphNum = $('#etc_graphNum').val();
		var bar_graphNum = $('#bar_graphNum').val();
		
		for(var i=0; i<etc_graphNum; i++){
			var type = $('#stargraph'+i).attr("g_type");
			var g_value = $('#stargraph'+i).attr("g_value");
			if(type == 1){
				$('#stargraph'+i).barrating({
		    		theme: 'bars-horizontal',
		    		initialRating : g_value,
					readonly : true
		    	});
			}
			else if(type == 2){
				$('#stargraph'+i).barrating({
					theme: 'bars-movie',
					initialRating : g_value,
					readonly : true
		    	});
			}
			else if(type == 3){
				$('#stargraph'+i).barrating({
					theme: 'fontawesome-stars',
					initialRating : g_value,
					readonly : true
		    	});
			}
		}
		
		for(var i=0; i<bar_graphNum; i++){
			$("#bargraph"+i).ionRangeSlider({
				min : 0,
				max : 100,
				from : $("#bargraph"+i).attr("g_value"),
				from_min : $("#bargraph"+i).attr("g_value"),
				from_max : $("#bargraph"+i).attr("g_value"),
				hide_min_max : true
			/*          hide_from_to: true  최소값 최대값 보이기*/
			});
		}
		
		
		$('#update').on('click', function() {
			$('#html').val('${html}');
			$('#div_width').val('${width}');
			$('#div_height').val('${height}');
			$('#upForm').submit();
		});
		
	})
</script>
</head>
<body>
	<form action="portUpdate" method="post" id="upForm">
		<input type="hidden" id="html" name="html">
		<input type="hidden" id="div_width" name="width">
  		<input type="hidden" id="div_height" name="height">
		<input type="button" id="update" value="수정">
	</form>
	<div id="see"></div>	
</body>
<script src="resources/table/js/test4.js"></script>
<link rel="stylesheet" href="resources/table/css/jquery.edittable.min.css">

</html>