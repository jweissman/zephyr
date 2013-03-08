class Zephyr.Views.StarsView extends Backbone.View
  render: ->
    ctx = atom.context
    grd = ctx.createLinearGradient(0, 0, atom.width,atom.height)
    grd.addColorStop 0, "black"
    grd.addColorStop 0.46, 'black'
    grd.addColorStop 1, "darkblue"
    ctx.fillStyle = grd
    ctx.fillRect 0,0,atom.width,atom.height

    @collection.render()

  click: (mouse) =>
    @collection.create mouse.x, mouse.y
