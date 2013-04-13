# the collection of players in the current world... would be belongs_to :world :)
class Zephyr.Collections.Players extends Backbone.Collection
  # something!
  initialize: (models, options) =>
    # ignoring models for now...
    console.log "--- new players collection for world #{options.world_id}!"
#    if @world?
    console.log "--- [would be] initializing players collection for world #{options.world_id}..."
    world_players_uri = "world/#{options.world_id}/players"
    console.log "--- using world players uri: #{world_players_uri}"

    ObjectHelper.addRole @, FirehoseConsumer
    @subscribe world_players_uri

  # note: not sure exactly what this buys us as we are still just calling through to @stream.stop()
  deactivate: => @unsubscribe()
#    else
#      console.log "--- initializing players collection for un-worlded players (lobby i guess?)"
#      @subscribe 'players'
#    console.log "--- could subscribe to the model changes here... :)"
    # TODO sync with firehose
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        for player in data
#          console.log "--- adding player: #{player}"
#          @add(new Player(data))
#      uri: "//localhost:7474/players.json"

#  update: => @each.update()


