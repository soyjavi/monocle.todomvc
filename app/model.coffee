class __Model.Todo extends Monocle.Model
  @fields  "name", "done"

  @active: -> @select (todo) -> !todo.done

  @completed: -> @select (todo) -> !!todo.done

  @clearCompleted: -> todo.destroy() for todo in @completed()

  validate: ->
    unless @name
      "name is required"
