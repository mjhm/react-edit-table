{Component, DOM, createFactory} = require 'react'
{form, button, tr, td} = DOM
EditingCell = createFactory require './editing_cell'
_ = require 'lodash'


class NewRow extends Component

  constructor: ->
    super
    @state = values: {}
    for column in @props.columns
      @state.values[column.key] = column.getInitialValue()


  getOnChangeCallbackForCell: (cellKey) -> (newValue) =>
    @setState values: _.assign {}, @state.values, "#{cellKey}": newValue


  onSave: =>
    @props.onNew? @state.values


  render: ->
    tr {},
      for column in @props.columns
        {key} = column
        if column.editableOnCreate
          EditingCell {
            column
            key
            focusOnCreate: no
            onChange: @getOnChangeCallbackForCell(key)
            onSubmit: @onSave
            value: @state.values[key]
          }
        else
          td {key}

      td {},
        button onClick: @onSave, 'Save'


module.exports = NewRow
