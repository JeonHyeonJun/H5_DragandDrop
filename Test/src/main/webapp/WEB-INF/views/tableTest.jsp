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
	var cnt = 1;
	$('#plus').on('click', function() {
		cnt++;
		var str = "<tr id='tr"+cnt+"'>";
		str += "<td>"+cnt+"번td입니당</td>";
		str += "<td>"+cnt+"번td입니당</td>";
		str += "<td>"+cnt+"번td입니당</td>";
		str += "<td><input type='button' value='삭제' onclick='del("+cnt+")'></td>"
		str += "</tr>";
		$('#tr'+(cnt-1)).after(str);
	});
	
});
	
function del(num) {
	$('#tr'+num).remove();
}
</script>
</head>
<body>
	<input type="button" value="+" id="plus">
	<table border="1">
		<tr id="tr1">
			<td>1번td입니당</td>
			<td>1번td입니당</td>
			<td>1번td입니당</td>
			<td><input type="button" value="삭제" onclick="del(1)"></td>
		</tr>
	</table>
</body>
</html>