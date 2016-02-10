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


  editHandler: (event) =>
    return unless @state.editable
    event.stopPropagation()
    event.preventDefault()
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
        className: @props.column.className
        column: @props.column
        focusOnCreate: yes
        onBlur: @saveChanges
        onDiscard: @discardChanges
        onSubmit: @saveChanges
        value: @state.editingValue
      }

    else
      td {
        onDoubleClick: @editHandler
        className: @props.column.className
      }, @props.column.cellComponent {value: "#{@props.value}", @editHandler}


module.exports = Cell
