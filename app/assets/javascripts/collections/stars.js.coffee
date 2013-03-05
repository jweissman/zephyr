class Zephyr.Collections.Stars extends Backbone.Collection
  model: Zephyr.Models.Star
  url:   "/stars.json"

  initialize: ->
    Molecular.Sync.subscribe @, 'stars'

  create: (x,y) ->
    star = new Star
      star:
        x: x
        y: y

    star.save()

  render: ->
    @each (model) ->
      model.render()

  update: ->
    @each (model) ->
      model.set
        x: model.get('x') + (0.5-Math.random())
