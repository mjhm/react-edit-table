{DOM, Component, createFactory} = require 'react'
{button, td, tr} = DOM
Cell = createFactory require './cell'


class Row extends Component

  getActionCallback: (action, row) -> ->
    action.onClick? {row}


  getOnChangeCallbackForCell: (columnName) -> (newValue) =>
    @props.onChange columnName, newValue


  render: ->
    tr {},
      for column in @props.columns
        {key} = column
        Cell {
          column
          key
          onChange: @getOnChangeCallbackForCell(key)
          value: @props.data[key]
        }

      # Actions cell
      td {},
        for action, actionIndex in @props.actions ? []
          button {
            key: actionIndex
            onClick: @getActionCallback(action, @props.data)
          }, action.text


module.exports = Row
