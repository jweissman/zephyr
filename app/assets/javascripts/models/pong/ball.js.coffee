class Zephyr.Models.Ball extends Backbone.Model
  defaults:
#    ball:
      x: 20
      y: 20
      vx: 0
      vy: 0
      radius: 5

  move: ->
    x = @get('x')
    y = @get('y')
    vx = @get('vx')
    vy = @get('vy')
    @set('x', x+vx)
    @set('y', y+vy)
