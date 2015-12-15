{DOM, Component} = require 'react'
{thead, tr, th} = DOM


class THead extends Component

  render: ->
    thead {},
      tr {},
        for column in @props.columns
          th key: column.key, column.text


module.exports = THead
