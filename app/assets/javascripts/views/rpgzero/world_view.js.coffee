class Zephyr.Views.WorldView extends Backbone.View
  initialize: ->
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
    @players = []
    ontology.on 'join', (data) =>
      console.log "--- ONTOLOGY WORLD VIEW JOIN!!!"
      console.log data
      @world_map = data['map']
      @players   = data['players']

    ontology.on 'move', (data) =>
      @players

  dereferenceSprite: (code) ->
    switch code
      when 0 then @sprites['floor']
      else @sprites['steel']



  tilemap: (map, opts) ->
    # might make sense just to cache the map -- though hold off on this
    # first make it scrollable and cache large segments of it -- 256x256 or so i would think? (maybe bigger...)
    # for now it's fine :)
    for row, mapY in map
      for element, mapX in row
        x = (mapX+1) * @tileSize
        y = (mapY+1) * @tileSize
        sprite = @dereferenceSprite(element)
        sprite.draw(x,y)

  render: ->
#    console.log "--- drawing map: "
#    console.log @world_map
    @tilemap @world_map
    for player in @players
      pos = player['position']
      # interesting: different ideas of a point on the FE...
      @sprites['warrior'].draw(pos[0]*@tileSize,pos[1]*@tileSize)
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

