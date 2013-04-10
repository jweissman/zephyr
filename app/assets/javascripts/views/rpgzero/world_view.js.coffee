class Zephyr.Views.WorldView extends Backbone.View
  initialize: (@model) ->
    console.log "--- new world view!!!!"
    @model.on("change", ->
      console.log "--- world was changed! [maybe a player was added? or just a tick probably...]"
    )
    @canvas_view = new Zephyr.Views.CanvasView(@model)

  clicked: (m) => @canvas_view.clicked(m)

  render: =>
    console.log "--- world render...!!!"
    console.log "--- i really need players and a map! :)"
    @canvas_view.render()

    # the model should have a map again...! :)
