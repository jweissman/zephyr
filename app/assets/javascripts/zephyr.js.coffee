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

    faye = new Faye.Client("http://localhost:9292/faye")
    faye.subscribe "/messages/new", (data) ->
      alert data

    window.StarsView   = new Zephyr.Views.StarsView {collection: Stars}

    Stars.fetch({})


$(document).ready ->
  Zephyr.initialize()


