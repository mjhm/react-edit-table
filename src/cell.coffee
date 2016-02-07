{Component, DOM, createFactory} = require 'react'
{td} = DOM
EditingCell = createFactory require './editing_cell'


class Cell extends Component

  constructor: ->
    super
    @state =
      editing: no
      editable: @props.column.editable


  discardChanges: =>
    @setState editing: no


  saveChanges: =>
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
        @onChange
        column: @props.column
        focusOnCreate: yes
        onBlur: @saveChanges
        onDiscard: @discardChanges
        onSubmit: @saveChanges
        value: @state.editingValue
      }

    else
      td {
        @onDoubleClick
        className: @props.column.className
      }, @props.column.cellComponent {value: "#{@props.value}"}


module.exports = Cell
