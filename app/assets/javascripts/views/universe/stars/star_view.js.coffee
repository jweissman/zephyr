class Zephyr.Views.StarView extends Backbone.View
  star: (x,y,r) ->
    (new Molecular.Canvas.Ellipse(x,y,
      radius: r
      line_width: 0.2
      blur: 3
      stroke_style: 'white'
      fill_style: 'white'
      shadow_color: 'white'
      glowing: true
    )).inscribe()

  render: ->
    @star(@model.get('x'), @model.get('y'),@model.get('radius'))



