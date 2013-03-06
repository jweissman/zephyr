class Zephyr.Views.StarView extends Backbone.View
  initialize: ->


  render: ->
    x = @model.get 'x'
    y = @model.get 'y'

#    if Math.random() < 0.002
    @ellipse = new Molecular.Canvas.Ellipse x,y,{
      radius: 1
      line_width: 0
      blur: 10
      stroke_style: 'white'
      fill_style: 'yellow'
      shadow_color: 'white'
      glowing: true
    }

    @ellipse.inscribe()
