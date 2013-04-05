class Zephyr.Views.WorldView extends Backbone.View
  initialize: ->
    console.log "--- world view created...!"
    @map_data = [
      [0,0,0],
      [0,0,1],
      [0,0,0]
    ]


#    @tiles = {
#      'steel':Assets.getAsset('images/steel.png')
#    }

    # a cached copy of the image
    @sprites = {
      'steel': new Canvas.Image(Assets.getAsset('images/steel.png')) #@cacheImage(@tiles['steel'])
      'floor': new Canvas.Image(Assets.getAsset('images/floor.png')) #@cacheImage(@tiles['steel'])

    }

    console.log "--- steel sprite: #{@sprites['steel']}"

#    console.log "--- creating sprite...!"
#    @sprite = @cacheImage(@tiles['steel'])
#    console.log "=== created sprite:"
#    console.log @sprite

    @x = 10
    @y = 20



#  cacheImage: (image) ->
#    console.log "--- attempting to cache image:"
#    console.log(image)
#    offscreenCanvas = document.createElement("canvas")
#    size = Math.max(image.width, image.height)
#    offscreenCanvas.width = size
#    offscreenCanvas.height = size
#    offscreenCtx = offscreenCanvas.getContext("2d")
#    offscreenCtx.save()
#    offscreenCtx.translate size / 2, size / 2
##    offscreenCtx.rotate angle + Math.PI / 2
#    offscreenCtx.translate 0, 0
#    offscreenCtx.drawImage image, -(image.width / 2), -(image.height / 2)
#    offscreenCtx.restore()
#    return offscreenCanvas

  dereferenceSprite: (code) ->
    if code == 1
      @sprites['steel']
    else
      @sprites['floor']
#    switch code
#      when 0 then @sprites['steel']
#      when 1 then @sprites['floor']

  tilemap: (map, opts) ->
    tileSize = 32
    for row, mapY in map
#      console.log "consider row #{mapY}: #{row}"
      for element, mapX in row
#        console.log "--- consider element #{element} at #{mapX}, #{mapY}"
        x = (mapX+1) * tileSize
        y = (mapY+1) * tileSize
#        spriteCode = map[mapY][mapX]
#        console.log
        sprite = @dereferenceSprite(element)
#        console.log "--- got sprite: #{sprite}"

#        console.log "--- drawing sprite at (#{x}, #{y})"
        sprite.draw(x,y)


#        arr = map[y][x].split(,)

  render: ->
#    @sprites['steel'].draw(@x, @y)
    @tilemap([[0,1,1,0,1,1,0],[1,1,1,0,1,1],[1,1,0,1,1,0,0],[0,0,0,1,1],[1,1,1,1,1,1,1,0]])
#    atom.context.save()
#    atom.context.translate(@x, @y)
#    atom.context.drawImage(@sprite, -@sprite.width/2, @sprite.height/2)
#    atom.context.restore()


#    @collection.fetch({})
#    @views = {}

#  viewFor: (star) ->
#    @views[star.id] = @views[star.id] or= (new StarView({model:star}))
#
#  render: ->
#    @night_sky()
#    @collection.each (star) => @viewFor(star).render()
##      (new StarView({model:star})).render()
#
#  night_sky: ->
#    ctx = atom.context
#    grd = ctx.createLinearGradient(0, 0, atom.width,atom.height)
#    grd.addColorStop 0,    "black"
#    grd.addColorStop 0.46, 'black'
#    grd.addColorStop 1,    "darkblue"
#    ctx.fillStyle = grd
#    ctx.fillRect 0,0,atom.width,atom.height

