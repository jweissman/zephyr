class Zephyr.Collections.Worlds extends Backbone.Collection
  model: Zephyr.Models.World
  initialize: =>
    console.log "--- worlds about to subscribe to firehose..."
    # eek, bb-relational :(
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'worlds'

    console.log "=== worlds collection created, subscribed to firehose...!!!!"
