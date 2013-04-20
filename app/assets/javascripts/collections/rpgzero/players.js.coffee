# the collection of players in the current world... would be belongs_to :world :)
class Zephyr.Collections.Players extends Backbone.Collection
  # something!
  initialize: (models, options) =>

    # ignoring models for now...
    players_uri = null
    if options && options.world_id
      console.log "--- new players collection for world #{options.world_id}!"
      console.log "--- [would be] initializing players collection for world #{options.world_id}..."
      players_uri = "world/#{options.world_id}/players"
      console.log "--- using world players uri: #{players_uri}"
    else
      console.log "--- new 'lobby' players collection (players.json for players not connected to a world)"
      players_uri = "players"

    ObjectHelper.addRole @, FirehoseConsumer
    @subscribe players_uri

  # note: not sure exactly what this buys us as we are still just calling through to @stream.stop()
  deactivate: => @unsubscribe()
