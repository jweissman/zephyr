class Zephyr.Views.StarsView extends Backbone.View
  render: ->
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height

    @collection.render()

  click: (mouse) =>
    @collection.create mouse.x, mouse.y
