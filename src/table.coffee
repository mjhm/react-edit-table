{DOM, Component, createFactory} = require 'react'
_ = require 'lodash'
Column = require './column'
TBody = createFactory require './tbody'
THead = createFactory require './thead'
{table} = DOM


class Table extends Component

  constructor: ->
    super
    @state = {};
    @state.columns = @props.columns.map (column) -> new Column column
    @state.columnOrder = (@state.columns.filter (c) -> c.sortCompare?).sort (a, b) ->
      (a.sortRank ? 0) - (b.sortRank ? 0)


  changeSort: (column, isDescending) =>
    column.isDescending = isDescending
    @setState({columnOrder: [column].concat(@state.columnOrder.filter (c) -> c.key isnt column.key)})


  render: ->
    data = @props.data.slice(0);
    columnOrder = @state.columnOrder;

    data.sort (a, b) ->
      compareResult = 0
      columnOrder.some (col) ->
        compareResult = (col.sortCompare a[col.key], b[col.key]) * (if col.isDescending then 1 else -1)
      compareResult ? 0

    table {},
      THead { columns: @state.columns, columnSortOrder: @state.columnOrder, @changeSort }
      TBody {
        actions: @props.actions
        columns: @state.columns
        data: data
        newRow: @props.newRow
        onChange: @props.onChange
        onNew: @props.onNew
      }


module.exports = Table
