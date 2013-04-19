#class Zephyr.Collections.Events extends Backbone.Collection
#  initialize: (models, options) =>
#    if options && options.world_id
#      console.log "=== new events collection for world #{options.world_id}"
#      console.log "--- would be initializing events collection..."
#      ObjectHelper.addRole @, FirehoseConsumer
#
#      # no individual instance to subscribe to
#      @subscribe "world/#{options.world_id}/events"
#
##      @on 'add', (evt) =>
##        console.log "=== trigger event thing!"
##        @trigger('remoteEvent', evt)
##        console.log "=== GOT AN EVENT"
##        console.log evt
#
