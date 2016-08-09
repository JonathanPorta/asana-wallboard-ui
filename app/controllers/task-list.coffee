angular.module('asana-wallboard').controller "TaskList", ($scope, tasks) ->
  console.log 'Controller::TaskList', arguments
  $scope.tasks = tasks.models
