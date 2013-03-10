class Zephyr.Collections.Stars extends Backbone.Collection
  model: Zephyr.Models.Star
  url:   "/stars.json"

  initialize: ->
    Molecular.Sync.subscribe @, 'stars'

  addOne: (x,y) ->
    (new Star(star:{x:x,y:y})).save()

  update: ->
    @each (star) -> star.wobble()
