class Zephyr.Models.GameMap extends Backbone.Model
  initialize: => #(@attributes, options) =>

    console.log "=== initialize game map with id #{@get('id')}!"
    console.log "--- players (in game_map#new): "
#    @players = options.players
    console.log @get('players')
    #    console.log @
#   console.log "--- about to create players for world: #{@get('id')}"



    console.log "--- subscribing to game map via firehose!"
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'game_map', @get('id')

    # TODO connect to firehose!
  current_player: =>
#    console.log "--- using #{window.player_id} to dereference current player in collection:"
    players = @get('players')
#    console.log players
    player = players.get(window.player_id)
#    console.log "=== got pla"
#    console.log "--- current player: "
#    console.log player
    return player
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        console.log
#  move: (direction) =>

  @delta: (x,y, direction) =>
    x -= 1 if direction == 'west'
    x += 1 if direction == 'east'
    y -= 1 if direction == 'north'
    y += 1 if direction == 'south'
    [x,y]

  passable: (direction) =>
    # use current player...
    player = @current_player()
    new_position = GameMap.delta(player.get('x'), player.get('y'), direction)

    # TODO check if there's a player or enemy there
    player_pos_conflict = false
    @get('players').each (p) =>
      player_pos_conflict = true if p.get('x') == new_position[0] && p.get('y') == new_position[1] && p.get('id') != player.get('id')

    player_pos_conflict || @get('rows')[new_position[1]][new_position[0]] == 0

  enemyPresent: (direction) =>
    player = @current_player()
    new_position = GameMap.delta(player.get('x'), player.get('y'), direction)

    # TODO check if there's a player or enemy there
    enemy_present = false
    @get('enemies').each (e) =>
      enemy_present = true if e.get('x') == new_position[0] && e.get('y') == new_position[1] # && p.get('id') != player.get('id')

    enemy_present
#    @get('rows')[new_position[1]][new_position[0]] == 0



#    if direction=='north'
#
#    else if direction == 'south'
#    else if direction == 'east'
#    else if direction == 'west'
#    else
#      throw "unknown direction: #{direction}"
