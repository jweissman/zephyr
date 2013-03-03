class Zephyr.Views.StarView extends Backbone.View
  initialize: ->
  render: ->
    x = @model.get 'x'
    y = @model.get 'y'

    ctx = atom.context
    ctx.fillStyle = "white"
    ctx.globalAlpha = 0.5
    ctx.fillRect x, y, 5, 5
    ctx.globalAlpha = 1
    ctx.strokeStyle = "white"
    ctx.lineWidth = 1
    ctx.strokeRect x, y, 5, 5


