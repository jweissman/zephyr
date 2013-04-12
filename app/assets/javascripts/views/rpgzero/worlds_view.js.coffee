# Summary view of active worlds.
class Zephyr.Views.WorldsView extends Backbone.View
  initialize: =>
#    console.log "=== worlds view created!"

    @labels = {
      'create': new Canvas.Text(240,250,{msg: "Create New Realm"})
    }

#    @worldViews = {}
#    @collection.on 'reset', (collection) =>
#      console.log "=== WORLDS COLLECTION RESET"
#      @collection = collection

#      @collection.each (w) =>
#        @worldViews[w.get('id')] = new Zephyr.Views.WorldSummaryView({model:w,collection:collection})

  summaryFor: (w) =>
    (new Zephyr.Views.WorldSummaryView({model:w,collection:@collection}))

  render: =>
#    console.log "--- render worlds: "
#    console.log "--- i have collection: "
#    console.log @collection

    @collection.each (world) =>
#      console.log world
      @summaryFor(world).render() # @worldViews, (view)  =>
      #view.render()
    _.each @labels,     (label) => label.draw()

  clickedLabel: (mouse) =>
    clicked_label = null
    _.map @labels, (label,label_name) =>
      if label.hit(mouse)
        clicked_label = label_name
    return clicked_label

#      console.log "--- ....*****"

  clickedWorld: (mouse) =>
#    false

    clicked_world = null
    @collection.each (world) =>
      if @summaryFor(world).clicked(mouse)
        clicked_world = world
    return clicked_world
