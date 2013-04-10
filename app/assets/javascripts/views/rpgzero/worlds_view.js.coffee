class Zephyr.Views.WorldsView extends Backbone.View
  initialize: (@collection) =>
    @worldViews = {}
    @collection.on 'add', (w) =>
      console.log "--- adding world view for world: "
      console.log w
      @worldViews[w.get('id')] = new Zephyr.Views.WorldSummaryView(w)

  render: ->
    _.each @worldViews, (view) ->
      view.render()

  clicked: (mouse) =>
    console.log "======== CLICKED!?!?"

    clicked_world = null
    _.each @worldViews, (view) =>
      console.log "--- checking view for click..."
      clicked = view.clicked(mouse)
      console.log "--- clicked? #{clicked}"
      if view.clicked(mouse)
        clicked_world = view.model

    console.log "--- clicked world: #{clicked_world}"
    return clicked_world



