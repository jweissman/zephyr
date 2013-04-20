class Zephyr.Models.World extends Backbone.Model
  initialize: =>
#    @players = []
    console.log "=== newly created world #{@get('id')}"
    console.log "--- about to subscribe to firehose..."
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'world', @get('id')
#    console.log "--- world #{@get('id')} is subscribed to firehose...!"
#    @bind "remove", =>
#      console.log "--- unsubscribed...!"
#      @unsubscribe()
#    console.log "--- okay, created a world!"
#    console.log "=== now to get maps and players! :)"
#    console.log "--- how best to do this?"
#    console.log @


    # maybe only do this when the world is entered by the client?
#    @players  = new Zephyr.Collections.Players({world: @})

  activate: =>
    console.log "--- world activated! should probably load players and map...."
    console.log "=== world #{@get('name')} about to load game map with id #{@get('game_map_id')}"

    @players  = new Zephyr.Collections.Players([],{world_id:@get('id')})
    @enemies  = new Zephyr.Collections.Enemies([],{world_id:@get('id')})
#    @events   = new Zephyr.Collections.Events([],{world_id:@get('id')})
#    console.log "--- players (in world#activate): "
#    console.log @players
    @game_map = new Zephyr.Models.GameMap
      id: @get('game_map_id')
      players: @players
      enemies: @enemies
#      events: @events #new Zephyr.Collections.Players([],{world_id:@get('id')})})


  deactivate: =>
    console.log "--- deactivating subscription to world resources..."
    @stream.stop()
    @players.stream.stop() #unsubscribe()
    @enemies.stream.stop()
    @game_map.stream.stop() #unsubscribe()

    console.log "--- done!"
