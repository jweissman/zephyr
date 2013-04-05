## TODO rpg demo! (not a bad idea to consider how we might be able to leverage rot.js...)


class RPGZero extends atom.Game
  constructor: ->
    super
    atom.input.bind atom.button.LEFT, 'click'

  draw: ->
    console.log '--- draw!'
    WorldView.render()

  update: ->
    # respond to movement, clicks...
    # Players.update() ...?



#Assets.queueDownload('img/alien-explosion.png');
#Assets.queueDownload('img/alien.png');
#Assets.queueDownload('img/bullet.png');
#Assets.queueDownload('img/earth.png');
#Assets.queueDownload('img/sentry.png');
#Assets.queueDownload('img/explosion.png');
Zephyr.Game.Callbacks.bootstrap = ->
  console.log "--- rpg zero bootstrap!"
#  console.log window.Assets
  Assets.queueDownload('floor.png')
  Assets.queueDownload('steel.png')

  # ...

  #Assets.queueSound('alien-boom', 'audio/alien_boom.mp3');
  #Assets.queueSound('bullet-boom', 'audio/bullet_boom.mp3');
  #Assets.queueSound('bullet', 'audio/bullet.mp3');

  console.log "=== downloads queue'd!"
  window.Assets.downloadAll(->
    window.World      = Zephyr.Models.World
    window.WorldView  = new Zephyr.Views.WorldView()


    console.log "=== RPG ZERO LAUNCHING"
    rpg_zero = new RPGZero()
    rpg_zero.run()
  )

#
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
#    layer = Math.floor(1+Math.random()*4)
#    #    inverseY = mouse.y + lastScrollY/(2*layer) #((layer/2))
#    #    inverseX = layer * (atom.width - mouse.x)
#    #    inverseX = atom.width/2 - (mouse.x+2-(mouse.x/layer))
#
#    inverseY = StarView.absoluteToRelativeY(mouse.y, layer)
#    Stars.addOne(mouse.x, inverseY, layer)
#
## and let go!
#atom.height_multiplier = 2
#universe = new Universe()
#universe.run()
