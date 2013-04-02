class Zephyr.Models.Paddle extends Backbone.Model
  defaults:
    paddle:
      x: 20
      y: 20
      w: 4
      h: 10
      vx: 0
      vy: 0

  trackY: (targetY) ->
    y = @get('y')
#    vy = @get('vy')
    vy = 0
    speed = 3
    distance = Math.abs(y-targetY)
    if distance < 3
      vy = 0
    else
      if targetY < y
        vy = -speed
      else
        vy = speed
      if distance > 10
        vy = vy * 2
      if distance > 50
        vy = vy * 3
      if distance > 100
        vy = vy * 4

#    if targetY - 2 > y
#      vy = 1
##      vy -= 1-(targetY-y)/100
#    else if targetY + 2 < y
#      vy = -1
#      vy += 1-(y-targetY)/100
#    @set('vy', vy)
    @set('y', y + vy)
