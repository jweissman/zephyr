class Zephyr.Views.BallView extends Backbone.View
#  model: new Ball({x:atom.width/2,y:atom.height/2})

  ball: (x,y) ->
    (new Molecular.Canvas.Ellipse x, y,
      radius: @model.get('radius')
      line_width: 0
      stroke_style: 'white'
      fill_style: 'white'
    ).inscribe()

  x: -> @model.get('x')
  y: -> @model.get('y')
  render: ->
#    x = @model.get('x')
#    y = @model.get('y')
#    console.log "rendering ball at #{@x()}, #{@y()}"
    @ball(@x(), @y()) #@model.get('x'), @model.get('y'))




