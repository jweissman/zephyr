class Zephyr.Collections.Worlds extends Backbone.Collection

  model: Zephyr.Models.World

  initialize: =>
    @stream = new Firehose.Consumer
      message: (data) =>
        console.log "=== worlds update from firehose!"
        console.log data
        @set(data)
      uri: "//localhost:7474/worlds.json"
    @stream.connect()

#  update: =>
#    console.log "--- update worlds...?"
