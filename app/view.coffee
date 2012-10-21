class __View.Task extends Monocle.View
  container: "ul#todo-list"

  template: """
    <li class="{{#done}}completed{{/done}}">
        <div class="view">
            <input class="toggle" type="checkbox" {{#done}}checked{{/done}} />
            <label>{{name}}</label>
            <button class="destroy"></button>
        </div>
        <input class="edit" value="{{name}}" />
    </li>"""

  events:
    "dblclick .view"  : "onEdit"
    "click .destroy"  : "onDestroy"
    "click .toggle"   : "onToggle"
    "keypress .edit"  : "onChange"

  elements:
    "input.toggle"   : "toggle"
    "input.edit"     : "input"

  onEdit: -> @el.addClass "editing"

  onChange: (event) ->
    if event.keyCode is 13
      @el.removeClass "editing"
      @model.updateAttributes name: @input.val()
      @refresh()

  onToggle: ->
    done = if (@toggle.attr "checked") is "" then false else true
    @model.updateAttributes done: done
    @refresh()

  onDestroy: -> @remove()
