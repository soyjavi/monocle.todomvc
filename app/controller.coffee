class TodoCtrl extends Monocle.Controller
  events:
    "keypress #new-todo"      : "onCreate"
    "click #clear-completed"  : "onClearCompleted"
    "click #filters li a"     : "onFilter"

  elements:
    "#new-todo"               : "input"
    "#todo-count strong"      : "pending"
    "#clear-completed strong" : "completed"
    "#clear-completed"        : "clear"
    "ul#todo-list"            : "items"
    "#filters li a"           : "filters"

  constructor: ->
    super
    __Model.Todo.bind "create", @bindCreate
    __Model.Todo.bind "change", @bindChange
    __Model.Todo.bind "error", @bindError
    @bindChange()

  bindError: (todo, error) -> alert error

  bindCreate: (todo) => @appendTodo todo

  bindChange: (todo) =>
    @pending.text __Model.Todo.active().length
    @completed.text __Model.Todo.completed().length
    if __Model.Todo.completed().length > 0 then @clear.show() else @clear.hide()

  onCreate: (event) ->
    if event.keyCode is 13
      __Model.Todo.create name: @input.val()
      @input.val ""

  onClearCompleted: (event) ->
      __Model.Todo.clearCompleted()
      @filterTodos()

  onFilter: (event) ->
    @filters.removeClass "selected"
    filter = Monocle.Dom(event.currentTarget).addClass "selected"
    @filterTodos filter.html().toLowerCase()

  filterTodos: (filter = "all") ->
    @items.html " "
    @appendTodo todo for todo in __Model.Todo[filter]()

  appendTodo: (todo) ->
    view = new __View.Task model: todo
    view.append todo

__Controller.Todos = new TodoCtrl('section#todoapp')
