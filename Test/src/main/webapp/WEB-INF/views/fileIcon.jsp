<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-3.2.1.js"/>'></script>
<script type="text/javascript">
$(function() {
	var result = '${params.result}';
	var savefile = '${params.savefile}';
	var originfile = '${params.originfile}';
	if(result == "success"){
		$('#icon').html("<a href='download?savefile=\""+savefile+"\"&originfile=\""+originfile+"\"'><img src='resources/img/download.png'></a>");
	}
});
</script>
</head>
<body>
	<form action="uploadfile" method="post" enctype="multipart/form-data">
		<input type="file" name="upload">
		<input type="submit" value="전송">
	</form>
	<div id="icon" style="width: 300px; height: 300px; border: 1px solid black;"></div>
</body>
</html>