#
# molecular: lightweight wrapper around atom instances
#            (goal is to help provide some of the support for multiplayer --
#            logic 'between' instances -- syncing model data, actions, etc.)
#

root = exports ? this

#
#   Molecular.GameEngine
#
#       core game engine, extends atom.Game
#       responsible for initialization and kicking updates to the bound app
#
#
class Engine extends atom.Game
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
    @app.draw()

#
#   molecular sync!
#     -- really just a lightweight wrapper around backbone sync / faye at this point
#     -- could be much more interesting (!)
#
Sync = {
  subscribe: (model, channel) ->
    new BackboneSync.RailsFayeSubscriber model,
      channel: channel
      client: new Faye.Client(Molecular.Sync.FayeServer)
}


#
#   molecular app
#     -- at this point fairly single-collection centric
#        (will presumably need to be addressed again...)
#     -- has a view which it renders and routes clicks to
#
class App
  constructor: ->
    @setup()

  setup: ->
    @engine   = new Engine @

  run: ->
    @collection.fetch({})
    @engine.run()

  draw: ->
    @view.render()

  update: ->
    @collection.update()

  click: (mouse) ->
    @view.click(mouse)

root.Molecular = {}
root.Molecular.App = App
root.Molecular.Sync = Sync
root.Molecular.Engine = Engine
