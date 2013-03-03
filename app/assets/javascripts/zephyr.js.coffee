window.Zephyr =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    Backbone.history.start(pushState: false)

    window.Star        = Zephyr.Models.Star
    window.StarView    = Zephyr.Views.StarView
    window.Stars       = new Zephyr.Collections.Stars()
    window.StarsView   = new Zephyr.Views.StarsView {collection: Stars}

    Stars.fetch({})


$(document).ready ->
  Zephyr.initialize()


