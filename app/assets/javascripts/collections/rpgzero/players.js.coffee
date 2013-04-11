class Zephyr.Collections.Players extends Backbone.Collection
  # something!
  initialize: ->
    console.log "--- initializing backbone players..."
    ObjectHelper.addRole @, FirehoseConsumer
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


