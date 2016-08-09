$ = require 'jquery'

TasksCollection = require '../collections/tasks.coffee'

class TasksService

  constructor: ($q) ->
    console.log 'init tasks service!'
    @$q = $q

  get: (endpoint) ->
    d = @$q.defer()
    collection = new TasksCollection [], endpoint: endpoint
    collection.fetch
      success: =>
        d.resolve collection
      error: (error)=>
        d.reject "Unable to load tasks for endpoint #{ endpoint }: #{ error }"

    d.promise

angular.module('asana-wallboard').service 'TasksService', ($q)->
  new TasksService $q
