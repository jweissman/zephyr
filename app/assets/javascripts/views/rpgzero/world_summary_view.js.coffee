# view group to hold the little mini descriptions of the worlds
#class Zephyr.Views.WorldsMiniView extends Backbone.Views
  # model: World # (needed in this case?)

class Zephyr.Views.WorldSummaryView extends Backbone.View
  initialize: =>
#    console.log "--- created world summary view!"
    # could bind to model change and update that way...?

  text: =>
    name  = @model.get 'name'
    count = 0
    count = @model.get('players').length if @model.get 'players'
    tick  = @model.get 'tick'
    index = @collection.indexOf(@model)

    x = 400
    y = 320 + (20*index)

    message = "World '#{name}' with #{count} active players at tick #{tick}"

#    console.log "--- rendering world summary for #{name} at (#{x}, #{y})"
    return new Canvas.Text(x,y, {msg: message})

  render: =>
    @text().draw()

  clicked: (mouse) =>
    return @text().hit(mouse)


