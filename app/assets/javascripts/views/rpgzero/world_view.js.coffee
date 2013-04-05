class Zephyr.Views.WorldView extends Backbone.View
  initialize: ->
#    @map_data = [
#      [0,0,0],
#      [0,0,1],
#      [0,0,0]
#    ]

    @sprites = {
      'steel': new Canvas.Image(Assets.getAsset('images/steel.png')) #@cacheImage(@tiles['steel'])
      'floor': new Canvas.Image(Assets.getAsset('images/floor.png')) #@cacheImage(@tiles['steel'])
    }

    @world_map = []
    @players = []
    ontology.on 'join', (data) =>
      console.log "--- ONTOLOGY WORLD VIEW JOIN!!!"
      console.log data
      @world_map = data['map']
      @players   = data['players']

  dereferenceSprite: (code) ->
    switch code
      when 0 then @sprites['steel']
      when 1 then @sprites['floor']

  tilemap: (map, opts) ->
    # might make sense just to cache the map -- though hold off on this
    # first make it scrollable and cache large segments of it -- 256x256 or so i would think? (maybe bigger...)
    # for now it's fine :)
    tileSize = 32
    for row, mapY in map
      for element, mapX in row
        x = (mapX+1) * tileSize
        y = (mapY+1) * tileSize
        sprite = @dereferenceSprite(element)
        sprite.draw(x,y)

  render: ->
#    console.log "--- drawing map: "
#    console.log @world_map
    @tilemap @world_map
#      [[0,1,1,0,1,1,0],
#              [1,1,1,0,1,1,0],
#              [1,1,0,1,1,0,0],
#              [1,0,0,0,0,1,1],
#              [1,1,1,1,1,1,0],
#              [0,1,1,0,1,1,0],
#              [0,1,1,1,0,1,1],
#              [1,1,0,1,1,0,0],
#              [0,0,0,1,1,1,1],
#              [1,1,1,1,1,1,0]])

