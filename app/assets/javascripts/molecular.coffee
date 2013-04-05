#
# molecular!
#   - lightweight wrapper around atom instances
#   - goal is to help provide some of the support for multiplayer --
#     logic 'between' instances -- syncing model data, actions, etc.
#
root = exports ? this
root.Molecular = Molecular = Zephyr.Molecular = {}

# yay, molecular banner! :D

Molecular.banner = ->
  console.log "                .__                      .__"
  console.log "   _____   ____ |  |   ____   ____  __ __|  | _____ _______"
  console.log "  /     \\ /    \\|  | _/ __ \\_/ ___\\|  |  \\  | \\__  \\_  __  \\"
  console.log " |  Y Y  (  <_> )  |_\\  ___/\\  \\___|  |  /  |__/ __ \\|  | \/"
  console.log " |__|_|  /\\____/|____/\\___  >\\___  >____/|____(____  /__|"
  console.log "       \\/                 \\/     \\/                \\/"


#
#   molecular sync!
#     -- really just a lightweight wrapper around backbone sync / faye at this point
#     -- could be much more interesting (!)
#
Zephyr.Molecular.Sync = {

#  aeronaut: (clientName) ->
#    now.ready ->
#      console.log('now ready, baby!')
#      now.getPlayerList (data) ->
#        console.log(data)

#    console.log "--- attempting to connect to zeronaut server..."
#    socket = new WebSocket(Molecular.Sync.ZeronautServer)
##    socket.send('what up')
#    socket.send('i knew you was urgently awaiting mah message')


  # model subscription to server-side CRUD ops
  # currently uses faye/websockets to keep a collection 'automatically' in sync between clients
  subscribe: (model, channel) ->
    faye_client = new Faye.Client(Molecular.Sync.FayeServer)
    new BackboneSync.RailsFayeSubscriber model,
      channel: channel
      client: faye_client # new Faye.Client(Molecular.Sync.FayeServer)
}


#### this (drawing stuff) is maybe a different lib (than the faye augmentations that would connect up atom instances)...

#
#   Molecular.Canvas
#     graphics with molecules!
#     -- again, really just some canvas helpers ATM...
#
root.Canvas = Zephyr.Molecular.Canvas = Molecular.Canvas = Canvas = {}


#
#   Molecular.Canvas.Path
#
#     - the basic idea is to wrap around the canvas drawing api
#       with shapes and mixins
#
class Canvas.Path
  constructor: (@x, @y, @opts) ->
    @glowing = @opts['glowing'] or= false
    if @glowing
      ObjectHelper.addRole(@, Molecular.Canvas.Glowing)

  beforeAll: ->
    atom.context.beginPath()

#  afterAll: ->
    @fill_style   = @opts['fill_style']  or= 'white'
    @line_width   = @opts['line_width']  or= 1
    @stroke_style = @opts['stroke_style'] or= "#FFFFFF"

    @glow() if @glowing

    atom.context.fillStyle   = @fill_style
    atom.context.lineWidth   = @line_width
    atom.context.strokeStyle = @stroke_style

  before: ->
  after: ->
  afterAll: ->

  inscribe: ->
    @beforeAll()
    @before()
    @draw()
    @after()
#    @afterAll()

#
#     a mixin for things that glow
#
class Canvas.Glowing extends Mixin
  glow: ->
    @blur         = @opts['blur']         or= 10
    @shadow_color = @opts['shadow_color'] or= 'white'

    atom.context.shadowBlur  = @blur
    atom.context.shadowColor = @shadowColor

#
# canvas helper for drawing circles
#
class Canvas.Ellipse extends Canvas.Path
  draw: ->
    @radius = @opts['radius'] or= 3
    atom.context.arc @x, @y, @radius, 0, 2*Math.PI, false
    atom.context.fill()
    atom.context.stroke()


#
# constructor for drawing rectangles
#
class Canvas.Rectangle extends Canvas.Path
  draw: ->
    @width = @opts['width'] or= 3
    @height = @opts['height'] or= 4
    atom.context.fillRect @x, @y, @width, @height

class Canvas.Text extends Canvas.Path
  draw: ->
    @msg = @opts['msg'] or= 'hello world';
    @font = @opts['font'] or= 'bold 16px Arial';
    atom.context.font = @font;
    atom.context.fillText(@msg, @x, @y);



Canvas.text = (x,y,msg,opts) -> (new Canvas.Text(x,y,$.extend(opts, {msg: msg}))).inscribe()
Canvas.clear = -> atom.context.clearRect 0,0,atom.width,atom.height


class Canvas.Image
  constructor: (@image) ->
    @cached_image = Canvas.Image.cache(@image)

  draw: (x,y) ->
    sprite = @cached_image
    atom.context.save()
    atom.context.translate x, y
    atom.context.drawImage sprite, -sprite.width/2, sprite.height/2
    atom.context.restore()

  @cache: (image) ->
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



#Canvas.image = (x,y,sprite,opts) ->
#  atom.context.save()
#  atom.context.translate x, y
#  atom.drawImage @sprite, -@sprite.width/2, @sprite.height/2
#  atom.context.restore()


#window.assets = assets = {}

#Molecular.launch = ->
#  # yo!
#  Molecular.banner()
#  Zephyr.launch()


