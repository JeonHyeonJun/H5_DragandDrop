<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="demo">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
    <script src="resources/js/angular.js"></script>
    <script src="resources/js/angular-drag-and-drop-lists.js"></script>
    <script src="resources/js/agapp.js"></script>
    <script src="resources/js/agsimple.js"></script>
    <link href="resources/css/agSimple.css" rel="stylesheet">
</head>
<body ng-controller="SimpleDemoController" class="simpleDemo">
	<!-- The dnd-list directive allows to drop elements into it.
     The dropped data will be added to the referenced list -->
     
	<ul dnd-list="list">
	    <!-- The dnd-draggable directive makes an element draggable and will
	         transfer the object that was assigned to it. If an element was
	         dragged away, you have to remove it from the original list
	         yourself using the dnd-moved attribute -->
	    <li ng-repeat="item in list"
	        dnd-draggable="item"
	        dnd-moved="list.splice($index, 1)"
	        dnd-effect-allowed="move"
	        dnd-selected="models.selected = item"
	        ng-class="{'selected': models.selected === item}">
	        <script>alert('{{item}}');</script>
	        {{item.label}}
	    </li>
	</ul>
</body>
</html>