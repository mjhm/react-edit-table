{Component, DOM} = require 'react'
{findDOMNode} = require 'react-dom'
{td, input, select, option} = DOM


class EditingCell extends Component

  constructor: ->
    super
    @isSelect = @props.column.values?


  componentDidMount: ->
    return unless @props.focusOnCreate
    inputElement = findDOMNode @refs.editInput
    inputElement.focus()
    inputElement.select() unless @isSelect


  onBlur: =>
    @props.onBlur?()


  onChange: (e) =>
    {value} = e.target
    value = @selectIndexToValue(value) if @isSelect
    @props.onChange? value


  selectIndexToValue: (index) ->
    @props.column.values[index]


  selectValueToIndex: (value) ->
    for item, index in @props.column.values
      return "#{index}" if item is value
    return undefined


  render: ->
    if @isSelect
      td {},
        select {value: @selectValueToIndex(@props.value), ref: 'editInput', @onBlur, @onChange},
          for optionName, index in @props.column.values
            option value: index, key: index, "#{optionName}"

    else

      td {},
        input {
          @onBlur
          @onChange
          ref: 'editInput'
          value: @props.value
          style: width: '100%'
        }


module.exports = EditingCell
