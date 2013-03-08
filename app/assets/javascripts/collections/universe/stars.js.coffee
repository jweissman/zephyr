class Zephyr.Collections.Stars extends Backbone.Collection
  model: Zephyr.Models.Star
  url:   "/stars.json"

  initialize: ->
    console.log "=== initialize Stars..."
    Molecular.sync @, 'stars'

  create: (x,y) ->
    newborn_star = new Star
      star:
        x: x
        y: y
    newborn_star.save()

  render: ->
    @each (model) ->
      model.render()

#  update: ->

