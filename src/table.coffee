{DOM, Component, createFactory} = require 'react'
THead = createFactory require './thead'
TBody = createFactory require './TBody'
{table} = DOM


class Table extends Component

  render: ->
    table {},
      THead columns: @props.columns
      TBody {
        columns: @props.columns
        data: @props.data
        newRow: @props.newRow
        onChange: @props.onChange
        onNew: @props.onNew
      }


module.exports = Table
