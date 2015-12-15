{Component, DOM, createFactory} = require 'react'
{button, tr, td} = DOM
EditingCell = createFactory require './editing_cell'
_ = require 'lodash'


class NewRow extends Component

  constructor: ->
    super
    @state = values: {}
    for column in @props.columns
      if column.values
        @state.values[column.key] = column.values[0]
      else
        @state.values[column.key] = ''


  getOnChangeCallbackForCell: (cellKey) -> (newValue) =>
    @setState values: _.assign {}, @state.values, "#{cellKey}": newValue


  onSave: =>
    @props.onNew? @state.values


  render: ->
    tr {},
      for column in @props.columns
        {key} = column
        if column.editable ? yes
          EditingCell {
            column
            key
            focusOnCreate: no
            onChange: @getOnChangeCallbackForCell(key)
            value: @state.values[key]
          }
        else
          td {key},
            button onClick: @onSave, 'Create'


module.exports = NewRow
