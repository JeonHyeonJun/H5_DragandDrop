angular.module('todo').factory('todoStorage', function() {
	var TODO_DATA = "TODO_DATA";	//상수
	var storage = {
		// todo....
		todos : [],
		
		// _ 는 private을 뜻함
		//내부db에 저장하기위한 함수
		_saveToLocalStorage: function(data) {
			//localStrage는 javascript 함수임. 내장db불러오는함수.
			localStorage.setItem(TODO_DATA, JSON.stringify(data));
		},
		
		//내부db에서 불러오기위한 함수
		_getFromLocalStorage: function() {
			return JSON.parse(localStorage.getItem(TODO_DATA)) || [];
		},
		
		//item받아오기
		get : function() {
			//strage.todos = storage._getFromLocalStrage();
			angular.copy(storage._getFromLocalStorage(), storage.todos);	//위에꺼랑 같은거
			return storage.todos;
		},
		
		//삭제
		remove : function(todo) {
			alert(todo);
			
			var idx = storage.todos.findIndex(function (item) {
				return item.id === todo;
			});
			
			if(idx > -1) {
				storage.todos.splice(idx, 1);
				storage._saveToLocalStorage(storage.todos);
			}
		},
		
		//추가
		add : function(newTodoTitle) {
			var newTodo = {
				title: newTodoTitle,
				completed: false,
				createdAt: Date.now(),
				id : storage.todos.length
			};
			
			//push into todos
			storage.todos.push(newTodo);
			storage._saveToLocalStorage(storage.todos);	//넣은리스트를 내부db에 저장
		},
		
		update : function() {
			storage._saveToLocalStorage(storage.todos);
		}
	}

	return storage;
});