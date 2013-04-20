# TODO rewrite using ontology/firehose :)
#
# cool things we could do:
#     - the basic unified 'movement' behavior i was initially wondering about with this
#       (rotating stars, or being pulled into a 'vortex', or even 'warped' by the movement
#        of the mouse, etc.)
#
# interesting reasons to do it:
#     - we could start building some of the client-side physics simulation that
#       we would need for more 'twitchy' games to feel responsive; as well as the
#       logic for 'smoothly' integrating updates
#
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
    inverseY = StarView.absoluteToRelativeY(mouse.y, layer)
    Stars.addOne(mouse.x, inverseY, layer)

$(document).ready ->
  console.log "=== universe booting up!"
  window.Star        = Zephyr.Models.Star
  window.StarView    = Zephyr.Views.StarView
  window.Stars       = new Zephyr.Collections.Stars()
  window.StarsView   = new Zephyr.Views.StarsView
    collection: Stars

  # and let go!

  atom.height_multiplier = 2
  universe = new Universe()
  universe.run()
