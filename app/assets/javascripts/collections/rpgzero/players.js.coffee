class Zephyr.Collections.Players extends Backbone.Collection
  # something!
  initialize: =>
    console.log "--- new players collection!"
    ObjectHelper.addRole @, FirehoseConsumer
    if @world?
      console.log "--- initializing players collection for world #{@world.get('name')}..."
      @subscribe "world/#{@world.get('id')}/players"
    else
      console.log "--- initializing players collection for un-worlded players (lobby)"
      @subscribe 'players'
#    console.log "--- could subscribe to the model changes here... :)"
    # TODO sync with firehose
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        for player in data
#          console.log "--- adding player: #{player}"
#          @add(new Player(data))
#      uri: "//localhost:7474/players.json"

#  update: => @each.update()


