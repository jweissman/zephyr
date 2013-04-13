class Zephyr.Models.GameMap extends Backbone.RelationalModel
  initialize: (@attributes, options) =>

    console.log "=== initialize game map with id #{@get('id')}!"
    console.log "--- players (in game_map#new): "
#    @players = options.players
    console.log @get('players')
    #    console.log @
#   console.log "--- about to create players for world: #{@get('id')}"



    console.log "--- subscribing to game map via firehose!"
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'game_map', @get('id')

    # TODO connect to firehose!
#    @stream = new Firehose.Consumer
#      message: (data) =>
#        console.log
