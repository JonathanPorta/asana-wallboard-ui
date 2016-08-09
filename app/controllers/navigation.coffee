angular.module('asana-wallboard').controller "Navigation", ($scope, $rootScope, $interval) ->
  console.log 'Controller::TaskList', arguments
  $scope.selected = 0
  $scope.endpoints = [
    {label: 'Actionable', value: 'todo'}
    {label: 'Unassigned', value: 'unassigned'}
    {label: 'Unplanned', value: 'unplanned'}
  ]

  $scope.onSelectTab = (index) ->
    console.log 'tab clicked!', index, arguments
    $scope.selected = index
    $rootScope.$state.go('app.navigation.tasks-list', {endpoint: $scope.endpoints[index].value})

  $scope.$watch $rootScope.$stateParams.autoAdvance, ->
    console.log '=================$rootScope.$stateParams.autoAdvance CHANGED!=======================================', arguments

  # Specify ?autoAdvance=1 to enable auto advancement between tabs.
  # Specify ?advanceRate=10000 to set the advance rate to 10 seconds.
  advanceRate = $rootScope.$stateParams.advanceRate || 10000
  $scope.timer = $interval =>
    return if !$rootScope.$stateParams.autoAdvance? || parseInt($rootScope.$stateParams.autoAdvance) != 1

    # find the next state, based on the order of the tabs, and then go there
    for i, endpoint of $scope.endpoints
      if endpoint.value == $rootScope.$stateParams.endpoint
        next = parseInt(i)+1
        if next == $scope.endpoints.length
          next = 0
        $scope.onSelectTab next
  , advanceRate
