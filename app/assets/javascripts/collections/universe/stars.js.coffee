class Zephyr.Collections.Stars extends Backbone.Collection
  model: Zephyr.Models.Star
  url:   "/stars.json"

  initialize: ->
    Molecular.Sync.subscribe @, 'stars'

  create: (x,y) ->
    newborn_star = new Star
      star:
        x: x
        y: y
#    @add(newborn_star)
    newborn_star.save()

  render: ->
    @each (model) ->
      model.render()

  update: ->
#    if Math.random() < 0.05
#      @each (model) ->
#        model.set({x: model.get('x')+ 0.5-Math.random()})


