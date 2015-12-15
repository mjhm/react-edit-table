EventComponent = require './event_component'
{DOM} = require 'react'
{findDOMNode} = require 'react-dom'
{td, input, select, option} = DOM


class Cell extends EventComponent

  constructor: ->
    super
    @state =
      editing: no
      editable: @props.column.editable ? yes


  focusInput: =>
    inputElement = findDOMNode @refs.editInput
    inputElement.focus()
    inputElement.select() unless @isSelect()


  isSelect: ->
    @props.column.values?


  onBlur: =>
    @setState editing: no
    @props.onChange @state.editingValue


  onDoubleClick: =>
    return unless @state.editable
    @once 'componentDidUpdate', @focusInput
    @setState
      editing: yes
      editingValue: @props.value


  onChange: (e) =>
    {value} = e.target
    value = @_selectIndexToValue(value) if @isSelect()
    @setState editingValue: value


  _selectValueToIndex: (value) ->
    for item, index in @props.column.values
      return "#{index}" if item is value
    return undefined


  _selectIndexToValue: (index) ->
    @props.column.values[index]


  render: ->
    if not @state.editing
      return td {
        @onDoubleClick
        style: whiteSpace: 'nowrap'
      }, "#{@props.value}"

    if @isSelect()
      return td {},
        select {value: @_selectValueToIndex(@state.editingValue), ref: 'editInput', @onBlur, @onChange},
          for optionName, index in @props.column.values
            option value: index, key: index, "#{optionName}"


    td {},
      input {
        @onBlur
        @onChange
        ref: 'editInput'
        value: @state.editingValue
        style: width: '100%'
      }


module.exports = Cell
