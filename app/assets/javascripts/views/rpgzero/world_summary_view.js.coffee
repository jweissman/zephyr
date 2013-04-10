# view group to hold the little mini descriptions of the worlds
#class Zephyr.Views.WorldsMiniView extends Backbone.Views
  # model: World # (needed in this case?)

class Zephyr.Views.WorldSummaryView extends Backbone.View
  initialize: (@model) ->
    console.log "--- created world summary view"

  text: =>
#    console.log "--- render micro text"
    name  = @model.get 'name'
    count = @model.get('players').length
    tick  = @model.get 'tick'
    return new Canvas.Text(300, 320+(20*Worlds.indexOf(@model)), {
      msg: "World #{name} (#{count} active players; #{tick})"
    })

  render: =>
#    console.log "--- render micro text"
    @text().draw()

  clicked: (mouse) =>
    return @text().hit(mouse)


