# Summary view of active worlds.
class Zephyr.Views.WorldsView extends Backbone.View
  initialize: =>
#    console.log "=== worlds view created!"

    @labels = {
      'title':  new Canvas.Text(100,150, {msg: 'Welcome, warrior, to the RPGZero Lobby!'})
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
    player_count = 0

    @collection.each (world) =>
#      console.log world
      @summaryFor(world).render() # @worldViews, (view)  =>
      player_count = player_count + world.get('player_ids').length
      #view.render()
    _.each @labels,     (label) => label.draw()
#    console.log "--- worlds view render! i have these players:"
#    console.log Players

    # some notes about system state
    message = "There are #{player_count} players in #{@collection.length} worlds."
    message += " There are #{Players.length} players not yet in worlds."
    new Canvas.Text(100,170, {msg: message}).draw()

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
