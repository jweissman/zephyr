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
    layer = Math.floor(1+Math.random()*4)
    inverseY = mouse.y + lastScrollY/(2*layer) #((layer/2))
#    inverseX = layer * (atom.width - mouse.x)
#    inverseX = atom.width/2 - (mouse.x+2-(mouse.x/layer))

    Stars.addOne(mouse.x, inverseY, layer)

# and let go!
atom.height_multiplier = 2
universe = new Universe()
universe.run()
