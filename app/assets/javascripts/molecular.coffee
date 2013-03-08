#
# molecular!
#   - lightweight wrapper around atom instances
#   - goal is to help provide some of the support for multiplayer --
#     logic 'between' instances -- syncing model data, actions, etc.
#
root = exports ? this
root.Molecular = Molecular = {}

console.log "=== defining molecular..."
#
#   Molecular.Engine
#
#       core game engine, extends (and is a lightweight wrapper around) atom.Game
#       responsible for input binding and kicking updates to the bound app
#
#
class Molecular.Engine extends atom.Game
  constructor: (@app) ->
    super
    atom.input.bind atom.button.LEFT, 'click'
    atom.input.bind atom.button.RIGHT, 'rightclick'
    # TODO capture keys

  update: (dt) ->
    if atom.input.released 'click'
      @app.click(atom.input.mouse)
    @app.update()
  draw: ->
    @app.render()

#
#   molecular view
#     -- currently has a single bound backbone view which it renders
#        and routes clicks to...
#
#class Molecular.App
#  constructor: ->
#    @setup()
#
#  setup: ->
#    @engine = new Molecular.Engine @
#
#  run: ->
#    @engine.run()
#
#  draw: ->
#    @view.render()
#
#  click: (mouse) ->
#    @view.click(mouse)
#
#  update: -> # override if not static


# --- the rest of this is really just helpers...

#
#   molecular sync!
#     -- really just a lightweight wrapper around backbone sync / faye at this point
#     -- could be much more interesting (!)
#
Molecular.sync = (model, channel) ->
    new BackboneSync.RailsFayeSubscriber model,
      channel: channel
      client: new Faye.Client(FayeServer)

#
#   Molecular.Canvas
#     graphics with molecules!
#     -- again, really just some canvas helpers ATM...
#
Molecular.Canvas = {}


#
#   Molecular.Canvas.Path
#
#     - the basic idea is to wrap around the canvas drawing api
#       with shapes and mixins
#
class Molecular.Canvas.Path
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
class Molecular.Canvas.Glowing extends Mixin
  glow: ->
    @blur        = @opts['blur']  or= 10
    @shadowColor = @opts['shadow_color'] or= 'white'
    atom.context.shadowBlur  = @blur
    atom.context.shadowColor = @shadowColor

#
# canvas helper for drawing circles
#
class Molecular.Canvas.Ellipse extends Molecular.Canvas.Path
  constructor: (@x,@y,@opts) ->
    super(@opts)
    @radius = @opts['radius'] or= 3

  draw: (render_opts) ->
    @x = @opts['x'] or= (render_opts['x'] or= 0)
    @y = @opts['y'] or= (render_opts['y'] or= 0)
    @radius = @opts['radius'] or= (render_opts['radius'] or= 3)
    atom.context.arc @x, @y, @radius, 0, 2*Math.PI, false


