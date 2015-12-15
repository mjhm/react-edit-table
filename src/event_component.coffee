{Component} = require 'react'
{EventEmitter} = require 'events'


class EventComponent extends Component

  constructor: ->
    super
    @_eventEmitter = new EventEmitter


  componentDidUpdate: ->
    @_eventEmitter.emit 'componentDidUpdate'


  emit: (event, args...) ->
    @_eventEmitter.emit event, args...


  on: (event, callback) ->
    @_eventEmitter.on event, callback


  once: (event, callback) ->
    @_eventEmitter.once event, callback


module.exports = EventComponent
