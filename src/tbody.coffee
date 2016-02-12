{DOM, Component, createFactory} = require 'react'
{tbody} = DOM
NewRow = createFactory require './new_row'
Row = createFactory require './row'
_ = require 'lodash'


class TBody extends Component

  getOnChangeCallbackForRow: (rowIndex) -> (columnName, newValue) =>
    @props.onChange? {
      index: rowIndex
      key: columnName
      row: _.assign {}, @props.data[rowIndex], "#{columnName}": newValue
      value: newValue
    }


  render: ->
    tbody {},
      if @props.newRow
        NewRow {
          columns: @props.columns
          onNew: @props.onNew
          key: @props.newRowKey
        }

      for rowData, rowIndex in @props.data
        Row {
          actions: @props.actions
          columns: @props.columns
          data: rowData
          key: rowIndex
          onChange: @getOnChangeCallbackForRow(rowIndex)
        }


module.exports = TBody
