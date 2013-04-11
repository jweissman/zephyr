class Zephyr.Models.GameMap extends Backbone.Model
  initialize: =>
    console.log "--- initialize gamemap! (noop right now...)"
    # TODO connect to firehose!
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        console.log
