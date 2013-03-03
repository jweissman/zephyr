class Zephyr.Views.StarsView extends Backbone.View
  initialize: ->
    @collection.on "all",    @render, this
    @collection.on "create", @render, this

  render: ->
    @collection.render()

  click: (mouse) =>
    @collection.create mouse.x, mouse.y
