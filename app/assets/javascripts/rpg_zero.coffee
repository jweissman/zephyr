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

    @tick = 0
    @player_moving = false

    # if much lower than this we get rough jitters (old moves backing up at server...) :(
    @player_cooldown = 2
    @last_player_move_tick = 0


  draw:   ->
    Canvas.clear()

    if GameState is GameStates.WorldSelection
      # render worlds selection
      WorldsView.render()
    else if GameState is GameStates.Playing
#      console.log "=== attempting to render current world view!!!!"
      CurrentWorldView.render()

  update: (dt) =>
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
      @tick = @tick + 1
#      console.log "=== tick #{@tick} (moving? #{@player_moving}, last move at t=#{@last_player_move_tick} [cooldown = #{@player_cooldown}])"

      if @player_moving && @last_player_move_tick + @player_cooldown < @tick
#        console.log "=== PLAYER WAITED OUT COOLDOWN*******"
        @player_moving = false

      map = CurrentWorld.game_map
      if map && !@player_moving
        moved = false
        direction = null
        if atom.input.down 'left'
          direction = 'west'
          moved = true
        else if atom.input.down 'right'
          direction = 'east'
          moved = true
        if atom.input.down 'up'
          direction = 'north'
          moved = true
        else if atom.input.down 'down'
          direction = 'south'
          moved = true

        player = map.current_player()
        if player && moved
          console.log "--- moving player: "
          console.log player
          if map.enemyPresent(direction)
            # don't change player local position -- server should interpret move as attack...
            console.log "=== #{player.get('name')} attacking enemy!"
            ontology.move(direction)
            @player_moving = true
            @last_player_move_tick = @tick
          else if map.passable(direction)
            console.log "=== moving player #{player.get('name')} #{direction} [assuming current player]"
            new_position = Zephyr.Models.GameMap.delta(player.get('x'),player.get('y'),direction)
            player.set({x: new_position[0], y: new_position[1]})
            ontology.move(direction)
            console.log "=== player moving? #{@player_moving}"
            @player_moving = true
            @last_player_move_tick = @tick
          else
            console.log "--- map isn't accessible in that direction!"

      # note: assuming we are current player...

#      else
#        console.log "--- current world didn't have a map?"
#        console.log CurrentWorld
#    else if atom.input.released 'click'
#      console.log 'tap!'
#      if passable(direction)
#        # TODO update player
#        ontology.move(direction)
#        player.set({x: })

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
