class Zephyr.Collections.Stars extends Backbone.Collection
  model: Zephyr.Models.Star
  url: "/stars.json"

  initialize: ->
    @__subscriber__ = new BackboneSync.RailsFayeSubscriber(@, {
      channel: "stars"
      client: new Faye.Client("https://zephyrfayediy-cerulean.rhcloud.com:8443/faye")
    })

  create: (x,y) ->
    star = new Star
      star:
        x: atom.input.mouse.x
        y: atom.input.mouse.y
    @add star
    star.save()

  render: ->
    @each (model) ->
      model.render()

  update: ->
    @each (model) ->
      model.set({x: model.get('x')+ 0.5-Math.random()})




