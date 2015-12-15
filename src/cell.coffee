{Component, DOM, createFactory} = require 'react'
{td} = DOM
EditingCell = createFactory require './editing_cell'


class Cell extends Component

  constructor: ->
    super
    @state =
      editing: no
      editable: @props.column.editable ? yes


  onBlur: =>
    @setState editing: no
    @props.onChange @state.editingValue


  onDoubleClick: =>
    return unless @state.editable
    @setState
      editing: yes
      editingValue: @props.value


  onChange: (value) =>
    @setState
      editingValue: value


  render: ->
    if @state.editing
      EditingCell {
        @onBlur
        @onChange
        column: @props.column
        focusOnCreate: yes
        value: @state.editingValue
      }

    else

      td {
        @onDoubleClick
        style: whiteSpace: 'nowrap'
      }, "#{@props.value}"


module.exports = Cell
