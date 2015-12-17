{Component, DOM} = require 'react'
{findDOMNode} = require 'react-dom'
{form, input, option, select, td} = DOM
_ = require 'lodash'


class EditingCell extends Component

  componentDidMount: ->
    return unless @props.focusOnCreate
    inputElement = findDOMNode @refs.editInput
    inputElement.focus()
    inputElement.select() unless @props.column.isSelect()


  onBlur: =>
    @props.onBlur?()


  onChange: (e) =>
    {value} = e.target
    value = @selectIndexToValue(value) if @props.column.isSelect()
    value = @props.column.mapValue(value)
    @props.onChange? value


  onKeyDown: (e) =>
    if e.key is 'Escape'
      @props.onDiscard?()


  onSubmit: (e) =>
    e.preventDefault()
    @props.onSubmit?()


  selectIndexToValue: (index) ->
    @props.column.values[index]


  selectValueToIndex: (value) ->
    for item, index in @props.column.values
      return "#{index}" if item is value
    return undefined


  render: ->
    td {},
      form {@onSubmit},
        if @props.column.isSelect()
          select {
            @onBlur
            @onChange
            @onKeyDown
            ref: 'editInput'
            value: @selectValueToIndex(@props.value)
          },
            for optionName, index in @props.column.values
              option value: index, key: index, "#{optionName}"

        else

          input {
            @onBlur
            @onChange
            @onKeyDown
            ref: 'editInput'
            value: @props.value
            style: width: '100%'
          }


module.exports = EditingCell
