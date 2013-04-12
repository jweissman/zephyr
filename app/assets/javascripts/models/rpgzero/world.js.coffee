class Zephyr.Models.World extends Backbone.Model # RelationalModel
  # a surprisingly verbose way to say "has n :players, has 1 :map"
  # unbelievably frustrated with backbone-relational .and firehose... fuck!
#  relations: [
#    {
#      type: Backbone.HasMany
#      key: 'players'
#      relatedModel: "Zephyr.Models.Player"
#      includeInJSON: Backbone.Model::idAttribute
#      collectionType: "Zephyr.Collections.Players"
#      reverseRelation:
#        key: 'playingIn'
#        includeInJSON: 'id'
#    }
#    {
#      type: Backbone.HasOne
#      key: 'game_map_id'
#      relatedModel: 'Zephyr.Models.GameMap'
#      includeInJSON: Backbone.Model::idAttribute
##      reverseRelation: {
##        key: 'world'
##        includeInJSON: 'id'
##      }
#    }
#  ]

  initialize: =>
#    @players = []
    console.log "=== newly created world #{@get('id')}"
    console.log "--- about to subscribe to firehose..."
    ObjectHelper.addRole(@, FirehoseConsumer)
    @subscribe 'world', @get('id')
#    console.log "--- world #{@get('id')} is subscribed to firehose...!"
#    @bind "remove", =>
#      console.log "--- unsubscribed...!"
#      @unsubscribe()
    console.log "--- okay, created a world!"
    console.log "=== now to get maps and players! :)"
    console.log "--- how best to do this?"
    console.log @


    # maybe only do this when the world is entered by the client?
#    @players  = new Zephyr.Collections.Players({world: @})
    console.log "=== about to load game map with id #{@get('game_map_id')}"
    @game_map = new Zephyr.Models.GameMap({id: @get('game_map_id')})

#   we want to get the model's map data and player ids
#    @map_data = GameMaps.get({id: @model.get('game_map_id')})

#    players = []
#    _.each @model.get("player_ids"), (player_id) =>
#      players.push Players.get({id: player_id})

    # well, we need to subscribe...
#    @players = new Zephyr.Collections.Players({collection: players, subscribe: false})

# firehose-powered backbone models :)
#Zephyr.Models.World.setup()
