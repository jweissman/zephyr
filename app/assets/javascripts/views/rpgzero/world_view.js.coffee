class Zephyr.Views.WorldView extends Backbone.View
  initialize: =>
#    @map_data = [
#      [0,0,0],
#      [0,0,1],
#      [0,0,0]
#    ]
    @world = new World()

    @tileSize = 32

    # REMEMBER TO ADD THIS TO MANIFEST
    @sprites = {
      'steel':   new Canvas.Image(Assets.getAsset('steel.png'))
      'floor':   new Canvas.Image(Assets.getAsset('floor.png'))
      'warrior': new Canvas.Image(Assets.getAsset('warrior.png'))
    }

    @world_map = []
    @collection = new Zephyr.Collections.Players() # really should be passing this in...

    # really should connect to ontology on this side (as opposed to the page.) i'm probably repeating myself though.
    ontology.on 'snapshot', (data) =>
      # this really could just be #set on the models in question... :)

      @world_map = data['map']
      @players   = data['players']
#      console.log "=== got players: #{@players}"

#    ontology.on 'move', (data) =>
#      @players

#    @firehose = new Firehose.Consumer({
#      uri: "/players"
#      message: (json) ->
#        @collection.add(json)
#    })

#
#  decodeMap: (data) ->
#    real_map = []
#    for row, y in data
#      real_map[y].push(1)
#      for element, x in data
##        real_map[y].push
#        real_map[y].push(mapCell(element))
#        # cell
#      real_map[y].push(1)
#      # row separator
#  mapCell: (el) ->

  dereferenceSprite: (code) ->
    switch code
      when 0 then @sprites['steel']
      else @sprites['floor']



  tilemap: (map, opts) ->
    # might make sense just to cache the map -- though hold off on this
    # first make it scrollable and cache large segments of it -- 256x256 or so i would think? (maybe bigger...)
    # for now it's fine :)
    sx = 0
    sy = 0
    for row, mapY in map
      for element, mapX in row
        x = (mapX+1) * @tileSize
        y = (mapY+1) * @tileSize
        sprite = @dereferenceSprite(element)
        sprite.draw(x+sx,y+sy)

  render: =>
#    console.log "--- drawing map: "
    if @world_map && @players
#      console.log @world_map
      @tilemap  @world_map
      for player in @players
        pos = player['position']
        # interesting: different ideas of a point on the FE (not anymore... :))
        @sprites['warrior'].draw(pos[0]*@tileSize,pos[1]*@tileSize)
