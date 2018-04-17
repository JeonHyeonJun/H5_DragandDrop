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

<script src="resources/table/js/test4.js"></script>
<link rel="stylesheet" href="resources/table/css/jquery.edittable.min.css">

<script type="text/javascript">
	$(function() {
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
	<h1>저장된 포트폴리오</h1>
	<form action="portUpdate" method="post" id="upForm">
		<input type="hidden" id="html" name="html">
		<input type="hidden" id="div_width" name="width">
  		<input type="hidden" id="div_height" name="height">
		<input type="button" id="update" value="수정">
	</form>
	<hr>
	<div id="see">${html }</div>	
</body>
</html>