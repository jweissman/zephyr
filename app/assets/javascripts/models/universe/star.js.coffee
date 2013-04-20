class Zephyr.Models.Star extends Backbone.Model
  url: ->
    (if @id then "/stars/" + @id else "/stars")

  defaults:
    star:
      x: 0
      y: 0
      layer: 2
      active: true
      description: 'a normal little star'
      name: 'Some Star'

  wobble: ->
    @set('x', @get('x') + (0.5 - Math.random()))



