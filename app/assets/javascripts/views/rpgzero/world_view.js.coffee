class Zephyr.Views.WorldView extends Backbone.View
  initialize: ->
    console.log "--- world view created...!"
    @map_data = [
      [0,0,0],
      [0,0,1],
      [0,0,0]
    ]


    @tiles = {
      'steel':Assets.getAsset('images/steel.png')
    }

    console.log "--- creating sprite...!"
    @sprite = @cacheImage(@tiles['steel'])
    console.log "=== created sprite:"
    console.log @sprite

    @x = 1
    @y = 2

  # move thiswhere
#  rotateAndCacheImage: (image, angle) ->
  cacheImage: (image) ->
    console.log "--- attempting to cache image:"
    console.log(image)
    offscreenCanvas = document.createElement("canvas")
    size = Math.max(image.width, image.height)
    offscreenCanvas.width = size
    offscreenCanvas.height = size
    offscreenCtx = offscreenCanvas.getContext("2d")
    offscreenCtx.save()
    offscreenCtx.translate size / 2, size / 2
#    offscreenCtx.rotate angle + Math.PI / 2
    offscreenCtx.translate 0, 0
    offscreenCtx.drawImage image, -(image.width / 2), -(image.height / 2)
    offscreenCtx.restore()
    return offscreenCanvas

#offscreenCtx.strokeStyle = "red";
#offscreenCtx.strokeRect(0,0,size,size);

  render: ->
#    console.log "--- render world!!!"
    atom.context.save()
    atom.context.translate(@x, @y)
#    atom.rotate(@angle +)
#    console.log "=== rendering sprite!"
    console.log(@sprite)
    atom.context.drawImage(@sprite, -@sprite.width/2, @sprite.height/2)
    atom.context.restore()


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

