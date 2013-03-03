class Zephyr.Collections.Stars extends Backbone.Collection
  model: Zephyr.Models.Star
  url: "/stars.json"

  create: (x,y) ->
    star = new Star({
      star: {
        x: atom.input.mouse.x
        y: atom.input.mouse.y
      }
    })
    this.add(star)
    star.save()

  render: ->
    @each (model) ->
      model.render()




