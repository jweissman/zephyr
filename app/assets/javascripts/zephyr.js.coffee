window.Zephyr =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  # custom stuff...?
  Game: {
    Callbacks: {}
  }

  initialize: ->
    Backbone.history.start(pushState: false)

#console.log $
#$(document).ready ->
Zephyr.launch = ->
#$ ->
  console.log "=== ZEPHYR LOAD ---"
  window.Assets = new AssetManager()
  #  console.log window.Assets
  Zephyr.Game.Callbacks.bootstrap()
  Zephyr.initialize()


