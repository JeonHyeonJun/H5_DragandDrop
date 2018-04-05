/**
 * 
 */
//html에선 todo-title 이지만 js에선 todoTitle로 써야 인식함   
angular.module('todo').directive('todoTitle', function() {
	return {
		template: '<h1>투두목록</h1>'		//todo-title에 template에 있는 값을 반환, html코드도 적용됨(딴거쓰면 안됨)
	}
});

angular.module('todo').directive('todoItem', function() {
	return {
		templateUrl: 'resources/angular/todoItem.tpl.html'
		/*template: '<input type="text" ng-model="todo.title">'
	        +'<input type="checkbox" ng-model="todo.completed">'
	        +'<input type="button" value="삭제" ng-click="remove(todo.id)">'
	        +'<p>{{todo.createdAt | date}}</p>'*/
	}
});

angular.module('todo').directive('todoFilters', function() {
	return {
		templateUrl: 'resources/angular/todoFilters.tpl.html'
	}
});

angular.module('todo').directive('todoForm', function() {
	return {
		templateUrl: 'resources/angular/todoForm.tpl.html'
	}
});