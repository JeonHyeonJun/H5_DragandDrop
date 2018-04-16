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