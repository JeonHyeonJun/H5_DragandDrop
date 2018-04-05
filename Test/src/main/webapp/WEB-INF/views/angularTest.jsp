<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='<c:url value="/resources/js/angular.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/angular/app.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/angular/directive.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/angular/controller.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/angular/service.js"/>'></script>
<link href="resources/css/agTest.css" rel="stylesheet">
</head>
<body> 
	<body ng-app="todo" ng-controller="TodoCtrl">
    <!-- <h1>투두목록</h1> -->
    <todo-title></todo-title>
    
    <todo-form></todo-form>
    	
    <pre>{{todoForm | json}}</pre>
    <!--  	todoForm 속성들:
    			$error
	    		$name
	    		$dirty		뭔가 입력하면 true, 아니면 false
	    		$pristine	dirty랑반대
	    		$valid		입력조건이 true이면 true(ex. 3글자이상이라는 조건이 있을때 3글자미만이면 false)
	    		$invalid	valid반대
	    		$submitted 
	-->
    
    <div id="container">
    	<ul>
	      <li ng-repeat="todo in todos | filter:statusFilter"><!-- filter:{completed: true} -->
	        <!-- <input type="text" ng-model="todo.title">
	        <input type="checkbox" ng-model="todo.completed">
	        <input type="button" value="삭제" ng-click="remove(todo.id)">
	        <p>{{todo.createdAt | date}}</p> -->
	        
	        <!-- 위에 있던 주석문을 js파일에서 처리함 -->
	        <todo-item></todo-item>
	      </li>
	    </ul>
	    
	    <!-- ng-click 그냥 클릭이벤트  -->
	    <!-- <button ng-click="statusFilter={completed: true}">Completed</button>
	    <button ng-click="statusFilter={completed: false}">Active</button>
	    <button ng-click="statusFilter={}">All</button> -->
	    
	    <!-- filter들을 다른html파일에서 불러옴. 내용은 위 주석과 동일 -->
    	<todo-filters></todo-filters>
    </div>
    
    <!--  -->
    <a href="agDragTest">앵귤러드래그</a>
  </body>
</body>
</html>