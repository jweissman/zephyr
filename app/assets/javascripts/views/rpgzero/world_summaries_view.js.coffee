#class Zephyr.Views.WorldSummariesView extends Backbone.View
#  initialize: (@collection) =>
#    console.log "--- creating new world summaries view..."
#
#    @worldViews = {}
#    @collection.on 'add', (w) =>
#      console.log "=== adding world view to collection..."
#      console.log "--- using world model: "
#      console.log(w)
#      world_view = new WorldView(w)
#      console.log "--- created new world view: "
#      console.log(world_view)
#      @worldViews[w.get('id')] = world_view
#      console.log "--- successfully added world view to collection!!!!!!!!!!!!!!!!!!!!!!~~~~~~"
#
#  render: ->
#    console.log "=== attempting to render...!!!!"
#    console.log "--- attempting to render world views..."
#    console.log "--- #{_.size(@worldViews)} world views to render..."
#    _.each @worldViews, (view) ->
#      console.log "=== attempting to render world view!!!"
#      view.render()
#
#
#  clickedWorld: (mouse) =>
#    _.each @worldViews, (view) =>
#      return view.model if view.clickedMicro(mouse)
#    return null
#
## dereference click to clicked world
#
#
#
