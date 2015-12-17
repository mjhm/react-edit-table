class Column

  constructor: (options) ->
    {
      @editable
      @editableOnCreate
      @key
      @mapValue
      @text
      @values
    } = options

    # Set defaults
    @editable ?= yes
    @editableOnCreate ?= @editable
    @mapValue ?= (v) -> v # (NO OP)
    @text ?= @key

    # Validate
    unless @key? then throw 'Column requires key'
    if typeof @mapValue isnt 'function' then throw 'mapValue must be a function'


  getInitialValue: ->
    if @isSelect()
      @values[0]
    else
      ''


  isSelect: ->
    # If values is provided then we render this column as a select
    @values?


module.exports = Column
