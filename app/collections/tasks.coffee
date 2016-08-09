Backbone = require 'backbone'

module.exports = class TasksCollection extends Backbone.Collection

  url: -> "/v1/tasks/#{ @endpoint }"
  model: require '../models/task.coffee'

  initialize: ([], options) ->
    console.log 'TasksCollection init', @
    @endpoint = options.endpoint
