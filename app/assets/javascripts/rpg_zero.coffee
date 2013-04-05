## TODO rpg demo! (not a bad idea to consider how we might be able to leverage rot.js...)


class RPGZero extends atom.Game
  constructor: ->
    super
    atom.input.bind atom.button.LEFT, 'click'

  draw:   -> WorldView.render()
  update: ->
    # ...


    # respond to movement, clicks...
    # Players.update() ...?

#Zephyr.Game.Callbacks.bootstrap = ->
$(document).ready ->
  console.log "--- starting rpg zero!"
  window.ontology = new Ontology("localhost",9000,nickname)
  ontology.join()

  Assets.queueDownload('floor.png')
  Assets.queueDownload('steel.png')
  window.Assets.downloadAll(->
    window.World      = Zephyr.Models.World
    window.WorldView  = new Zephyr.Views.WorldView()
    rpg_zero = new RPGZero()
    rpg_zero.run()
  )
