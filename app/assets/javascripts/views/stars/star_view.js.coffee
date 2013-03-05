class Zephyr.Views.StarView extends Backbone.View
  initialize: ->
  render: ->
    x = @model.get 'x'
    y = @model.get 'y'

    ctx = atom.context
    ctx.beginPath();
    ctx.arc(x, y, 3 + Math.random()*0.5, 0, 2 * Math.PI, false);
    ctx.fillStyle = 'white';
    ctx.fill();
    ctx.lineWidth = 0.25;
    ctx.strokeStyle = '#8F8F8F';
    ctx.stroke();

#    ctx.fillStyle = "white"
#    ctx.globalAlpha = 0.5
#    ctx.fillRect x, y, 5, 5
#    ctx.globalAlpha = 1
#    ctx.strokeStyle = "white"
#    ctx.lineWidth = 1
#    ctx.strokeRect x, y, 5, 5


