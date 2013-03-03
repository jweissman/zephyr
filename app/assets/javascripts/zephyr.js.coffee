window.Zephyr =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    Backbone.history.start(pushState: false)

$(document).ready ->
  Zephyr.initialize()


