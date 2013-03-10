#
# molecular!
#   - lightweight wrapper around atom instances
#   - goal is to help provide some of the support for multiplayer --
#     logic 'between' instances -- syncing model data, actions, etc.
#
root = exports ? this
root.Molecular = Molecular = Zephyr.Molecular = {}

# yay, molecular banner! :D

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
  subscribe: (model, channel) ->
    faye_client = new Faye.Client(Molecular.Sync.FayeServer)
    new BackboneSync.RailsFayeSubscriber model,
      channel: channel
      client: faye_client # new Faye.Client(Molecular.Sync.FayeServer)
}


#### this is a different lib....

#
#   Molecular.Canvas
#     graphics with molecules!
#     -- again, really just some canvas helpers ATM...
#
Zephyr.Molecular.Canvas = {}


#
#   Molecular.Canvas.Path
#
#     - the basic idea is to wrap around the canvas drawing api
#       with shapes and mixins
#
class Zephyr.Molecular.Canvas.Path
  constructor: (@opts) ->
    @glowing = @opts['glowing'] or= false
    if @glowing
      ObjectHelper.addRole(@, Molecular.Canvas.Glowing)

  beforeAll: ->
    atom.context.beginPath()

  afterAll: ->
    @fill_style   = @opts['fill_style']  or= 'white'
    @line_width   = @opts['line_width']  or= 1
    @stroke_style = @opts['stroke_style'] or= "#FFFFFF"

    @glow() if @glowing

    atom.context.fillStyle   = @fill_style
    atom.context.fill()
    atom.context.lineWidth   = @line_width
    atom.context.strokeStyle = @stroke_style
    atom.context.stroke()

  before: ->
  after: ->

  inscribe: ->
    @beforeAll()
    @before()
    @draw()
    @after()
    @afterAll()

#
#     a mixin for things that glow
#
class Zephyr.Molecular.Canvas.Glowing extends Mixin
  glow: ->
    @blur        = @opts['blur']  or= 10
    @shadow_color = @opts['shadow_color'] or= 'white'
    atom.context.shadowBlur  = @blur
    atom.context.shadowColor = @shadowColor

#
# canvas helper for drawing circles
#
class Zephyr.Molecular.Canvas.Ellipse extends Molecular.Canvas.Path
  constructor: (@x,@y,@opts) ->
    super(@opts)
    @radius = @opts['radius'] or= 3

  draw: ->
    atom.context.arc @x, @y, @radius, 0, 2*Math.PI, false
