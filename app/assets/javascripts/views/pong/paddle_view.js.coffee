class Zephyr.Views.PaddleView extends Backbone.View
  paddle: (x,y, w, h) ->
    (new Molecular.Canvas.Rectangle x, y,
      width: w
      height: h
#      line_width: 2
#      stroke_style: 'blue'
      fill_style: 'lime'
    ).inscribe()

  x: -> @model.get('x')
  y: -> @model.get('y')
  width: -> @model.get('width')
  height: -> @model.get('height')
  render: -> @paddle(@x(), @y(), @width(), @height())




