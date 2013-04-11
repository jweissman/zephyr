class Zephyr.Models.World extends Backbone.Model
  # a surprisingly verbose way to say "has n :players, has 1 :map"
#  relations: [
#    {
#      type: Backbone.HasMany
#      key: 'players'
#      relatedModel: "Zephyr.Models.Player"
#      collectionType: "Zephyr.Collections.Players"
##      reverseRelation: {
##        key: 'world'
##        includeInJSON: 'id'
##      }
#    }
#    {
#      type: Backbone.HasOne
#      key: 'map'
#      relatedModel: 'Zephyr.Models.GameMap'
##      reverseRelation: {
##        key: 'world'
##        includeInJSON: 'id'
##      }
#    }
#  ]

  initialize: =>
    console.log "=== newly created world #{@get('id')}"
#    console.log "--- about to subscribe to firehose..."
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'world', @get('id')
    console.log "--- world #{@get('id')} is subscribed to firehose...!"
#    @bind "remove", =>
#      console.log "--- unsubscribed...!"
#      @unsubscribe()

# firehose-powered backbone models :)


#  update: =>
    # any local processing on each frame might be handled here...
    # (animation, etc.? no; offhand that seems like view stuff. any data-level stuff goes here.)

#
#    console.log "=== initialize world...!**********************"
#
#    # TODO create additional entities when 'activated'??
#
#    console.log "--- subscribe worldstream..."
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        console.log "--- updating world: #{data}"
#        @set(data)
#      uri: "//localhost:7474/worlds/#{@get('id')}.json"
#    console.log "--- built stream, about to connect (!!!!!)"
#    @stream.connect()

#    @on "change:players", (model) ->
#      console.log "--- changed players!!!!****************"

#  update: ->
#    console.log "--- world model updating..."
#    console.log "--- i should now get updates when the world changes...!"
#
#
#
#
#  update: ->
#    console.log "--- attempting to update world... (not sure what this would do, so no-op for now)"




