class Zephyr.Models.GameMap extends Backbone.RelationalModel
  initialize: =>
    console.log "=== initialize game map with id #{@get('id')}!"
#    console.log @

    console.log "--- subscribing to game map via firehose!"
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'game_map', @get('id')

    # TODO connect to firehose!
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        console.log
