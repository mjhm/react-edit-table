{DOM, Component, createFactory} = require 'react'
{tr} = DOM
Cell = createFactory require './cell'


class Row extends Component

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


module.exports = Row
