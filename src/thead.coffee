{DOM, Component} = require 'react'
classNames = require 'classnames'
{thead, tr, th, span} = DOM


class THead extends Component

  onSortClick: (column) ->
    @props.changeSort column, !column.isDescending

  render: ->
    thead {},
      tr {},
        for column in @props.columns
          className = classNames(
            column.className ? "column-#{column.key}",
            {
              'sort-down':    column.sortCompare and column.isDescending
              'sort-up':      column.sortCompare and not column.isDescending
              'sort-primary': column.sortCompare and column is @props.columnSortOrder[0]
            }
          )
          sortArrow = if column.sortCompare
            if column.isDescending
              span className: 'glyphicon glyphicon-triangle-bottom', ariaHidden: true
            else
              span className: 'glyphicon glyphicon-triangle-top', ariaHidden: true
          else
            null
          th {
            key: column.key
            className: className
            onClick: @onSortClick.bind @, column
          }, column.text, sortArrow

        # Actions cell header
        th {}, 'Actions'


module.exports = THead
