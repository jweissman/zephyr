window.Star        = Zephyr.Models.Star
window.StarView    = Zephyr.Views.StarView
window.Stars       = new Zephyr.Collections.Stars()
window.StarsView   = new Zephyr.Views.StarsView
  collection: Stars

class Universe extends atom.Game
  constructor: ->
    super
    atom.input.bind atom.button.LEFT, 'click'

  draw: -> StarsView.render()

  update: (dt) ->
    if atom.input.released 'click'
      @click(atom.input.mouse)

    Stars.update()

  click: (mouse) ->
    Stars.addOne(mouse.x, mouse.y)

# and let go!
universe = new Universe()
universe.run()
