// Generated by CoffeeScript 1.10.0
(function() {
  var Cell, Component, DOM, Row, createFactory, ref, tr,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  ref = require('react'), DOM = ref.DOM, Component = ref.Component, createFactory = ref.createFactory;

  tr = DOM.tr;

  Cell = createFactory(require('./cell'));

  Row = (function(superClass) {
    extend(Row, superClass);

    function Row() {
      return Row.__super__.constructor.apply(this, arguments);
    }

    Row.prototype.getOnChangeCallbackForCell = function(columnName) {
      return (function(_this) {
        return function(newValue) {
          return _this.props.onChange(columnName, newValue);
        };
      })(this);
    };

    Row.prototype.render = function() {
      var column, key;
      return tr({}, (function() {
        var i, len, ref1, results;
        ref1 = this.props.columns;
        results = [];
        for (i = 0, len = ref1.length; i < len; i++) {
          column = ref1[i];
          key = column.key;
          results.push(Cell({
            column: column,
            key: key,
            onChange: this.getOnChangeCallbackForCell(key),
            value: this.props.data[key]
          }));
        }
        return results;
      }).call(this));
    };

    return Row;

  })(Component);

  module.exports = Row;

}).call(this);