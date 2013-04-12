class Zephyr.Models.Player extends Backbone.Model # RelationalModel
#  model_name: -> 'players'
#  relations: [
#    {
#      type: Backbone.HasMany,
#      key: 'world',
#      relatedModel: 'Zephyr.Models.World',
##      collectionType: 'Worlds',
#      reverseRelation: {
#        key: 'players',
#        includeInJSON: 'id'
#      }
#    }
#  ]

  initialize: =>
    console.log "===== NEW PLAYER CREATED!!!! subscribing"
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'player', @get('id')

#Zephyr.Models.Player.setup()

#    console.log "=================== creating player!!!"
#    @set(data)
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        console.log "--- player #{@get('id')} got data!************"
#        console.log data
#        @set(data)
#      uri: "//localhost:7474/player/#{@get('id')}.json"
#    @stream.connect()
#    @subscribe()

# get updates from the server
#    new Firehose.Client()
#      .uri "//players/#{@get('id')}.json"
#      .message((msg) -> @set(JSON.parse(msg)))
#      .connect()


  # really we'd only be moving the CURRENT player so this generality is speculative or at least weird
#  move: (direction) ->
#    # so we don't actually perform the move here, but just send a message to the server informing it of our intentions
#
#    ontology.move('direction')
    # ...
#  url: ->
#
