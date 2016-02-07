{DOM, Component} = require 'react'
{thead, tr, th} = DOM


class THead extends Component

  render: ->
    thead {},
      tr {},
        for column in @props.columns
          th {
            key: column.key
            className: column.className ? "column-#{column.key}"
          }, column.text

        # Actions cell header
        th {}, 'Actions'


module.exports = THead
