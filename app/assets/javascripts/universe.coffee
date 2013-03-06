window.Stars       = new Zephyr.Collections.Stars()
window.StarsView   = new Zephyr.Views.StarsView {collection: Stars}
window.Star        = Zephyr.Models.Star
window.StarView    = Zephyr.Views.StarView

class Universe extends Molecular.App
  setup: ->
    super

    # not really sure a better place to put these
    @collection        = Stars
    @view              = StarsView

  run: ->
    super
    @collection.fetch({})

  update: ->
    @collection.update()


universe = new Universe
universe.run()
