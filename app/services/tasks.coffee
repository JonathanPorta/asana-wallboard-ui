_ = require 'underscore'

TasksCollection = require '../collections/tasks.coffee'

class TasksService

  constructor: ($q) ->
    console.log 'init tasks service!'
    @$q = $q
    @_collectionsByEndpointCache = {}

  get: (endpoint, options={}) ->

    options = _.defaults options,
      force: false

    console.log '@_collectionsByEndpointCache[endpoint]', @_collectionsByEndpointCache[endpoint]

    if !options.force && @_collectionsByEndpointCache[endpoint]?
      c = @_collectionsByEndpointCache[endpoint]
      console.log "Return a collection from cache for endpoint: #{ endpoint }", c
      return c

    d = @$q.defer()
    collection = new TasksCollection [], endpoint: endpoint
    collection.fetch
      success: =>
        @_collectionsByEndpointCache[endpoint] = collection
        d.resolve collection
      error: (error)=>
        d.reject "Unable to load tasks for endpoint #{ endpoint }: #{ error }"

    d.promise

angular.module('asana-wallboard').service 'TasksService', ($q)->
  new TasksService $q
