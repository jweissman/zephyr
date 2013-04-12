# view group to hold the little mini descriptions of the worlds
#class Zephyr.Views.WorldsMiniView extends Backbone.Views
  # model: World # (needed in this case?)

class Zephyr.Views.WorldSummaryView extends Backbone.View
  initialize: =>
  text: =>
    players = @model.get('players')

    count = 0
    count = players.length if players
#    count = @model.get('players').length if @model.get 'players'

    tick  = @model.get 'tick'
    name  = @model.get 'name'

    index = if @collection
      @collection.indexOf(@model)
    else
      0

    x = 400
    y = 320 + (20*index)

    message = "    '#{name}' [players currently active: #{count}] (tick #{tick})   "
    return new Canvas.Text(x,y, {msg: message})

  render: =>
    @text().draw()

  clicked: (mouse) =>
    return @text().hit(mouse)


