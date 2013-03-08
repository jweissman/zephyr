class Zephyr.Views.StarView extends Backbone.View
  radius: 0.75
  initialize: ->
    @ellipse = new Molecular.Canvas.Ellipse
      radius: @radius
      line_width: 0
      blur: 10
      fill_style: 'white'
      shadow_color: 'white'
      glowing: true
#  star: (x,y) -> new Molecular.Canvas.Ellipse x,y, {
#    radius: @radius
#    line_width: 0
#    blur: 10
#    fill_style: 'white'
#    shadow_color: 'white'
#    glowing: true
#  }


  render: ->
    @ellipse.inscribe
      x: @model.get('x')
      y: @model.get('y')
