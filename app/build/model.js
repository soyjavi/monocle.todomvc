var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

__Model.Todo = (function(_super) {

  __extends(Todo, _super);

  function Todo() {
    return Todo.__super__.constructor.apply(this, arguments);
  }

  Todo.fields("name", "done");

  Todo.active = function() {
    return this.select(function(todo) {
      return !todo.done;
    });
  };

  Todo.completed = function() {
    return this.select(function(todo) {
      return !!todo.done;
    });
  };

  Todo.clearCompleted = function() {
    var todo, _i, _len, _ref, _results;
    _ref = this.completed();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      todo = _ref[_i];
      _results.push(todo.destroy());
    }
    return _results;
  };

  Todo.prototype.validate = function() {
    if (!this.name) {
      return "name is required";
    }
  };

  return Todo;

})(Monocle.Model);
