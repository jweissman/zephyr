class Zephyr.Views.WorldView extends Backbone.View
  initialize: =>
#    console.log "--- new world view!!!!"
#    console.log "--- i have model: "
#    console.log @model
#    @model.on("change", ->
#      console.log "--- world was changed! [maybe a player was added? or just a tick probably...]"
#    )
    @canvas_view        = new Zephyr.Views.GameMapView({model:@model})
    @world_summary_view = new Zephyr.Views.WorldSummaryView({model:@model})

    # could update stats somewhat intelligently -- but it's all coming at once now anyway so nvm
#    @model.on 'change', (w) =>
#      console.log "=== WORLDS COLLECTION ADD"
#      @worldViews[w.get('id')] = new Zephyr.Views.WorldSummaryView({model:w})


  clicked: (m) => @canvas_view.clicked(m)

  render: =>
#    console.log "--- world render...!!!"
#    console.log "--- i really need players and a map! :)"
    @canvas_view.render()
    @world_summary_view.render()

    # the model should have a map again...! :)
