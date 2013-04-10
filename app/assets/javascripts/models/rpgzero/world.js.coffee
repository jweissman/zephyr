class Zephyr.Models.World extends Backbone.RelationalModel

  relations: [
    {
      type: Backbone.HasMany,
      key: 'players',
      relatedModel: "Zephyr.Models.Player",
      collectionType: "Zephyr.Collections.Players",
      reverseRelation: {
        key: 'playingIn',
        includeInJSON: 'id'
      }
    }
#    {
#      type: Backbone.HasOne,
#      key: 'map',
#      relatedModel: 'Zephyr.Models.GameMap',
##      collectionType: 'Zephyr.C/'
#      reverseRelation: {
#        key: 'world',
#        includeInJSON: 'id'
#      }
#    }
  ]

  # TODO could have a relationship to a map
  #      a map is really going to be an element of a cartographic corpus... :)


  initialize: =>
    console.log "=== initialize world...!**********************"

    # TODO create additional entities when 'activated'

    console.log "--- subscribe worldstream..."
    @stream = new Firehose.Consumer
      message: (data) =>
        console.log "--- updating world: #{data}"
        @set(data)
      uri: "//localhost:7474/worlds/#{@get('id')}.json"
    console.log "--- built stream, about to connect (!!!!!)"
    @stream.connect()

#    @on "change:players", (model) ->
#      console.log "--- changed players!!!!****************"

  update: ->
    console.log "--- world model updating..."
    console.log "--- i should now get updates when the world changes...!"
#
#
#
#
#  update: ->
#    console.log "--- attempting to update world... (not sure what this would do, so no-op for now)"




