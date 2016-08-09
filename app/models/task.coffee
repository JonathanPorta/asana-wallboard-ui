Backbone = require 'backbone'

module.exports = class TaskModel extends Backbone.Model

  initialize: (attributes, options) ->
    console.log 'task model', @
    @tags = []

    @on 'all', =>
      @tags = @get 'tags'
