app = angular.module 'asana-wallboard', ['ngMaterial', 'ui.router']

app.run ($rootScope, $state, $stateParams) ->
  $rootScope.$on "$stateChangeError", ->
    console.error 'Error Changing state', arguments

  console.log 'app.run ($rootScope, $state, $stateParams) ->'

  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams

app.config ($mdThemingProvider, $urlRouterProvider, $stateProvider) ->
  console.log 'app.config ($mdThemingProvider, $urlRouterProvider, $stateProvider) ->'
  # Add router here if we need one
  $urlRouterProvider.otherwise '/tasks/todo'

  $stateProvider.state 'app',
    abstract: true
    template: '<div ui-view></div>'

  $stateProvider.state 'app.navigation',
    url: '/tasks'
    controller: 'Navigation'
    templateProvider: ($templateCache) ->
      console.log 'templateProvider: ($templateCache) ->'
      $templateCache.get 'partials/navigation'

  $stateProvider.state 'app.navigation.tasks-list',
    url: '/:endpoint?autoAdvance&advanceRate'
    controller: 'TaskList'
    resolve:
      tasks: (TasksService, $stateParams) ->
        console.log 'tasks: (TasksService, $stateParams) ->'
        TasksService.get $stateParams.endpoint
    templateProvider: ($templateCache) ->
      console.log 'templateProvider: ($templateCache) ->'
      $templateCache.get 'partials/task-list'
