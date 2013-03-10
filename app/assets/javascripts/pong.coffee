window.Paddle       = Zephyr.Models.Paddle
window.PaddleView   = Zephyr.Views.PaddleView
window.Ball         = Zephyr.Models.Ball
window.BallView     = Zephyr.Views.BallView

window.PongView     = new Zephyr.Views.PongView()

class Pong extends atom.Game
  draw: -> PongView.render()
  update: (dt) ->
    Paddle.update({y:atom.input.mouse.y})
    Ball.move()

pong = new Pong()


#window.Star        = Zephyr.Models.Star
#window.StarView    = Zephyr.Views.StarView
#window.Stars       = new Zephyr.Collections.Stars()
#window.StarsView   = new Zephyr.Views.StarsView
#  collection: Stars
#
#class Universe extends atom.Game
#  constructor: ->
#    super
#    atom.input.bind atom.button.LEFT, 'click'
#
#  draw: -> StarsView.render()
#
#  update: (dt) ->
#    if atom.input.released 'click'
#      @click(atom.input.mouse)
#
#    Stars.update()
#
#  click: (mouse) ->
#    Stars.addOne(mouse.x, mouse.y)
#
## and let go!
#universe = new Universe()
#universe.run()
