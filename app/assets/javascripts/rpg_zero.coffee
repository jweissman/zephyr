## TODO rpg demo! (not a bad idea to consider how we might be able to leverage rot.js...
#                  somewhat obviated now but still might be interesting for inspriation...)
class RPGZero extends atom.Game
  constructor: ->
    super
    console.log "=== FIRING UP RPGZERO"

    window.GameStates = new Backbone.Collection(
      [
        id: 1
        name: "WorldSelection"
      ,
        id: 2
        name: "Playing"
      ,
        id: 3
        name: "Paused"
      ],
      model: window.GameStates
    )

    GameStates.each (state) -> GameStates[state.get('name')] = state

    window.GameState = GameStates.WorldSelection
    console.log "--- current game state: #{GameState.get('name')}"


    # other global entities
    window.Player       = Zephyr.Models.Player
    window.PlayerView   = Zephyr.Views.PlayerView
    window.Players      = new Zephyr.Collections.Players()
#    window.PlayersView  = new Zephyr.Views.PlayersView({collection: new Zephyr.Collections.Players()})

    window.WorldView    = Zephyr.Views.WorldView
    window.World        = Zephyr.Models.World

    window.Worlds       = new Zephyr.Collections.Worlds()

#    window.Worlds       = new Zephyr.Collections.Worlds()
    window.WorldsView   = new Zephyr.Views.WorldsView({collection: Worlds})

    # can hook into global behavior if need be...
#    Worlds.on 'add', (world) ->
#      console.log "=== ADDED WORLD #{world.get('id')}!!!"

    # bind all the things
    atom.input.bind atom.button.LEFT,     'click'
    atom.input.bind atom.key.LEFT_ARROW,  'left'
    atom.input.bind atom.key.RIGHT_ARROW, 'right'
    atom.input.bind atom.key.UP_ARROW,    'up'
    atom.input.bind atom.key.DOWN_ARROW,  'down'
    console.log "--- done rpgzero init!!!"

  draw:   ->
    Canvas.clear()

    if GameState is GameStates.WorldSelection
      # render worlds selection
      WorldsView.render()
    else if GameState is GameStates.Playing
#      console.log "=== attempting to render current world view!!!!"
      CurrentWorldView.render()

  update: (dt) ->
#    console.log "--- update"
#    console.log "current game state: #{window.GameState.get('name')}"

    if atom.input.released 'click'
      if window.GameState is window.GameStates.WorldSelection
        clicked_label = WorldsView.clickedLabel(atom.input.mouse)
        clicked_world = WorldsView.clickedWorld(atom.input.mouse)
        if world = clicked_world
          console.log "--- joining world #{world.get('name')}!"
          ontology.join world.get('id')
          # connect and get players/map
          world.activate()
          window.CurrentWorld     = world
          window.CurrentWorldView = new WorldView({model:world},{players: world.players})
          window.GameState        = window.GameStates.Playing
        else if label = clicked_label
          if label == 'create'
            ontology.create prompt('what shall the name of the new realm be?')
      else if window.GameState is window.GameStates.Playing
        clicked_label_name = window.CurrentWorldView.clicked(atom.input.mouse)
        if label = clicked_label_name
          if label == 'exit'
            window.CurrentWorld.deactivate()
            ontology.leave()

#            window.CurrentWorld = null
            window.GameState = window.GameStates.WorldSelection

#     WorldsView.

    if GameState is GameStates.Playing
      if atom.input.down 'left'
        ontology.move('west')
      else if atom.input.down 'right'
        ontology.move('east')
      if atom.input.down 'up'
        ontology.move 'north'
      else if atom.input.down 'down'
        ontology.move 'south'
#    else if atom.input.released 'click'
#      console.log 'tap!'

$(document).ready ->
  console.log "=== preloading images and sounds"
  window.Assets.downloadAll(->
    console.log "--- images loaded"
    atom.preloadSounds({sword: 'sword.wav', miss: 'miss.wav'},  ->
      console.log "--- sounds loaded"
      rpg_zero = new RPGZero()
      rpg_zero.run()
    )
  )
