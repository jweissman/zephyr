class Zephyr.Views.PlayersView extends Backbone.View
  initialize: (@collection) ->
    console.log 'initialized players view!'
  render: ->
    console.log 'should probably be rendering players...'
    # could look at current_player and highlight it
