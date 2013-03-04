class Zephyr.Models.Star extends Backbone.Model
  url: ->
    (if @id then "/stars/" + @id else "/stars")

  defaults:
    star:
      x: 0
      y: 0

  initialize: ->
    @view = new StarView(model: @)

  render: =>
    @view.render()
