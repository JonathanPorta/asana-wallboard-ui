angular.module('asana-wallboard').controller "Navigation", ($scope) ->
  console.log 'Controller::TaskList', arguments
  $scope.endpoints = [
    {label: 'Actionable', value: 'todo'}
    {label: 'Unassigned', value: 'unassigned'}
    {label: 'Unplanned', value: 'unplanned'}
  ]
