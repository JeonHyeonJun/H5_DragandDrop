angular.module('todo').controller('TodoCtrl', function($scope, todoStorage){
    
	$scope.todos = todoStorage.get();
	
	/*$scope.todos = [
      {
        title: "욕요갓요가술요가수련",
        completed : true,
        createdAt: Date.now(),
        id:0
      },
      {
        title: "benkyo",
        completed : false,
        createdAt: Date.now(),
        id:1
      },
      {
        title: "angular",
        completed : true,
        createdAt: Date.now(),
        id:2
      }
    ];
	*/
      $scope.remove = function (todo) {
    	/*  alert(todo);
  		//find todo index in todos
  		var idx = $scope.todos.findIndex(function (item) {
  			return item.id === todo;
  		});
  		//remove from todos
  		if(idx > -1) {
  			$scope.todos.splice(idx, 1);
  		}*/
		todoStorage.remove(todo);
	};
	
	$scope.add = function (newTodoTitle){
		//alert(newTodoTitle);
		
		//create new todo
		/*var newTodo = {
				title: newTodoTitle,
				completed: false,
				createdAt: Date.now(),
				id : $scope.todos.length
		};
		
		//push into todos
		$scope.todos.push(newTodo);*/
		
		todoStorage.add(newTodoTitle);
		//empty form
		$scope.newTodoTitle = "";
		
		
	};
	
	$scope.update = function() {
		todoStorage.update();
	};
});