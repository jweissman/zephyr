###

           ______     ______     ______   __  __     __  __     ______
          /\___  \   /\  ___\   /\  == \ /\ \_\ \   /\ \_\ \   /\  == \
          \/_/  /__  \ \  __\   \ \  _-/ \ \  __ \  \ \____ \  \ \  __<
            /\_____\  \ \_____\  \ \_\    \ \_\ \_\  \/\_____\  \ \_\ \_\
            \/_____/   \/_____/   \/_/     \/_/\/_/   \/_____/   \/_/ /_/


###

window.Zephyr =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    Backbone.history.start(pushState: false)


$(document).ready ->
  window.Assets = Zephyr.AssetManager = new AssetManager()

  Zephyr.initialize()


