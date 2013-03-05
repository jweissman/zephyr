class Universe extends Molecular.App
  setup: ->
    super
    @connectBackbone()
    @collection = Stars
    @view = StarsView

  # backbone setup
  connectBackbone: ->
    window.Stars       = new Zephyr.Collections.Stars()
    window.StarsView   = new Zephyr.Views.StarsView {collection: Stars}
    window.Star        = Zephyr.Models.Star
    window.StarView    = Zephyr.Views.StarView

universe = new Universe
universe.run()
