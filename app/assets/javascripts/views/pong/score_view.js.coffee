class Zephyr.Views.ScoreView extends Backbone.View
  render: ->
    score = @model.formatScore()
    x = @model.get('x')
    y = @model.get('y')
#    console.log "--- attempting to write text: '#{score}' at #{x}, #{y}"
    Canvas.text x, y, score, { fill_style: 'neon', font: 'bold 30px lucida console' }
