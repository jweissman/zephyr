class Universe extends Molecular.App
  setup: ->
    super
    @collection        = Stars
    @view              = StarsView

  run: ->
    super
    @collection.fetch({})

  update: ->
    console.log "--- step"
    @collection.update()

# not really sure a better place to put these...
window.Stars       = new Zephyr.Collections.Stars()
window.StarsView   = new Zephyr.Views.StarsView {collection: Stars}
window.Star        = Zephyr.Models.Star
window.StarView    = Zephyr.Views.StarView

universe = new Universe
universe.run()
