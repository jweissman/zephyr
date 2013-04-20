class Zephyr.Views.StarsView extends Backbone.View
  initialize: ->
    @collection.fetch({})
    @views = {}

  viewFor: (star) ->
    @views[star.id] = @views[star.id] or= (new StarView({model:star}))

  render: ->
    @night_sky()
    @collection.each (star) => @viewFor(star).render()
#      (new StarView({model:star})).render()

  night_sky: ->
    ctx = atom.context
    grd = ctx.createLinearGradient(0, 0, atom.width,atom.height)
    grd.addColorStop 0,    "black"
    grd.addColorStop 0.46, 'black'
    grd.addColorStop 1,    "darkblue"
    ctx.fillStyle = grd
    ctx.fillRect 0,0,atom.width,atom.height

