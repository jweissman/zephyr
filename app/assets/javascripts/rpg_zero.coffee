## TODO rpg demo! (not a bad idea to consider how we might be able to leverage rot.js...)


class RPGZero extends atom.Game
  constructor: ->
    super

    # bind all the things
    atom.input.bind atom.button.LEFT,     'click'
    atom.input.bind atom.key.LEFT_ARROW,  'left'
    atom.input.bind atom.key.RIGHT_ARROW, 'right'
    atom.input.bind atom.key.UP_ARROW,    'up'
    atom.input.bind atom.key.DOWN_ARROW,  'down'



  draw:   -> WorldView.render()
  update: (dt) ->
    if atom.input.pressed 'left'
#      console.log "player started moving left"
      ontology.move('west')
    else if atom.input.down 'right'
      console.log "player still moving right"
      ontology.move('east')
    else if atom.input.down 'up'
      console.log "player moving up!"
      ontology.move 'north'
    else if atom.input.down 'down'
      console.log 'player moving down!'
      ontology.move 'south'
    else if atom.input.released 'click'
      console.log 'tap!'
      ontology.move('down')




    # respond to movement, clicks...
    # Players.update() ...?

#Zephyr.Game.Callbacks.bootstrap = ->
$(document).ready ->

  console.log "--- starting rpg zero!"
  window.ontology = new Ontology(ontology_host,9000,nickname)
  ontology.join()

  # REMEMBER TO ADD TO SPRITES
  Assets.queueDownload('floor.png')
  Assets.queueDownload('steel.png')
  Assets.queueDownload('warrior.png')

  window.Assets.downloadAll(->
    window.World      = Zephyr.Models.World
    window.WorldView  = new Zephyr.Views.WorldView()
    rpg_zero = new RPGZero()
    rpg_zero.run()
  )
