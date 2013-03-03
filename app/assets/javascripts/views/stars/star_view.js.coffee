class Zephyr.Views.StarView extends Backbone.View
  initialize: ->
  render: ->
    x = @model.get 'x'
    y = @model.get 'y'
    clr = @model.get 'color'

    ctx = atom.context
    ctx.fillStyle = "#FF9000"
    ctx.globalAlpha = 0.1
    ctx.fillRect x, y, 5, 5
    ctx.globalAlpha = 1
    ctx.strokeStyle = clr
    ctx.lineWidth = 1
    ctx.strokeRect x, y, 5, 5


