{DOM, Component, createFactory} = require 'react'
Column = require './column'
TBody = createFactory require './TBody'
THead = createFactory require './thead'
{table} = DOM


class Table extends Component

  render: ->
    table {},
      THead columns: @props.columns
      TBody {
        actions: @props.actions
        columns: @props.columns.map (column) -> new Column column
        data: @props.data
        newRow: @props.newRow
        onChange: @props.onChange
        onNew: @props.onNew
      }


module.exports = Table
